Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbeBUMXX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:23:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49494 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeBUMXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:23:21 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCMCIA / PM: Avoid noirq suspend aborts during suspend-to-idle
Date: Wed, 21 Feb 2018 13:24:16 +0100
Message-ID: <3352336.6IBe4RuE7s@aspire.rjw.lan>
In-Reply-To: <20180220213839.GA12082@light.dominikbrodowski.net>
References: <4287858.bFmM5lK9H6@aspire.rjw.lan> <20180220213839.GA12082@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a problem with PCMCIA system resume callbacks with respect
to suspend-to-idle in which the ->suspend_noirq() callback may be
invoked after the ->resume_noirq() one without resuming the system
entirely in some cases.  This doesn't work for PCMCIA because of
the lack of symmetry between its system suspend and system resume
"noirq" callbacks.

The system resume handling in PCMCIA is split between
socket_early_resume() and socket_late_resume() which are called in
different phases of system resume and both need to run for
socket_suspend() (invoked by the system suspend "noirq" callback)
to work.  Specifically, socket_suspend() returns an error when
called after socket_early_resume() without socket_late_resume(),
so if the suspend-to-idle core detects a spurious wakeup event and
attempts to put the system back to sleep, that is aborted by the
error coming from socket_suspend().

Avoid that by using a new socket state flag, SOCKET_IN_RESUME,
to indicate that socket_early_resume() has already run for the
socket in which case socket_suspend() will do minimum handling
and return 0.

This change has been tested on my venerable Toshiba Portege R500
(which is where the problem has been discovered in the first place),
but admittedly I have no PCMCIA cards to test along with the socket
itself.

Fixes: 33e4f80ee69b (ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This replaces https://patchwork.kernel.org/patch/10229821/

---
 drivers/pcmcia/cs.c          |   11 ++++++++++-
 drivers/pcmcia/cs_internal.h |    1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/pcmcia/cs.c
===================================================================
--- linux-pm.orig/drivers/pcmcia/cs.c
+++ linux-pm/drivers/pcmcia/cs.c
@@ -452,6 +452,14 @@ static int socket_insert(struct pcmcia_s
 
 static int socket_suspend(struct pcmcia_socket *skt)
 {
+	if (skt->state & SOCKET_IN_RESUME) {
+		mutex_lock(&skt->ops_mutex);
+		skt->socket = dead_socket;
+		skt->ops->set_socket(skt, &skt->socket);
+		mutex_unlock(&skt->ops_mutex);
+		return 0;
+	}
+
 	if (skt->state & SOCKET_SUSPEND)
 		return -EBUSY;
 
@@ -475,6 +483,7 @@ static int socket_early_resume(struct pc
 	skt->ops->set_socket(skt, &skt->socket);
 	if (skt->state & SOCKET_PRESENT)
 		skt->resume_status = socket_setup(skt, resume_delay);
+	skt->state |= SOCKET_IN_RESUME;
 	mutex_unlock(&skt->ops_mutex);
 	return 0;
 }
@@ -484,7 +493,7 @@ static int socket_late_resume(struct pcm
 	int ret = 0;
 
 	mutex_lock(&skt->ops_mutex);
-	skt->state &= ~SOCKET_SUSPEND;
+	skt->state &= ~(SOCKET_SUSPEND | SOCKET_IN_RESUME);
 	mutex_unlock(&skt->ops_mutex);
 
 	if (!(skt->state & SOCKET_PRESENT)) {
Index: linux-pm/drivers/pcmcia/cs_internal.h
===================================================================
--- linux-pm.orig/drivers/pcmcia/cs_internal.h
+++ linux-pm/drivers/pcmcia/cs_internal.h
@@ -70,6 +70,7 @@ struct pccard_resource_ops {
 /* Flags in socket state */
 #define SOCKET_PRESENT		0x0008
 #define SOCKET_INUSE		0x0010
+#define SOCKET_IN_RESUME	0x0040
 #define SOCKET_SUSPEND		0x0080
 #define SOCKET_WIN_REQ(i)	(0x0100<<(i))
 #define SOCKET_CARDBUS		0x8000

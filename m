Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeBTLtZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:49:25 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48347 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTLtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:49:24 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] PCMCIA / PM: Combine system resume callbacks
Date: Tue, 20 Feb 2018 12:47:27 +0100
Message-ID: <4287858.bFmM5lK9H6@aspire.rjw.lan>
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

This design doesn't follow the power management documentation
stating that the "noirq" resume callback is expected to reverse
the changes made by the "noirq" suspend one.  Moreover, I don't see
a reason for splitting the PCMCIA socket system resume handling this
way and since it has become problematic in practice, replace both
socket_early_resume() and socket_late_resume() with one routine,
__socket_resume(), that will run all of the code from them in one
go, and point the "noirq" system suspend callback for the socket to
it.

This change has been tested on my venerable Toshiba Portege R500
(which is where the problem has been discovered in the first place),
but admittedly I have no PCMCIA cards to test along with the socket
itself.

Fixes: 33e4f80ee69b (ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pcmcia/cs.c |   26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/pcmcia/cs.c
===================================================================
--- linux-pm.orig/drivers/pcmcia/cs.c
+++ linux-pm/drivers/pcmcia/cs.c
@@ -467,23 +467,17 @@ static int socket_suspend(struct pcmcia_
 	return 0;
 }
 
-static int socket_early_resume(struct pcmcia_socket *skt)
+static int __socket_resume(struct pcmcia_socket *skt)
 {
+	int ret = 0;
+
 	mutex_lock(&skt->ops_mutex);
 	skt->socket = dead_socket;
 	skt->ops->init(skt);
 	skt->ops->set_socket(skt, &skt->socket);
 	if (skt->state & SOCKET_PRESENT)
 		skt->resume_status = socket_setup(skt, resume_delay);
-	mutex_unlock(&skt->ops_mutex);
-	return 0;
-}
 
-static int socket_late_resume(struct pcmcia_socket *skt)
-{
-	int ret = 0;
-
-	mutex_lock(&skt->ops_mutex);
 	skt->state &= ~SOCKET_SUSPEND;
 	mutex_unlock(&skt->ops_mutex);
 
@@ -546,8 +540,7 @@ static int socket_resume(struct pcmcia_s
 	if (!(skt->state & SOCKET_SUSPEND))
 		return -EBUSY;
 
-	socket_early_resume(skt);
-	err = socket_late_resume(skt);
+	err = __socket_resume(skt);
 	if (!err)
 		err = socket_complete_resume(skt);
 	return err;
@@ -853,12 +846,7 @@ static int pcmcia_socket_dev_suspend_noi
 
 static int pcmcia_socket_dev_resume_noirq(struct device *dev)
 {
-	return __pcmcia_pm_op(dev, socket_early_resume);
-}
-
-static int __used pcmcia_socket_dev_resume(struct device *dev)
-{
-	return __pcmcia_pm_op(dev, socket_late_resume);
+	return __pcmcia_pm_op(dev, __socket_resume);
 }
 
 static void __used pcmcia_socket_dev_complete(struct device *dev)
@@ -868,10 +856,6 @@ static void __used pcmcia_socket_dev_com
 }
 
 static const struct dev_pm_ops pcmcia_socket_pm_ops = {
-	/* dev_resume may be called with IRQs enabled */
-	SET_SYSTEM_SLEEP_PM_OPS(NULL,
-				pcmcia_socket_dev_resume)
-
 	/* late suspend must be called with IRQs disabled */
 	.suspend_noirq = pcmcia_socket_dev_suspend_noirq,
 	.freeze_noirq = pcmcia_socket_dev_suspend_noirq,

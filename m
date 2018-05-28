Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937053AbeE1K1o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937024AbeE1K1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:27:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 033/329] Input: psmouse - fix Synaptics detection when protocol is disabled
Date: Mon, 28 May 2018 11:59:22 +0200
Message-Id: <20180528100245.187673827@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 2bc4298f59d2f15175bb568e2d356b5912d0cdd9 ]

When Synaptics protocol is disabled, we still need to try and detect the
hardware, so we can switch to SMBus device if SMbus is detected, or we know
that it is Synaptics device and reset it properly for the bare PS/2
protocol.

Fixes: c378b5119eb0 ("Input: psmouse - factor out common protocol probing code")
Reported-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/psmouse-base.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -937,6 +937,21 @@ static void psmouse_apply_defaults(struc
 	psmouse->pt_deactivate = NULL;
 }
 
+static bool psmouse_do_detect(int (*detect)(struct psmouse *, bool),
+			      struct psmouse *psmouse, bool allow_passthrough,
+			      bool set_properties)
+{
+	if (psmouse->ps2dev.serio->id.type == SERIO_PS_PSTHRU &&
+	    !allow_passthrough) {
+		return false;
+	}
+
+	if (set_properties)
+		psmouse_apply_defaults(psmouse);
+
+	return detect(psmouse, set_properties) == 0;
+}
+
 static bool psmouse_try_protocol(struct psmouse *psmouse,
 				 enum psmouse_type type,
 				 unsigned int *max_proto,
@@ -948,15 +963,8 @@ static bool psmouse_try_protocol(struct
 	if (!proto)
 		return false;
 
-	if (psmouse->ps2dev.serio->id.type == SERIO_PS_PSTHRU &&
-	    !proto->try_passthru) {
-		return false;
-	}
-
-	if (set_properties)
-		psmouse_apply_defaults(psmouse);
-
-	if (proto->detect(psmouse, set_properties) != 0)
+	if (!psmouse_do_detect(proto->detect, psmouse, proto->try_passthru,
+			       set_properties))
 		return false;
 
 	if (set_properties && proto->init && init_allowed) {
@@ -988,8 +996,8 @@ static int psmouse_extensions(struct psm
 	 * Always check for focaltech, this is safe as it uses pnp-id
 	 * matching.
 	 */
-	if (psmouse_try_protocol(psmouse, PSMOUSE_FOCALTECH,
-				 &max_proto, set_properties, false)) {
+	if (psmouse_do_detect(focaltech_detect,
+			      psmouse, false, set_properties)) {
 		if (max_proto > PSMOUSE_IMEX &&
 		    IS_ENABLED(CONFIG_MOUSE_PS2_FOCALTECH) &&
 		    (!set_properties || focaltech_init(psmouse) == 0)) {
@@ -1035,8 +1043,8 @@ static int psmouse_extensions(struct psm
 	 * probing for IntelliMouse.
 	 */
 	if (max_proto > PSMOUSE_PS2 &&
-	    psmouse_try_protocol(psmouse, PSMOUSE_SYNAPTICS, &max_proto,
-				 set_properties, false)) {
+	    psmouse_do_detect(synaptics_detect,
+			      psmouse, false, set_properties)) {
 		synaptics_hardware = true;
 
 		if (max_proto > PSMOUSE_IMEX) {

Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A6EC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A1D20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A1D20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeJNXR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:17:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36681 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbeJNXR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:17:27 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM9-0004cp-CJ; Sun, 14 Oct 2018 16:31:01 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000HS-R8; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Ondrej Zary" <linux@rainbow-software.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.172595598@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 103/366] Input: i8042 - enable MUX on Sony VAIO
 VGN-CS series to fix touchpad
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Zary <linux@rainbow-software.org>

commit 04bb1719c4de94700056241d4c0fe3c1413f5aff upstream.

The touch sensor buttons on Sony VAIO VGN-CS series laptops (e.g.
VGN-CS31S) are a separate PS/2 device. As the MUX is disabled for all
VAIO machines by the nomux blacklist, the data from touch sensor
buttons and touchpad are combined. The protocol used by the buttons is
probably similar to the touchpad protocol (both are Synaptics) so both
devices get enabled. The controller combines the data, creating a mess
which results in random button clicks, touchpad stopping working and
lost sync error messages:
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 4
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: issuing reconnect request

Add a new i8042_dmi_forcemux_table whitelist with VGN-CS.
With MUX enabled, touch sensor buttons are detected as separate device
(and left disabled as there's currently no driver), fixing all touchpad
problems.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/serio/i8042-x86ia64io.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -516,6 +516,20 @@ static const struct dmi_system_id __init
 	{ }
 };
 
+static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst = {
+	{
+		/*
+		 * Sony Vaio VGN-CS series require MUX or the touch sensor
+		 * buttons will disturb touchpad operation
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
+		},
+	},
+	{ }
+};
+
 static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
 	{
 		/* MSI Wind U-100 */
@@ -1116,6 +1130,9 @@ static int __init i8042_platform_init(vo
 	if (dmi_check_system(i8042_dmi_nomux_table))
 		i8042_nomux = true;
 
+	if (dmi_check_system(i8042_dmi_forcemux_table))
+		i8042_nomux = false;
+
 	if (dmi_check_system(i8042_dmi_notimeout_table))
 		i8042_notimeout = true;
 


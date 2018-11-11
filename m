Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC120869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEC120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbeKLG1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:27:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49714 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730070AbeKLFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0000lJ-CZ; Sun, 11 Nov 2018 19:58:40 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001bm-EG; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Stefan Valouch" <stefan@valouch.com>,
        "Ulrik De Bie" <ulrik.debie-os@e2big.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.674209376@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 176/366] Input: elantech - report the middle button
 of the touchpad
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ulrik De Bie <ulrik.debie-os@e2big.org>

commit f386474e12a560e005ec7899e78f51f6bdc3cf41 upstream.

In the past, no elantech was known with 3 touchpad mouse buttons.
Fujitsu H730 is the first known elantech with a middle button. This commit
enables this middle button. For backwards compatibility, the Fujitsu is
detected via DMI, and only for this one 3 buttons will be announced.

Reported-by: Stefan Valouch <stefan@valouch.com>
Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/mouse/elantech.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -500,6 +500,7 @@ static void elantech_input_sync_v4(struc
 	} else {
 		input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+		input_report_key(dev, BTN_MIDDLE, packet[0] & 0x04);
 	}
 
 	input_mt_report_pointer_emulation(dev, true);
@@ -1064,6 +1065,22 @@ static void elantech_set_buttonpad_prop(
 }
 
 /*
+ * Some hw_version 4 models do have a middle button
+ */
+static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		/* Fujitsu H730 has a middle button */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
+		},
+	},
+#endif
+	{ }
+};
+
+/*
  * Set the appropriate event bits for the input subsystem
  */
 static int elantech_set_input_params(struct psmouse *psmouse)
@@ -1082,6 +1099,8 @@ static int elantech_set_input_params(str
 	__clear_bit(EV_REL, dev->evbit);
 
 	__set_bit(BTN_LEFT, dev->keybit);
+	if (dmi_check_system(elantech_dmi_has_middle_button))
+		__set_bit(BTN_MIDDLE, dev->keybit);
 	__set_bit(BTN_RIGHT, dev->keybit);
 
 	__set_bit(BTN_TOUCH, dev->keybit);


Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E352C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE3820869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE3820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbeKLG1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:27:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49630 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730034AbeKLFsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:09 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0000l6-20; Sun, 11 Nov 2018 19:58:40 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001br-Ey; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Aaron Ma" <aaron.ma@canonical.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.597440308@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 177/366] Input: elantech - enable middle button of
 touchpads on ThinkPad P52
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

From: Aaron Ma <aaron.ma@canonical.com>

commit 24bb555e6e46d96e2a954aa0295029a81cc9bbaa upstream.

PNPID is better way to identify the type of touchpads.
Enable middle button support on 2 types of touchpads on Lenovo P52.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/mouse/elantech.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1080,6 +1080,12 @@ static const struct dmi_system_id elante
 	{ }
 };
 
+static const char * const middle_button_pnp_ids[] = {
+	"LEN2131", /* ThinkPad P52 w/ NFC */
+	"LEN2132", /* ThinkPad P52 */
+	NULL
+};
+
 /*
  * Set the appropriate event bits for the input subsystem
  */
@@ -1099,7 +1105,8 @@ static int elantech_set_input_params(str
 	__clear_bit(EV_REL, dev->evbit);
 
 	__set_bit(BTN_LEFT, dev->keybit);
-	if (dmi_check_system(elantech_dmi_has_middle_button))
+	if (dmi_check_system(elantech_dmi_has_middle_button) ||
+			psmouse_matches_pnp_id(psmouse, middle_button_pnp_ids))
 		__set_bit(BTN_MIDDLE, dev->keybit);
 	__set_bit(BTN_RIGHT, dev->keybit);
 


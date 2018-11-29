Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AF0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A59320868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAuS0WVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A59320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeK3B3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731245AbeK3B3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E252145D;
        Thu, 29 Nov 2018 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501433;
        bh=+rsiHtKRjFf2rDm4ZY8fS/RV4Y8Dlmf1ZLGRh9HwXA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAuS0WVDBPhk21dd7pcnZlMq0p4p5stlozszer/bE+boMp1KWpm/dVzbbRpnuetlm
         wKCgIoBRKfNyuHM6ms/1b8Wvwg7n1iXe76eQmF5UcYD3dO79XvTiJO9Rfm3/EjhwhM
         KXWXASA0PQ3B1WwPWSZ0F1pyhPDNLCowKf5ov6wE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyle Beauchamp <kyleabeauchamp@gmail.com>,
        Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 61/92] Input: xpad - fix PowerA init quirk for some gamepad models
Date:   Thu, 29 Nov 2018 15:12:30 +0100
Message-Id: <20181129140111.269483325@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f5308d1b83eba20e69df5e0926ba7257c8dd9074 ]

The PowerA gamepad initialization quirk worked with the PowerA
wired gamepad I had around (0x24c6:0x543a), but a user reported [0]
that it didn't work for him, even though our gamepads shared the
same vendor and product IDs.

When I initially implemented the PowerA quirk, I wanted to avoid
actually triggering the rumble action during init. My tests showed
that my gamepad would work correctly even if it received a rumble
of 0 intensity, so that's what I went with.

Unfortunately, this apparently isn't true for all models (perhaps
a firmware difference?). This non-working gamepad seems to require
the real magic rumble packet that the Microsoft driver sends, which
actually vibrates the gamepad. To counteract this effect, I still
send the old zero-rumble PowerA quirk packet which cancels the
rumble effect before the motors can spin up enough to vibrate.

[0]: https://github.com/paroj/xpad/issues/48#issuecomment-313904867

Reported-by: Kyle Beauchamp <kyleabeauchamp@gmail.com>
Tested-by: Kyle Beauchamp <kyleabeauchamp@gmail.com>
Fixes: 81093c9848a7 ("Input: xpad - support some quirky Xbox One pads")
Cc: stable@vger.kernel.org # v4.12
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2578a7677040..f8e34ef643c7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -476,10 +476,21 @@ static const u8 xboxone_hori_init[] = {
 };
 
 /*
- * A rumble packet is required for some PowerA pads to start
+ * A specific rumble packet is required for some PowerA pads to start
  * sending input reports. One of those pads is (0x24c6:0x543a).
  */
-static const u8 xboxone_zerorumble_init[] = {
+static const u8 xboxone_rumblebegin_init[] = {
+	0x09, 0x00, 0x00, 0x09, 0x00, 0x0F, 0x00, 0x00,
+	0x1D, 0x1D, 0xFF, 0x00, 0x00
+};
+
+/*
+ * A rumble packet with zero FF intensity will immediately
+ * terminate the rumbling required to init PowerA pads.
+ * This should happen fast enough that the motors don't
+ * spin up to enough speed to actually vibrate the gamepad.
+ */
+static const u8 xboxone_rumbleend_init[] = {
 	0x09, 0x00, 0x00, 0x09, 0x00, 0x0F, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00
 };
@@ -494,9 +505,12 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
 	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
-	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_zerorumble_init),
-	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_zerorumble_init),
-	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_zerorumble_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumbleend_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumbleend_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumbleend_init),
 };
 
 struct xpad_output_packet {
-- 
2.17.1




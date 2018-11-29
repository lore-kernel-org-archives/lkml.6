Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3156BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB33205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6nPcIiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB33205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeK3B3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:29:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732523AbeK3B3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 907912133F;
        Thu, 29 Nov 2018 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501450;
        bh=Yhqg+Uf7MlgfKEOK6J6DqH2XeoIysu3eJFoazenytRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6nPcIiBCUa+w50KMxN4Zhyef4ckj9L+SMdZ5IaulkdH5D2KkSujpACdGJ0Va2bK9
         VFCSvFXI8dx8azwHWb9drMACPsjVLN3Y1UZd/JASWF2QhimHcjaGzwKDo0X8pQYsy6
         YZ5VHUfaKIc0De8xyfQ+LlBi7LT7okhlOmLL1yPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Furneaux <mark@furneaux.ca>,
        Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 63/92] Input: xpad - add support for PDP Xbox One controllers
Date:   Thu, 29 Nov 2018 15:12:32 +0100
Message-Id: <20181129140111.432770795@linuxfoundation.org>
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

[ Upstream commit e5c9c6a885fad00aa559b49d8fc23a60e290824e ]

Adds support for the current lineup of Xbox One controllers from PDP
(Performance Designed Products). These controllers are very picky with
their initialization sequence and require an additional 2 packets before
they send any input reports.

Signed-off-by: Mark Furneaux <mark@furneaux.ca>
Reviewed-by: Cameron Gutman <aicommander@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d86e59515b9c..d88d3e0f59fb 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -229,6 +229,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0213, "Afterglow Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x02ab, "PDP Controller for Xbox One", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
@@ -475,6 +476,22 @@ static const u8 xboxone_hori_init[] = {
 	0x00, 0x00, 0x00, 0x80, 0x00
 };
 
+/*
+ * This packet is required for some of the PDP pads to start
+ * sending input reports. One of those pads is (0x0e6f:0x02ab).
+ */
+static const u8 xboxone_pdp_init1[] = {
+	0x0a, 0x20, 0x00, 0x03, 0x00, 0x01, 0x14
+};
+
+/*
+ * This packet is required for some of the PDP pads to start
+ * sending input reports. One of those pads is (0x0e6f:0x02ab).
+ */
+static const u8 xboxone_pdp_init2[] = {
+	0x06, 0x20, 0x00, 0x02, 0x01, 0x00
+};
+
 /*
  * A specific rumble packet is required for some PowerA pads to start
  * sending input reports. One of those pads is (0x24c6:0x543a).
@@ -505,6 +522,8 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
 	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init1),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
-- 
2.17.1




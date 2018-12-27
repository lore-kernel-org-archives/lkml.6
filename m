Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290EAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD8C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Q7pDsdW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbeL0POY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 10:14:24 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:60230 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731151AbeL0POW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 10:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z5QYLHj4C/hWCkjjUWQwky4GByXTl43sM+tyOxveHE8=; b=Q7pDsdW5XXfsOPpin04wUNCKz
        PMKpTSck9+wWgHa0bwsy31/n6qlyrI/dUQKa4OGbchvZgAi8Jk0xHa2DzsBa8ROobUXMNP3bsMnUu
        XmToMpdLA4SVZkq9qF7HtJLuY2l+QXbtyTxFmpy/imiN+Jsta3amUgSV4u0hPg+5v+QK0=;
Received: from p200300ccfbcbef001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcb:ef00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gcXMC-0003PO-4G; Thu, 27 Dec 2018 16:13:56 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gcXMC-0007kr-5j; Thu, 27 Dec 2018 16:13:56 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] hwmon: (hih6130) add dtb compatibility tables
Date:   Thu, 27 Dec 2018 16:13:48 +0100
Message-Id: <20181227151349.29753-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181227151349.29753-1-andreas@kemnade.info>
References: <20181227151349.29753-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the hih6130 to be used in devicetree files and auto-probed
that way.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/hwmon/hih6130.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
index 0ae1ee1dbf76..de1b50ddc740 100644
--- a/drivers/hwmon/hih6130.c
+++ b/drivers/hwmon/hih6130.c
@@ -254,8 +254,17 @@ static const struct i2c_device_id hih6130_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, hih6130_id);
 
+static const struct of_device_id hih6130_of_match[] = {
+	{ .compatible = "honeywell,hih6130", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hih6130_of_match);
+
 static struct i2c_driver hih6130_driver = {
-	.driver.name = "hih6130",
+	.driver = {
+		.name = "hih6130",
+		.of_match_table = of_match_ptr(hih6130_of_match),
+	},
 	.probe       = hih6130_probe,
 	.id_table    = hih6130_id,
 };
-- 
2.11.0


Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F40C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A8C2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500942;
	bh=siWW6RX0kXOQHAb12WkiznLHaMk4rTgTtcmu8PfLx5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fFhhzeWEwwVdjqhL4dqVirbrP3gT2P6X0BWAB2SLyzsRVo002fM8/ZzB20ejNnyjd
	 m1ZSjcCwZquB65qeNiKW9f+53CH5UOALlJvvCGNHUxYOZnwEUdE+JPGKND/9l6OF0D
	 q0So7Df4K3dRmkDQOOr4Us7XlNTH8UqVj4LHpgE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfBROmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732198AbfBRNuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2180321901;
        Mon, 18 Feb 2019 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497816;
        bh=siWW6RX0kXOQHAb12WkiznLHaMk4rTgTtcmu8PfLx5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyCMEYlwmC0v+76t/f0LVc6hR6v3ZK6VaVM0hqp1zp1rwhNvEbPk87F4M5WOU65Ko
         /2Em3pZewRc2rTLxwDwayBcmDE3AQwFfzX6CD6mMddVNPZ3VKHTzh05TbxjWSPW6HE
         as3KOl8+1soFCI846z15+F3Phmhc5dCmtFHvMCJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Bunk <bunk@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 02/85] eeprom: at24: add support for 24c2048
Date:   Mon, 18 Feb 2019 14:42:28 +0100
Message-Id: <20190218133500.041824712@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 37cf28d3b5bca1b532a0b6aac722e7f2788a9294 ]

Works with ST M24M02.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/eeprom/Kconfig | 2 +-
 drivers/misc/eeprom/at24.c  | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 68a1ac929917..d382b13c27dd 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -13,7 +13,7 @@ config EEPROM_AT24
 	  ones like at24c64, 24lc02 or fm24c04:
 
 	     24c00, 24c01, 24c02, spd (readonly 24c02), 24c04, 24c08,
-	     24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024
+	     24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024, 24c2048
 
 	  Unless you like data loss puzzles, always be sure that any chip
 	  you configure as a 24c32 (32 kbit) or larger is NOT really a
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 7e50e1d6f58c..94836fcbe721 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -173,6 +173,7 @@ AT24_CHIP_DATA(at24_data_24c128, 131072 / 8, AT24_FLAG_ADDR16);
 AT24_CHIP_DATA(at24_data_24c256, 262144 / 8, AT24_FLAG_ADDR16);
 AT24_CHIP_DATA(at24_data_24c512, 524288 / 8, AT24_FLAG_ADDR16);
 AT24_CHIP_DATA(at24_data_24c1024, 1048576 / 8, AT24_FLAG_ADDR16);
+AT24_CHIP_DATA(at24_data_24c2048, 2097152 / 8, AT24_FLAG_ADDR16);
 /* identical to 24c08 ? */
 AT24_CHIP_DATA(at24_data_INT3499, 8192 / 8, 0);
 
@@ -199,6 +200,7 @@ static const struct i2c_device_id at24_ids[] = {
 	{ "24c256",	(kernel_ulong_t)&at24_data_24c256 },
 	{ "24c512",	(kernel_ulong_t)&at24_data_24c512 },
 	{ "24c1024",	(kernel_ulong_t)&at24_data_24c1024 },
+	{ "24c2048",    (kernel_ulong_t)&at24_data_24c2048 },
 	{ "at24",	0 },
 	{ /* END OF LIST */ }
 };
@@ -227,6 +229,7 @@ static const struct of_device_id at24_of_match[] = {
 	{ .compatible = "atmel,24c256",		.data = &at24_data_24c256 },
 	{ .compatible = "atmel,24c512",		.data = &at24_data_24c512 },
 	{ .compatible = "atmel,24c1024",	.data = &at24_data_24c1024 },
+	{ .compatible = "atmel,24c2048",	.data = &at24_data_24c2048 },
 	{ /* END OF LIST */ },
 };
 MODULE_DEVICE_TABLE(of, at24_of_match);
-- 
2.19.1




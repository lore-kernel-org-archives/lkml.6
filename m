Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7850C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3B321902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497520;
	bh=wm/xvyKAh4hOPZeBLhIj5oV9Sy1L0m+PWfkeJ/MaCPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7Pj3xVC0KRS7otdfkKX+/QsjNfxEasOGm4/z8MkS4IsWg/hauA/PugBTapXDgcC5
	 I6SgA1kksYQdRoEMnk9r/59HeIWcJcRJTLiyKMliQJI477e03ED5dhcQsE2V7D4adS
	 cvOLLB1YlkMKtpFckmofScuilV+ZOOCmFRJ1b7lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfBRNpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731281AbfBRNpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6E521902;
        Mon, 18 Feb 2019 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497514;
        bh=wm/xvyKAh4hOPZeBLhIj5oV9Sy1L0m+PWfkeJ/MaCPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXYpxvX2gTmD9XeRw54F2BQIgWriuLmm3m8zxpoiOzKtKmY1MvJdrP7Oa1yEaV7/L
         3dWDyJ8JgRVs8QmxlcCiH1xYdaG6fAidnGhxFFZqe2GbRhw+xovvvCIYHwgdNkNx60
         0PLJ7a7WPYVUAMv0dYl4RDPaCGMmnACjidrxPk7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Bunk <bunk@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 02/92] eeprom: at24: add support for 24c2048
Date:   Mon, 18 Feb 2019 14:42:05 +0100
Message-Id: <20190218133454.872363445@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index fe7a1d27a017..a846faefa210 100644
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
index 636ed7149793..ddfcf4ade7bf 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -156,6 +156,7 @@ AT24_CHIP_DATA(at24_data_24c128, 131072 / 8, AT24_FLAG_ADDR16);
 AT24_CHIP_DATA(at24_data_24c256, 262144 / 8, AT24_FLAG_ADDR16);
 AT24_CHIP_DATA(at24_data_24c512, 524288 / 8, AT24_FLAG_ADDR16);
 AT24_CHIP_DATA(at24_data_24c1024, 1048576 / 8, AT24_FLAG_ADDR16);
+AT24_CHIP_DATA(at24_data_24c2048, 2097152 / 8, AT24_FLAG_ADDR16);
 /* identical to 24c08 ? */
 AT24_CHIP_DATA(at24_data_INT3499, 8192 / 8, 0);
 
@@ -182,6 +183,7 @@ static const struct i2c_device_id at24_ids[] = {
 	{ "24c256",	(kernel_ulong_t)&at24_data_24c256 },
 	{ "24c512",	(kernel_ulong_t)&at24_data_24c512 },
 	{ "24c1024",	(kernel_ulong_t)&at24_data_24c1024 },
+	{ "24c2048",    (kernel_ulong_t)&at24_data_24c2048 },
 	{ "at24",	0 },
 	{ /* END OF LIST */ }
 };
@@ -210,6 +212,7 @@ static const struct of_device_id at24_of_match[] = {
 	{ .compatible = "atmel,24c256",		.data = &at24_data_24c256 },
 	{ .compatible = "atmel,24c512",		.data = &at24_data_24c512 },
 	{ .compatible = "atmel,24c1024",	.data = &at24_data_24c1024 },
+	{ .compatible = "atmel,24c2048",	.data = &at24_data_24c2048 },
 	{ /* END OF LIST */ },
 };
 MODULE_DEVICE_TABLE(of, at24_of_match);
-- 
2.19.1




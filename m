Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E675CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A402080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRi988vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503366AbfBNU5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:57:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37572 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503354AbfBNU5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:57:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id c8so8029186wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvvtHtkxY7gDjS3zaDEI2ZkA7ToO966jWFaiZg0ledQ=;
        b=kRi988vysu5i0JcUW2xzI1lTBQ7S+Nl+EQ5vNXOKMjHu1546NTpw/WDtv82l7x6If0
         elGe4B5mlOKoZbrBGg3qNGxrI6Zwd3AAgwgz+T8w6Y6yUf1pur56TFBXihPKwMcdPbjp
         DpazaKMKWK7fcLQNigdaVyr9WymWgcsS4P7v2h65wOzkaE+6xSFIpwrb3u0NPpTwxKc4
         cWsZ1ZUyZPPPhRK6PXK/lCtlN/Gd+8H24jCJTMb0qQXvv/k85it7T825O6Kfy7Nvu1YZ
         5L7zKhpGCLDcmYteyJdTTAvqDjdL67QuimAERGe7haAqfEs8sXyb2XMUvS9EBfyfsv/6
         PX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvvtHtkxY7gDjS3zaDEI2ZkA7ToO966jWFaiZg0ledQ=;
        b=OzysGz9Tyzs5pHK7ZwPAoG8FaCDfHsSQWCIR3mg9ybBgSSs2Pcvs7b/2b3o5MM0tsr
         frfaoNsb47CCnla+pnd5lhNovnc+vt4oSJ/InxH/JNGCOozyYdbOwNEwZgtk7eJpZRpo
         KqUpFxz652Swmpn3diOF4xh3PfM6xboplMmN4nLRksS6cLMeGvhzhPcNF2+trOT1Utvz
         yNDSu7R39KRF3keR8gMOVMQiqbPr1X09/uhp2htswcvl+xfCf6dGuEr+/8+O3rmcY554
         nxoThfORDtF3z/tuZhogR+rACt7/ukVnI2MtY/NvFfbjKFbdGN9fHQh9tr/0IYztodhY
         z6Jg==
X-Gm-Message-State: AHQUAuYaq+umR+lh1pLX/+bFnEmyUctz6u+qts3US0CH2U53CFIyD7b0
        8ZM4JiCpZKLXy+cpOcL90zs=
X-Google-Smtp-Source: AHgI3IYbLirdqADytkiTJBrlSNsz82YeozoD0oZBfs3T1MhoB9ONvw/JvQwLpQ96KCYEvwcR7SoRjw==
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr4268567wro.249.1550177856110;
        Thu, 14 Feb 2019 12:57:36 -0800 (PST)
Received: from localhost.localdomain (93-143-192-123.adsl.net.t-com.hr. [93.143.192.123])
        by smtp.gmail.com with ESMTPSA id d24sm8952870wrb.47.2019.02.14.12.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:57:35 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, bbrezillon@kernel.org, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] mtd: spi-nor: Add Winbond w25q16jv support
Date:   Thu, 14 Feb 2019 21:57:23 +0100
Message-Id: <20190214205723.9011-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Datasheet: https://www.winbond.com/resource-files/w25q16jv%20spi%20revg%2003222018%20plus.pdf

Testing done on Mikrotik Routerboard RB450Gx4 board under 4.19.19 kernel.

Test board does not support Dual or Quad modes.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6e13bbd1aaa5..0e958f48db1b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1975,6 +1975,11 @@ static const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
+	{
+		"w25q16jv", INFO(0xef7015, 0, 64 * 1024,  32,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
 	{ "w25x32", INFO(0xef3016, 0, 64 * 1024,  64, SECT_4K) },
 	{ "w25q20cl", INFO(0xef4012, 0, 64 * 1024,  4, SECT_4K) },
 	{ "w25q20bw", INFO(0xef5012, 0, 64 * 1024,  4, SECT_4K) },
-- 
2.20.1


Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17598C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F4420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JSF4rfgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F4420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeLEGcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:32:53 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39380 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:32:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181205063251euoutp0222fa30ae4737f00a6b92507bc51f7eb9~tXCdotmU_1298512985euoutp02T;
        Wed,  5 Dec 2018 06:32:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181205063251euoutp0222fa30ae4737f00a6b92507bc51f7eb9~tXCdotmU_1298512985euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543991571;
        bh=DVHpxsFPg5jF8utUvYDed61sdmGaeauogjzwq/Mmqxw=;
        h=From:To:Subject:Date:In-reply-to:References:From;
        b=JSF4rfgQPaQLt6xt/0iem4jPH7PIUyddEEXaQu9XfT4AO6Z2P4HiyC5r4tVuEE4Tr
         ACQZ73rusRRVv44zVHggVj8F2xh8JitO0PMagzeNDxyb4YHNEWSIPPFr+icsAfOs73
         MskGDD/TQSMVypoB7/pZDIMUU/lLohqwZoEoBOMo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205063250eucas1p121752ad829bb30352fa512e9bb87e800~tXCc8ivm_1609916099eucas1p1g;
        Wed,  5 Dec 2018 06:32:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AE.41.04294.211770C5; Wed,  5
        Dec 2018 06:32:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205063250eucas1p1819de50c3030fb60a704656be878fff2~tXCcNpj0x1627616276eucas1p1N;
        Wed,  5 Dec 2018 06:32:50 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-8e-5c077112c2f5
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F0.C7.04284.111770C5; Wed,  5
        Dec 2018 06:32:50 +0000 (GMT)
Received: from localhost.localdomain ([10.88.100.192]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PJ900CCM3I7V060@eusync3.samsung.com>;
        Wed, 05 Dec 2018 06:32:49 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        js07.lee@samsung.com, js07.lee@gmail.com
Subject: [RFC PATCH 2/2] mtd: spi-nor: support lock/unlock for a few Micron
 chips
Date:   Wed, 05 Dec 2018 15:32:20 +0900
Message-id: <20181205063220.22279-2-js07.lee@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181205063220.22279-1-js07.lee@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7djP87pChewxBm3X5Cz2nepnsThyYS2z
        xcSVk5kt/s55x2Tx6OZvVovLu+awWexuWsZucXTPPWaLyTvfMDpwesxbU+2xc9Zddo/NK7Q8
        Ni+p97g5r9Cjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mt78msNesJavor13BlMD4x3uLkZO
        DgkBE4nvhzqZuxi5OIQEVjBKvJt5hBXC+cwoceD4WhaYqp3bHzFBJJYxStzY3cIO4fxjlFgz
        o5MRpIpNQEvixu9NYO0iAnuZJP6dOMAOkhAWCJZoaV3OBmKzCKhKzHuziwnE5hWwlDjf9gZq
        hbzE6g0HmEFsTgEriTVt/YwggyQEJrBJ7Di5BWgqB5DjIrHyQDREvbDEq+Nb2CFsGYnOjoNM
        EHaxxM6VE9khelsYJR4tXwJVZCzx7u1asAXMAnwSk7ZNZ4aYySvR0SYEUeIhcfrsLmhg9DJK
        fNz3hH0Co8QCRoZVjOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgbF4+t/xLzsYd/1JOsQo
        wMGoxMMrMYUtRog1say4MvcQowQHs5II7wob9hgh3pTEyqrUovz4otKc1OJDjNIcLErivNUM
        D6KFBNITS1KzU1MLUotgskwcnFINjA7TFn2eM182NDapY3Ng3U+H+JnV3UULFNzP3Dwx955E
        b+JipXkrWu+0T/wX9vPrB8X1PbfSbYw0nrlU1M968mnm/X9FDVF/JqQxnpezLnR7E7c/87Su
        otVkXtnKljWL++fPneGv+Lr08ye2m/90GueqZOYUCk7knPxh1mSHoBcXnRX4JhrcWqTEUpyR
        aKjFXFScCADpRIrWwQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42I5/e/4VV2hQvYYg/4Ai32n+lksjlxYy2wx
        ceVkZou/c94xWTy6+ZvV4vKuOWwWu5uWsVsc3XOP2WLyzjeMDpwe89ZUe+ycdZfdY/MKLY/N
        S+o9bs4r9OjbsorR4/MmuQD2KC6blNSczLLUIn27BK6MN7/msBes5ato753B1MB4h7uLkZND
        QsBEYuf2R0wgtpDAEkaJ5tv1XYxcQHYDk8TF3ifsIAk2AS2JG783sYIkRAT2MkkcPTWbDSQh
        LBAs0dK6HMxmEVCVmPdmF9gkXgFLifNtb1ggNshLrN5wgBnE5hSwkljT1s8Isc1S4tfmZawT
        GLkXMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECAyhbcd+bt7BeGlj8CFGAQ5GJR5eySls
        MUKsiWXFlbmHGCU4mJVEeFfYsMcI8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKa
        nZpakFoEk2Xi4JRqYNQU7M74tfXH48CJfDcPp2jXP3l01GP+/hnZIVHqplMmirD/qvT8FftR
        k6l18s0W8eDJlxbPlM883/5GxGCpzaq52lGu9cxnNB4Ynn2afXleMZfx2oKuf7VP86ZI/K9K
        5GvxX9aUvmnnm0ML+crl+eaZP9/aK7w0udj4C7tGzqFPRwWnMuX8yVJiKc5INNRiLipOBACV
        4GrTHQIAAA==
X-CMS-MailID: 20181205063250eucas1p1819de50c3030fb60a704656be878fff2
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205063250eucas1p1819de50c3030fb60a704656be878fff2
References: <20181205063220.22279-1-js07.lee@samsung.com>
        <CGME20181205063250eucas1p1819de50c3030fb60a704656be878fff2@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Micron models are known to have lock/unlock support,
and that also support 4bit block protection bit (bp0-3).

This patch support lock/unlock feature on the flash.

Tested on w25q512ax3. The Other is modified following the datasheet.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index c261d8f7bef4..25d2abb842c0 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1438,8 +1438,16 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
-	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+	{
+		"n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024,
+			SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_HAS_BP3)
+	},
+	{
+		"n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024,
+			SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_HAS_BP3)
+	},
 	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
-- 
2.17.1


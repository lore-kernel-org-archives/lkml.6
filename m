Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2626C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A773920865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A773920865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeIKIWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 04:22:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38769 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbeIKIWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 04:22:03 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 15FFE91B4AB;
        Tue, 11 Sep 2018 11:24:48 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Tue, 11 Sep 2018
 11:24:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <arend.vanspriel@broadcom.com>,
        <franky.lin@broadcom.com>, <hante.meuleman@broadcom.com>,
        <chi-hsien.lin@cypress.com>, <wright.feng@cypress.com>,
        <kvalo@codeaurora.org>, <pieter-paul.giesberts@broadcom.com>,
        <ian@mnementh.co.uk>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <brcm80211-dev-list@cypress.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] brcmfmac: remove set but not used variables 'sfdoff' and 'pad_size'
Date:   Tue, 11 Sep 2018 11:24:04 +0800
Message-ID: <20180911032404.14536-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c: In function 'brcmf_sdio_rxglom':
drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:1466:11: warning:
 variable 'sfdoff' set but not used [-Wunused-but-set-variable]

drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c: In function 'brcmf_sdio_bus_preinit':
drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:3408:7: warning:
 variable 'pad_size' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 1e2fd28..b2e1ab5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -1463,7 +1463,7 @@ static u8 brcmf_sdio_rxglom(struct brcmf_sdio *bus, u8 rxseq)
 	struct sk_buff *pfirst, *pnext;
 
 	int errcode;
-	u8 doff, sfdoff;
+	u8 doff;
 
 	struct brcmf_sdio_hdrinfo rd_new;
 
@@ -1597,7 +1597,6 @@ static u8 brcmf_sdio_rxglom(struct brcmf_sdio *bus, u8 rxseq)
 
 		/* Remove superframe header, remember offset */
 		skb_pull(pfirst, rd_new.dat_offset);
-		sfdoff = rd_new.dat_offset;
 		num = 0;
 
 		/* Validate all the subframe headers */
@@ -3405,7 +3404,6 @@ static int brcmf_sdio_bus_preinit(struct device *dev)
 	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
 	struct brcmf_sdio *bus = sdiodev->bus;
 	struct brcmf_core *core = bus->sdio_core;
-	uint pad_size;
 	u32 value;
 	int err;
 
@@ -3448,7 +3446,6 @@ static int brcmf_sdio_bus_preinit(struct device *dev)
 	if (sdiodev->sg_support) {
 		bus->txglom = false;
 		value = 1;
-		pad_size = bus->sdiodev->func2->cur_blksize << 1;
 		err = brcmf_iovar_data_set(bus->sdiodev->dev, "bus:rxglom",
 					   &value, sizeof(u32));
 		if (err < 0) {
-- 
2.7.0



Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5E2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4308721872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfADVaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:30:52 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.79]:41047 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbfADVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:30:52 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 870C1A5B954
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 15:30:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fX3Lgp2ZAdnCefX3LgvmUn; Fri, 04 Jan 2019 15:30:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41140 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gfX3K-0033Fu-DA; Fri, 04 Jan 2019 15:30:50 -0600
Date:   Fri, 4 Jan 2019 15:30:47 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: mt7621-dma: Use struct_size() in devm_kzalloc()
Message-ID: <20190104213047.GA19391@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gfX3K-0033Fu-DA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:41140
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 27
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/mt7621-dma/ralink-gdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-dma/ralink-gdma.c b/drivers/staging/mt7621-dma/ralink-gdma.c
index 792a63bd55d4..d78042eba6dd 100644
--- a/drivers/staging/mt7621-dma/ralink-gdma.c
+++ b/drivers/staging/mt7621-dma/ralink-gdma.c
@@ -821,9 +821,9 @@ static int gdma_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	data = (struct gdma_data *) match->data;
 
-	dma_dev = devm_kzalloc(&pdev->dev, sizeof(*dma_dev) +
-			(sizeof(struct gdma_dmaengine_chan) * data->chancnt),
-			GFP_KERNEL);
+	dma_dev = devm_kzalloc(&pdev->dev,
+			       struct_size(dma_dev, chan, data->chancnt),
+			       GFP_KERNEL);
 	if (!dma_dev) {
 		dev_err(&pdev->dev, "alloc dma device failed\n");
 		return -EINVAL;
-- 
2.20.1


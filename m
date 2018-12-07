Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4DBC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E0220838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E0220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLGE3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:29:17 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:56093 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbeLGE3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:29:16 -0500
X-ASG-Debug-ID: 1544156944-093b7e716200aa0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id O304JibF04MvZMck (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 07 Dec 2018 12:29:04 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from y.localdomain (10.5.21.109) by HXTBJIDCEMVIW02.hxtcorp.net
 (10.128.0.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 12:28:14 +0800
From:   Shunyong Yang <shunyong.yang@hxt-semitech.com>
To:     <okaya@kernel.org>
CC:     <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH 1/2] dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*
Date:   Fri, 7 Dec 2018 12:28:56 +0800
X-ASG-Orig-Subj: [PATCH 1/2] dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*
Message-ID: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1544156944
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7368 1.0000 1.6611
X-Barracuda-Spam-Score: 1.66
X-Barracuda-Spam-Status: No, SCORE=1.66 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63225
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In async_tx_test_ack(), it uses flags in struct dma_async_tx_descriptor
to check the ACK status. As hidma reuses the descriptor in a free list
when hidma_prep_dma_*(memcpy/memset) is called, the flag will keep ACKed
if the descriptor has been used before. This will cause a BUG_ON in
async_tx_quiesce().

  kernel BUG at crypto/async_tx/async_tx.c:282!
  Internal error: Oops - BUG: 0 1 SMP
  ...
  task: ffff8017dd3ec000 task.stack: ffff8017dd3e8000
  PC is at async_tx_quiesce+0x54/0x78 [async_tx]
  LR is at async_trigger_callback+0x98/0x110 [async_tx]

This patch initializes flags in dma_async_tx_descriptor by the flags
passed from the caller when hidma_prep_dma_*(memcpy/memset) is called.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 drivers/dma/qcom/hidma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 43d4b00b8138..9d639ed1955a 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -415,6 +415,7 @@ static int hidma_alloc_chan_resources(struct dma_chan *dmach)
 	if (!mdesc)
 		return NULL;
 
+	mdesc->desc.flags = flags;
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
 				     src, dest, len, flags,
 				     HIDMA_TRE_MEMCPY);
@@ -447,6 +448,7 @@ static int hidma_alloc_chan_resources(struct dma_chan *dmach)
 	if (!mdesc)
 		return NULL;
 
+	mdesc->desc.flags = flags;
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
 				     value, dest, len, flags,
 				     HIDMA_TRE_MEMSET);
-- 
1.8.3.1


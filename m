Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC9DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9002085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfAGBeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 20:34:03 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:50947 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbfAGBeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 20:34:03 -0500
X-ASG-Debug-ID: 1546824836-093b7e2d88461f0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id nWtwUO3HFt2XpM8S (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 07 Jan 2019 09:33:56 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from y.localdomain (10.5.21.109) by HXTBJIDCEMVIW02.hxtcorp.net
 (10.128.0.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Jan
 2019 09:33:51 +0800
From:   Shunyong Yang <shunyong.yang@hxt-semitech.com>
To:     <vkoul@kernel.org>
CC:     <okaya@kernel.org>, <andy.gross@linaro.org>,
        <david.brown@linaro.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH v2 1/2] dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*
Date:   Mon, 7 Jan 2019 09:32:14 +0800
X-ASG-Orig-Subj: [PATCH v2 1/2] dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*
Message-ID: <8109d1ab70fe6dbacdbe89fda38d8dcb450c884c.1546823811.git.shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1546824836
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5309 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65247
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
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---

v2: add Reviewed-by: Sinan Kaya <okaya@kernel.org>

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


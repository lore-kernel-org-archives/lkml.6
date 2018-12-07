Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A503C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1B220838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1B220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLGEaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:30:01 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:56128 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbeLGEaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:30:00 -0500
X-ASG-Debug-ID: 1544156993-093b7e716200ac0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id BQtTxU3a9l7Pw2PH (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 07 Dec 2018 12:29:53 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from y.localdomain (10.5.21.109) by HXTBJIDCEMVIW02.hxtcorp.net
 (10.128.0.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 12:29:03 +0800
From:   Shunyong Yang <shunyong.yang@hxt-semitech.com>
To:     <okaya@kernel.org>
CC:     <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH 2/2] dmaengine: qcom_hidma: assign channel cookie correctly
Date:   Fri, 7 Dec 2018 12:29:47 +0800
X-ASG-Orig-Subj: [PATCH 2/2] dmaengine: qcom_hidma: assign channel cookie correctly
Message-ID: <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
References: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1544156993
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7665 1.0000 1.9161
X-Barracuda-Spam-Score: 2.42
X-Barracuda-Spam-Status: No, SCORE=2.42 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE_7582B
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63225
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE_7582B         Custom Rule 7582B
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dma_cookie_complete() is called in hidma_process_completed(),
dma_cookie_status() will return DMA_COMPLETE in hidma_tx_status(). Then,
hidma_txn_is_success() will be called to use channel cookie
mchan->last_success to do additional DMA status check. Current code
assigns mchan->last_success after dma_cookie_complete(). This causes
a race condition of dma_cookie_status() returns DMA_COMPLETE before
mchan->last_success is assigned correctly. The race will cause
hidma_tx_status() return DMA_ERROR but the transaction is actually a
success. Moreover, in async_tx case, it will cause a timeout panic
in async_tx_quiesce().

 Kernel panic - not syncing: async_tx_quiesce: DMA error waiting for
 transaction
 ...
 Call trace:
 [<ffff000008089994>] dump_backtrace+0x0/0x1f4
 [<ffff000008089bac>] show_stack+0x24/0x2c
 [<ffff00000891e198>] dump_stack+0x84/0xa8
 [<ffff0000080da544>] panic+0x12c/0x29c
 [<ffff0000045d0334>] async_tx_quiesce+0xa4/0xc8 [async_tx]
 [<ffff0000045d03c8>] async_trigger_callback+0x70/0x1c0 [async_tx]
 [<ffff0000048b7d74>] raid_run_ops+0x86c/0x1540 [raid456]
 [<ffff0000048bd084>] handle_stripe+0x5e8/0x1c7c [raid456]
 [<ffff0000048be9ec>] handle_active_stripes.isra.45+0x2d4/0x550 [raid456]
 [<ffff0000048beff4>] raid5d+0x38c/0x5d0 [raid456]
 [<ffff000008736538>] md_thread+0x108/0x168
 [<ffff0000080fb1cc>] kthread+0x10c/0x138
 [<ffff000008084d34>] ret_from_fork+0x10/0x18

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 drivers/dma/qcom/hidma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 9d639ed1955a..aa88bcceda20 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -138,24 +138,24 @@ static void hidma_process_completed(struct hidma_chan *mchan)
 		desc = &mdesc->desc;
 		last_cookie = desc->cookie;
 
+		llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
+
 		spin_lock_irqsave(&mchan->lock, irqflags);
+		if (llstat == DMA_COMPLETE) {
+			mchan->last_success = last_cookie;
+			result.result = DMA_TRANS_NOERROR;
+		} else
+			result.result = DMA_TRANS_ABORTED;
+
 		dma_cookie_complete(desc);
 		spin_unlock_irqrestore(&mchan->lock, irqflags);
 
-		llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
 		dmaengine_desc_get_callback(desc, &cb);
 
 		dma_run_dependencies(desc);
 
 		spin_lock_irqsave(&mchan->lock, irqflags);
 		list_move(&mdesc->node, &mchan->free);
-
-		if (llstat == DMA_COMPLETE) {
-			mchan->last_success = last_cookie;
-			result.result = DMA_TRANS_NOERROR;
-		} else
-			result.result = DMA_TRANS_ABORTED;
-
 		spin_unlock_irqrestore(&mchan->lock, irqflags);
 
 		dmaengine_desc_callback_invoke(&cb, &result);
-- 
1.8.3.1


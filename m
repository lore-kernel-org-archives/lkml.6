Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0A2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EB120864
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="OAf3/P8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EB120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metanate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeGQLUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:20:11 -0400
Received: from dougal.metanate.com ([90.155.101.14]:57070 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729717AbeGQLUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kd1R/D0rhEllo6mHo7rjn1kFe39t23TsCXZO2SFjQGI=; b=OAf3/P8i/i2H/YvRfC9Gf8RLup
        xF6CfmciPtrJL5AlXW9rSTxXrRG+vZ2I5yZnqcJFwkeHCmRkJLajI2GUd0nNOJLNmq32zpjx0yGq2
        OSyX+cNysG/lx/dutyIMEbz65W7N4xbhOODZHQS6/QXdcxk1Y9Gt9kgbumgdKMtHwel4/ChX62ixW
        C0SdowhAoPaYwZPQg9TZIe3KQXkqh4O1Pt3GFsd29kKRjRhbiCKvSioW5TXVBtI9+O+Q+z3GiXU5/
        BhfyPZt4ADSPp7Nxak3/743A4UsaFDcvPM/OL/0rZ4NWcpHLJF+e8aCp65rEBCIc7yP6DBTnGUpRy
        8SqRan/w==;
Received: from johnkeeping.plus.com ([81.174.171.191] helo=localhost.localdomain)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1ffNWQ-000447-Mx; Tue, 17 Jul 2018 11:47:59 +0100
From:   John Keeping <john@metanate.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH] dmaengine: pl330: fix irq race with terminate_all
Date:   Tue, 17 Jul 2018 11:48:16 +0100
Message-Id: <20180717104816.17044-1-john@metanate.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pl330_update() when checking if a channel has been aborted, the
channel's lock is not taken, only the overall pl330_dmac lock.  But in
pl330_terminate_all() the aborted flag (req_running==-1) is set under
the channel lock and not the pl330_dmac lock.

With threaded interrupts, this leads to a potential race:

    pl330_terminate_all	        pl330_update
    -------------------         ------------
    lock channel
                                entry
    lock pl330
    _stop channel
    unlock pl330
                                lock pl330
                                check req_running != -1
    req_running = -1
                                _start channel

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/dma/pl330.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 370df2e74ddd..88750a34e859 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2256,13 +2256,14 @@ static int pl330_terminate_all(struct dma_chan *chan)
 
 	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
+
 	spin_lock(&pl330->lock);
 	_stop(pch->thread);
-	spin_unlock(&pl330->lock);
-
 	pch->thread->req[0].desc = NULL;
 	pch->thread->req[1].desc = NULL;
 	pch->thread->req_running = -1;
+	spin_unlock(&pl330->lock);
+
 	power_down = pch->active;
 	pch->active = false;
 
-- 
2.18.0


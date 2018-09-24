Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B285DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ADC214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73ADC214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeIXR5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:57:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbeIXR5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:57:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9B3F1073;
        Mon, 24 Sep 2018 11:55:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Keeping <john@metanate.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 08/70] dmaengine: pl330: fix irq race with terminate_all
Date:   Mon, 24 Sep 2018 13:52:07 +0200
Message-Id: <20180924113059.325600863@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Keeping <john@metanate.com>

[ Upstream commit e49756544a21f5625b379b3871d27d8500764670 ]

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
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/pl330.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2132,13 +2132,14 @@ static int pl330_terminate_all(struct dm
 
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
 



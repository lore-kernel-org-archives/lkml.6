Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7DBECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4108D21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4108D21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbeIXSeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:34:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbeIXSeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:34:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 81DC01018;
        Mon, 24 Sep 2018 12:32:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hanna Hawa <hannah@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 092/235] dmaengine: mv_xor_v2: kill the tasklets upon exit
Date:   Mon, 24 Sep 2018 13:51:18 +0200
Message-Id: <20180924113114.349238780@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hanna Hawa <hannah@marvell.com>

[ Upstream commit 8bbafed8dd5cfa81071b50ead5cb60367fdef3a9 ]

The mv_xor_v2 driver uses a tasklet, initialized during the probe()
routine. However, it forgets to cleanup the tasklet using
tasklet_kill() function during the remove() routine, which this patch
fixes. This prevents the tasklet from potentially running after the
module has been removed.

Fixes: 19a340b1a820 ("dmaengine: mv_xor_v2: new driver")

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/mv_xor_v2.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -899,6 +899,8 @@ static int mv_xor_v2_remove(struct platf
 
 	platform_msi_domain_free_irqs(&pdev->dev);
 
+	tasklet_kill(&xor_dev->irq_tasklet);
+
 	clk_disable_unprepare(xor_dev->clk);
 
 	return 0;



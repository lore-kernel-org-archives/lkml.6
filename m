Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C895C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D981521917
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeLWJfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:35:31 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44293
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727249AbeLWJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:34:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; 
   d="scan'208";a="289991771"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 23 Dec 2018 10:33:53 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] dmaengine: at_hdmac: drop useless LIST_HEAD
Date:   Sun, 23 Dec 2018 09:57:02 +0100
Message-Id: <1545555435-24576-8-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop LIST_HEAD where the variable it declares is never used.

tmp_list has been declared since the introduction of the driver
and has never been used.  The two declarations of list were
introduced with the containing functions but were also not used.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
@@
- LIST_HEAD(x);
  ... when != x
// </smpl>

Fixes: dc78baa2b90b ("dmaengine: at_hdmac: new driver for the Atmel AHB DMA Controller")
Fixes: 4facfe7f09f2b ("dmaengine: hdmac: Split device_control")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Successfully 0-day tested on 151 configurations.

 drivers/dma/at_hdmac.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 01d936c9fe89..a0a9cd76c1d4 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -134,7 +134,6 @@ static struct at_desc *atc_desc_get(struct at_dma_chan *atchan)
 	struct at_desc *ret = NULL;
 	unsigned long flags;
 	unsigned int i = 0;
-	LIST_HEAD(tmp_list);
 
 	spin_lock_irqsave(&atchan->lock, flags);
 	list_for_each_entry_safe(desc, _desc, &atchan->free_list, desc_node) {
@@ -1387,8 +1386,6 @@ static int atc_pause(struct dma_chan *chan)
 	int			chan_id = atchan->chan_common.chan_id;
 	unsigned long		flags;
 
-	LIST_HEAD(list);
-
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
 
 	spin_lock_irqsave(&atchan->lock, flags);
@@ -1408,8 +1405,6 @@ static int atc_resume(struct dma_chan *chan)
 	int			chan_id = atchan->chan_common.chan_id;
 	unsigned long		flags;
 
-	LIST_HEAD(list);
-
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
 
 	if (!atc_chan_is_paused(atchan))


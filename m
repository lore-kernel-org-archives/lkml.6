Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682C32087C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682C32087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbeHWM3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:29:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeHWM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:29:01 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF298CA0;
        Thu, 23 Aug 2018 09:00:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 231/324] bnxt_en: Do not modify max IRQ count after RDMA driver requests/frees IRQs.
Date:   Thu, 23 Aug 2018 09:54:57 +0200
Message-Id: <20180823075007.683385138@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 30f529473ec962102e8bcd33a6a04f1e1b490ae2 ]

Calling bnxt_set_max_func_irqs() to modify the max IRQ count requested or
freed by the RDMA driver is flawed.  The max IRQ count is checked when
re-initializing the IRQ vectors and this can happen multiple times
during ifup or ethtool -L.  If the max IRQ is reduced and the RDMA
driver is operational, we may not initailize IRQs correctly.  This
problem shows up on VFs with very small number of MSIX.

There is no other logic that relies on the IRQ count excluding the ones
used by RDMA.  So we fix it by just removing the call to subtract or
add the IRQs used by RDMA.

Fixes: a588e4580a7e ("bnxt_en: Add interface to support RDMA driver.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |    1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |    2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5915,7 +5915,7 @@ unsigned int bnxt_get_max_func_irqs(stru
 	return min_t(unsigned int, hw_resc->max_irqs, hw_resc->max_cp_rings);
 }
 
-void bnxt_set_max_func_irqs(struct bnxt *bp, unsigned int max_irqs)
+static void bnxt_set_max_func_irqs(struct bnxt *bp, unsigned int max_irqs)
 {
 	bp->hw_resc.max_irqs = max_irqs;
 }
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1455,7 +1455,6 @@ void bnxt_set_max_func_stat_ctxs(struct
 unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp);
 void bnxt_set_max_func_cp_rings(struct bnxt *bp, unsigned int max);
 unsigned int bnxt_get_max_func_irqs(struct bnxt *bp);
-void bnxt_set_max_func_irqs(struct bnxt *bp, unsigned int max);
 int bnxt_get_avail_msix(struct bnxt *bp, int num);
 int bnxt_reserve_rings(struct bnxt *bp);
 void bnxt_tx_disable(struct bnxt *bp);
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -169,7 +169,6 @@ static int bnxt_req_msix_vecs(struct bnx
 		edev->ulp_tbl[ulp_id].msix_requested = avail_msix;
 	}
 	bnxt_fill_msix_vecs(bp, ent);
-	bnxt_set_max_func_irqs(bp, bnxt_get_max_func_irqs(bp) - avail_msix);
 	bnxt_set_max_func_cp_rings(bp, max_cp_rings - avail_msix);
 	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
 	return avail_msix;
@@ -192,7 +191,6 @@ static int bnxt_free_msix_vecs(struct bn
 	msix_requested = edev->ulp_tbl[ulp_id].msix_requested;
 	bnxt_set_max_func_cp_rings(bp, max_cp_rings + msix_requested);
 	edev->ulp_tbl[ulp_id].msix_requested = 0;
-	bnxt_set_max_func_irqs(bp, bnxt_get_max_func_irqs(bp) + msix_requested);
 	edev->flags &= ~BNXT_EN_FLAG_MSIX_REQUESTED;
 	if (netif_running(dev)) {
 		bnxt_close_nic(bp, true, false);



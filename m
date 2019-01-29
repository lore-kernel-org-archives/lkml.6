Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2028DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43F820881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763481;
	bh=I/baSjvT9WPxQf5cWTWvFDYXVJ6JLDnXfq0SnBAS8gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WgUQvNriFBSTO4hrMrrSIHeSUf4A+8e+LVB9GrvNscxaSfg01pZh8neZrJi9ype6I
	 IwUWJAwpDTHhY6ChYC/XkMuw2reqUXB1s9f2H1D3GXoA8+a8EMBhX/oXlBkTw4mi0r
	 cDzCglhBFXE8BkwmTxa2OZfxqR4DvWcoAEWHqwyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfA2Lmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730130AbfA2Lms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E7820857;
        Tue, 29 Jan 2019 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762167;
        bh=I/baSjvT9WPxQf5cWTWvFDYXVJ6JLDnXfq0SnBAS8gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LclsgPFrcCUHTm5Osrqs1pxTStcMofOG0Ean2YXNw/MAiFbnw2oMRhjG2t9juSunq
         hDW7Z0vq25kMU/peqq0fqoaVK8MGjTenCAWnvInlRHqHO4yxsFdvynP9Vub67bn6Uo
         xoEJTzk6UUnuSnVHbff7gjo2tFyrMWNzlBRp0VIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Semion Lisyansky <semionl@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 014/103] mlxsw: pci: Ring CQs doorbell before RDQs
Date:   Tue, 29 Jan 2019 12:34:51 +0100
Message-Id: <20190129113200.380757705@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>

When a packet should be trapped to the CPU the device consumes a WQE
(work queue element) from an RDQ (receive descriptor queue) and copies
the packet to the address specified in the WQE. The device then tries to
post a CQE (completion queue element) that contains various metadata
(e.g., ingress port) about the packet to a CQ (completion queue).

In case the device managed to consume a WQE, but did not manage to post
the corresponding CQE, it will get stuck. This unlikely situation can be
triggered due to the scheme the driver is currently using to process
CQEs.

The driver will consume up to 512 CQEs at a time and after processing
each corresponding WQE it will ring the RDQ's doorbell, letting the
device know that a new WQE was posted for it to consume. Only after
processing all the CQEs (up to 512), the driver will ring the CQ's
doorbell, letting the device know that new ones can be posted.

Fix this by having the driver ring the CQ's doorbell for every processed
CQE, but before ringing the RDQ's doorbell. This guarantees that
whenever we post a new WQE, there is a corresponding CQE available. Copy
the currently processed CQE to prevent the device from overwriting it
with a new CQE after ringing the doorbell.

Note that the driver still arms the CQ only after processing all the
pending CQEs, so that interrupts for this CQ will only be delivered
after the driver finished its processing.

Before commit 8404f6f2e8ed ("mlxsw: pci: Allow to use CQEs of version 1
and version 2") the issue was virtually impossible to trigger since the
number of CQEs was twice the number of WQEs and the number of CQEs
processed at a time was equal to the number of available WQEs.

Fixes: 8404f6f2e8ed ("mlxsw: pci: Allow to use CQEs of version 1 and version 2")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Semion Lisyansky <semionl@mellanox.com>
Tested-by: Semion Lisyansky <semionl@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c    |   12 +++++++-----
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h |    1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -604,29 +604,31 @@ static void mlxsw_pci_cq_tasklet(unsigne
 		u16 wqe_counter = mlxsw_pci_cqe_wqe_counter_get(cqe);
 		u8 sendq = mlxsw_pci_cqe_sr_get(q->u.cq.v, cqe);
 		u8 dqn = mlxsw_pci_cqe_dqn_get(q->u.cq.v, cqe);
+		char ncqe[MLXSW_PCI_CQE_SIZE_MAX];
+
+		memcpy(ncqe, cqe, q->elem_size);
+		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 
 		if (sendq) {
 			struct mlxsw_pci_queue *sdq;
 
 			sdq = mlxsw_pci_sdq_get(mlxsw_pci, dqn);
 			mlxsw_pci_cqe_sdq_handle(mlxsw_pci, sdq,
-						 wqe_counter, cqe);
+						 wqe_counter, ncqe);
 			q->u.cq.comp_sdq_count++;
 		} else {
 			struct mlxsw_pci_queue *rdq;
 
 			rdq = mlxsw_pci_rdq_get(mlxsw_pci, dqn);
 			mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
-						 wqe_counter, q->u.cq.v, cqe);
+						 wqe_counter, q->u.cq.v, ncqe);
 			q->u.cq.comp_rdq_count++;
 		}
 		if (++items == credits)
 			break;
 	}
-	if (items) {
-		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
+	if (items)
 		mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
-	}
 }
 
 static u16 mlxsw_pci_cq_elem_count(const struct mlxsw_pci_queue *q)
--- a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
@@ -53,6 +53,7 @@
 #define MLXSW_PCI_WQE_SIZE	32 /* 32 bytes per element */
 #define MLXSW_PCI_CQE01_SIZE	16 /* 16 bytes per element */
 #define MLXSW_PCI_CQE2_SIZE	32 /* 32 bytes per element */
+#define MLXSW_PCI_CQE_SIZE_MAX	MLXSW_PCI_CQE2_SIZE
 #define MLXSW_PCI_EQE_SIZE	16 /* 16 bytes per element */
 #define MLXSW_PCI_WQE_COUNT	(MLXSW_PCI_AQ_SIZE / MLXSW_PCI_WQE_SIZE)
 #define MLXSW_PCI_CQE01_COUNT	(MLXSW_PCI_AQ_SIZE / MLXSW_PCI_CQE01_SIZE)



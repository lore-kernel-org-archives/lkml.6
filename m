Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8B5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B33920989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5ZLdgHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B33920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbeKZV6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeKZV6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3646A20645;
        Mon, 26 Nov 2018 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230304;
        bh=PsOz21DxxdlII/yMeDVLTW76dnaUPkwtz4RCZKmKxHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5ZLdgHkSii5YUXwUZ9NJTzxyyyHhoSlc9clsFhDP6OBnw2AkizZ9V+YVT8VOhPLq
         wNjcNtQ0oGjMB51yvpq4+xEwwULKvOt03HzsdhM7ul34RqVr21qse8xnqNZCY+EdfI
         fxAVlha5ZlLPYmmBxnSWgomZlCFRVv3mfKkAEAjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 086/118] net: aquantia: fix potential IOMMU fault after driver unbind
Date:   Mon, 26 Nov 2018 11:51:20 +0100
Message-Id: <20181126105105.154535503@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7a1bb49461b12b2e6332a4d054256835f45203f3 ]

IOMMU fault may occurr on unbind/bind or if_down/if_up sequence.

Although driver disables the rings on down, this is not enough.
Due to internal HW design, during subsequent initialization
NIC sometimes may reuse RX descriptors cache and write to the
host memory from the descriptor cache.
That's get catched by IOMMU on host.

This patch invalidates the descriptor cache in NIC on interface down
to prevent writing to the cached descriptors and to the memory pointed
in those descriptors.

Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../aquantia/atlantic/hw_atl/hw_atl_b0.c       |  6 ++++++
 .../aquantia/atlantic/hw_atl/hw_atl_llh.c      |  8 ++++++++
 .../aquantia/atlantic/hw_atl/hw_atl_llh.h      |  3 +++
 .../atlantic/hw_atl/hw_atl_llh_internal.h      | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 1d44a386e7d3..0271a0fdfee8 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -915,6 +915,12 @@ static int hw_atl_b0_hw_interrupt_moderation_set(struct aq_hw_s *self)
 static int hw_atl_b0_hw_stop(struct aq_hw_s *self)
 {
 	hw_atl_b0_hw_irq_disable(self, HW_ATL_B0_INT_MASK);
+
+	/* Invalidate Descriptor Cache to prevent writing to the cached
+	 * descriptors and to the data pointer of those descriptors
+	 */
+	hw_atl_rdm_rx_dma_desc_cache_init_set(self, 1);
+
 	return aq_hw_err_from_flags(self);
 }
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
index 10ba035dadb1..10ec5dc88e24 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
@@ -619,6 +619,14 @@ void hw_atl_rpb_rx_flow_ctl_mode_set(struct aq_hw_s *aq_hw, u32 rx_flow_ctl_mode
 			    HW_ATL_RPB_RX_FC_MODE_SHIFT, rx_flow_ctl_mode);
 }
 
+void hw_atl_rdm_rx_dma_desc_cache_init_set(struct aq_hw_s *aq_hw, u32 init)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL_RDM_RX_DMA_DESC_CACHE_INIT_ADR,
+			    HW_ATL_RDM_RX_DMA_DESC_CACHE_INIT_MSK,
+			    HW_ATL_RDM_RX_DMA_DESC_CACHE_INIT_SHIFT,
+			    init);
+}
+
 void hw_atl_rpb_rx_pkt_buff_size_per_tc_set(struct aq_hw_s *aq_hw,
 					    u32 rx_pkt_buff_size_per_tc, u32 buffer)
 {
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h
index dfb426f2dc2c..b3bf64b48b93 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h
@@ -325,6 +325,9 @@ void hw_atl_rpb_rx_pkt_buff_size_per_tc_set(struct aq_hw_s *aq_hw,
 					    u32 rx_pkt_buff_size_per_tc,
 					    u32 buffer);
 
+/* set rdm rx dma descriptor cache init */
+void hw_atl_rdm_rx_dma_desc_cache_init_set(struct aq_hw_s *aq_hw, u32 init);
+
 /* set rx xoff enable (per tc) */
 void hw_atl_rpb_rx_xoff_en_per_tc_set(struct aq_hw_s *aq_hw, u32 rx_xoff_en_per_tc,
 				      u32 buffer);
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
index e0cf70120f1d..e2ecdb1c5a5c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
@@ -293,6 +293,24 @@
 /* default value of bitfield desc{d}_reset */
 #define HW_ATL_RDM_DESCDRESET_DEFAULT 0x0
 
+/* rdm_desc_init_i bitfield definitions
+ * preprocessor definitions for the bitfield rdm_desc_init_i.
+ * port="pif_rdm_desc_init_i"
+ */
+
+/* register address for bitfield rdm_desc_init_i */
+#define HW_ATL_RDM_RX_DMA_DESC_CACHE_INIT_ADR 0x00005a00
+/* bitmask for bitfield rdm_desc_init_i */
+#define HW_ATL_RDM_RX_DMA_DESC_CACHE_INIT_MSK 0xffffffff
+/* inverted bitmask for bitfield rdm_desc_init_i */
+#define HW_ATL_RDM_RX_DMA_DESC_CACHE_INIT_MSKN 0x00000000
+/* lower bit position of bitfield  rdm_desc_init_i */
+#define HW_ATL_RDM_RX_DMA_DESC_CACHE_INIT_SHIFT 0
+/* width of bitfield rdm_desc_init_i */
+#define HW_ATL_RDM_RX_DMA_DESC_CACHE_INIT_WIDTH 32
+/* default value of bitfield rdm_desc_init_i */
+#define HW_ATL_RDM_RX_DMA_DESC_CACHE_INIT_DEFAULT 0x0
+
 /* rx int_desc_wrb_en bitfield definitions
  * preprocessor definitions for the bitfield "int_desc_wrb_en".
  * port="pif_rdm_int_desc_wrb_en_i"
-- 
2.17.1




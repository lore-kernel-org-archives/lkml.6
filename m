Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300F9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AFA2251C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHMHeIL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AFA2251C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbeKOI2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:28:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeKOI12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:28 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62182251A;
        Wed, 14 Nov 2018 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234144;
        bh=60MJEDb2GN9Ntw+SChJdZFxyEwXydI23/fO1nKnVCaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHMHeIL6YOhGgV1iRVgJ1Xfy39QcR+gWDFYmeoVyn0A3ap8pe18Nm0VAb+PdNA3lY
         mGzBEK4/qhNlGywvDhu4svpCIqnEFUsdl8dydu3EfGx2pIoaxZD8nQj9mOATVfq3cM
         t8uKRiwN5RIbv9vuLrf98S1WaG+Gm/0d9WMdpdnk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 67/73] net: aquantia: fix potential IOMMU fault after driver unbind
Date:   Wed, 14 Nov 2018 17:22:01 -0500
Message-Id: <20181114222207.98701-67-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>

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


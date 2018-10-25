Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F49DECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051EF20854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1gDd5+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051EF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeJYWsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbeJYWsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:13 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9512B20834;
        Thu, 25 Oct 2018 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476916;
        bh=aadg4Mpj4prdsxV0X0on3nI3wpzGrUXTOSAmVxMF568=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1gDd5+msK35cVFbBn2SLVNPdCwqv/qG9zORFvgXTgl9f4FSX7psn5oLpK2Uy3rbs
         7qgFStC26lh4av3C94iH8kURZo7afuxiMZZaXME3XpUIM3Hm1SCowSX+j2GJM40kX2
         uzCBWYEspEbUb4EiRcEd6coxOYZwkmjpvHxMqRqE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Chopra, Manish" <Manish.Chopra@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 35/98] qlcnic: Fix tunnel offload for 82xx adapters
Date:   Thu, 25 Oct 2018 10:13:20 -0400
Message-Id: <20181025141423.213774-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chopra, Manish" <Manish.Chopra@cavium.com>

[ Upstream commit 4bd7ef0b033721b659b9357057e76d1ced95c1da ]

Qlogic's 82xx series adapter doesn't support
tunnel offloads, driver incorrectly assumes that it is
supported and causes firmware hang while running tunnel IO.

This patch fixes this by not advertising tunnel offloads
for 82xx adapters.

Signed-off-by: Manish Chopra <manish.chopra@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h   | 26 +++++++++++++++++--
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |  2 ++
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  2 ++
 .../qlogic/qlcnic/qlcnic_sriov_common.c       |  2 ++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
index 5ddadcd0c8db..f1242ab32ca6 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
@@ -1825,22 +1825,44 @@ struct qlcnic_hardware_ops {
 	u32 (*get_cap_size)(void *, int);
 	void (*set_sys_info)(void *, int, u32);
 	void (*store_cap_mask)(void *, u32);
+	bool (*encap_rx_offload) (struct qlcnic_adapter *adapter);
+	bool (*encap_tx_offload) (struct qlcnic_adapter *adapter);
 };
 
 extern struct qlcnic_nic_template qlcnic_vf_ops;
 
-static inline bool qlcnic_encap_tx_offload(struct qlcnic_adapter *adapter)
+static inline bool qlcnic_83xx_encap_tx_offload(struct qlcnic_adapter *adapter)
 {
 	return adapter->ahw->extra_capability[0] &
 	       QLCNIC_83XX_FW_CAPAB_ENCAP_TX_OFFLOAD;
 }
 
-static inline bool qlcnic_encap_rx_offload(struct qlcnic_adapter *adapter)
+static inline bool qlcnic_83xx_encap_rx_offload(struct qlcnic_adapter *adapter)
 {
 	return adapter->ahw->extra_capability[0] &
 	       QLCNIC_83XX_FW_CAPAB_ENCAP_RX_OFFLOAD;
 }
 
+static inline bool qlcnic_82xx_encap_tx_offload(struct qlcnic_adapter *adapter)
+{
+	return false;
+}
+
+static inline bool qlcnic_82xx_encap_rx_offload(struct qlcnic_adapter *adapter)
+{
+        return false;
+}
+
+static inline bool qlcnic_encap_rx_offload(struct qlcnic_adapter *adapter)
+{
+        return adapter->ahw->hw_ops->encap_rx_offload(adapter);
+}
+
+static inline bool qlcnic_encap_tx_offload(struct qlcnic_adapter *adapter)
+{
+        return adapter->ahw->hw_ops->encap_tx_offload(adapter);
+}
+
 static inline int qlcnic_start_firmware(struct qlcnic_adapter *adapter)
 {
 	return adapter->nic_ops->start_firmware(adapter);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index 05d32e86bcf7..35c5ac41c0a1 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -242,6 +242,8 @@ static struct qlcnic_hardware_ops qlcnic_83xx_hw_ops = {
 	.get_cap_size			= qlcnic_83xx_get_cap_size,
 	.set_sys_info			= qlcnic_83xx_set_sys_info,
 	.store_cap_mask			= qlcnic_83xx_store_cap_mask,
+	.encap_rx_offload		= qlcnic_83xx_encap_rx_offload,
+	.encap_tx_offload		= qlcnic_83xx_encap_tx_offload,
 };
 
 static struct qlcnic_nic_template qlcnic_83xx_ops = {
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 3ae3968b0edf..ebf5ead16939 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -632,6 +632,8 @@ static struct qlcnic_hardware_ops qlcnic_hw_ops = {
 	.get_cap_size			= qlcnic_82xx_get_cap_size,
 	.set_sys_info			= qlcnic_82xx_set_sys_info,
 	.store_cap_mask			= qlcnic_82xx_store_cap_mask,
+	.encap_rx_offload               = qlcnic_82xx_encap_rx_offload,
+	.encap_tx_offload               = qlcnic_82xx_encap_tx_offload,
 };
 
 static int qlcnic_check_multi_tx_capability(struct qlcnic_adapter *adapter)
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 2f656f395f39..c58180f40844 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -77,6 +77,8 @@ static struct qlcnic_hardware_ops qlcnic_sriov_vf_hw_ops = {
 	.free_mac_list			= qlcnic_sriov_vf_free_mac_list,
 	.enable_sds_intr		= qlcnic_83xx_enable_sds_intr,
 	.disable_sds_intr		= qlcnic_83xx_disable_sds_intr,
+	.encap_rx_offload               = qlcnic_83xx_encap_rx_offload,
+	.encap_tx_offload               = qlcnic_83xx_encap_tx_offload,
 };
 
 static struct qlcnic_nic_template qlcnic_sriov_vf_ops = {
-- 
2.17.1


Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E72C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E072B2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277112;
	bh=tgJK/lLolqTjWI881ehaYx1h7zTatW4NSLm0PTJorGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N1j0CTybl6BC7TKVTfnlDmdxzSsCUsTmQIARksuEVNHqP1yGHWwrSAvoxXYYkgbj1
	 OIBBhkGtkOQLgJzg2DTKLYUQJpXfh099AMWYm351mZoW6/MTFB61SJyPImmPJf3Qpz
	 7ODvbWjHtDnmkSIuxXJEdk8MkC7upUxHUReNMrko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfBDKpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730338AbfBDKpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:45:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65CA82070C;
        Mon,  4 Feb 2019 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277102;
        bh=tgJK/lLolqTjWI881ehaYx1h7zTatW4NSLm0PTJorGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrq2v2HQGQaNk5Wny+5MVcKx7l9qgywReE70/iZo8K20WZP4Yzwv/6N/gJivck0Vz
         CNmtXJ7mNkH2NJHkq32eXmxX1XqKsTL81kHAevKzo+UW4dFhinemA++EeGq8wtpYCf
         DpGRp6rsvakP+/eVEBeFyUAthmHHJGrXJsP8oOwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/46] net/mlx4_core: Add masking for a few queries on HCA caps
Date:   Mon,  4 Feb 2019 11:36:36 +0100
Message-Id: <20190204103609.597380964@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit a40ded6043658444ee4dd6ee374119e4e98b33fc ]

Driver reads the query HCA capabilities without the corresponding masks.
Without the correct masks, the base addresses of the queues are
unaligned.  In addition some reserved bits were wrongly read.  Using the
correct masks, ensures alignment of the base addresses and allows future
firmware versions safe use of the reserved bits.

Fixes: ab9c17a009ee ("mlx4_core: Modify driver initialization flow to accommodate SRIOV for Ethernet")
Fixes: 0ff1fb654bec ("{NET, IB}/mlx4: Add device managed flow steering firmware API")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/fw.c |   75 +++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 29 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
@@ -2048,9 +2048,11 @@ int mlx4_QUERY_HCA(struct mlx4_dev *dev,
 {
 	struct mlx4_cmd_mailbox *mailbox;
 	__be32 *outbox;
+	u64 qword_field;
 	u32 dword_field;
-	int err;
+	u16 word_field;
 	u8 byte_field;
+	int err;
 	static const u8 a0_dmfs_query_hw_steering[] =  {
 		[0] = MLX4_STEERING_DMFS_A0_DEFAULT,
 		[1] = MLX4_STEERING_DMFS_A0_DYNAMIC,
@@ -2078,19 +2080,32 @@ int mlx4_QUERY_HCA(struct mlx4_dev *dev,
 
 	/* QPC/EEC/CQC/EQC/RDMARC attributes */
 
-	MLX4_GET(param->qpc_base,      outbox, INIT_HCA_QPC_BASE_OFFSET);
-	MLX4_GET(param->log_num_qps,   outbox, INIT_HCA_LOG_QP_OFFSET);
-	MLX4_GET(param->srqc_base,     outbox, INIT_HCA_SRQC_BASE_OFFSET);
-	MLX4_GET(param->log_num_srqs,  outbox, INIT_HCA_LOG_SRQ_OFFSET);
-	MLX4_GET(param->cqc_base,      outbox, INIT_HCA_CQC_BASE_OFFSET);
-	MLX4_GET(param->log_num_cqs,   outbox, INIT_HCA_LOG_CQ_OFFSET);
-	MLX4_GET(param->altc_base,     outbox, INIT_HCA_ALTC_BASE_OFFSET);
-	MLX4_GET(param->auxc_base,     outbox, INIT_HCA_AUXC_BASE_OFFSET);
-	MLX4_GET(param->eqc_base,      outbox, INIT_HCA_EQC_BASE_OFFSET);
-	MLX4_GET(param->log_num_eqs,   outbox, INIT_HCA_LOG_EQ_OFFSET);
-	MLX4_GET(param->num_sys_eqs,   outbox, INIT_HCA_NUM_SYS_EQS_OFFSET);
-	MLX4_GET(param->rdmarc_base,   outbox, INIT_HCA_RDMARC_BASE_OFFSET);
-	MLX4_GET(param->log_rd_per_qp, outbox, INIT_HCA_LOG_RD_OFFSET);
+	MLX4_GET(qword_field, outbox, INIT_HCA_QPC_BASE_OFFSET);
+	param->qpc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_QP_OFFSET);
+	param->log_num_qps = byte_field & 0x1f;
+	MLX4_GET(qword_field, outbox, INIT_HCA_SRQC_BASE_OFFSET);
+	param->srqc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_SRQ_OFFSET);
+	param->log_num_srqs = byte_field & 0x1f;
+	MLX4_GET(qword_field, outbox, INIT_HCA_CQC_BASE_OFFSET);
+	param->cqc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_CQ_OFFSET);
+	param->log_num_cqs = byte_field & 0x1f;
+	MLX4_GET(qword_field, outbox, INIT_HCA_ALTC_BASE_OFFSET);
+	param->altc_base = qword_field;
+	MLX4_GET(qword_field, outbox, INIT_HCA_AUXC_BASE_OFFSET);
+	param->auxc_base = qword_field;
+	MLX4_GET(qword_field, outbox, INIT_HCA_EQC_BASE_OFFSET);
+	param->eqc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_EQ_OFFSET);
+	param->log_num_eqs = byte_field & 0x1f;
+	MLX4_GET(word_field, outbox, INIT_HCA_NUM_SYS_EQS_OFFSET);
+	param->num_sys_eqs = word_field & 0xfff;
+	MLX4_GET(qword_field, outbox, INIT_HCA_RDMARC_BASE_OFFSET);
+	param->rdmarc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_RD_OFFSET);
+	param->log_rd_per_qp = byte_field & 0x7;
 
 	MLX4_GET(dword_field, outbox, INIT_HCA_FLAGS_OFFSET);
 	if (dword_field & (1 << INIT_HCA_DEVICE_MANAGED_FLOW_STEERING_EN)) {
@@ -2109,22 +2124,21 @@ int mlx4_QUERY_HCA(struct mlx4_dev *dev,
 	/* steering attributes */
 	if (param->steering_mode == MLX4_STEERING_MODE_DEVICE_MANAGED) {
 		MLX4_GET(param->mc_base, outbox, INIT_HCA_FS_BASE_OFFSET);
-		MLX4_GET(param->log_mc_entry_sz, outbox,
-			 INIT_HCA_FS_LOG_ENTRY_SZ_OFFSET);
-		MLX4_GET(param->log_mc_table_sz, outbox,
-			 INIT_HCA_FS_LOG_TABLE_SZ_OFFSET);
-		MLX4_GET(byte_field, outbox,
-			 INIT_HCA_FS_A0_OFFSET);
+		MLX4_GET(byte_field, outbox, INIT_HCA_FS_LOG_ENTRY_SZ_OFFSET);
+		param->log_mc_entry_sz = byte_field & 0x1f;
+		MLX4_GET(byte_field, outbox, INIT_HCA_FS_LOG_TABLE_SZ_OFFSET);
+		param->log_mc_table_sz = byte_field & 0x1f;
+		MLX4_GET(byte_field, outbox, INIT_HCA_FS_A0_OFFSET);
 		param->dmfs_high_steer_mode =
 			a0_dmfs_query_hw_steering[(byte_field >> 6) & 3];
 	} else {
 		MLX4_GET(param->mc_base, outbox, INIT_HCA_MC_BASE_OFFSET);
-		MLX4_GET(param->log_mc_entry_sz, outbox,
-			 INIT_HCA_LOG_MC_ENTRY_SZ_OFFSET);
-		MLX4_GET(param->log_mc_hash_sz,  outbox,
-			 INIT_HCA_LOG_MC_HASH_SZ_OFFSET);
-		MLX4_GET(param->log_mc_table_sz, outbox,
-			 INIT_HCA_LOG_MC_TABLE_SZ_OFFSET);
+		MLX4_GET(byte_field, outbox, INIT_HCA_LOG_MC_ENTRY_SZ_OFFSET);
+		param->log_mc_entry_sz = byte_field & 0x1f;
+		MLX4_GET(byte_field,  outbox, INIT_HCA_LOG_MC_HASH_SZ_OFFSET);
+		param->log_mc_hash_sz = byte_field & 0x1f;
+		MLX4_GET(byte_field, outbox, INIT_HCA_LOG_MC_TABLE_SZ_OFFSET);
+		param->log_mc_table_sz = byte_field & 0x1f;
 	}
 
 	/* CX3 is capable of extending CQEs/EQEs from 32 to 64 bytes */
@@ -2148,15 +2162,18 @@ int mlx4_QUERY_HCA(struct mlx4_dev *dev,
 	/* TPT attributes */
 
 	MLX4_GET(param->dmpt_base,  outbox, INIT_HCA_DMPT_BASE_OFFSET);
-	MLX4_GET(param->mw_enabled, outbox, INIT_HCA_TPT_MW_OFFSET);
-	MLX4_GET(param->log_mpt_sz, outbox, INIT_HCA_LOG_MPT_SZ_OFFSET);
+	MLX4_GET(byte_field, outbox, INIT_HCA_TPT_MW_OFFSET);
+	param->mw_enabled = byte_field >> 7;
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_MPT_SZ_OFFSET);
+	param->log_mpt_sz = byte_field & 0x3f;
 	MLX4_GET(param->mtt_base,   outbox, INIT_HCA_MTT_BASE_OFFSET);
 	MLX4_GET(param->cmpt_base,  outbox, INIT_HCA_CMPT_BASE_OFFSET);
 
 	/* UAR attributes */
 
 	MLX4_GET(param->uar_page_sz, outbox, INIT_HCA_UAR_PAGE_SZ_OFFSET);
-	MLX4_GET(param->log_uar_sz, outbox, INIT_HCA_LOG_UAR_SZ_OFFSET);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_UAR_SZ_OFFSET);
+	param->log_uar_sz = byte_field & 0xf;
 
 	/* phv_check enable */
 	MLX4_GET(byte_field, outbox, INIT_HCA_CACHELINE_SZ_OFFSET);



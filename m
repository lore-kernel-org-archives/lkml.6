Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85312C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C6C20661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957118;
	bh=Clj/HtEaO58PsCho28r97eFtDqpjsbf5gpuNOCt1ldI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mU8osUhAVQXr2nZYHuppdI53BdPlJVDyswjyBtxZf/tdou4y60zAjZ0UGjToNRWNg
	 Ok/2gh70Ci877sMjcRj9Vsobrgv9XNY5UCWs8SwG4/ryqxOY23cIR8GuStwcLTk7FD
	 HSST1d6FedaE6wo99ekRss2rxqyi1chVcUx+S5Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfBWVZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:25:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbfBWVHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07B820866;
        Sat, 23 Feb 2019 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956066;
        bh=Clj/HtEaO58PsCho28r97eFtDqpjsbf5gpuNOCt1ldI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jle15SfH+K1SAHklJ+cD6Ydcj33ZR1XSPF2HJY6IXlMMjAj7WVVc7lYyO4B4NQVoO
         MDevCBtH5CkfgqdxrDlNcR3v3KhxDFT5K2H6eB8ALPdcIalAw6VeoAZlGFqrUsWM4n
         xtIribRre5+aFN4vDG+ifrZ53mh/nevOg6ZZ7GE4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 40/65] qed: Fix LACP pdu drops for VFs
Date:   Sat, 23 Feb 2019 16:06:15 -0500
Message-Id: <20190223210640.200911-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit ff9296966e5e00b0d0d00477b2365a178f0f06a3 ]

VF is always configured to drop control frames
(with reserved mac addresses) but to work LACP
on the VFs, it would require LACP control frames
to be forwarded or transmitted successfully.

This patch fixes this in such a way that trusted VFs
(marked through ndo_set_vf_trust) would be allowed to
pass the control frames such as LACP pdus.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c    |  5 +++++
 drivers/net/ethernet/qlogic/qed/qed_l2.h    |  3 +++
 drivers/net/ethernet/qlogic/qed/qed_sriov.c | 10 ++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index b8baa6fcef8e3..e68ca83ae9153 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -748,6 +748,11 @@ int qed_sp_vport_update(struct qed_hwfn *p_hwfn,
 		return rc;
 	}
 
+	if (p_params->update_ctl_frame_check) {
+		p_cmn->ctl_frame_mac_check_en = p_params->mac_chk_en;
+		p_cmn->ctl_frame_ethtype_check_en = p_params->ethtype_chk_en;
+	}
+
 	/* Update mcast bins for VFs, PF doesn't use this functionality */
 	qed_sp_update_mcast_bin(p_hwfn, p_ramrod, p_params);
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.h b/drivers/net/ethernet/qlogic/qed/qed_l2.h
index 8d80f1095d171..7127d5aaac422 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.h
@@ -219,6 +219,9 @@ struct qed_sp_vport_update_params {
 	struct qed_rss_params		*rss_params;
 	struct qed_filter_accept_flags	accept_flags;
 	struct qed_sge_tpa_params	*sge_tpa_params;
+	u8				update_ctl_frame_check;
+	u8				mac_chk_en;
+	u8				ethtype_chk_en;
 };
 
 int qed_sp_vport_update(struct qed_hwfn *p_hwfn,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index ca6290fa0f309..71a7af134dd8e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -1969,7 +1969,9 @@ static void qed_iov_vf_mbx_start_vport(struct qed_hwfn *p_hwfn,
 	params.vport_id = vf->vport_id;
 	params.max_buffers_per_cqe = start->max_buffers_per_cqe;
 	params.mtu = vf->mtu;
-	params.check_mac = true;
+
+	/* Non trusted VFs should enable control frame filtering */
+	params.check_mac = !vf->p_vf_info.is_trusted_configured;
 
 	rc = qed_sp_eth_vport_start(p_hwfn, &params);
 	if (rc) {
@@ -5130,6 +5132,9 @@ static void qed_iov_handle_trust_change(struct qed_hwfn *hwfn)
 		params.opaque_fid = vf->opaque_fid;
 		params.vport_id = vf->vport_id;
 
+		params.update_ctl_frame_check = 1;
+		params.mac_chk_en = !vf_info->is_trusted_configured;
+
 		if (vf_info->rx_accept_mode & mask) {
 			flags->update_rx_mode_config = 1;
 			flags->rx_accept_filter = vf_info->rx_accept_mode;
@@ -5147,7 +5152,8 @@ static void qed_iov_handle_trust_change(struct qed_hwfn *hwfn)
 		}
 
 		if (flags->update_rx_mode_config ||
-		    flags->update_tx_mode_config)
+		    flags->update_tx_mode_config ||
+		    params.update_ctl_frame_check)
 			qed_sp_vport_update(hwfn, &params,
 					    QED_SPQ_MODE_EBLOCK, NULL);
 	}
-- 
2.19.1


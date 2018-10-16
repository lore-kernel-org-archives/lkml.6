Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEAC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E100A21480
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNJ2MY93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E100A21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeJPMBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbeJPMBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1BB12145D;
        Tue, 16 Oct 2018 04:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663172;
        bh=Al+SHSL1RMsGSZ6ScEcrncJGUdT/huAMwVpR5aojDeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNJ2MY93yPubpdTZauKgp9c8DI+BYc5pf5zF/8lh0gWdkWult3I/BPxiuk7lElHUH
         NxjyaDLZirkY/zcvXQCFRnhw0ONh9okz1R1Md4Q8zMV5qgYZ7aTSEXKe9NSPqDPrGl
         WKEwrXKkZyrw5IkS77O5jhPfO/45O2O0ze5EqF00=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 031/100] qed: Fix mask parameter in qed_vf_prep_tunn_req_tlv
Date:   Tue, 16 Oct 2018 00:11:12 -0400
Message-Id: <20181016041221.135528-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit db803f36e56f23b5a2266807e190d1dc11554d54 ]

Clang complains when one enumerated type is implicitly converted to
another.

drivers/net/ethernet/qlogic/qed/qed_vf.c:686:6: warning: implicit
conversion from enumeration type 'enum qed_tunn_mode' to different
enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
                                 QED_MODE_L2GENEVE_TUNN,
                                 ^~~~~~~~~~~~~~~~~~~~~~

Update mask's parameter to expect qed_tunn_mode, which is what was
intended.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index be6ddde1a104..ac3f54bbe9b9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -572,7 +572,7 @@ int qed_vf_hw_prepare(struct qed_hwfn *p_hwfn)
 static void
 __qed_vf_prep_tunn_req_tlv(struct vfpf_update_tunn_param_tlv *p_req,
 			   struct qed_tunn_update_type *p_src,
-			   enum qed_tunn_clss mask, u8 *p_cls)
+			   enum qed_tunn_mode mask, u8 *p_cls)
 {
 	if (p_src->b_update_mode) {
 		p_req->tun_mode_update_mask |= BIT(mask);
@@ -587,7 +587,7 @@ __qed_vf_prep_tunn_req_tlv(struct vfpf_update_tunn_param_tlv *p_req,
 static void
 qed_vf_prep_tunn_req_tlv(struct vfpf_update_tunn_param_tlv *p_req,
 			 struct qed_tunn_update_type *p_src,
-			 enum qed_tunn_clss mask,
+			 enum qed_tunn_mode mask,
 			 u8 *p_cls, struct qed_tunn_update_udp_port *p_port,
 			 u8 *p_update_port, u16 *p_udp_port)
 {
-- 
2.17.1


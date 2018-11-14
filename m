Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA13C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD8E22547
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r82l/rp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD8E22547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbeKOI3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732896AbeKOI3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:53 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFE22252B;
        Wed, 14 Nov 2018 22:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234289;
        bh=gBQg2d1D88jv3FxnUPFkv8Z5gUs9Ya6aolVT3+ZfWUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r82l/rp+3zQFTIDU9gVPCJngs5shRVDr03iFpuTrKRQTGLV64YybosVyKFH/91YO1
         XJRMxgVigEkZPd662yAwKcb0oo2T64/YeyZI8zImAbptm0l/0np+vGft6Ajtfl2cfu
         mMfkN0+C9OJKV5gQDCgb82uF1/ixVipDsRjG5A3Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 47/59] qed: Fix memory/entry leak in qed_init_sp_request()
Date:   Wed, 14 Nov 2018 17:23:19 -0500
Message-Id: <20181114222335.99339-47-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Bolotin <denis.bolotin@cavium.com>

[ Upstream commit 39477551df940ddb1339203817de04f5caaacf7a ]

Free the allocated SPQ entry or return the acquired SPQ entry to the free
list in error flows.

Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/qlogic/qed/qed_sp_commands.c    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
index 77b6248ad3b9..e86a1ea23613 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
@@ -80,7 +80,7 @@ int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 
 	case QED_SPQ_MODE_BLOCK:
 		if (!p_data->p_comp_data)
-			return -EINVAL;
+			goto err;
 
 		p_ent->comp_cb.cookie = p_data->p_comp_data->cookie;
 		break;
@@ -95,7 +95,7 @@ int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 	default:
 		DP_NOTICE(p_hwfn, "Unknown SPQE completion mode %d\n",
 			  p_ent->comp_mode);
-		return -EINVAL;
+		goto err;
 	}
 
 	DP_VERBOSE(p_hwfn, QED_MSG_SPQ,
@@ -109,6 +109,18 @@ int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 	memset(&p_ent->ramrod, 0, sizeof(p_ent->ramrod));
 
 	return 0;
+
+err:
+	/* qed_spq_get_entry() can either get an entry from the free_pool,
+	 * or, if no entries are left, allocate a new entry and add it to
+	 * the unlimited_pending list.
+	 */
+	if (p_ent->queue == &p_hwfn->p_spq->unlimited_pending)
+		kfree(p_ent);
+	else
+		qed_spq_return_entry(p_hwfn, p_ent);
+
+	return -EINVAL;
 }
 
 static enum tunnel_clss qed_tunn_clss_to_fw_clss(u8 type)
-- 
2.17.1


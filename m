Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70854C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7B722513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfUP0yAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7B722513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbeKOI12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbeKOI11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:27 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A0C22522;
        Wed, 14 Nov 2018 22:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234143;
        bh=bDzVpBEeasCK6L2LHb5Avj++8I4uhG/rkiWq/6M38lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfUP0yAA5NLEq8AAEAXbOuyWqGrKhle2asINIZlvf22r1bpm1eDhOVYesvhktxc9/
         /ILYRLVcN8A/2GqsPoPi4K6uOPpeggE0Bn+AdyfvEryPyZWpgICbtQcC4Wpdk7HW/J
         zv60k2ic219tLlT1ojNyRbcoxPHflX3vMYRCC2DI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sagiv Ozeri <sagiv.ozeri@cavium.com>,
        Denis Bolotin <denis.bolotin@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 63/73] qed: Fix potential memory corruption
Date:   Wed, 14 Nov 2018 17:21:57 -0500
Message-Id: <20181114222207.98701-63-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagiv Ozeri <sagiv.ozeri@cavium.com>

[ Upstream commit fa5c448d98f0df660bfcad3dd5facc027ef84cd3 ]

A stuck ramrod should be deleted from the completion_pending list,
otherwise it will be added again in the future and corrupt the list.

Return error value to inform that ramrod is stuck and should be deleted.

Signed-off-by: Sagiv Ozeri <sagiv.ozeri@cavium.com>
Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_spq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_spq.c b/drivers/net/ethernet/qlogic/qed/qed_spq.c
index 43619b6bb232..7106ad17afe2 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_spq.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_spq.c
@@ -142,6 +142,7 @@ static int qed_spq_block(struct qed_hwfn *p_hwfn,
 
 	DP_INFO(p_hwfn, "Ramrod is stuck, requesting MCP drain\n");
 	rc = qed_mcp_drain(p_hwfn, p_ptt);
+	qed_ptt_release(p_hwfn, p_ptt);
 	if (rc) {
 		DP_NOTICE(p_hwfn, "MCP drain failed\n");
 		goto err;
@@ -150,18 +151,15 @@ static int qed_spq_block(struct qed_hwfn *p_hwfn,
 	/* Retry after drain */
 	rc = __qed_spq_block(p_hwfn, p_ent, p_fw_ret, true);
 	if (!rc)
-		goto out;
+		return 0;
 
 	comp_done = (struct qed_spq_comp_done *)p_ent->comp_cb.cookie;
-	if (comp_done->done == 1)
+	if (comp_done->done == 1) {
 		if (p_fw_ret)
 			*p_fw_ret = comp_done->fw_return_code;
-out:
-	qed_ptt_release(p_hwfn, p_ptt);
-	return 0;
-
+		return 0;
+	}
 err:
-	qed_ptt_release(p_hwfn, p_ptt);
 	DP_NOTICE(p_hwfn,
 		  "Ramrod is stuck [CID %08x cmd %02x protocol %02x echo %04x]\n",
 		  le32_to_cpu(p_ent->elem.hdr.cid),
-- 
2.17.1


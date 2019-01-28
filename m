Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3961FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B7421783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690972;
	bh=lLMz3wPd3HhBhwdzUjg+kMYT4fN2D2jscQXkEkV7hj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nqDQ5LkAauj7Yh9yy4ztlYg361SDj6U7N6aPEbJbCsqIj3pE34YHxj3l+DPsiLrKf
	 DdpnjBLnSKZOMLw1Z6ZDIX6XjNgGB8+9kl3cZbIuJsT/lIrpGYuVxCGmhkneUSRWx0
	 tSSuj3Az8mt97QlLrmtz6DhkmyxYY9qOG/0uxK9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfA1P4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbfA1P4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:56:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A887F2183F;
        Mon, 28 Jan 2019 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690964;
        bh=lLMz3wPd3HhBhwdzUjg+kMYT4fN2D2jscQXkEkV7hj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3NRVPY9rWs3ZGp7w+8oEbzQKFeu62dWQw12PFbKYuBwnxODklQIv3aGW3/JkSLPh
         ANVAv1eBbkSG4IlpGnrk4RIGbl5ApI0TJ387iuHHDO2aDOVBHb2GqGhH3LSDogJKRd
         YAdS2ZvhtlYGvyarHw/hy2bHt/QrokABbb2eWpGg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Young Xiao <YangX92@hotmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 248/304] ice: Do not enable NAPI on q_vectors that have no rings
Date:   Mon, 28 Jan 2019 10:42:45 -0500
Message-Id: <20190128154341.47195-248-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <YangX92@hotmail.com>

[ Upstream commit eec903769b4ea476591ffff73bb7359f14f38c51 ]

If ice driver has q_vectors w/ active NAPI that has no rings,
then this will result in a divide by zero error. To correct it
I am updating the driver code so that we only support NAPI on
q_vectors that have 1 or more rings allocated to them.

See commit 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors
that have no rings") for detail.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
Acked-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 333312a1d595..945000449279 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2563,8 +2563,12 @@ static void ice_napi_enable_all(struct ice_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
-		napi_enable(&vsi->q_vectors[q_idx]->napi);
+	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
+
+		if (q_vector->rx.ring || q_vector->tx.ring)
+			napi_enable(&q_vector->napi);
+	}
 }
 
 /**
@@ -2931,8 +2935,12 @@ static void ice_napi_disable_all(struct ice_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
-		napi_disable(&vsi->q_vectors[q_idx]->napi);
+	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
+
+		if (q_vector->rx.ring || q_vector->tx.ring)
+			napi_disable(&q_vector->napi);
+	}
 }
 
 /**
-- 
2.19.1


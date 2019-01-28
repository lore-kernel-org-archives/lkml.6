Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBB9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABDE2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695539;
	bh=cWT+3wHl4fh/O3uJciDJKpHd1NBQ8RSh/G/cSfLyFa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYHO3C0wyFbpfpj3O+W5uu7kimwMvd55D+0AsGYqq3eGGH97GQkl75HshkO0Fdag+
	 68UZgn+rkojaPrXlla0abY/5ZrwEYuYqbho2F9kw9F5+sTDov3baXQzieU3zKY16Pc
	 DhtHglLEAba911ZFYdM7+Kfg0oXJbm7Xvv71EpT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbfA1RMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:12:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbfA1QJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CFDA21738;
        Mon, 28 Jan 2019 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691761;
        bh=cWT+3wHl4fh/O3uJciDJKpHd1NBQ8RSh/G/cSfLyFa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0+1lWYP3MxWjODLnwbQCfEirEMCWmas+6cR4ANwgCyPnkMlBdEkCdlSRrenFRZfB
         EECHVlAJCiWJUwsrINTt2NhPs9lpym3qv0fw/RZpPVo+BTt1E7Y2/hz5YxzhPIx/0e
         tjJm8CMNRA/D7oYEgw/OB7812g3nz8LOYWVbHEh0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Young Xiao <YangX92@hotmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 208/258] ice: Do not enable NAPI on q_vectors that have no rings
Date:   Mon, 28 Jan 2019 10:58:34 -0500
Message-Id: <20190128155924.51521-208-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 3f047bb43348..db1543bca701 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4333,8 +4333,12 @@ static void ice_napi_enable_all(struct ice_vsi *vsi)
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
@@ -4817,8 +4821,12 @@ static void ice_napi_disable_all(struct ice_vsi *vsi)
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


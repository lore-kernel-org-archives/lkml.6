Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B849C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF00A218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900766;
	bh=Ng5fQiYRJ9rOSbXvdo++/Wm9yyWJHyKEqRr0lHD+mYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EchdMwKqLpIT61IZaVxITT4MRZRq0Q/6dUKVhTVpIMZOz0uhO+2xGDbwPIc57RhfL
	 FoW64pMAuQdpv5rUwz5Tk4RTrruUHHH4TN28clP0udGWKs3T+6SpGENNSeoXMhYePo
	 dlAmlRm7Tc1o0rBe9o9yaEqgt2ushM4Z9Nacdecw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfBKP7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbfBKOcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3FB220844;
        Mon, 11 Feb 2019 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895534;
        bh=Ng5fQiYRJ9rOSbXvdo++/Wm9yyWJHyKEqRr0lHD+mYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCo/y9zSZnGYUho5MA2Y9ZbfDd53FMgw97sd+eNEFy0hhSrf1TtXur2dm9OF2jHtS
         OQKccnO1Efe3VAdI2KtjG9+wYTiFYvUrTmjnZ1RBLJw5ZGMDy6yek+9vwN2cFjIIUI
         qDiuadGBvUp5PwQ+xH9uvIpoabsfrIFCLKMCUU4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young Xiao <YangX92@hotmail.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 236/352] ice: Do not enable NAPI on q_vectors that have no rings
Date:   Mon, 11 Feb 2019 15:17:43 +0100
Message-Id: <20190211141902.197408152@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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




Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C828FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9031D2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPxjsrGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9031D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeK2RJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:09:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729481AbeK2RJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:09:21 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6795D2081C;
        Thu, 29 Nov 2018 06:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471509;
        bh=PMRMCqXbb94oyk+FKQzc8YeuNuBLqH1diJspZhaEzSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPxjsrGORP6LVlxGTCS8M0flEM0Tch+N1i9wqytVP70TJFZRocbxGMLyrxIHxPK8G
         iFHtzLxNFTyLaIX1/J7Wn6DG3+IdG8j1SfBobNORgNlRkaW/nKzKcv3vPCz20otWTE
         X78dMglZX1b2tqAxL+gxG+zjtBicVaIytk9ZBkxI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 07/13] qed: Fix reading wrong value in loop condition
Date:   Thu, 29 Nov 2018 01:04:38 -0500
Message-Id: <20181129060444.160434-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060444.160434-1-sashal@kernel.org>
References: <20181129060444.160434-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Bolotin <denis.bolotin@cavium.com>

[ Upstream commit ed4eac20dcffdad47709422e0cb925981b056668 ]

The value of "sb_index" is written by the hardware. Reading its value and
writing it to "index" must finish before checking the loop condition.

Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_int.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_int.c b/drivers/net/ethernet/qlogic/qed/qed_int.c
index 9cc9d62c1fec..8b15a018d625 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_int.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_int.c
@@ -177,6 +177,8 @@ static int qed_int_attentions(struct qed_hwfn *p_hwfn)
 	 */
 	do {
 		index = p_sb_attn->sb_index;
+		/* finish reading index before the loop condition */
+		dma_rmb();
 		attn_bits = le32_to_cpu(p_sb_attn->atten_bits);
 		attn_acks = le32_to_cpu(p_sb_attn->atten_ack);
 	} while (index != p_sb_attn->sb_index);
-- 
2.17.1


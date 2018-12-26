Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C1DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C415214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864540;
	bh=QQu/iPJ7+ROvuKy5dayjKDeMpBpcnT0R7E4P2euW8L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zGPVm2eQOHJw5zKuGE1xBg5c7W5Le8iofOuF2V/PtTl/4HvXNknQGnxCWmPxJKXs7
	 tOVQdS5oVDAoLibuZs563fkuF9c83EeyVF2GCjfiOdbo0D0GawxGaQEAbjDaanx4Sv
	 vkPQLKc3SHRh5FiNencQmKpR8rRdzLBSBlHNClq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeLZWs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbeLZWiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79D3218E2;
        Wed, 26 Dec 2018 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863880;
        bh=QQu/iPJ7+ROvuKy5dayjKDeMpBpcnT0R7E4P2euW8L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8eGE3lz4zz8RsgRvUydYoijc6IjZ9iDA3rAlOjKKZG8M+JVB2ECwFVsJvFQstHv7
         cxCQFaK2a14uxKBF2c7rVoy2t3B3uAu/I3/5ljfmbxFGg/6wM3rvVp/5NyNCRM7wyF
         DfQR7zGitWea1suSYFal/Isia8hAO4dro6GO35N4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 70/97] qed: Fix an error code qed_ll2_start_xmit()
Date:   Wed, 26 Dec 2018 17:35:30 -0500
Message-Id: <20181226223557.149329-70-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f07d4276892d97671e880190ff195a288b2d8d92 ]

We accidentally deleted the code to set "rc = -ENOMEM;" and this patch
adds it back.

Fixes: d2201a21598a ("qed: No need for LL2 frags indication")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index 14ac9cab2653..2fa1c050a14b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -2485,6 +2485,7 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb,
 		if (unlikely(dma_mapping_error(&cdev->pdev->dev, mapping))) {
 			DP_NOTICE(cdev,
 				  "Unable to map frag - dropping packet\n");
+			rc = -ENOMEM;
 			goto err;
 		}
 
-- 
2.19.1


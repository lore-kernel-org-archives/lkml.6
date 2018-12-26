Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCF7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC35214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864190;
	bh=stW1XYEJ+N+HZgcJBiemTJ1sGNMIW4VOEXptqD6DQec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CN/WY34ox9sIjtX5gsmAsF4hpRDqFGZurfGF+uInSQdcl+4F+RZl0Swxiq8nEz6DS
	 0pShYseITqGH4TI5vRJ4vbCbp05Qe4K1TFu0nneVoDZnkpR7lWVNlftWDllCBDISVB
	 jOEmLSR2eC2WTzljoa/EkG5nZVKia8SM6Zddx9TQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeLZWnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:43:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbeLZWlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7006620651;
        Wed, 26 Dec 2018 22:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864081;
        bh=stW1XYEJ+N+HZgcJBiemTJ1sGNMIW4VOEXptqD6DQec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRQ5RRGnActExelzBezmyRlagBIgSaklKlw/4aeQ+u9zeQjHOHoAyycxsTHjJsPzX
         oIcxT6xTxp0FJ1fpvOsf9UuKM3QHeOczwBrE4yudKkcm2nhgHOKamPFm5nrcu6r4UA
         +4xoKGGaKouyP7P2H34JVYffsEWTdt3xiAb7NRBg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 45/59] qed: Fix an error code qed_ll2_start_xmit()
Date:   Wed, 26 Dec 2018 17:38:25 -0500
Message-Id: <20181226223839.150262-45-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
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
index 5f52f14761a3..b73bcbeb5f27 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -2351,6 +2351,7 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb)
 		if (unlikely(dma_mapping_error(&cdev->pdev->dev, mapping))) {
 			DP_NOTICE(cdev,
 				  "Unable to map frag - dropping packet\n");
+			rc = -ENOMEM;
 			goto err;
 		}
 
-- 
2.19.1


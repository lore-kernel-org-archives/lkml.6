Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C094C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8341218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864067;
	bh=SM0VSOwWu5ooMk1dhXb8EjtP/pnJCfMV3tRdQtafXQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mwctdNQ8YdWjfVGANt/68aMfIxJ5yMyMo8F3MkEo6KjSqFvz6QH+QCRsOVDQeQu/q
	 ZFwkfoIezAEfTDJMJHogKFi/3vFkXv/zon56qHv25GsTlF8/00FI8boEQhW7IzfVRN
	 d6pCfko7tMj04U/Q58GoNNd+TxvYy6Li/rVfAomA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeLZWlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:41:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729261AbeLZWlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB2D20651;
        Wed, 26 Dec 2018 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864062;
        bh=SM0VSOwWu5ooMk1dhXb8EjtP/pnJCfMV3tRdQtafXQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1pLZdGvveZdh9/ETvz6PjjGTnU5S6Yv/kHDWQjiLLqJwK0fVNFWK4xCXfzucAF6C
         6ohZy1sNmw1kAmZSrqCPlJy/P3U4Fd0WhJJj4Li9ce4sOtB7+rwdYz3eLlZsf2chjk
         MQL5/FIgoEUXgBoMPxoNQjMXHxoeeK+x6gF9+wJc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 37/59] net: hns: Clean rx fbd when ae stopped.
Date:   Wed, 26 Dec 2018 17:38:17 -0500
Message-Id: <20181226223839.150262-37-sashal@kernel.org>
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

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 31f6b61d810654fb3ef43f4d8afda0f44b142fad ]

If there are packets in hardware when changing the speed or duplex,
it may cause hardware hang up.

This patch adds the code to wait rx fbd clean up when ae stopped.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
index bf930ab3c2bd..a185a8be7999 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -379,6 +379,9 @@ void hns_ae_stop(struct hnae_handle *handle)
 
 	hns_ae_ring_enable_all(handle, 0);
 
+	/* clean rx fbd. */
+	hns_rcb_wait_fbd_clean(handle->qs, handle->q_num, RCB_INT_FLAG_RX);
+
 	(void)hns_mac_vm_config_bc_en(mac_cb, 0, false);
 }
 
-- 
2.19.1


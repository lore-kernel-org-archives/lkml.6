Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72426C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3865921741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864968;
	bh=a5K9ZQFYng9IVox80vIts5BAqnTsB57OwCnvM/ljh7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LYeWm+4UK5f1k12KdSXzBbnDn3tdRLaJ9pt4fLVNDWL0Arp7RIfkWJhNClL5qzJwQ
	 p0rbNws2NRCWhM5o5GM7N/X54PdVM5N1ytTaY5LqiXXCZAv3iLPfYQ8AXAjFhiB1UR
	 2CpDyGLhpg8IbOeE98lG8nXu8UgIVj4SflUf7Ax4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeLZWyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbeLZWyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDAC214D8;
        Wed, 26 Dec 2018 22:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864876;
        bh=a5K9ZQFYng9IVox80vIts5BAqnTsB57OwCnvM/ljh7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=as6n9bTO9gnvFtFIipXlwlZNJfvJW7RNpqWMLPgkVDg+X5xU4xe9NzXnidq0TSV3+
         3iD7wbfB0DqIT7rH8rOJfzhtSGJkhUweWZvx78rAJq5myg+0bpgaPQNsUlsJWBiNer
         Lwhf8JLFjloR1vfWOaXJ4rTGHAphlyUBnMkq07Y4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 24/35] net: hns: Clean rx fbd when ae stopped.
Date:   Wed, 26 Dec 2018 17:41:31 -0500
Message-Id: <20181226224142.150866-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
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
index b7c8433a7a37..0b4d90ceea7a 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -290,6 +290,9 @@ void hns_ae_stop(struct hnae_handle *handle)
 
 	hns_ae_ring_enable_all(handle, 0);
 
+	/* clean rx fbd. */
+	hns_rcb_wait_fbd_clean(handle->qs, handle->q_num, RCB_INT_FLAG_RX);
+
 	(void)hns_mac_vm_config_bc_en(mac_cb, 0, false);
 }
 
-- 
2.19.1


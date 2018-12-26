Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A44FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30F02070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865305;
	bh=vnRN+BKWylB9mvjJsL4sBZqVUf9HjvIaaBf9qHRC5hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EO5Z5xZiJcXqbV6znfkjoFX/Swz3zvKPL/bF/lJL0Etm9c94QI+0Yqp+N93/XvPEy
	 Phr1pmqZigRkeUJF/vkfkO9RgbONDoKmIDCQEcummWkccnXGt/cVfVuZQMC5LOiQGF
	 ah6H+ASe/2TCB9pZMDn/wV+g63QUmqVMIRdgf+HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeLZWgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeLZWgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0E021741;
        Wed, 26 Dec 2018 22:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863782;
        bh=vnRN+BKWylB9mvjJsL4sBZqVUf9HjvIaaBf9qHRC5hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zm8dDCJKdUy2yAM51LFjDFa40g6PMy6DecLGoWIXGHcU9wg81qKYwtPcF78YO0Jbb
         vqKBv2oggZp4WwANnhQCjUt6eN8LO5G6f/1aTaDkczU/pbxxNrFBDCvzpkW8L85tEq
         qnyCYYxTa3GlJg7rpGLF83ELOTnhxLkHNp3k0Dak=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Zhang <markz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/97] IB/core: Fix oops in netdev_next_upper_dev_rcu()
Date:   Wed, 26 Dec 2018 17:34:34 -0500
Message-Id: <20181226223557.149329-14-sashal@kernel.org>
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

From: Mark Zhang <markz@mellanox.com>

[ Upstream commit 37fbd834b4e492dc41743830cbe435f35120abd8 ]

When support for bonding of RoCE devices was added, there was
necessarily a link between the RoCE device and the paired netdevice that
was part of the bond.  If you remove the mlx4_en module, that paired
association is broken (the RoCE device is still present but the paired
netdevice has been released).  We need to account for this in
is_upper_ndev_bond_master_filter() and filter out those links with a
broken pairing or else we later oops in netdev_next_upper_dev_rcu().

Fixes: 408f1242d940 ("IB/core: Delete lower netdevice default GID entries in bonding scenario")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/roce_gid_mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index 25d43c8f1c2a..558de0b9895c 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -267,6 +267,9 @@ is_upper_ndev_bond_master_filter(struct ib_device *ib_dev, u8 port,
 	struct net_device *cookie_ndev = cookie;
 	bool match = false;
 
+	if (!rdma_ndev)
+		return false;
+
 	rcu_read_lock();
 	if (netif_is_bond_master(cookie_ndev) &&
 	    rdma_is_upper_dev_rcu(rdma_ndev, cookie_ndev))
-- 
2.19.1


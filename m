Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E58C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1AE20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218660;
	bh=h3g1koeO0QmifHzfsYwoQjfqhCXdgZZ2Bly36Hxxp0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ujzx2fOlN2aOjx5jU0BRBMvdRWFKidKGArVUVQoQuDM1WB96M/Cf3wQAoigmgurzq
	 BdjqTkIf2NXRLOFSz/cvLXYh82aLG/DXZskixVzyqwDSKe13iWwH+gXIHIvSl9WeQT
	 uANufWY87+RszCM7SONoohc2yrSPj81MRxT49wZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391711AbfAKO5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:57:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390046AbfAKOfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B462063F;
        Fri, 11 Jan 2019 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217306;
        bh=h3g1koeO0QmifHzfsYwoQjfqhCXdgZZ2Bly36Hxxp0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBW4a83rJ8XSPCz9L1xo4nDHn35HiMuggIqKP6PktcLXrOmvZpZwQiU+CXKx9gTbL
         C299E39s979trNAbCTrGUPoL1BOROZMyHeIRbNwXjDbx2AOOAOTmphmO6dsN3Niw0O
         4yjGUouw6ZKI0E8F2W99GJKUmT4YeGtmGQt3i5uU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/148] IB/core: Fix oops in netdev_next_upper_dev_rcu()
Date:   Fri, 11 Jan 2019 15:13:12 +0100
Message-Id: <20190111131114.903741900@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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




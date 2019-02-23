Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A22DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDB720651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956611;
	bh=W0+d7Q0DE/8AVb3O4VusYPnxaYaOMmBbh8ipujwL6Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eRXkRPqcqrYVPICm9WnDjf253Pj8qdMzKfYCK0pyKOtQ5m2LQ3WF5/Z9IksGbucyr
	 hVPd+hYTOJoKHGCfBB3V6QwSPF1oJOM1JCj9CYCChVclbABt4Lvyzmzwyzd7kC+uXo
	 L64q727InT5HQ4zCuN0h9YyPlaThJ3oCXKEdAUI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfBWVQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:16:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729696AbfBWVKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:10:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F2032085A;
        Sat, 23 Feb 2019 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956219;
        bh=W0+d7Q0DE/8AVb3O4VusYPnxaYaOMmBbh8ipujwL6Ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVnfzbQNF3bvjc/Md7d9n4hGJLLvvac6xac8J158nv3gRoBYV6jfA991xSoKq3jah
         CX3Ym1+0q/DDcw14bZE+th5YIOkUge8nGu1+bIDjC9L0DFcKRtF9+Yf9p3EzVJdzbd
         sDFUayjxS+026C7KFUvJ1SwwpQSMOkfiU/zp/jYI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 16/32] net: hns: Fix for missing of_node_put() after of_parse_phandle()
Date:   Sat, 23 Feb 2019 16:09:35 -0500
Message-Id: <20190223210951.202268-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210951.202268-1-sashal@kernel.org>
References: <20190223210951.202268-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 263c6d75f9a544a3c2f8f6a26de4f4808d8f59cf ]

In hns enet driver, we use of_parse_handle() to get hold of the
device node related to "ae-handle" but we have missed to put
the node reference using of_node_put() after we are done using
the node. This patch fixes it.

Note:
This problem is stated in Link: https://lkml.org/lkml/2018/12/22/217

Fixes: 48189d6aaf1e ("net: hns: enet specifies a reference to dsaf")
Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index a2f7d08340715..ad8681cf5ef06 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2078,6 +2078,8 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 out_notify_fail:
 	(void)cancel_work_sync(&priv->service_task);
 out_read_prop_fail:
+	/* safe for ACPI FW */
+	of_node_put(to_of_node(priv->fwnode));
 	free_netdev(ndev);
 	return ret;
 }
@@ -2107,6 +2109,9 @@ static int hns_nic_dev_remove(struct platform_device *pdev)
 	set_bit(NIC_STATE_REMOVING, &priv->state);
 	(void)cancel_work_sync(&priv->service_task);
 
+	/* safe for ACPI FW */
+	of_node_put(to_of_node(priv->fwnode));
+
 	free_netdev(ndev);
 	return 0;
 }
-- 
2.19.1


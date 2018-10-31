Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C334AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACFD20840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGVLno3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACFD20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeKAILi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731688AbeKAILe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691752081B;
        Wed, 31 Oct 2018 23:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027482;
        bh=jnHWnBRsFdtChXJGWCcZ6Kgw2uy8icB27pwNJvxJpXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGVLno3hAjm1C0agZ5gBjQo73D72CgJgbgxTfGxAs+Jwx+bmnHcjW8HZ3LK8bywF0
         I5aJqYXwnapazBigSRAGQ4i163G30WkwuYrWLYLgKIE4mBVa/WF8w503ljfHNde/+y
         Ziz6DvUJxMGzesE4xSc+SES1wMUWsnHuBUS6L/hU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 31/48] RDMA/core: Do not expose unsupported counters
Date:   Wed, 31 Oct 2018 19:10:37 -0400
Message-Id: <20181031231054.29333-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 0f6ef65d1c6ec8deb5d0f11f86631ec4cfe8f22e ]

If the provider driver (such as rdma_rxe) doesn't support pma counters,
avoid exposing its directory similar to optional hw_counters directory.
If core fails to read the PMA counter, return an error so that user can
retry later if needed.

Fixes: 35c4cbb17811 ("IB/core: Create get_perf_mad function in sysfs.c")
Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/sysfs.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 42de5f22da93..a1240ddca026 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -485,7 +485,7 @@ static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
 	ret = get_perf_mad(p->ibdev, p->port_num, tab_attr->attr_id, &data,
 			40 + offset / 8, sizeof(data));
 	if (ret < 0)
-		return sprintf(buf, "N/A (no PMA)\n");
+		return ret;
 
 	switch (width) {
 	case 4:
@@ -1008,10 +1008,12 @@ static int add_port(struct ib_device *device, int port_num,
 		goto err_put;
 	}
 
-	p->pma_table = get_counter_table(device, port_num);
-	ret = sysfs_create_group(&p->kobj, p->pma_table);
-	if (ret)
-		goto err_put_gid_attrs;
+	if (device->process_mad) {
+		p->pma_table = get_counter_table(device, port_num);
+		ret = sysfs_create_group(&p->kobj, p->pma_table);
+		if (ret)
+			goto err_put_gid_attrs;
+	}
 
 	p->gid_group.name  = "gids";
 	p->gid_group.attrs = alloc_group_attrs(show_port_gid, attr.gid_tbl_len);
@@ -1124,7 +1126,8 @@ static int add_port(struct ib_device *device, int port_num,
 	p->gid_group.attrs = NULL;
 
 err_remove_pma:
-	sysfs_remove_group(&p->kobj, p->pma_table);
+	if (p->pma_table)
+		sysfs_remove_group(&p->kobj, p->pma_table);
 
 err_put_gid_attrs:
 	kobject_put(&p->gid_attr_group->kobj);
@@ -1236,7 +1239,9 @@ static void free_port_list_attributes(struct ib_device *device)
 			kfree(port->hw_stats);
 			free_hsag(&port->kobj, port->hw_stats_ag);
 		}
-		sysfs_remove_group(p, port->pma_table);
+
+		if (port->pma_table)
+			sysfs_remove_group(p, port->pma_table);
 		sysfs_remove_group(p, &port->pkey_group);
 		sysfs_remove_group(p, &port->gid_group);
 		sysfs_remove_group(&port->gid_attr_group->kobj,
-- 
2.17.1


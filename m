Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0796ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685E720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1UXnOJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685E720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeKAIHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbeKAIHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B027F20664;
        Wed, 31 Oct 2018 23:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027230;
        bh=iIBFHOFdm1uol+cnicz6GG1J/Q+oGi6a5JTQyVLqpv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1UXnOJHqKOUryA63O5cssspLW+W/XenPdjPSjOuCZqcp3MB4cLt7e3Hhl5VuycX6
         kDgfCn5o3UY9hY16wnchXTg3tR4tOPzqUECiLLfto/JW548LniolCJSW2zRbFgduj+
         pldt2+IyQg3mBnwLs3sUhRhoPOlJUBa/dWgreEEE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 097/146] RDMA/core: Do not expose unsupported counters
Date:   Wed, 31 Oct 2018 19:04:52 -0400
Message-Id: <20181031230541.28822-97-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
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
index 7fd14ead7b37..ace40bb98624 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -512,7 +512,7 @@ static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
 	ret = get_perf_mad(p->ibdev, p->port_num, tab_attr->attr_id, &data,
 			40 + offset / 8, sizeof(data));
 	if (ret < 0)
-		return sprintf(buf, "N/A (no PMA)\n");
+		return ret;
 
 	switch (width) {
 	case 4:
@@ -1057,10 +1057,12 @@ static int add_port(struct ib_device *device, int port_num,
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
@@ -1173,7 +1175,8 @@ static int add_port(struct ib_device *device, int port_num,
 	p->gid_group.attrs = NULL;
 
 err_remove_pma:
-	sysfs_remove_group(&p->kobj, p->pma_table);
+	if (p->pma_table)
+		sysfs_remove_group(&p->kobj, p->pma_table);
 
 err_put_gid_attrs:
 	kobject_put(&p->gid_attr_group->kobj);
@@ -1285,7 +1288,9 @@ static void free_port_list_attributes(struct ib_device *device)
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


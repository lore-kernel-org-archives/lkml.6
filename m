Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB9EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED62D20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQAluPxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED62D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeKLJyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732053AbeKLIRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:48 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3AC5223CE;
        Sun, 11 Nov 2018 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975272;
        bh=PD2bNtkcOiQjKDEUzOd1byEm/0WblSAVXZIz8P/CgaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQAluPxhzsHyzU4tuxooP1qInNgRu8fcKjKDvneHRnZeddn4pen/5ySIBnHH01yid
         EX/ZWfsmM+2OLdwpY2Z09UZIpHtMzOmAEtG1HHNO0/HlvC7GcmqwY4bA48PxAz7uX9
         6ZGbdZ4WCSAS2Hqx9gq3SzxXcNciwTmdYszk+Wwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>, Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 142/361] RDMA/core: Do not expose unsupported counters
Date:   Sun, 11 Nov 2018 14:18:09 -0800
Message-Id: <20181111221640.418091820@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/sysfs.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -512,7 +512,7 @@ static ssize_t show_pma_counter(struct i
 	ret = get_perf_mad(p->ibdev, p->port_num, tab_attr->attr_id, &data,
 			40 + offset / 8, sizeof(data));
 	if (ret < 0)
-		return sprintf(buf, "N/A (no PMA)\n");
+		return ret;
 
 	switch (width) {
 	case 4:
@@ -1057,10 +1057,12 @@ static int add_port(struct ib_device *de
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
@@ -1173,7 +1175,8 @@ err_free_gid:
 	p->gid_group.attrs = NULL;
 
 err_remove_pma:
-	sysfs_remove_group(&p->kobj, p->pma_table);
+	if (p->pma_table)
+		sysfs_remove_group(&p->kobj, p->pma_table);
 
 err_put_gid_attrs:
 	kobject_put(&p->gid_attr_group->kobj);
@@ -1285,7 +1288,9 @@ static void free_port_list_attributes(st
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



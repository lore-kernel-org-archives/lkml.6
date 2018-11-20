Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62784C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF7C2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="mKwGN9wE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF7C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeKTUuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:50:32 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25466 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeKTUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:50:31 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1542709282; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=hTxHz5DGo19Ny9KMCReq6pElGw2VHGwsKbTeYoZXI9kGN6S8H8sDecAp8pVyLs6ninaT9miuDLW/P1sjNUFXmNVVOzAcz/Dzq2q0TUNJLS2e/kx7FsHOpcJh2qEQK4qQO0oEdbGHpIrS0J5NNoiA0nu/8kLLMNftUEOhfmOZvAA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1542709282; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=jTSA+Zs1+7240+81mturwydytJwomKEmU0d3STdG9hM=; 
        b=lhNnEjVi2k4UpZtnIZz/EDS7ttApQ/sADEH91ZlSLW5cS+Oc3tmyuCE0qHlpp6T6cvCOj1olkjEkCxXSXhAAt0NW361kESDQVlAO6HHjFuVGiireWzgmg3KxbKzw6DnmpZpoDRs5U5EXBVM6ybDY4ps4hWbk0ZWEFqzMpTL8PU0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=v+ol4wC+zrNtnk+7oNXY8mD2caQFtrhFLHi8DranfE7G2ydwK/v8awFDm4DJIUXtg1a3jBV2ZPoy
    0N8oJCLZ77iYZGI1IBj/4EJlTTg9IyBqTVRHRhfMI5kMRzHSp0Qy  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1542709282;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=3228; bh=jTSA+Zs1+7240+81mturwydytJwomKEmU0d3STdG9hM=;
        b=mKwGN9wEH4U4+Hj3tm2/faI6lZ14eTWQJdCZobeae/vUakbmNjb+CTrCsak7245Z
        Apa9FCzTzlTLQhL9M0ePhrGIsJuVqvzbRuAny07KUklZsUV7A+9bEAL1HfOYMPiLPi4
        Xmq9ZdeOThiJhtQ1bCi3r75IYym1qYMdZlo78+g4=
Received: from YEHS1XR956R00D1.lenovo.com (58.243.153.247 [58.243.153.247]) by mx.zohomail.com
        with SMTPS id 1542709279011240.5816416360435; Tue, 20 Nov 2018 02:21:19 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, dan.j.williams@intel.com, willy@infradead.org,
        zwisler@kernel.org, jack@suse.cz, dave.jiang@intel.com,
        vishal.l.verma@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH 2/3] dm: expand hc_map in mapped_device for lack of map
Date:   Tue, 20 Nov 2018 18:20:36 +0800
Message-Id: <20181120102037.4536-3-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20181120102037.4536-1-yehs2007@zoho.com>
References: <20181120102037.4536-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Sometimes dm_swap_table couldn't be used in time.

For example, during the origin construction of
dm-snapshot, the sys_ioctl table_load will try to
detect the lower device origin-real whether support
direct access or not. But origin-real md's struct
dm-table pointer has not yet been assigned real address
in time by dev_suspend.

So I expand hc_map for get the address from struct
hash_cell directly in this case.

Here is the call trace, dm_dax_direct_access will call
dm_dax_get_live_target for get the struct dm_table pointer.

[  213.975827] Call Trace:
[  213.975832]  dump_stack+0x5a/0x73
[  213.975840]  dm_dax_direct_access+0x12b/0x1b0 [dm_mod]
[  213.975845]  dax_direct_access+0x2d/0x60
[  213.975848]  __bdev_dax_supported+0x162/0x2a0
[  213.975851]  ? dump_stack+0x5a/0x73
[  213.975859]  device_supports_dax+0x15/0x20 [dm_mod]
[  213.975867]  dm_table_supports_dax.isra.13+0x7d/0xa0 [dm_mod]
[  213.975875]  dm_table_complete+0x3fb/0x750 [dm_mod]
[  213.975883]  table_load+0x19a/0x390 [dm_mod]
[  213.975891]  ? retrieve_status+0x1c0/0x1c0 [dm_mod]
[  213.975898]  ctl_ioctl+0x1d8/0x450 [dm_mod]
[  213.975909]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
[  213.975913]  do_vfs_ioctl+0xa9/0x620
[  213.975918]  ? syscall_trace_enter+0x1c9/0x2b0
[  213.975923]  ksys_ioctl+0x60/0x90
[  213.975927]  __x64_sys_ioctl+0x16/0x20
[  213.975931]  do_syscall_64+0x5b/0x180
[  213.975936]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-core.h  |  1 +
 drivers/md/dm-ioctl.c |  1 +
 drivers/md/dm.c       | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 224d445..5577d90 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -40,6 +40,7 @@ struct mapped_device {
 	 * dereference.
 	 */
 	void __rcu *map;
+	struct dm_table *hc_map;
 
 	unsigned long flags;
 
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index f666778..a27016e 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1365,6 +1365,7 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (hc->new_map)
 		old_map = hc->new_map;
 	hc->new_map = t;
+	hc->md->hc_map = hc->new_map;
 	up_write(&_hash_lock);
 
 	param->flags |= DM_INACTIVE_PRESENT_FLAG;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c510179..19b48bb 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1080,6 +1080,21 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 	struct dm_target *ti;
 
 	map = dm_get_live_table(md, srcu_idx);
+	if (!map) {
+		/* Sometimes dm_swap_table couldn't be used in time.
+		 *
+		 * For example, during the origin construction of
+		 * dm-snapshot, the sys_ioctl table_load will try to
+		 * detect the lower device origin-real whether support
+		 * direct access or not. But origin-real device md's struct
+		 * dm-table pointer has not yet been assigned real address.
+		 * So hc_map has been used for get the address from
+		 * struct hash_cell directly.
+		 */
+		DMINFO("failed to get map, use hc_map insteadly");
+		map = md->hc_map;
+	}
+
 	if (!map)
 		return NULL;
 
-- 
1.8.3.1



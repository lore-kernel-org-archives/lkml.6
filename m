Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE46ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27CE2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27CE2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeINT6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:58:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38297 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727749AbeINT6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:58:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 17DDB9E18549E;
        Fri, 14 Sep 2018 22:43:31 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 14 Sep
 2018 22:43:24 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Chen Gong <gongchen4@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 7/8] staging: erofs: add trace points for reading zipped data
Date:   Fri, 14 Sep 2018 22:40:29 +0800
Message-ID: <1536936030-62362-8-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
References: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Gong <gongchen4@huawei.com>

This patch adds trace points for reading zipped data.

Signed-off-by: Chen Gong <gongchen4@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/include/trace/events/erofs.h | 20 ++++++++++++++++++--
 drivers/staging/erofs/unzip_vle.c                  | 11 +++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/include/trace/events/erofs.h b/drivers/staging/erofs/include/trace/events/erofs.h
index 5aead93..660c92f 100644
--- a/drivers/staging/erofs/include/trace/events/erofs.h
+++ b/drivers/staging/erofs/include/trace/events/erofs.h
@@ -162,7 +162,8 @@
 
 	TP_printk("dev = (%d,%d), nid = %llu, la %llu llen %llu flags %s",
 		  show_dev_nid(__entry),
-		  __entry->la, __entry->llen, show_map_flags(__entry->flags))
+		  __entry->la, __entry->llen,
+		  __entry->flags ? show_map_flags(__entry->flags) : "NULL")
 );
 
 DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_flatmode_enter,
@@ -172,6 +173,13 @@
 	TP_ARGS(inode, map, flags)
 );
 
+DEFINE_EVENT(erofs__map_blocks_enter, z_erofs_map_blocks_iter_enter,
+	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
+		 unsigned int flags),
+
+	TP_ARGS(inode, map, flags)
+);
+
 DECLARE_EVENT_CLASS(erofs__map_blocks_exit,
 	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
 		 unsigned int flags, int ret),
@@ -204,7 +212,8 @@
 
 	TP_printk("dev = (%d,%d), nid = %llu, flags %s "
 		  "la %llu pa %llu llen %llu plen %llu mflags %s ret %d",
-		  show_dev_nid(__entry), show_map_flags(__entry->flags),
+		  show_dev_nid(__entry),
+		  __entry->flags ? show_map_flags(__entry->flags) : "NULL",
 		  __entry->la, __entry->pa, __entry->llen, __entry->plen,
 		  show_mflags(__entry->mflags), __entry->ret)
 );
@@ -216,6 +225,13 @@
 	TP_ARGS(inode, map, flags, ret)
 );
 
+DEFINE_EVENT(erofs__map_blocks_exit, z_erofs_map_blocks_iter_exit,
+	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
+		 unsigned int flags, int ret),
+
+	TP_ARGS(inode, map, flags, ret)
+);
+
 TRACE_EVENT(erofs_destroy_inode,
 	TP_PROTO(struct inode *inode),
 
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 15c2015..ad3b7bb 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -13,6 +13,8 @@
 #include "unzip_vle.h"
 #include <linux/prefetch.h>
 
+#include <trace/events/erofs.h>
+
 static struct workqueue_struct *z_erofs_workqueue __read_mostly;
 static struct kmem_cache *z_erofs_workgroup_cachep __read_mostly;
 
@@ -613,6 +615,8 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	unsigned int cur, end, spiltted, index;
 	int err = 0;
 
+	trace_erofs_readpage(page, false);
+
 	/* register locked file pages as online pages in pack */
 	z_erofs_onlinepage_init(page);
 
@@ -1348,6 +1352,9 @@ static inline int __z_erofs_vle_normalaccess_readpages(
 	struct page *head = NULL;
 	LIST_HEAD(pagepool);
 
+	trace_erofs_readpages(mapping->host, lru_to_page(pages),
+			      nr_pages, false);
+
 #if (EROFS_FS_ZIP_CACHE_LVL >= 2)
 	f.cachedzone_la = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
 #endif
@@ -1570,6 +1577,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	unsigned int cluster_type, logical_cluster_ofs;
 	int err = 0;
 
+	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
+
 	/* when trying to read beyond EOF, leave it unmapped */
 	if (unlikely(map->m_la >= inode->i_size)) {
 		DBG_BUGON(!initial);
@@ -1688,6 +1697,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		__func__, map->m_la, map->m_pa,
 		map->m_llen, map->m_plen, map->m_flags);
 
+	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
+
 	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
 	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
-- 
1.9.1


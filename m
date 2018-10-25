Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19926C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB37920834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB37920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJYQvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:51:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbeJYQvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:51:24 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3E62A5C290865;
        Thu, 25 Oct 2018 16:19:40 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Thu, 25 Oct 2018 16:19:35 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 3/3] f2fs: export migration_granularity sysfs entry
Date:   Thu, 25 Oct 2018 16:19:28 +0800
Message-ID: <20181025081928.88953-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one sysfs entry to control migration granularity of GC in large
section f2fs, it can be tuned to mitigate heavy overhead of migrating
huge number of blocks in large section.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix incorrect command name parsing.
 Documentation/ABI/testing/sysfs-fs-f2fs | 9 +++++++++
 fs/f2fs/sysfs.c                         | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 3ac41774ad3c..a7ce33199457 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -92,6 +92,15 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
 Description:
 		 Controls the number of trials to find a victim segment.
 
+What:		/sys/fs/f2fs/<disk>/migration_granularity
+Date:		October 2018
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:
+		 Controls migration granularity of garbage collection on large
+		 section, it can let GC move partial segment{s} of one section
+		 in one GC cycle, so that dispersing heavy overhead GC to
+		 multiple lightweight one.
+
 What:		/sys/fs/f2fs/<disk>/dir_level
 Date:		March 2014
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 240e4881279e..0575edbe3ed6 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -246,6 +246,11 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "migration_granularity")) {
+		if (t == 0 || t > sbi->segs_per_sec)
+			return -EINVAL;
+	}
+
 	if (!strcmp(a->attr.name, "trim_sections"))
 		return -EINVAL;
 
@@ -406,6 +411,7 @@ F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, migration_granularity, migration_granularity);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
@@ -460,6 +466,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(min_hot_blocks),
 	ATTR_LIST(min_ssr_sections),
 	ATTR_LIST(max_victim_search),
+	ATTR_LIST(migration_granularity),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
 	ATTR_LIST(ra_nid_pages),
-- 
2.18.0.rc1


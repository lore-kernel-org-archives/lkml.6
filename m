Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3681AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC72E20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC72E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbeGWPMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:12:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55398 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388129AbeGWPMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:12:43 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F010740F93243;
        Mon, 23 Jul 2018 22:10:45 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Mon, 23 Jul 2018
 22:10:40 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] f2fs: add proc entry to show victim_secmap bitmap
Date:   Mon, 23 Jul 2018 22:10:22 +0800
Message-ID: <1532355022-163029-6-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new proc entry to show victim_secmap information in
more detail, which is very helpful to know the get_victim candidate
status clearly, and helpful to debug problems (e.g., some sections can
not gc all of its blocks, since some blocks belong to atomic file,
leaving victim_secmap with section bit setting, in extrem case, this
will lead all bytes of victim_secmap setting with 0xff).

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/sysfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index bca1236..f22782a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -615,6 +615,28 @@ static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static int __maybe_unused victim_bits_seq_show(struct seq_file *seq,
+						void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	int i;
+
+	seq_puts(seq, "format: victim_secmap bitmaps\n");
+
+	for (i = 0; i < MAIN_SECS(sbi); i++) {
+		if ((i % 10) == 0)
+			seq_printf(seq, "%-10d", i);
+		seq_printf(seq, "%d", test_bit(i, dirty_i->victim_secmap) ? 1 : 0);
+		if ((i % 10) == 9 || i == (MAIN_SECS(sbi) - 1))
+			seq_putc(seq, '\n');
+		else
+			seq_putc(seq, ' ');
+	}
+	return 0;
+}
+
 int __init f2fs_init_sysfs(void)
 {
 	int ret;
@@ -664,6 +686,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				segment_bits_seq_show, sb);
 		proc_create_single_data("iostat_info", S_IRUGO, sbi->s_proc,
 				iostat_info_seq_show, sb);
+		proc_create_single_data("victim_bits", S_IRUGO, sbi->s_proc,
+				victim_bits_seq_show, sb);
 	}
 	return 0;
 }
@@ -674,6 +698,7 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry("iostat_info", sbi->s_proc);
 		remove_proc_entry("segment_info", sbi->s_proc);
 		remove_proc_entry("segment_bits", sbi->s_proc);
+		remove_proc_entry("victim_bits", sbi->s_proc);
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 	kobject_del(&sbi->s_kobj);
-- 
1.8.5.2


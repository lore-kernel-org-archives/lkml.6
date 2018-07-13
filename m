Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B7EECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C2F2147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C2F2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeGMETJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 00:19:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40445 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725822AbeGMETJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 00:19:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B6C983DC9CE6C;
        Fri, 13 Jul 2018 12:06:17 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 12:06:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jaegeuk@kernel.org>, <yuchao0@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] f2fs: hide unused procfs helpers
Date:   Fri, 13 Jul 2018 11:53:04 +0800
Message-ID: <20180713035304.18520-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROC_FS isn't set, gcc warning this:

fs/f2fs/sysfs.c:519:12: warning: ‘segment_info_seq_show’ defined but not used [-Wunused-function]
 static int segment_info_seq_show(struct seq_file *seq, void *offset)
            ^
fs/f2fs/sysfs.c:546:12: warning: ‘segment_bits_seq_show’ defined but not used [-Wunused-function]
 static int segment_bits_seq_show(struct seq_file *seq, void *offset)
            ^
fs/f2fs/sysfs.c:570:12: warning: ‘iostat_info_seq_show’ defined but not used [-Wunused-function]
 static int iostat_info_seq_show(struct seq_file *seq, void *offset)

We can fix the warning by adding the same #ifdef around them.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/f2fs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 2e7e611..7d45e65 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -516,6 +516,7 @@ static struct kobject f2fs_feat = {
 	.kset	= &f2fs_kset,
 };
 
+#ifdef CONFIG_PROC_FS
 static int segment_info_seq_show(struct seq_file *seq, void *offset)
 {
 	struct super_block *sb = seq->private;
@@ -608,6 +609,7 @@ static int iostat_info_seq_show(struct seq_file *seq, void *offset)
 
 	return 0;
 }
+#endif
 
 int __init f2fs_init_sysfs(void)
 {
-- 
2.7.0



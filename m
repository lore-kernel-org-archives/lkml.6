Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B15C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF4121531
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF4121531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJTUQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 16:16:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727483AbeJTUQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 16:16:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 544118E577939;
        Sat, 20 Oct 2018 20:06:14 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Sat, 20 Oct 2018
 20:06:14 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <dwmw2@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <richard.weinberger@gmail.com>, <boris.brezillon@bootlin.com>
Subject: [PATCH] jffs2: ensure wbuf_verify is valid before using it.
Date:   Sat, 20 Oct 2018 20:08:49 +0800
Message-ID: <20181020120849.65708-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now MTD emulated by UBI volumn doesn't allocate wbuf_verify in
jffs2_ubivol_setup(), because UBI can do the verifcation itself,
so when CONFIG_JFFS2_FS_WBUF_VERIFY is enabled and a MTD device
emulated by UBI volumn is used, a Oops will occur as show in the
following trace:

    general protection fault: 0000 [#1] SMP KASAN PTI
    CPU: 6 PID: 404 Comm: kworker/6:1 Not tainted 4.19.0-rc8
    Workqueue: events_long delayed_wbuf_sync
    RIP: 0010:ubi_io_read+0x156/0x650
    Call Trace:
     ubi_eba_read_leb+0x57d/0xba0
     ubi_leb_read+0xe5/0x1b0
     gluebi_read+0x10c/0x1a0
     mtd_read+0x112/0x340
     jffs2_verify_write+0xef/0x440
     __jffs2_flush_wbuf+0x3fa/0x3540
     jffs2_flush_wbuf_gc+0x1b1/0x2e0
     process_one_work+0x58b/0x11e0
     worker_thread+0x8f/0xfe0
     kthread+0x2ae/0x3a0
     ret_from_fork+0x35/0x40

Fix the problem by checking the validity of wbuf_verify before
using it in jffs2_verify_write().

Cc: stable@vger.kernel.org
Fixes: 0029da3bf430 ("JFFS2: add UBI support")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/jffs2/wbuf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index c6821a509481..3de45f4559d1 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -234,6 +234,13 @@ static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
 	size_t retlen;
 	char *eccstr;
 
+	/*
+	 * MTD emulated by UBI volume doesn't allocate wbuf_verify,
+	 * because it can do the verification itself.
+	 */
+	if (!c->wbuf_verify)
+		return 0;
+
 	ret = mtd_read(c->mtd, ofs, c->wbuf_pagesize, &retlen, c->wbuf_verify);
 	if (ret && ret != -EUCLEAN && ret != -EBADMSG) {
 		pr_warn("%s(): Read back of page at %08x failed: %d\n",
-- 
2.16.2.dirty


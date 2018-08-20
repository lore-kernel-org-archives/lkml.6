Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D359C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA2320E20
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA2320E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeHTMBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:01:17 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:38239
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbeHTMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:01:17 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 08:01:15 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AXDgB5fXpb/602LHlbhACBUBIog3C?=
 =?us-ascii?q?UJEwBAQEBAQEGgRA4gyqFH4Q2iQWBeh4YAYRAg00hNRcBAgEBAQEBAQJtKIV?=
 =?us-ascii?q?hBFIoAQwCGA4CSRYThRcMpQR7MxoCijyBC4gNF3mBB4ESM4peglcCjUcvjQY?=
 =?us-ascii?q?Jj2AViFMDhWEBK5RAATWBUk0uCjuCaZBgMjB7AQGNVgEB?=
X-IPAS-Result: =?us-ascii?q?A2AXDgB5fXpb/602LHlbhACBUBIog3CUJEwBAQEBAQEGg?=
 =?us-ascii?q?RA4gyqFH4Q2iQWBeh4YAYRAg00hNRcBAgEBAQEBAQJtKIVhBFIoAQwCGA4CS?=
 =?us-ascii?q?RYThRcMpQR7MxoCijyBC4gNF3mBB4ESM4peglcCjUcvjQYJj2AViFMDhWEBK?=
 =?us-ascii?q?5RAATWBUk0uCjuCaZBgMjB7AQGNVgEB?=
X-IronPort-AV: E=Sophos;i="5.53,264,1531756800"; 
   d="scan'208";a="122976998"
Received: from unknown (HELO pluto.themaw.net) ([121.44.54.173])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 20 Aug 2018 16:37:10 +0800
Subject: [PATCH] autofs - fix autofs_sbi() does not check super block type
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Aug 2018 16:37:09 +0800
Message-ID: <153475422934.17131.7563724552005298277.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The autofs_sbi() inline function does not check the super block
magic number to verify it has been given an autofs super block.

Reported-by: syzbot+87c3c541582e56943277@syzkaller.appspotmail.com
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    4 +++-
 fs/autofs/inode.c    |    1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 9400a9f6318a..5057b9f0f846 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/completion.h>
 #include <linux/file.h>
+#include <linux/magic.h>
 
 /* This is the range of ioctl() numbers we claim as ours */
 #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
@@ -124,7 +125,8 @@ struct autofs_sb_info {
 
 static inline struct autofs_sb_info *autofs_sbi(struct super_block *sb)
 {
-	return (struct autofs_sb_info *)(sb->s_fs_info);
+	return sb->s_magic != AUTOFS_SUPER_MAGIC ?
+		NULL : (struct autofs_sb_info *)(sb->s_fs_info);
 }
 
 static inline struct autofs_info *autofs_dentry_ino(struct dentry *dentry)
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index b51980fc274e..846c052569dd 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -10,7 +10,6 @@
 #include <linux/seq_file.h>
 #include <linux/pagemap.h>
 #include <linux/parser.h>
-#include <linux/magic.h>
 
 #include "autofs_i.h"
 


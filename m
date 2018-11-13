Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C116C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAE622506
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAE622506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbeKMLlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:41:18 -0500
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:53737
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbeKMLlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:41:17 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A1AACYKepb/1Sw0HYNVhwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVEHAQELAYQSg3iIGIxNBoEQg2eFU4R6iSaBeoR0AwICg080DQ0BAwE?=
 =?us-ascii?q?BAQEBAQKGUAIBAyMEUhAYAQwCJgICRxAGE4UWqANwfDMaiheBC4FziRl4gQe?=
 =?us-ascii?q?BETOKYYJXAokShjQyj1cJkTUKAoleA4cDgnSWR4INTS4KgyeCJxeOKWWOGwE?=
 =?us-ascii?q?B?=
X-IPAS-Result: =?us-ascii?q?A2A1AACYKepb/1Sw0HYNVhwBAQEEAQEHBAEBgVEHAQELA?=
 =?us-ascii?q?YQSg3iIGIxNBoEQg2eFU4R6iSaBeoR0AwICg080DQ0BAwEBAQEBAQKGUAIBA?=
 =?us-ascii?q?yMEUhAYAQwCJgICRxAGE4UWqANwfDMaiheBC4FziRl4gQeBETOKYYJXAokSh?=
 =?us-ascii?q?jQyj1cJkTUKAoleA4cDgnSWR4INTS4KgyeCJxeOKWWOGwEB?=
X-IronPort-AV: E=Sophos;i="5.54,497,1534780800"; 
   d="scan'208";a="116718277"
Received: from unknown (HELO [192.168.1.28]) ([118.208.176.84])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 13 Nov 2018 09:36:14 +0800
Subject: [PATCH 3/6] autofs - refactor super block info init
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 13 Nov 2018 09:36:12 +0800
Message-ID: <154207297202.11064.11609172823638684904.stgit@pluto-themaw-net>
In-Reply-To: <154207295533.11064.12485527860509413072.stgit@pluto-themaw-net>
References: <154207295533.11064.12485527860509413072.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the allocation and initialisation of the super block
info struct to its own function.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index e5c06b5a7371..93af0d5777ae 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -201,43 +201,49 @@ static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
 	return (*pipefd < 0);
 }
 
-int autofs_fill_super(struct super_block *s, void *data, int silent)
+static struct autofs_sb_info *autofs_alloc_sbi(struct super_block *s)
 {
-	struct inode *root_inode;
-	struct dentry *root;
-	struct file *pipe;
-	int pipefd;
 	struct autofs_sb_info *sbi;
-	struct autofs_info *ino;
-	int pgrp = 0;
-	bool pgrp_set = false;
-	int ret = -EINVAL;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
-		return -ENOMEM;
-	pr_debug("starting up, sbi = %p\n", sbi);
+		return NULL;
 
-	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
+	sbi->sb = s;
 	sbi->pipefd = -1;
 	sbi->pipe = NULL;
 	sbi->catatonic = 1;
-	sbi->exp_timeout = 0;
-	sbi->oz_pgrp = NULL;
-	sbi->sb = s;
-	sbi->version = 0;
-	sbi->sub_version = 0;
 	set_autofs_type_indirect(&sbi->type);
-	sbi->min_proto = 0;
-	sbi->max_proto = 0;
 	mutex_init(&sbi->wq_mutex);
 	mutex_init(&sbi->pipe_mutex);
 	spin_lock_init(&sbi->fs_lock);
-	sbi->queues = NULL;
 	spin_lock_init(&sbi->lookup_lock);
 	INIT_LIST_HEAD(&sbi->active_list);
 	INIT_LIST_HEAD(&sbi->expiring_list);
+
+	return sbi;
+}
+
+int autofs_fill_super(struct super_block *s, void *data, int silent)
+{
+	struct inode *root_inode;
+	struct dentry *root;
+	struct file *pipe;
+	int pipefd;
+	struct autofs_sb_info *sbi;
+	struct autofs_info *ino;
+	int pgrp = 0;
+	bool pgrp_set = false;
+	int ret = -EINVAL;
+
+	sbi = autofs_alloc_sbi(s);
+	if (!sbi)
+		return -ENOMEM;
+
+	pr_debug("starting up, sbi = %p\n", sbi);
+
+	s->s_fs_info = sbi;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;


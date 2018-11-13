Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F865C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA4C22506
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA4C22506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbeKMLmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:42:15 -0500
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:53984
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbeKMLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:42:14 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A1AACYKepb/1Sw0HYNVhwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVEHAQELAYQSg3iIGIxNBoEQg2eFU4R6iSaBeoR0AwICg080DQ0BAwE?=
 =?us-ascii?q?BAQEBAQKGUAIBAyMEUhAYAQwCJgICRxAGE4UWqANwfDMaiheBC4FziRl4gQe?=
 =?us-ascii?q?BETOHR4MaglcCjwNDMo9XCZE1CgKBTIgSA4cDgnSGZo9hgg1NLgqDJ5BnZY4?=
 =?us-ascii?q?bAQE?=
X-IPAS-Result: =?us-ascii?q?A2A1AACYKepb/1Sw0HYNVhwBAQEEAQEHBAEBgVEHAQELA?=
 =?us-ascii?q?YQSg3iIGIxNBoEQg2eFU4R6iSaBeoR0AwICg080DQ0BAwEBAQEBAQKGUAIBA?=
 =?us-ascii?q?yMEUhAYAQwCJgICRxAGE4UWqANwfDMaiheBC4FziRl4gQeBETOHR4MaglcCj?=
 =?us-ascii?q?wNDMo9XCZE1CgKBTIgSA4cDgnSGZo9hgg1NLgqDJ5BnZY4bAQE?=
X-IronPort-AV: E=Sophos;i="5.54,497,1534780800"; 
   d="scan'208";a="116718432"
Received: from unknown (HELO [192.168.1.28]) ([118.208.176.84])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 13 Nov 2018 09:37:11 +0800
Subject: [PATCH 6/6] autofs - add strictexpire mount option
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 13 Nov 2018 09:37:08 +0800
Message-ID: <154207302780.11064.8291702401952765872.stgit@pluto-themaw-net>
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

Commit 092a53452b (("autofs: take more care to not update last_used
on path walk") helped to (partially) resolve a problem where automounts
were not expiring due to aggressive accesses from user space.

This patch was later reverted because, for very large environments,
it meant more mount requests from clients and when there are a lot
of clients this caused a fairly significant increase in server load.

But there is a need for both types of expire check, depending on use
case, so add a mount option to allow for strict update of last use
of autofs dentrys (which just means not updating the last use on path
walk accesses).

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h         |    1 +
 fs/autofs/inode.c            |   13 ++++++++++++-
 fs/autofs/root.c             |    5 ++++-
 include/uapi/linux/auto_fs.h |    2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 032cbb12531a..fa3733beb52e 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -102,6 +102,7 @@ struct autofs_wait_queue {
 #define AUTOFS_SBI_MAGIC 0x6d4a556d
 
 #define AUTOFS_SBI_CATATONIC	0x0001
+#define AUTOFS_SBI_STRICTEXPIRE 0x0002
 
 struct autofs_sb_info {
 	u32 magic;
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 5e774852ae84..75d61f5a3069 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -87,6 +87,8 @@ static int autofs_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",direct");
 	else
 		seq_printf(m, ",indirect");
+	if (sbi->flags & AUTOFS_SBI_STRICTEXPIRE)
+		seq_printf(m, ",strictexpire");
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (sbi->pipe)
 		seq_printf(m, ",pipe_ino=%ld", file_inode(sbi->pipe)->i_ino);
@@ -116,11 +118,12 @@ struct autofs_fs_params {
 	bool pgrp_set;
 	int min_proto;
 	int max_proto;
+	bool strictexpire;
 	unsigned int type;
 };
 
 enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
-	Opt_indirect, Opt_direct, Opt_offset};
+	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire};
 
 static const match_table_t tokens = {
 	{Opt_fd, "fd=%u"},
@@ -132,6 +135,7 @@ static const match_table_t tokens = {
 	{Opt_indirect, "indirect"},
 	{Opt_direct, "direct"},
 	{Opt_offset, "offset"},
+	{Opt_strictexpire, "strictexpire"},
 	{Opt_err, NULL}
 };
 
@@ -155,6 +159,7 @@ static int autofs_parse_options(char *options, struct autofs_fs_params *params)
 	params->max_proto = AUTOFS_MAX_PROTO_VERSION;
 
 	params->pgrp_set = false;
+	params->strictexpire = false;
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
@@ -210,6 +215,9 @@ static int autofs_parse_options(char *options, struct autofs_fs_params *params)
 		case Opt_offset:
 			set_autofs_type_offset(&params->type);
 			break;
+		case Opt_strictexpire:
+			params->strictexpire = true;
+			break;
 		default:
 			return 1;
 		}
@@ -275,6 +283,9 @@ static int autofs_apply_sbi_options(struct autofs_sb_info *sbi,
 	if (err < 0)
 		goto out_fput;
 
+	if (params->strictexpire)
+		sbi->flags |= AUTOFS_SBI_STRICTEXPIRE;
+
 	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 
 	return 0;
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 164ccd3402cf..1246f396bf0e 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -275,8 +275,11 @@ static int autofs_mount_wait(const struct path *path, bool rcu_walk)
 		pr_debug("waiting for mount name=%pd\n", path->dentry);
 		status = autofs_wait(sbi, path, NFY_MOUNT);
 		pr_debug("mount wait done status=%d\n", status);
+		ino->last_used = jiffies;
+		return status;
 	}
-	ino->last_used = jiffies;
+	if (!(sbi->flags & AUTOFS_SBI_STRICTEXPIRE))
+		ino->last_used = jiffies;
 	return status;
 }
 
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index df31aa9c9a8c..082119630b49 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -23,7 +23,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	5
 
-#define AUTOFS_PROTO_SUBVERSION		3
+#define AUTOFS_PROTO_SUBVERSION		4
 
 /*
  * The wait_queue_token (autofs_wqt_t) is part of a structure which is passed


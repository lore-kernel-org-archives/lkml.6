Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E2DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEE520664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEE520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503372AbeKWVZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:25:54 -0500
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:13399
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409442AbeKWVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:25:54 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AMAACP2Pdb/7650XYNVRwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVEHAQELAYgLiBiMSQEBAQEBAQaBEINnhVeOIoF6hHQDAgKENTQJDQE?=
 =?us-ascii?q?DAQEBAQEBAoZSAgEDIwRSEBgBDAImAgJHEAaFKaY7cHwzGol9gQuBc4kieIE?=
 =?us-ascii?q?HgREzimGCVwKJI4Y5M49zCZFHCgKJaQOHECyCTJZ+gg1NLgo7gm2CJheOKY4?=
 =?us-ascii?q?NAQE?=
X-IPAS-Result: =?us-ascii?q?A2AMAACP2Pdb/7650XYNVRwBAQEEAQEHBAEBgVEHAQELA?=
 =?us-ascii?q?YgLiBiMSQEBAQEBAQaBEINnhVeOIoF6hHQDAgKENTQJDQEDAQEBAQEBAoZSA?=
 =?us-ascii?q?gEDIwRSEBgBDAImAgJHEAaFKaY7cHwzGol9gQuBc4kieIEHgREzimGCVwKJI?=
 =?us-ascii?q?4Y5M49zCZFHCgKJaQOHECyCTJZ+gg1NLgo7gm2CJheOKY4NAQE?=
X-IronPort-AV: E=Sophos;i="5.56,269,1539619200"; 
   d="scan'208";a="122563367"
Received: from unknown (HELO [192.168.1.28]) ([118.209.185.190])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 23 Nov 2018 18:42:06 +0800
Subject: [PATCH v2 3/5] autofs - simplify parse_options() function call
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 23 Nov 2018 18:42:04 +0800
Message-ID: <154296972423.9889.9368859245676473329.stgit@pluto-themaw-net>
In-Reply-To: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
References: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parse_options() function uses a long list of parameters, most
of which are present in the super block info structure already.

The mount parameters set in parse_options() options don't require
cleanup so using the super block info struct directly is simpler.
---
 fs/autofs/inode.c |   55 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index e5c06b5a7371..ccedd12c1ac5 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -124,21 +124,24 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
-static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
-			 int *pgrp, bool *pgrp_set, unsigned int *type,
-			 int *minproto, int *maxproto)
+static int parse_options(char *options,
+			 struct inode *root, int *pgrp, bool *pgrp_set,
+			 struct autofs_sb_info *sbi)
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
 	int option;
+	int pipefd = -1;
+	kuid_t uid;
+	kgid_t gid;
 
-	*uid = current_uid();
-	*gid = current_gid();
+	root->i_uid = current_uid();
+	root->i_gid = current_gid();
 
-	*minproto = AUTOFS_MIN_PROTO_VERSION;
-	*maxproto = AUTOFS_MAX_PROTO_VERSION;
+	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
+	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
 
-	*pipefd = -1;
+	sbi->pipefd = -1;
 
 	if (!options)
 		return 1;
@@ -152,22 +155,25 @@ static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case Opt_fd:
-			if (match_int(args, pipefd))
+			if (match_int(args, &pipefd))
 				return 1;
+			sbi->pipefd = pipefd;
 			break;
 		case Opt_uid:
 			if (match_int(args, &option))
 				return 1;
-			*uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(*uid))
+			uid = make_kuid(current_user_ns(), option);
+			if (!uid_valid(uid))
 				return 1;
+			root->i_uid = uid;
 			break;
 		case Opt_gid:
 			if (match_int(args, &option))
 				return 1;
-			*gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(*gid))
+			gid = make_kgid(current_user_ns(), option);
+			if (!gid_valid(gid))
 				return 1;
+			root->i_gid = gid;
 			break;
 		case Opt_pgrp:
 			if (match_int(args, &option))
@@ -178,27 +184,27 @@ static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
 		case Opt_minproto:
 			if (match_int(args, &option))
 				return 1;
-			*minproto = option;
+			sbi->min_proto = option;
 			break;
 		case Opt_maxproto:
 			if (match_int(args, &option))
 				return 1;
-			*maxproto = option;
+			sbi->max_proto = option;
 			break;
 		case Opt_indirect:
-			set_autofs_type_indirect(type);
+			set_autofs_type_indirect(&sbi->type);
 			break;
 		case Opt_direct:
-			set_autofs_type_direct(type);
+			set_autofs_type_direct(&sbi->type);
 			break;
 		case Opt_offset:
-			set_autofs_type_offset(type);
+			set_autofs_type_offset(&sbi->type);
 			break;
 		default:
 			return 1;
 		}
 	}
-	return (*pipefd < 0);
+	return (sbi->pipefd < 0);
 }
 
 int autofs_fill_super(struct super_block *s, void *data, int silent)
@@ -206,7 +212,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	struct inode *root_inode;
 	struct dentry *root;
 	struct file *pipe;
-	int pipefd;
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
 	int pgrp = 0;
@@ -266,9 +271,7 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	root->d_fsdata = ino;
 
 	/* Can this call block? */
-	if (parse_options(data, &pipefd, &root_inode->i_uid, &root_inode->i_gid,
-			  &pgrp, &pgrp_set, &sbi->type, &sbi->min_proto,
-			  &sbi->max_proto)) {
+	if (parse_options(data, root_inode, &pgrp, &pgrp_set, sbi)) {
 		pr_err("called with bogus options\n");
 		goto fail_dput;
 	}
@@ -307,9 +310,10 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	root_inode->i_fop = &autofs_root_operations;
 	root_inode->i_op = &autofs_dir_inode_operations;
 
-	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi->oz_pgrp));
+	pr_debug("pipe fd = %d, pgrp = %u\n",
+		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
 
-	pipe = fget(pipefd);
+	pipe = fget(sbi->pipefd);
 	if (!pipe) {
 		pr_err("could not open pipe file descriptor\n");
 		goto fail_put_pid;
@@ -318,7 +322,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	if (ret < 0)
 		goto fail_fput;
 	sbi->pipe = pipe;
-	sbi->pipefd = pipefd;
 	sbi->catatonic = 0;
 
 	/*


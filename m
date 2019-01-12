Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045FFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3E920878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfALAJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:09:59 -0500
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:46786
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfALAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:09:58 -0500
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 19:09:45 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ASAADXLDlc//yp0HYNVhwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVEHAQELAYQShAGIGow/AQEGgRCDa4VpjkuBe4R0AwICgks0CQ0BAwE?=
 =?us-ascii?q?BAQEBAQKGYAIBAyMEUhAYAQwCJgICRxAGE4UXrgBxfDMaihuBC4FziVh4gQe?=
 =?us-ascii?q?BETOKaYJXApBANpEFCZIbCwKKHwOHTpwpgg5NLgqDJ5BpZYpXAQE?=
X-IPAS-Result: =?us-ascii?q?A2ASAADXLDlc//yp0HYNVhwBAQEEAQEHBAEBgVEHAQELA?=
 =?us-ascii?q?YQShAGIGow/AQEGgRCDa4VpjkuBe4R0AwICgks0CQ0BAwEBAQEBAQKGYAIBA?=
 =?us-ascii?q?yMEUhAYAQwCJgICRxAGE4UXrgBxfDMaihuBC4FziVh4gQeBETOKaYJXApBAN?=
 =?us-ascii?q?pEFCZIbCwKKHwOHTpwpgg5NLgqDJ5BpZYpXAQE?=
X-IronPort-AV: E=Sophos;i="5.56,467,1539619200"; 
   d="scan'208";a="155670411"
Received: from unknown (HELO [192.168.1.228]) ([118.208.169.252])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 12 Jan 2019 08:00:41 +0800
Subject: [PATCH 3/3] autofs: add ignore mount option
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pan Bian <bianpan2016@163.com>
Date:   Sat, 12 Jan 2019 08:00:40 +0800
Message-ID: <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
In-Reply-To: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an autofs file system mount option that can be used to provide
a generic indicator to applications that the mount entry should be
ignored when displaying mount information.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h         |    1 +
 fs/autofs/inode.c            |    9 ++++++++-
 include/uapi/linux/auto_fs.h |    2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 3e59f0ed777b..b735f2b1e462 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -105,6 +105,7 @@ struct autofs_wait_queue {
 
 #define AUTOFS_SBI_CATATONIC	0x0001
 #define AUTOFS_SBI_STRICTEXPIRE 0x0002
+#define AUTOFS_SBI_IGNORE	0x0004
 
 struct autofs_sb_info {
 	u32 magic;
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 078992eee299..8647ecaa89fc 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -89,6 +89,8 @@ static int autofs_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",indirect");
 	if (sbi->flags & AUTOFS_SBI_STRICTEXPIRE)
 		seq_printf(m, ",strictexpire");
+	if (sbi->flags & AUTOFS_SBI_IGNORE)
+		seq_printf(m, ",ignore");
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (sbi->pipe)
 		seq_printf(m, ",pipe_ino=%ld", file_inode(sbi->pipe)->i_ino);
@@ -111,7 +113,8 @@ static const struct super_operations autofs_sops = {
 };
 
 enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
-	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire};
+	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire,
+	Opt_ignore};
 
 static const match_table_t tokens = {
 	{Opt_fd, "fd=%u"},
@@ -124,6 +127,7 @@ static const match_table_t tokens = {
 	{Opt_direct, "direct"},
 	{Opt_offset, "offset"},
 	{Opt_strictexpire, "strictexpire"},
+	{Opt_ignore, "ignore"},
 	{Opt_err, NULL}
 };
 
@@ -206,6 +210,9 @@ static int parse_options(char *options,
 		case Opt_strictexpire:
 			sbi->flags |= AUTOFS_SBI_STRICTEXPIRE;
 			break;
+		case Opt_ignore:
+			sbi->flags |= AUTOFS_SBI_IGNORE;
+			break;
 		default:
 			return 1;
 		}
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index 082119630b49..1f7925afad2d 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -23,7 +23,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	5
 
-#define AUTOFS_PROTO_SUBVERSION		4
+#define AUTOFS_PROTO_SUBVERSION		5
 
 /*
  * The wait_queue_token (autofs_wqt_t) is part of a structure which is passed


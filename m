Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E52EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1287922506
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1287922506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeKMLlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:41:07 -0500
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:53685
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbeKMLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:41:07 -0500
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 06:41:05 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A1AACYKepb/1Sw0HYNVhwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVEHAQELAYQSg3iIGIxNBoEQg2eFU4R6hC+Ed4F6hHQDAgKDTzQNDQE?=
 =?us-ascii?q?DAQEBAQEBAoZQAgEDIwQgMhAYAQwCJgICRxAGE4UWqANwfDMagxCHB4ELgXO?=
 =?us-ascii?q?JGXiBB4ERM4phglcCiQ6GODKPVwmRNQoCiV4DhwMsgkiWR4INTS4KgyeCJxe?=
 =?us-ascii?q?OKWWOGwEB?=
X-IPAS-Result: =?us-ascii?q?A2A1AACYKepb/1Sw0HYNVhwBAQEEAQEHBAEBgVEHAQELA?=
 =?us-ascii?q?YQSg3iIGIxNBoEQg2eFU4R6hC+Ed4F6hHQDAgKDTzQNDQEDAQEBAQEBAoZQA?=
 =?us-ascii?q?gEDIwQgMhAYAQwCJgICRxAGE4UWqANwfDMagxCHB4ELgXOJGXiBB4ERM4phg?=
 =?us-ascii?q?lcCiQ6GODKPVwmRNQoCiV4DhwMsgkiWR4INTS4KgyeCJxeOKWWOGwEB?=
X-IronPort-AV: E=Sophos;i="5.54,497,1534780800"; 
   d="scan'208";a="116718241"
Received: from unknown (HELO [192.168.1.28]) ([118.208.176.84])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 13 Nov 2018 09:36:07 +0800
Subject: [PATCH 2/6] autofs - fix possible inode leak in autofs_fill_super()
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 13 Nov 2018 09:36:05 +0800
Message-ID: <154207296462.11064.11496013579571371405.stgit@pluto-themaw-net>
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

There is no check at all for a failure to allocate the root inode
in autofs_fill_super(), handle it.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 846c052569dd..e5c06b5a7371 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -254,9 +254,13 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 		goto fail_free;
 	}
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
+	if (!root_inode) {
+		ret = -ENOMEM;
+		goto fail_ino;
+	}
 	root = d_make_root(root_inode);
 	if (!root)
-		goto fail_ino;
+		goto fail_iput;
 	pipe = NULL;
 
 	root->d_fsdata = ino;
@@ -304,8 +308,8 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	root_inode->i_op = &autofs_dir_inode_operations;
 
 	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi->oz_pgrp));
-	pipe = fget(pipefd);
 
+	pipe = fget(pipefd);
 	if (!pipe) {
 		pr_err("could not open pipe file descriptor\n");
 		goto fail_put_pid;
@@ -334,6 +338,8 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 fail_dput:
 	dput(root);
 	goto fail_free;
+fail_iput:
+	iput(root_inode);
 fail_ino:
 	autofs_free_ino(ino);
 fail_free:


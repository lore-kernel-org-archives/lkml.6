Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DBBC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63FA2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63FA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJNXLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35754 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727173AbeJNXLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0004cH-PM; Sun, 14 Oct 2018 16:30:25 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000Ta-W8; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@redhat.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Miklos Szeredi" <mszeredi@redhat.com>,
        "Song Liu" <songliubraving@fb.com>,
        "Howard McLauchlan" <hmclauchlan@fb.com>,
        "Srikar Dronamraju" <srikar@linux.vnet.ibm.com>,
        "Josef Bacik" <jbacik@fb.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.113166439@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 233/366] tracing: Fix bad use of igrab in trace_uprobe.c
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Song Liu <songliubraving@fb.com>

commit 0c92c7a3c5d416f47b32c5f20a611dfeca5d5f2e upstream.

As Miklos reported and suggested:

  This pattern repeats two times in trace_uprobe.c and in
  kernel/events/core.c as well:

      ret = kern_path(filename, LOOKUP_FOLLOW, &path);
      if (ret)
          goto fail_address_parse;

      inode = igrab(d_inode(path.dentry));
      path_put(&path);

  And it's wrong.  You can only hold a reference to the inode if you
  have an active ref to the superblock as well (which is normally
  through path.mnt) or holding s_umount.

  This way unmounting the containing filesystem while the tracepoint is
  active will give you the "VFS: Busy inodes after unmount..." message
  and a crash when the inode is finally put.

  Solution: store path instead of inode.

This patch fixes two instances in trace_uprobe.c. struct path is added to
struct trace_uprobe to keep the inode and containing mount point
referenced.

Link: http://lkml.kernel.org/r/20180423172135.4050588-1-songliubraving@fb.com

Fixes: f3f096cfedf8 ("tracing: Provide trace events interface for uprobes")
Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Howard McLauchlan <hmclauchlan@fb.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Reported-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bwh: Backported to 3.16:
 - Open-code d_real_inode(), d_is_reg()
 - Drop changes in create_local_trace_uprobe()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace_uprobe.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -53,6 +53,7 @@ struct trace_uprobe {
 	struct list_head		list;
 	struct trace_uprobe_filter	filter;
 	struct uprobe_consumer		consumer;
+	struct path			path;
 	struct inode			*inode;
 	char				*filename;
 	unsigned long			offset;
@@ -284,7 +285,7 @@ static void free_trace_uprobe(struct tra
 	for (i = 0; i < tu->tp.nr_args; i++)
 		traceprobe_free_probe_arg(&tu->tp.args[i]);
 
-	iput(tu->inode);
+	path_put(&tu->path);
 	kfree(tu->tp.call.class->system);
 	kfree(tu->tp.call.name);
 	kfree(tu->filename);
@@ -358,7 +359,6 @@ end:
 static int create_trace_uprobe(int argc, char **argv)
 {
 	struct trace_uprobe *tu;
-	struct inode *inode;
 	char *arg, *event, *group, *filename;
 	char buf[MAX_EVENT_NAME_LEN];
 	struct path path;
@@ -366,7 +366,6 @@ static int create_trace_uprobe(int argc,
 	bool is_delete, is_return;
 	int i, ret;
 
-	inode = NULL;
 	ret = 0;
 	is_delete = false;
 	is_return = false;
@@ -432,21 +431,16 @@ static int create_trace_uprobe(int argc,
 	}
 	/* Find the last occurrence, in case the path contains ':' too. */
 	arg = strrchr(argv[1], ':');
-	if (!arg) {
-		ret = -EINVAL;
-		goto fail_address_parse;
-	}
+	if (!arg)
+		return -EINVAL;
 
 	*arg++ = '\0';
 	filename = argv[1];
 	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (ret)
-		goto fail_address_parse;
-
-	inode = igrab(path.dentry->d_inode);
-	path_put(&path);
+		return ret;
 
-	if (!inode || !S_ISREG(inode->i_mode)) {
+	if (!S_ISREG(path.dentry->d_inode->i_mode)) {
 		ret = -EINVAL;
 		goto fail_address_parse;
 	}
@@ -485,7 +479,7 @@ static int create_trace_uprobe(int argc,
 		goto fail_address_parse;
 	}
 	tu->offset = offset;
-	tu->inode = inode;
+	tu->path = path;
 	tu->filename = kstrdup(filename, GFP_KERNEL);
 
 	if (!tu->filename) {
@@ -552,7 +546,7 @@ error:
 	return ret;
 
 fail_address_parse:
-	iput(inode);
+	path_put(&path);
 
 	pr_info("Failed to parse address or file.\n");
 
@@ -919,6 +913,7 @@ probe_event_enable(struct trace_uprobe *
 		goto err_flags;
 
 	tu->consumer.filter = filter;
+	tu->inode = tu->path.dentry->d_inode;
 	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
 	if (ret)
 		goto err_buffer;
@@ -964,6 +959,7 @@ probe_event_disable(struct trace_uprobe
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
 	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+	tu->inode = NULL;
 	tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
 
 	uprobe_buffer_disable();


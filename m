Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B313EC46473
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43B21A1C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B43B21A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeHKQYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbeHKQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:30 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD6C21A2E;
        Sat, 11 Aug 2018 13:50:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHV-00068k-Qy; Sat, 11 Aug 2018 09:50:13 -0400
Message-Id: <20180811135013.733694526@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [for-next][PATCH 17/34] tracefs: Annotate tracefs_ops with __ro_after_init
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zubin Mithra <zsm@chromium.org>

tracefs_ops is initialized inside tracefs_create_instance_dir and not
modified after. tracefs_create_instance_dir allows for initialization
only once, and is called from create_trace_instances(marked __init),
which is called from tracer_init_tracefs(marked __init). Also, mark
tracefs_create_instance_dir as __init.

Link: http://lkml.kernel.org/r/20180725171901.4468-1-zsm@chromium.org

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index bea8ad876bf9..7098c49f3693 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -53,7 +53,7 @@ static const struct file_operations tracefs_file_operations = {
 static struct tracefs_dir_ops {
 	int (*mkdir)(const char *name);
 	int (*rmdir)(const char *name);
-} tracefs_ops;
+} tracefs_ops __ro_after_init;
 
 static char *get_dname(struct dentry *dentry)
 {
@@ -478,7 +478,8 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
  *
  * Returns the dentry of the instances directory.
  */
-struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *parent,
+__init struct dentry *tracefs_create_instance_dir(const char *name,
+					  struct dentry *parent,
 					  int (*mkdir)(const char *name),
 					  int (*rmdir)(const char *name))
 {
-- 
2.18.0



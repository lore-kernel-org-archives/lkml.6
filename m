Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F8B217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170630;
	bh=0yNuOAQk176i2GYqxghL1ZfWbitCGMbN3lB5divZh2Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=T8MRB3Y1q4WH0r0tHPQGZnDekXzQlW/jFIv4HYsosQ+MAFeBQIZrCuM8IL778X/gc
	 C0PUMg0j8eAyc/SbcnNwsgeQB7VM1lk80dXzw2T+OoDFx8HVklVAqB9QDQZRAPaRY+
	 P6ACreXJSUNIIDReqciwtZFGWUlVMX9GkWOZVh48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfAVPXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbfAVPXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB0E20879;
        Tue, 22 Jan 2019 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170624;
        bh=0yNuOAQk176i2GYqxghL1ZfWbitCGMbN3lB5divZh2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=ljX2Mt1jDigt9huAS5kExEs4CaxeiZhX7eo62jw1ZnMCeYrim/HuNmQRzZcYkVH6J
         zRKn7teAQEsRE0si/BxOO7hdBHfcI+2jDq2ODEmcJ+mMpgyy3Zhn7Gl19kLyFVBwPL
         Zj2KrxBNwI7QsXTRhZTAJk+vxJo6zjMqbErPMYMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] kprobes: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:46 +0100
Message-Id: <20190122152151.16139-47-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kprobes.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f4ddfdd2d07e..7287e7de2350 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2566,33 +2566,20 @@ static const struct file_operations fops_kp = {
 
 static int __init debugfs_kprobe_init(void)
 {
-	struct dentry *dir, *file;
+	struct dentry *dir;
 	unsigned int value = 1;
 
 	dir = debugfs_create_dir("kprobes", NULL);
-	if (!dir)
-		return -ENOMEM;
 
-	file = debugfs_create_file("list", 0400, dir, NULL,
-				&debugfs_kprobes_operations);
-	if (!file)
-		goto error;
+	debugfs_create_file("list", 0400, dir, NULL,
+			    &debugfs_kprobes_operations);
 
-	file = debugfs_create_file("enabled", 0600, dir,
-					&value, &fops_kp);
-	if (!file)
-		goto error;
+	debugfs_create_file("enabled", 0600, dir, &value, &fops_kp);
 
-	file = debugfs_create_file("blacklist", 0400, dir, NULL,
-				&debugfs_kprobe_blacklist_ops);
-	if (!file)
-		goto error;
+	debugfs_create_file("blacklist", 0400, dir, NULL,
+			    &debugfs_kprobe_blacklist_ops);
 
 	return 0;
-
-error:
-	debugfs_remove(dir);
-	return -ENOMEM;
 }
 
 late_initcall(debugfs_kprobe_init);
-- 
2.20.1


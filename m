Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7338C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC07217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170621;
	bh=Gt+BQnAE5G3kokbj7CXTtGHsB+Ea6BBNKJv4YX6f9lw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hgibH2mQUFeWkfTYQr4+0LlmvAd8rFgaZQs0eP8xDQzlsrr8FeeUsqgGlxQpNLkEs
	 NoXHD6e417dsw77QC23iVwdwMHoWYc5q9mB1SYFJ18expmCljEF1gEjyU6VbmPBXbs
	 yi0DasbxhCqTUquAmv5bYB3XbhyrBLQUWpGfoTBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfAVPXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbfAVPXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09598217F4;
        Tue, 22 Jan 2019 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170616;
        bh=Gt+BQnAE5G3kokbj7CXTtGHsB+Ea6BBNKJv4YX6f9lw=;
        h=From:To:Cc:Subject:Date:From;
        b=DxZe5LwhjQzvaqYimudJ6ZqrdZTUTK6jopWfOdI6vIgKvMPNv3M9t2IBm3hb+4zNl
         yaZGN7ZqrjPDdrKI3jIuRTZVS8Cq61tZfBxeS1z6AfNLAaHOeLJedsH+FRfBAPgwaT
         PXvQbKqacDAcj6goPe49DVIHsfS7g4BV44DK4Y8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH] qspinlock: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:43 +0100
Message-Id: <20190122152151.16139-44-gregkh@linuxfoundation.org>
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

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/qspinlock_stat.h | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 42d3d8dc8f49..766fa0c8c115 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -213,9 +213,6 @@ static int __init init_qspinlock_stat(void)
 	struct dentry *d_qstat = debugfs_create_dir("qlockstat", NULL);
 	int i;
 
-	if (!d_qstat)
-		goto out;
-
 	/*
 	 * Create the debugfs files
 	 *
@@ -224,20 +221,13 @@ static int __init init_qspinlock_stat(void)
 	 * performance.
 	 */
 	for (i = 0; i < qstat_num; i++)
-		if (!debugfs_create_file(qstat_names[i], 0400, d_qstat,
-					 (void *)(long)i, &fops_qstat))
-			goto fail_undo;
+		debugfs_create_file(qstat_names[i], 0400, d_qstat,
+				    (void *)(long)i, &fops_qstat);
 
-	if (!debugfs_create_file(qstat_names[qstat_reset_cnts], 0200, d_qstat,
-				 (void *)(long)qstat_reset_cnts, &fops_qstat))
-		goto fail_undo;
+	debugfs_create_file(qstat_names[qstat_reset_cnts], 0200, d_qstat,
+			    (void *)(long)qstat_reset_cnts, &fops_qstat);
 
 	return 0;
-fail_undo:
-	debugfs_remove_recursive(d_qstat);
-out:
-	pr_warn("Could not create 'qlockstat' debugfs entries\n");
-	return -ENOMEM;
 }
 fs_initcall(init_qspinlock_stat);
 
-- 
2.20.1


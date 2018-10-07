Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEEAC6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B8E2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="WWimZL5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B8E2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeJHGhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:37:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41302 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJHGhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id l41-v6so6700813qtl.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfsFRrZ6KAlLBf436Eo8OYltlmn/LipQqbccNRty++w=;
        b=WWimZL5GLgq3R/GRMWQL2pBx28YmlCB6UWU2Ed/Der3OhEfGxgwDq2hAPiLcQyORzu
         PHbS1zlcy0jvrII5euhA2NQ3hKl/A24JdMvVwhEr6749KW/Ycv15BbynIHDr0BiK+qKH
         zFkDz8Khs+os0lKEZSxOZQ5DkZHRw5lrFE81ceTZQLtt0UvLt0BK3Z3itnlxTdDiWOfO
         4T8YAPzi2y64P25d8VH6o8nSXOUufVkiAKrqJljhwnUiZ5qR14QNqkeTobObVpA2QaE9
         QwnFnVtZvlV1iIRBUKrQ4Y32GsQq8RninagJxxQryHIVvaIaIQCG6PTBf52v2xzDWSCM
         J3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfsFRrZ6KAlLBf436Eo8OYltlmn/LipQqbccNRty++w=;
        b=PtW6GD6KhSIgkgsDzfqvgoGNBkf4x24WjHPhQ+5jAPZNMZBpsI0Pl5GC68VWJ4/xYA
         PAxV6QYE6ZgG+e2+8NTQ1A49MkagUTWmU3lPh7RBgUyeFSIW9md+GUKlE+g6wn4NzSwh
         nsjs0qcLlhu4SaQK9h+taAD9QYvGmuywz5FZrxtgkMeCRx9aeLm9t1OC2gqLVjDalec5
         jsd6R02FzGKDo9kZ1VeeknhLTzkfhzvSJvOOiGYRmVz/ghwKQyH/HL4C8FHB231ZxFiw
         RkgGsmIeMftSI/R5zzRzMsY+btE7Wan3+tM5ng8zxQbrQ2+RLQy6rXMTN7mToh4mB2iu
         C/Bw==
X-Gm-Message-State: ABuFfohs5y17tq1bMMjYSpJKsffFOP7szGhXKCoquWwr5JJu7gBXhKM0
        FAbcCDKskLlXd/4BwcPdGYSPQg==
X-Google-Smtp-Source: ACcGV61muAt+yXc9x3AvCG4fF0qPoOXuMlA4ytwPIOOdbstStI0guocY4GSgw4msvKAxjcGm4jaGRA==
X-Received: by 2002:a0c:c119:: with SMTP id f25-v6mr17277242qvh.219.1538954894640;
        Sun, 07 Oct 2018 16:28:14 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:13 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 15/19] orangefs: avoid fsync service operation on flush
Date:   Sun,  7 Oct 2018 23:27:32 +0000
Message-Id: <20181007232736.3780-16-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, an fsync call is sent to the server even if no data
changed.  This resulted in a rather severe (50%) performance regression
under certain metadata-heavy workloads.

In the past, everything was direct IO.  Nothing happend on a close call.
An explicit fsync call would send an fsync request to the server which
in turn fsynced the underlying file.

Now there are cached writes.  Then fsync began writing out dirty pages
in addition to making an fsync request to the server, and close began
calling fsync.

With this commit, close only writes out dirty pages, and does not make
the fsync request.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/file.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 5eda483263ae..d5ecfea3288a 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -596,7 +596,24 @@ static int orangefs_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 int orangefs_flush(struct file *file, fl_owner_t id)
 {
-	return vfs_fsync(file, 0);
+	/*
+	 * This is vfs_fsync_range(file, 0, LLONG_MAX, 0) without the
+	 * service_operation in orangefs_fsync.
+	 *
+	 * Do not send fsync to OrangeFS server on a close.  Do send fsync
+	 * on an explicit fsync call.  This duplicates historical OrangeFS
+	 * behavior.
+	 */
+	struct inode *inode = file->f_mapping->host;
+
+	if (inode->i_state & I_DIRTY_TIME) {
+		spin_lock(&inode->i_lock);
+		inode->i_state &= ~I_DIRTY_TIME;
+		spin_unlock(&inode->i_lock);
+		mark_inode_dirty_sync(inode);
+	}
+
+	return filemap_write_and_wait_range(file->f_mapping, 0, LLONG_MAX);
 }
 
 /** ORANGEFS implementation of VFS file operations */
-- 
2.19.0


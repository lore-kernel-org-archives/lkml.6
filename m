Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1745C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703CE2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjdEBwxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703CE2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933692AbeGJOCk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933336AbeGJOBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:01:31 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB59208E4;
        Tue, 10 Jul 2018 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531231291;
        bh=LnZjtKlv7EEzgFlcE3Bk7HrAuI2UheKa25IHdJB+NnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjdEBwxj/41Br+6/GCqUKqIj9RVJbG29fL6Q4NUFh601X4BVGzWWjzvED4i6dQuzW
         OWDq9XrHeA5X1e1FIcX1pVcYaXuNF1rfcV5AMt821lc6M5nZ2qFIK89BKkbkOGgiTB
         LLyPid8s+Qj68hfxWbEF/5tkXq+33QHUVSpMqjP8=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc:     willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/4] vfs: track per-sb writeback errors
Date:   Tue, 10 Jul 2018 10:01:24 -0400
Message-Id: <20180710140127.20739-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710140127.20739-1-jlayton@kernel.org>
References: <20180710140127.20739-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Keep a per-sb errseq_t that tracks whether there have been any writeback
errors on this superblock. When an error is recorded for an inode via
mapping_set_error, record it in s_wb_err as well.

Cc: Andres Freund <andres@anarazel.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/fs.h      | 3 +++
 include/linux/pagemap.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 858dd2f3300c..5378a845ca01 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1446,6 +1446,9 @@ struct super_block {
 	/* Being remounted read-only */
 	int s_readonly_remount;
 
+	/* per-sb errseq_t for reporting writeback errors via syncfs */
+	errseq_t s_wb_err;
+
 	/* AIO completions deferred from interrupt context */
 	struct workqueue_struct *s_dio_done_wq;
 	struct hlist_head s_pins;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 442977811b59..c1e36a7b44d2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -51,7 +51,10 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
 		return;
 
 	/* Record in wb_err for checkers using errseq_t based tracking */
-	filemap_set_wb_err(mapping, error);
+	__filemap_set_wb_err(mapping, error);
+
+	/* Record it in superblock */
+	errseq_set(&mapping->host->i_sb->s_wb_err, error);
 
 	/* Record it in flags for now, for legacy callers */
 	if (error == -ENOSPC)
-- 
2.17.1


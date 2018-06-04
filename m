Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeFDSEi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeFDSDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:03:08 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc: willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] vfs: track per-sb writeback errors
Date: Mon,  4 Jun 2018 14:03:00 -0400
Message-Id: <20180604180304.9662-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604180304.9662-1-jlayton@kernel.org>
References: <20180604180304.9662-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
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
index 79f98ed39a18..ccdcde9e185b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1429,6 +1429,9 @@ struct super_block {
 	/* Being remounted read-only */
 	int s_readonly_remount;
 
+	/* per-sb errseq_t for reporting writeback errors via syncfs */
+	errseq_t s_wb_err;
+
 	/* AIO completions deferred from interrupt context */
 	struct workqueue_struct *s_dio_done_wq;
 	struct hlist_head s_pins;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b1bd2186e6d2..2de87c5a2718 100644
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
2.17.0

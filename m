Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeFDSEF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbeFDSDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:03:11 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc: willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] vfs: allow fsinfo to fetch the current state of s_wb_err
Date: Mon,  4 Jun 2018 14:03:03 -0400
Message-Id: <20180604180304.9662-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604180304.9662-1-jlayton@kernel.org>
References: <20180604180304.9662-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Add a new "error_state" struct to fsinfo, and teach the kernel to fill
that out from sb->s_wb_info. There are two fields:

wb_error_last: the most recently recorded errno for the filesystem

wb_error_cookie: this value will change vs. the previously fetched
                 value if a new error was recorded since it was last
		 checked

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/statfs.c                 |  9 +++++++++
 include/uapi/linux/fsinfo.h | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index f996ab6af44f..df8f1a1166c0 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -576,6 +576,14 @@ static int fsinfo_generic_io_size(struct dentry *dentry,
 	return sizeof(*c);
 }
 
+static int fsinfo_generic_error_state(struct dentry *dentry,
+				  struct fsinfo_error_state *c)
+{
+	c->wb_error_cookie = errseq_scrape(&dentry->d_sb->s_wb_err);
+	c->wb_error_last = c->wb_error_cookie & MAX_ERRNO;
+	return sizeof(*c);
+}
+
 /*
  * Implement some queries generically from stuff in the superblock.
  */
@@ -594,6 +602,7 @@ int generic_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
 	case _gen(volume_id);
 	case _gen(name_encoding);
 	case _gen(io_size);
+	case _gen(error_state);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index a6758e71f0c7..a0c6e0e18e8a 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -35,6 +35,7 @@ enum fsinfo_attribute {
 	fsinfo_attr_name_encoding	= 17,	/* Filename encoding (string) */
 	fsinfo_attr_name_codepage	= 18,	/* Filename codepage (string) */
 	fsinfo_attr_io_size		= 19,	/* Optimal I/O sizes */
+	fsinfo_attr_error_state		= 20,	/* Error state */
 	fsinfo_attr__nr
 };
 
@@ -209,6 +210,16 @@ struct fsinfo_server_address {
 	struct __kernel_sockaddr_storage address;
 };
 
+/*
+ * Information struct for fsinfo(fsinfo_attr_error_state).
+ *
+ * Retrieve the error state for a filesystem.
+ */
+struct fsinfo_error_state {
+	__u32		wb_error_cookie;	/* writeback error cookie */
+	__u32		wb_error_last;		/* latest writeback error */
+};
+
 /*
  * Information struct for fsinfo(fsinfo_attr_io_size).
  *
-- 
2.17.0

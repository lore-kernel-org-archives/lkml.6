Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbeDEUbk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:31:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751750AbeDEUbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:31:38 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/20] afs: Add stats for data transfer operations
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:31:36 +0100
Message-ID: <152296029636.31027.9996788773150502222.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add statistics to /proc/fs/afs/stats for data transfer RPC operations.  New
lines are added that look like:

	file-rd : n=55794 nb=10252282150
	file-wr : n=9789 nb=3247763645

where n= indicates the number of ops completed and nb= indicates the number
of bytes successfully transferred.  file-rd is the counts for read/fetch
operations and file-wr the counts for write/store operations.

Note that directory and symlink downloading are included in the file-rd
stats at the moment.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c     |    6 ++++++
 fs/afs/internal.h |    4 ++++
 fs/afs/proc.c     |    7 +++++++
 fs/afs/write.c    |    6 ++++++
 4 files changed, 23 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 91ff1335fd33..e5cac1bc3cf0 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -242,6 +242,12 @@ int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *de
 		ret = afs_end_vnode_operation(&fc);
 	}
 
+	if (ret == 0) {
+		afs_stat_v(vnode, n_fetches);
+		atomic_long_add(desc->actual_len,
+				&afs_v2net(vnode)->n_fetch_bytes);
+	}
+
 	_leave(" = %d", ret);
 	return ret;
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 901c11521662..184094810038 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -271,6 +271,10 @@ struct afs_net {
 	atomic_t		n_read_dir;	/* Number of directory pages read */
 	atomic_t		n_dir_cr;	/* Number of directory entry creation edits */
 	atomic_t		n_dir_rm;	/* Number of directory entry removal edits */
+	atomic_t		n_stores;	/* Number of store ops */
+	atomic_long_t		n_store_bytes;	/* Number of bytes stored */
+	atomic_long_t		n_fetch_bytes;	/* Number of bytes fetched */
+	atomic_t		n_fetches;	/* Number of data fetch ops */
 };
 
 extern const char afs_init_sysname[];
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 5ced655d08b3..870b0bad03d0 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -902,6 +902,13 @@ static int afs_proc_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "dir-edit: cr=%u rm=%u\n",
 		   atomic_read(&net->n_dir_cr),
 		   atomic_read(&net->n_dir_rm));
+
+	seq_printf(m, "file-rd : n=%u nb=%lu\n",
+		   atomic_read(&net->n_fetches),
+		   atomic_long_read(&net->n_fetch_bytes));
+	seq_printf(m, "file-wr : n=%u nb=%lu\n",
+		   atomic_read(&net->n_stores),
+		   atomic_long_read(&net->n_store_bytes));
 	return 0;
 }
 
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 70a563c14e6f..eccc16198f68 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -356,6 +356,12 @@ static int afs_store_data(struct address_space *mapping,
 	}
 
 	switch (ret) {
+	case 0:
+		afs_stat_v(vnode, n_stores);
+		atomic_long_add((last * PAGE_SIZE + to) -
+				(first * PAGE_SIZE + offset),
+				&afs_v2net(vnode)->n_store_bytes);
+		break;
 	case -EACCES:
 	case -EPERM:
 	case -ENOKEY:

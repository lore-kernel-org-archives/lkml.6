Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B536C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4016721A2D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4016721A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbeHFP0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:26:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729660AbeHFP0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:26:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40A5E401EF11;
        Mon,  6 Aug 2018 13:17:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DD391049483;
        Mon,  6 Aug 2018 13:17:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/10] afs: Add a couple of tracepoints to log I/O errors
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@wil.cx
Date:   Mon, 06 Aug 2018 14:17:39 +0100
Message-ID: <153356145982.1195.16417986152411637909.stgit@warthog.procyon.org.uk>
In-Reply-To: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
References: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 06 Aug 2018 13:17:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 06 Aug 2018 13:17:41 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of tracepoints to log the production of I/O errors within the AFS
filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c         |   10 +++--
 fs/afs/dir.c               |   23 ++++++++----
 fs/afs/internal.h          |   11 ++++++
 fs/afs/mntpt.c             |    2 +
 fs/afs/rxrpc.c             |    2 +
 fs/afs/server.c            |    4 +-
 fs/afs/volume.c            |    2 +
 fs/afs/write.c             |    1 +
 include/trace/events/afs.h |   81 ++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 117 insertions(+), 19 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 4db62ae8dc1a..186f621f8722 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -260,7 +260,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 	}
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
-		return -EIO;
+		return afs_io_error(call, afs_io_error_cm_reply);
 
 	/* we'll need the file server record as that tells us which set of
 	 * vnodes to operate upon */
@@ -368,7 +368,7 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 	}
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
-		return -EIO;
+		return afs_io_error(call, afs_io_error_cm_reply);
 
 	/* we'll need the file server record as that tells us which set of
 	 * vnodes to operate upon */
@@ -409,7 +409,7 @@ static int afs_deliver_cb_probe(struct afs_call *call)
 		return ret;
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
-		return -EIO;
+		return afs_io_error(call, afs_io_error_cm_reply);
 
 	return afs_queue_call_work(call);
 }
@@ -490,7 +490,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 	}
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
-		return -EIO;
+		return afs_io_error(call, afs_io_error_cm_reply);
 
 	return afs_queue_call_work(call);
 }
@@ -573,7 +573,7 @@ static int afs_deliver_cb_tell_me_about_yourself(struct afs_call *call)
 		return ret;
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
-		return -EIO;
+		return afs_io_error(call, afs_io_error_cm_reply);
 
 	return afs_queue_call_work(call);
 }
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1357a10804bb..300514cb33d8 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -173,6 +173,7 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 			       ntohs(dbuf->blocks[tmp].hdr.magic));
 			trace_afs_dir_check_failed(dvnode, off, i_size);
 			kunmap(page);
+			trace_afs_file_error(dvnode, -EIO, afs_file_error_dir_bad_magic);
 			goto error;
 		}
 
@@ -273,12 +274,15 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 expand:
 	i_size = i_size_read(&dvnode->vfs_inode);
-	ret = -EIO;
-	if (i_size < 2048)
+	if (i_size < 2048) {
+		ret = afs_bad(dvnode, afs_file_error_dir_small);
 		goto error;
-	ret = -EFBIG;
-	if (i_size > 2048 * 1024)
+	}
+	if (i_size > 2048 * 1024) {
+		trace_afs_file_error(dvnode, -EFBIG, afs_file_error_dir_big);
+		ret = -EFBIG;
 		goto error;
+	}
 
 	nr_pages = (i_size + PAGE_SIZE - 1) / PAGE_SIZE;
 
@@ -383,7 +387,8 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 /*
  * deal with one block in an AFS directory
  */
-static int afs_dir_iterate_block(struct dir_context *ctx,
+static int afs_dir_iterate_block(struct afs_vnode *dvnode,
+				 struct dir_context *ctx,
 				 union afs_xdr_dir_block *block,
 				 unsigned blkoff)
 {
@@ -433,7 +438,7 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 				       " (len %u/%zu)",
 				       blkoff / sizeof(union afs_xdr_dir_block),
 				       offset, next, tmp, nlen);
-				return -EIO;
+				return afs_bad(dvnode, afs_file_error_dir_over_end);
 			}
 			if (!(block->hdr.bitmap[next / 8] &
 			      (1 << (next % 8)))) {
@@ -441,7 +446,7 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 				       " %u unmarked extension (len %u/%zu)",
 				       blkoff / sizeof(union afs_xdr_dir_block),
 				       offset, next, tmp, nlen);
-				return -EIO;
+				return afs_bad(dvnode, afs_file_error_dir_unmarked_ext);
 			}
 
 			_debug("ENT[%zu.%u]: ext %u/%zu",
@@ -517,7 +522,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 			page = radix_tree_deref_slot(slot);
 		rcu_read_unlock();
 		if (!page) {
-			ret = -EIO;
+			ret = afs_bad(dvnode, afs_file_error_dir_missing_page);
 			break;
 		}
 		mark_page_accessed(page);
@@ -530,7 +535,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 		do {
 			dblock = &dbuf->blocks[(blkoff % PAGE_SIZE) /
 					       sizeof(union afs_xdr_dir_block)];
-			ret = afs_dir_iterate_block(ctx, dblock, blkoff);
+			ret = afs_dir_iterate_block(dvnode, ctx, dblock, blkoff);
 			if (ret != 1) {
 				kunmap(page);
 				goto out;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ac763e651c42..8e2941cafc36 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1149,6 +1149,17 @@ static inline void afs_check_for_remote_deletion(struct afs_fs_cursor *fc,
 	}
 }
 
+static inline int afs_io_error(struct afs_call *call, enum afs_io_error where)
+{
+	trace_afs_io_error(call->debug_id, -EIO, where);
+	return -EIO;
+}
+
+static inline int afs_bad(struct afs_vnode *vnode, enum afs_file_error where)
+{
+	trace_afs_file_error(vnode, -EIO, where);
+	return -EIO;
+}
 
 /*****************************************************************************/
 /*
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index c8a7f05b9f12..822d62790a74 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -122,7 +122,7 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 
 		if (PageError(page)) {
 			put_page(page);
-			return -EIO;
+			return afs_bad(AFS_FS_I(d_inode(mntpt)), afs_file_error_mntpt);
 		}
 
 		buf = kmap(page);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index fa22739cbf4f..36363c33097b 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -845,7 +845,7 @@ int afs_extract_data(struct afs_call *call, bool want_more)
 			break;
 		case AFS_CALL_COMPLETE:
 			kdebug("prem complete %d", call->error);
-			return -EIO;
+			return afs_io_error(call, afs_io_error_extract);
 		default:
 			break;
 		}
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 1d329e6981d5..b7874bf9402e 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -274,7 +274,7 @@ static struct afs_addr_list *afs_vl_lookup_addrs(struct afs_cell *cell,
 		case -ECONNREFUSED:
 			break;
 		default:
-			ac.error = -EIO;
+			ac.error = afs_io_error(NULL, afs_io_error_vl_lookup_fail);
 			goto error;
 		}
 	}
@@ -560,7 +560,7 @@ static bool afs_do_probe_fileserver(struct afs_fs_cursor *fc)
 		case -ETIME:
 			break;
 		default:
-			fc->ac.error = -EIO;
+			fc->ac.error = afs_io_error(NULL, afs_io_error_fs_probe_fail);
 			goto error;
 		}
 	}
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 7adcddf02e66..23dde4624d06 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -116,7 +116,7 @@ static struct afs_vldb_entry *afs_vl_lookup_vldb(struct afs_cell *cell,
 		case -ECONNREFUSED:
 			break;
 		default:
-			ac.error = -EIO;
+			ac.error = afs_io_error(NULL, afs_io_error_vl_lookup_fail);
 			goto error;
 		}
 	}
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 18b836b473f2..6ff0f25836de 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -537,6 +537,7 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 	case -ENOENT:
 	case -ENOMEDIUM:
 	case -ENXIO:
+		trace_afs_file_error(vnode, ret, afs_file_error_writeback_fail);
 		afs_kill_pages(mapping, first, last);
 		mapping_set_error(mapping, ret);
 		break;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 9c44245987b3..d9c99c423fd9 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -103,6 +103,24 @@ enum afs_eproto_cause {
 	afs_eproto_yvl_vlendpt_type,
 };
 
+enum afs_io_error {
+	afs_io_error_cm_reply,
+	afs_io_error_extract,
+	afs_io_error_fs_probe_fail,
+	afs_io_error_vl_lookup_fail,
+};
+
+enum afs_file_error {
+	afs_file_error_dir_bad_magic,
+	afs_file_error_dir_big,
+	afs_file_error_dir_missing_page,
+	afs_file_error_dir_over_end,
+	afs_file_error_dir_small,
+	afs_file_error_dir_unmarked_ext,
+	afs_file_error_mntpt,
+	afs_file_error_writeback_fail,
+};
+
 #endif /* end __AFS_DECLARE_TRACE_ENUMS_ONCE_ONLY */
 
 /*
@@ -183,6 +201,21 @@ enum afs_eproto_cause {
 	EM(afs_eproto_yvl_vlendpt6_len,	"YVL.VlEnd6Len") \
 	E_(afs_eproto_yvl_vlendpt_type,	"YVL.VlEndType")
 
+#define afs_io_errors							\
+	EM(afs_io_error_cm_reply,		"CM_REPLY")		\
+	EM(afs_io_error_extract,		"EXTRACT")		\
+	EM(afs_io_error_fs_probe_fail,		"FS_PROBE_FAIL")	\
+	E_(afs_io_error_vl_lookup_fail,		"VL_LOOKUP_FAIL")
+
+#define afs_file_errors							\
+	EM(afs_file_error_dir_bad_magic,	"DIR_BAD_MAGIC")	\
+	EM(afs_file_error_dir_big,		"DIR_BIG")		\
+	EM(afs_file_error_dir_missing_page,	"DIR_MISSING_PAGE")	\
+	EM(afs_file_error_dir_over_end,		"DIR_ENT_OVER_END")	\
+	EM(afs_file_error_dir_small,		"DIR_SMALL")		\
+	EM(afs_file_error_dir_unmarked_ext,	"DIR_UNMARKED_EXT")	\
+	EM(afs_file_error_mntpt,		"MNTPT_READ_FAILED")	\
+	E_(afs_file_error_writeback_fail,	"WRITEBACK_FAILED")
 
 /*
  * Export enum symbols via userspace.
@@ -197,6 +230,9 @@ afs_fs_operations;
 afs_vl_operations;
 afs_edit_dir_ops;
 afs_edit_dir_reasons;
+afs_eproto_causes;
+afs_io_errors;
+afs_file_errors;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -600,6 +636,51 @@ TRACE_EVENT(afs_protocol_error,
 		      __print_symbolic(__entry->cause, afs_eproto_causes))
 	    );
 
+TRACE_EVENT(afs_io_error,
+	    TP_PROTO(unsigned int call, int error, enum afs_io_error where),
+
+	    TP_ARGS(call, error, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call		)
+		    __field(int,		error		)
+		    __field(enum afs_io_error,	where		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call = call;
+		    __entry->error = error;
+		    __entry->where = where;
+			   ),
+
+	    TP_printk("c=%08x r=%d %s",
+		      __entry->call, __entry->error,
+		      __print_symbolic(__entry->where, afs_io_errors))
+	    );
+
+TRACE_EVENT(afs_file_error,
+	    TP_PROTO(struct afs_vnode *vnode, int error, enum afs_file_error where),
+
+	    TP_ARGS(vnode, error, where),
+
+	    TP_STRUCT__entry(
+		    __field_struct(struct afs_fid,	fid		)
+		    __field(int,			error		)
+		    __field(enum afs_file_error,	where		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->fid = vnode->fid;
+		    __entry->error = error;
+		    __entry->where = where;
+			   ),
+
+	    TP_printk("%x:%x:%x r=%d %s",
+		      __entry->fid.vid, __entry->fid.vnode, __entry->fid.unique,
+		      __entry->error,
+		      __print_symbolic(__entry->where, afs_file_errors))
+	    );
+
 TRACE_EVENT(afs_cm_no_server,
 	    TP_PROTO(struct afs_call *call, struct sockaddr_rxrpc *srx),
 


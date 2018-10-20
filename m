Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F5EECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF518214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF518214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJTJUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:20:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 480393D95A;
        Sat, 20 Oct 2018 01:11:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1FD60FAB;
        Sat, 20 Oct 2018 01:11:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/24] afs: Add a couple of tracepoints to log I/O errors
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:11:50 +0100
Message-ID: <153999791034.866.7378749374763197382.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 20 Oct 2018 01:11:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of tracepoints to log the production of I/O errors within the AFS
filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c         |   10 +++--
 fs/afs/dir.c               |   18 ++++++----
 fs/afs/internal.h          |   11 ++++++
 fs/afs/mntpt.c             |    5 ++-
 fs/afs/rxrpc.c             |    2 +
 fs/afs/server.c            |    2 +
 fs/afs/write.c             |    1 +
 include/trace/events/afs.h |   81 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 114 insertions(+), 16 deletions(-)

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
index 855bf2b79fed..78f9754fd03d 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -138,6 +138,7 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 			       ntohs(dbuf->blocks[tmp].hdr.magic));
 			trace_afs_dir_check_failed(dvnode, off, i_size);
 			kunmap(page);
+			trace_afs_file_error(dvnode, -EIO, afs_file_error_dir_bad_magic);
 			goto error;
 		}
 
@@ -190,9 +191,11 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 retry:
 	i_size = i_size_read(&dvnode->vfs_inode);
 	if (i_size < 2048)
-		return ERR_PTR(-EIO);
-	if (i_size > 2048 * 1024)
+		return ERR_PTR(afs_bad(dvnode, afs_file_error_dir_small));
+	if (i_size > 2048 * 1024) {
+		trace_afs_file_error(dvnode, -EFBIG, afs_file_error_dir_big);
 		return ERR_PTR(-EFBIG);
+	}
 
 	_enter("%llu", i_size);
 
@@ -315,7 +318,8 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 /*
  * deal with one block in an AFS directory
  */
-static int afs_dir_iterate_block(struct dir_context *ctx,
+static int afs_dir_iterate_block(struct afs_vnode *dvnode,
+				 struct dir_context *ctx,
 				 union afs_xdr_dir_block *block,
 				 unsigned blkoff)
 {
@@ -365,7 +369,7 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 				       " (len %u/%zu)",
 				       blkoff / sizeof(union afs_xdr_dir_block),
 				       offset, next, tmp, nlen);
-				return -EIO;
+				return afs_bad(dvnode, afs_file_error_dir_over_end);
 			}
 			if (!(block->hdr.bitmap[next / 8] &
 			      (1 << (next % 8)))) {
@@ -373,7 +377,7 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 				       " %u unmarked extension (len %u/%zu)",
 				       blkoff / sizeof(union afs_xdr_dir_block),
 				       offset, next, tmp, nlen);
-				return -EIO;
+				return afs_bad(dvnode, afs_file_error_dir_unmarked_ext);
 			}
 
 			_debug("ENT[%zu.%u]: ext %u/%zu",
@@ -442,7 +446,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 		 */
 		page = req->pages[blkoff / PAGE_SIZE];
 		if (!page) {
-			ret = -EIO;
+			ret = afs_bad(dvnode, afs_file_error_dir_missing_page);
 			break;
 		}
 		mark_page_accessed(page);
@@ -455,7 +459,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 		do {
 			dblock = &dbuf->blocks[(blkoff % PAGE_SIZE) /
 					       sizeof(union afs_xdr_dir_block)];
-			ret = afs_dir_iterate_block(ctx, dblock, blkoff);
+			ret = afs_dir_iterate_block(dvnode, ctx, dblock, blkoff);
 			if (ret != 1) {
 				kunmap(page);
 				goto out;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 7e264cb9b4f7..28d08aac515d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1257,6 +1257,17 @@ static inline void afs_check_for_remote_deletion(struct afs_fs_cursor *fc,
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
index 99fd13500a97..2e51c6994148 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -130,9 +130,10 @@ static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
 			goto error_no_page;
 		}
 
-		ret = -EIO;
-		if (PageError(page))
+		if (PageError(page)) {
+			ret = afs_bad(AFS_FS_I(d_inode(mntpt)), afs_file_error_mntpt);
 			goto error;
+		}
 
 		buf = kmap_atomic(page);
 		memcpy(devname, buf, size);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 947ae3ab389b..e6ab824ab761 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -915,7 +915,7 @@ int afs_extract_data(struct afs_call *call, bool want_more)
 			break;
 		case AFS_CALL_COMPLETE:
 			kdebug("prem complete %d", call->error);
-			return -EIO;
+			return afs_io_error(call, afs_io_error_extract);
 		default:
 			break;
 		}
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 6102ea9ee3fb..1a087eb8f2d7 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -542,7 +542,7 @@ static bool afs_do_probe_fileserver(struct afs_fs_cursor *fc)
 		case -ETIME:
 			break;
 		default:
-			fc->ac.error = -EIO;
+			fc->ac.error = afs_io_error(NULL, afs_io_error_fs_probe_fail);
 			goto error;
 		}
 	}
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 19c04caf3c01..fdb9d6024126 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -533,6 +533,7 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 	case -ENOENT:
 	case -ENOMEDIUM:
 	case -ENXIO:
+		trace_afs_file_error(vnode, ret, afs_file_error_writeback_fail);
 		afs_kill_pages(mapping, first, last);
 		mapping_set_error(mapping, ret);
 		break;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 5e0f8dcede26..48b20a261d39 100644
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
@@ -613,6 +649,51 @@ TRACE_EVENT(afs_protocol_error,
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
 


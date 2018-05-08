Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933244AbeEHSHl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:07:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54357 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933066AbeEHSGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:37 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 74/76] fs: Use fs_view device from struct inode.
Date: Tue,  8 May 2018 11:04:34 -0700
Message-Id: <20180508180436.716-75-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace calls of inode_sb(inode)->s_dev with inode_view(inode)->v_dev.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 arch/arc/kernel/troubleshoot.c             |   2 +-
 drivers/staging/lustre/lustre/llite/dir.c  |   2 +-
 drivers/staging/lustre/lustre/llite/file.c |   2 +-
 fs/eventpoll.c                             |   2 +-
 fs/f2fs/trace.c                            |   8 +-
 fs/fuse/dir.c                              |   2 +-
 fs/locks.c                                 |  12 +--
 fs/nfs/nfs4trace.h                         |  36 ++++-----
 fs/nfs/nfstrace.h                          |  42 +++++-----
 fs/nfsd/vfs.c                              |   6 +-
 fs/notify/fdinfo.c                         |   4 +-
 fs/proc/nommu.c                            |   2 +-
 fs/proc/task_mmu.c                         |   2 +-
 fs/proc/task_nommu.c                       |   2 +-
 fs/stat.c                                  |   2 +-
 fs/xfs/xfs_iops.c                          |   2 +-
 fs/xfs/xfs_trace.h                         |  64 ++++++++--------
 include/trace/events/ext4.h                | 118 ++++++++++++++---------------
 include/trace/events/f2fs.h                |  52 ++++++-------
 include/trace/events/filelock.h            |   8 +-
 include/trace/events/filemap.h             |   6 +-
 include/trace/events/fs_dax.h              |  14 ++--
 include/trace/events/jbd2.h                |   2 +-
 include/trace/events/writeback.h           |   2 +-
 kernel/audit.c                             |   2 +-
 kernel/audit_fsnotify.c                    |   2 +-
 kernel/audit_watch.c                       |   4 +-
 kernel/auditsc.c                           |   4 +-
 kernel/bpf/offload.c                       |   4 +-
 kernel/events/core.c                       |   4 +-
 mm/memory-failure.c                        |   2 +-
 security/tomoyo/condition.c                |   2 +-
 32 files changed, 209 insertions(+), 209 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index 18eb4984d555..b3aa20be118e 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -104,7 +104,7 @@ static void show_faulting_vma(unsigned long address, char *buf)
 		if (file) {
 			nm = file_path(file, buf, PAGE_SIZE - 1);
 			inode = file_inode(vma->vm_file);
-			dev = inode_sb(inode)->s_dev;
+			dev = inode_view(inode)->v_dev;
 			ino = inode->i_ino;
 		}
 		pr_info("    @off 0x%lx in [%s]\n"
diff --git a/drivers/staging/lustre/lustre/llite/dir.c b/drivers/staging/lustre/lustre/llite/dir.c
index 809e493b61da..cb50d04327d4 100644
--- a/drivers/staging/lustre/lustre/llite/dir.c
+++ b/drivers/staging/lustre/lustre/llite/dir.c
@@ -1364,7 +1364,7 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			struct lov_user_mds_data __user *lmdp;
 			lstat_t st = { 0 };
 
-			st.st_dev     = inode_sb(inode)->s_dev;
+			st.st_dev     = inode_view(inode)->v_dev;
 			st.st_mode    = body->mbo_mode;
 			st.st_nlink   = body->mbo_nlink;
 			st.st_uid     = body->mbo_uid;
diff --git a/drivers/staging/lustre/lustre/llite/file.c b/drivers/staging/lustre/lustre/llite/file.c
index 64df47bd1118..749a74e49e61 100644
--- a/drivers/staging/lustre/lustre/llite/file.c
+++ b/drivers/staging/lustre/lustre/llite/file.c
@@ -2967,7 +2967,7 @@ int ll_getattr(const struct path *path, struct kstat *stat,
 
 	OBD_FAIL_TIMEOUT(OBD_FAIL_GETATTR_DELAY, 30);
 
-	stat->dev = inode_sb(inode)->s_dev;
+	stat->dev = inode_view(inode)->v_dev;
 	if (ll_need_32bit_api(sbi))
 		stat->ino = cl_fid_build_ino(&lli->lli_fid, 1);
 	else
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a7e3dbc83bbc..39487ae0eabd 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -955,7 +955,7 @@ static void ep_show_fdinfo(struct seq_file *m, struct file *f)
 			   epi->ffd.fd, epi->event.events,
 			   (long long)epi->event.data,
 			   (long long)epi->ffd.file->f_pos,
-			   inode->i_ino, inode_sb(inode)->s_dev);
+			   inode->i_ino, inode_view(inode)->v_dev);
 		if (seq_has_overflowed(m))
 			break;
 	}
diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index 235a3bca1f5f..601cf0cb723e 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -74,8 +74,8 @@ void f2fs_trace_pid(struct page *page)
 	f2fs_radix_tree_insert(&pids, pid, current);
 
 	trace_printk("%3x:%3x %4x %-16s\n",
-			MAJOR(inode_sb(inode)->s_dev),
-			MINOR(inode_sb(inode)->s_dev),
+			MAJOR(inode_view(inode)->v_dev),
+			MINOR(inode_view(inode)->v_dev),
 			pid, current->comm);
 out:
 	mutex_unlock(&pids_lock);
@@ -96,8 +96,8 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
 	inode = fio->page->mapping->host;
 	pid = page_private(fio->page);
 
-	major = MAJOR(inode_sb(inode)->s_dev);
-	minor = MINOR(inode_sb(inode)->s_dev);
+	major = MAJOR(inode_view(inode)->v_dev);
+	minor = MINOR(inode_view(inode)->v_dev);
 
 	if (last_io.major == major && last_io.minor == minor &&
 			last_io.pid == pid &&
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b68adb3bd70d..f3dfca9a59ac 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -855,7 +855,7 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 		attr->ctimensec = inode->i_ctime.tv_nsec;
 	}
 
-	stat->dev = inode_sb(inode)->s_dev;
+	stat->dev = inode_view(inode)->v_dev;
 	stat->ino = attr->ino;
 	stat->mode = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
 	stat->nlink = attr->nlink;
diff --git a/fs/locks.c b/fs/locks.c
index 2a86a18c0523..86ef062c3ea1 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -263,8 +263,8 @@ locks_check_ctx_lists(struct inode *inode)
 		     !list_empty(&ctx->flc_posix) ||
 		     !list_empty(&ctx->flc_lease))) {
 		pr_warn("Leaked locks on dev=0x%x:0x%x ino=0x%lx:\n",
-			MAJOR(inode_sb(inode)->s_dev),
-			MINOR(inode_sb(inode)->s_dev),
+			MAJOR(inode_view(inode)->v_dev),
+			MINOR(inode_view(inode)->v_dev),
 			inode->i_ino);
 		locks_dump_ctx_list(&ctx->flc_flock, "FLOCK");
 		locks_dump_ctx_list(&ctx->flc_posix, "POSIX");
@@ -283,8 +283,8 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list,
 		if (fl->fl_file == filp)
 			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
 				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
-				list_type, MAJOR(inode_sb(inode)->s_dev),
-				MINOR(inode_sb(inode)->s_dev), inode->i_ino,
+				list_type, MAJOR(inode_view(inode)->v_dev),
+				MINOR(inode_view(inode)->v_dev), inode->i_ino,
 				fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
 }
 
@@ -2684,8 +2684,8 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	if (inode) {
 		/* userspace relies on this representation of dev_t */
 		seq_printf(f, "%d %02x:%02x:%ld ", fl_pid,
-				MAJOR(inode_sb(inode)->s_dev),
-				MINOR(inode_sb(inode)->s_dev), inode->i_ino);
+				MAJOR(inode_view(inode)->v_dev),
+				MINOR(inode_view(inode)->v_dev), inode->i_ino);
 	} else {
 		seq_printf(f, "%d <none>:0 ", fl_pid);
 	}
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 517f3194b055..07f81f981792 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -488,7 +488,7 @@ TRACE_EVENT(nfs4_cached_open,
 		TP_fast_assign(
 			const struct inode *inode = state->inode;
 
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)state->state;
@@ -533,7 +533,7 @@ TRACE_EVENT(nfs4_close,
 		TP_fast_assign(
 			const struct inode *inode = state->inode;
 
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)state->state;
@@ -600,7 +600,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 			__entry->type = request->fl_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
@@ -672,7 +672,7 @@ TRACE_EVENT(nfs4_set_lock,
 			__entry->type = request->fl_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
@@ -719,7 +719,7 @@ DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)fmode;
@@ -804,7 +804,7 @@ DECLARE_EVENT_CLASS(nfs4_test_stateid_event,
 			const struct inode *inode = state->inode;
 
 			__entry->error = error;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
@@ -855,7 +855,7 @@ DECLARE_EVENT_CLASS(nfs4_lookup_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
 			__assign_str(name, name->name);
@@ -903,7 +903,7 @@ TRACE_EVENT(nfs4_lookupp,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->ino = NFS_FILEID(inode);
 			__entry->error = error;
 		),
@@ -938,7 +938,7 @@ TRACE_EVENT(nfs4_rename,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(olddir)->s_dev;
+			__entry->dev = inode_view(olddir)->v_dev;
 			__entry->olddir = NFS_FILEID(olddir);
 			__entry->newdir = NFS_FILEID(newdir);
 			__entry->error = error;
@@ -976,7 +976,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->error = error;
@@ -1029,7 +1029,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->error = error;
@@ -1139,7 +1139,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_callback_event,
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			if (inode != NULL) {
 				__entry->fileid = NFS_FILEID(inode);
-				__entry->dev = inode_sb(inode)->s_dev;
+				__entry->dev = inode_view(inode)->v_dev;
 			} else {
 				__entry->fileid = 0;
 				__entry->dev = 0;
@@ -1196,7 +1196,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			if (inode != NULL) {
 				__entry->fileid = NFS_FILEID(inode);
-				__entry->dev = inode_sb(inode)->s_dev;
+				__entry->dev = inode_view(inode)->v_dev;
 			} else {
 				__entry->fileid = 0;
 				__entry->dev = 0;
@@ -1303,7 +1303,7 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 			const struct inode *inode = hdr->inode;
 			const struct nfs4_state *state =
 				hdr->args.context->state;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->offset = hdr->args.offset;
@@ -1363,7 +1363,7 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 			const struct inode *inode = hdr->inode;
 			const struct nfs4_state *state =
 				hdr->args.context->state;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->offset = hdr->args.offset;
@@ -1420,7 +1420,7 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 
 		TP_fast_assign(
 			const struct inode *inode = data->inode;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->offset = data->args.offset;
@@ -1485,7 +1485,7 @@ TRACE_EVENT(nfs4_layoutget,
 		TP_fast_assign(
 			const struct inode *inode = d_inode(ctx->dentry);
 			const struct nfs4_state *state = ctx->state;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->iomode = args->iomode;
@@ -1567,7 +1567,7 @@ TRACE_EVENT(pnfs_update_layout,
 			__field(enum pnfs_update_layout_reason, reason)
 		),
 		TP_fast_assign(
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->pos = pos;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index aeacf2b86260..fc74ac0b729e 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -59,7 +59,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 
 		TP_fast_assign(
 			const struct nfs_inode *nfsi = NFS_I(inode);
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
@@ -97,7 +97,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
 		TP_fast_assign(
 			const struct nfs_inode *nfsi = NFS_I(inode);
 			__entry->error = error;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->type = nfs_umode_to_dtype(inode->i_mode);
@@ -183,7 +183,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__assign_str(name, dentry->d_name.name);
@@ -227,7 +227,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
 			__entry->flags = flags;
@@ -294,7 +294,7 @@ TRACE_EVENT(nfs_atomic_open_enter,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__entry->fmode = (__force unsigned int)ctx->mode;
@@ -333,7 +333,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 
 		TP_fast_assign(
 			__entry->error = error;
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__entry->fmode = (__force unsigned int)ctx->mode;
@@ -370,7 +370,7 @@ TRACE_EVENT(nfs_create_enter,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__assign_str(name, dentry->d_name.name);
@@ -406,7 +406,7 @@ TRACE_EVENT(nfs_create_exit,
 
 		TP_fast_assign(
 			__entry->error = error;
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__assign_str(name, dentry->d_name.name);
@@ -438,7 +438,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__assign_str(name, dentry->d_name.name);
 		),
@@ -476,7 +476,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event_done,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
 			__assign_str(name, dentry->d_name.name);
@@ -530,7 +530,7 @@ TRACE_EVENT(nfs_link_enter,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->dir = NFS_FILEID(dir);
 			__assign_str(name, dentry->d_name.name);
@@ -565,7 +565,7 @@ TRACE_EVENT(nfs_link_exit,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
@@ -602,7 +602,7 @@ DECLARE_EVENT_CLASS(nfs_rename_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(old_dir)->s_dev;
+			__entry->dev = inode_view(old_dir)->v_dev;
 			__entry->old_dir = NFS_FILEID(old_dir);
 			__entry->new_dir = NFS_FILEID(new_dir);
 			__assign_str(old_name, old_dentry->d_name.name);
@@ -650,7 +650,7 @@ DECLARE_EVENT_CLASS(nfs_rename_event_done,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode_sb(old_dir)->s_dev;
+			__entry->dev = inode_view(old_dir)->v_dev;
 			__entry->old_dir = NFS_FILEID(old_dir);
 			__entry->new_dir = NFS_FILEID(new_dir);
 			__entry->error = error;
@@ -705,7 +705,7 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 		TP_fast_assign(
 			struct inode *dir = d_inode(data->dentry->d_parent);
 			size_t len = data->args.name.len;
-			__entry->dev = inode_sb(dir)->s_dev;
+			__entry->dev = inode_view(dir)->v_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
 			memcpy(__get_str(name),
@@ -743,7 +743,7 @@ TRACE_EVENT(nfs_initiate_read,
 
 			__entry->offset = offset;
 			__entry->count = count;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -781,7 +781,7 @@ TRACE_EVENT(nfs_readpage_done,
 			__entry->status = status;
 			__entry->offset = offset;
 			__entry->eof = eof;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -831,7 +831,7 @@ TRACE_EVENT(nfs_initiate_write,
 			__entry->offset = offset;
 			__entry->count = count;
 			__entry->stable = stable;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -875,7 +875,7 @@ TRACE_EVENT(nfs_writeback_done,
 			__entry->stable = writeverf->committed;
 			memcpy(&__entry->verifier, &writeverf->verifier,
 			       sizeof(__entry->verifier));
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -914,7 +914,7 @@ TRACE_EVENT(nfs_initiate_commit,
 
 			__entry->offset = data->args.offset;
 			__entry->count = data->args.count;
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -953,7 +953,7 @@ TRACE_EVENT(nfs_commit_done,
 			__entry->offset = data->args.offset;
 			memcpy(&__entry->verifier, &data->verf.verifier,
 			       sizeof(__entry->verifier));
-			__entry->dev = inode_sb(inode)->s_dev;
+			__entry->dev = inode_view(inode)->v_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 393159739b95..9ea609b0ca8e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -786,7 +786,7 @@ struct raparms *
 nfsd_init_raparms(struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	dev_t dev = inode_sb(inode)->s_dev;
+	dev_t dev = inode_view(inode)->v_dev;
 	ino_t ino = inode->i_ino;
 	struct raparms	*ra, **rap, **frap = NULL;
 	int depth = 0;
@@ -943,7 +943,7 @@ static int wait_for_concurrent_writes(struct file *file)
 	int err = 0;
 
 	if (atomic_read(&inode->i_writecount) > 1
-	    || (last_ino == inode->i_ino && last_dev == inode_sb(inode)->s_dev)) {
+	    || (last_ino == inode->i_ino && last_dev == inode_view(inode)->v_dev)) {
 		dprintk("nfsd: write defer %d\n", task_pid_nr(current));
 		msleep(10);
 		dprintk("nfsd: write resume %d\n", task_pid_nr(current));
@@ -954,7 +954,7 @@ static int wait_for_concurrent_writes(struct file *file)
 		err = vfs_fsync(file, 0);
 	}
 	last_ino = inode->i_ino;
-	last_dev = inode_sb(inode)->s_dev;
+	last_dev = inode_view(inode)->v_dev;
 	return err;
 }
 
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 857df5ce27ac..9a6ad77fbe6f 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -92,7 +92,7 @@ static void inotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 		u32 mask = mark->mask & IN_ALL_EVENTS;
 		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:%x ",
 			   inode_mark->wd, inode->i_ino,
-			   inode_sb(inode)->s_dev,
+			   inode_view(inode)->v_dev,
 			   mask, mark->ignored_mask);
 		show_mark_fhandle(m, inode);
 		seq_putc(m, '\n');
@@ -122,7 +122,7 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 		if (!inode)
 			return;
 		seq_printf(m, "fanotify ino:%lx sdev:%x mflags:%x mask:%x ignored_mask:%x ",
-			   inode->i_ino, inode_sb(inode)->s_dev,
+			   inode->i_ino, inode_view(inode)->v_dev,
 			   mflags, mark->mask, mark->ignored_mask);
 		show_mark_fhandle(m, inode);
 		seq_putc(m, '\n');
diff --git a/fs/proc/nommu.c b/fs/proc/nommu.c
index 5c979fc49662..1278548e099f 100644
--- a/fs/proc/nommu.c
+++ b/fs/proc/nommu.c
@@ -46,7 +46,7 @@ static int nommu_region_show(struct seq_file *m, struct vm_region *region)
 
 	if (file) {
 		struct inode *inode = file_inode(region->vm_file);
-		dev = inode_sb(inode)->s_dev;
+		dev = inode_view(inode)->v_dev;
 		ino = inode->i_ino;
 	}
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 27bf744e8da9..10ac40e87939 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -312,7 +312,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma, int is_pid)
 
 	if (file) {
 		struct inode *inode = file_inode(vma->vm_file);
-		dev = inode_sb(inode)->s_dev;
+		dev = inode_view(inode)->v_dev;
 		ino = inode->i_ino;
 		pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
 	}
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index d3acd4433d9d..a109df40fa3c 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -157,7 +157,7 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma,
 
 	if (file) {
 		struct inode *inode = file_inode(vma->vm_file);
-		dev = inode_sb(inode)->s_dev;
+		dev = inode_view(inode)->v_dev;
 		ino = inode->i_ino;
 		pgoff = (loff_t)vma->vm_pgoff << PAGE_SHIFT;
 	}
diff --git a/fs/stat.c b/fs/stat.c
index 178b81d4359e..48787ee00e9c 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -32,7 +32,7 @@
  */
 void generic_fillattr(struct inode *inode, struct kstat *stat)
 {
-	stat->dev = inode_sb(inode)->s_dev;
+	stat->dev = inode_view(inode)->v_dev;
 	stat->ino = inode->i_ino;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 7aed2ad33d07..be323e17a302 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -503,7 +503,7 @@ xfs_vn_getattr(
 		return -EIO;
 
 	stat->size = XFS_ISIZE(ip);
-	stat->dev = inode_sb(inode)->s_dev;
+	stat->dev = inode_view(inode)->v_dev;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
 	stat->uid = inode->i_uid;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 633c7cbc097a..16065fe0bd4d 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -60,7 +60,7 @@ DECLARE_EVENT_CLASS(xfs_attr_list_class,
 		__field(int, flags)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ctx->dp))->s_dev;
+		__entry->dev = inode_view(VFS_I(ctx->dp))->v_dev;
 		__entry->ino = ctx->dp->i_ino;
 		__entry->hashval = ctx->cursor->hashval;
 		__entry->blkno = ctx->cursor->blkno;
@@ -186,7 +186,7 @@ TRACE_EVENT(xfs_attr_list_node_descend,
 		__field(u32, bt_before)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ctx->dp))->s_dev;
+		__entry->dev = inode_view(VFS_I(ctx->dp))->v_dev;
 		__entry->ino = ctx->dp->i_ino;
 		__entry->hashval = ctx->cursor->hashval;
 		__entry->blkno = ctx->cursor->blkno;
@@ -240,7 +240,7 @@ DECLARE_EVENT_CLASS(xfs_bmap_class,
 
 		ifp = xfs_iext_state_to_fork(ip, state);
 		xfs_iext_get_extent(ifp, cur, &r);
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->leaf = cur->leaf;
 		__entry->pos = cur->pos;
@@ -515,7 +515,7 @@ DECLARE_EVENT_CLASS(xfs_filestream_class,
 		__field(int, streams)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->agno = agno;
 		__entry->streams = xfs_filestream_peek_ag(ip->i_mount, agno);
@@ -547,7 +547,7 @@ TRACE_EVENT(xfs_filestream_pick,
 		__field(int, nscan)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->agno = agno;
 		__entry->streams = xfs_filestream_peek_ag(ip->i_mount, agno);
@@ -574,7 +574,7 @@ DECLARE_EVENT_CLASS(xfs_lock_class,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->lock_flags = lock_flags;
 		__entry->caller_ip = caller_ip;
@@ -604,7 +604,7 @@ DECLARE_EVENT_CLASS(xfs_inode_class,
 		__field(xfs_ino_t, ino)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 	),
 	TP_printk("dev %d:%d ino 0x%llx",
@@ -665,7 +665,7 @@ TRACE_EVENT(xfs_filemap_fault,
 		__field(bool, write_fault)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->pe_size = pe_size;
 		__entry->write_fault = write_fault;
@@ -691,7 +691,7 @@ DECLARE_EVENT_CLASS(xfs_iref_class,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->count = atomic_read(&VFS_I(ip)->i_count);
 		__entry->pincount = atomic_read(&ip->i_pincount);
@@ -717,7 +717,7 @@ TRACE_EVENT(xfs_iomap_prealloc_size,
 		__field(unsigned int, writeio_blocks)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->blocks = blocks;
 		__entry->shift = shift;
@@ -795,7 +795,7 @@ DECLARE_EVENT_CLASS(xfs_namespace_class,
 		__dynamic_array(char, name, name->len)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(dp))->s_dev;
+		__entry->dev = inode_view(VFS_I(dp))->v_dev;
 		__entry->dp_ino = dp->i_ino;
 		__entry->namelen = name->len;
 		memcpy(__get_str(name), name->name, name->len);
@@ -831,7 +831,7 @@ TRACE_EVENT(xfs_rename,
 		__dynamic_array(char, target_name, target_name->len)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(src_dp))->s_dev;
+		__entry->dev = inode_view(VFS_I(src_dp))->v_dev;
 		__entry->src_dp_ino = src_dp->i_ino;
 		__entry->target_dp_ino = target_dp->i_ino;
 		__entry->src_namelen = src_name->len;
@@ -1132,7 +1132,7 @@ DECLARE_EVENT_CLASS(xfs_file_class,
 		__field(size_t, count)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->offset = offset;
@@ -1176,7 +1176,7 @@ DECLARE_EVENT_CLASS(xfs_page_class,
 
 		if (page_has_buffers(page))
 			xfs_count_page_state(page, &delalloc, &unwritten);
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = XFS_I(inode)->i_ino;
 		__entry->pgoff = page_offset(page);
 		__entry->size = i_size_read(inode);
@@ -1215,7 +1215,7 @@ DECLARE_EVENT_CLASS(xfs_readpage_class,
 		__field(int, nr_pages)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->nr_pages = nr_pages;
 	),
@@ -1248,7 +1248,7 @@ DECLARE_EVENT_CLASS(xfs_imap_class,
 		__field(xfs_filblks_t, blockcount)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->offset = offset;
@@ -1296,7 +1296,7 @@ DECLARE_EVENT_CLASS(xfs_simple_io_class,
 		__field(size_t, count)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->isize = VFS_I(ip)->i_size;
 		__entry->disize = ip->i_d.di_size;
@@ -1336,7 +1336,7 @@ DECLARE_EVENT_CLASS(xfs_itrunc_class,
 		__field(xfs_fsize_t, new_size)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->new_size = new_size;
@@ -1366,7 +1366,7 @@ TRACE_EVENT(xfs_pagecache_inval,
 		__field(xfs_off_t, finish)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->start = start;
@@ -1394,7 +1394,7 @@ TRACE_EVENT(xfs_bunmap,
 		__field(int, flags)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->bno = bno;
@@ -1682,7 +1682,7 @@ DECLARE_EVENT_CLASS(xfs_da_class,
 		__field(int, op_flags)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(args->dp))->s_dev;
+		__entry->dev = inode_view(VFS_I(args->dp))->v_dev;
 		__entry->ino = args->dp->i_ino;
 		if (args->namelen)
 			memcpy(__get_str(name), args->name, args->namelen);
@@ -1746,7 +1746,7 @@ DECLARE_EVENT_CLASS(xfs_attr_class,
 		__field(int, op_flags)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(args->dp))->s_dev;
+		__entry->dev = inode_view(VFS_I(args->dp))->v_dev;
 		__entry->ino = args->dp->i_ino;
 		if (args->namelen)
 			memcpy(__get_str(name), args->name, args->namelen);
@@ -1849,7 +1849,7 @@ DECLARE_EVENT_CLASS(xfs_dir2_space_class,
 		__field(int, idx)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(args->dp))->s_dev;
+		__entry->dev = inode_view(VFS_I(args->dp))->v_dev;
 		__entry->ino = args->dp->i_ino;
 		__entry->op_flags = args->op_flags;
 		__entry->idx = idx;
@@ -1882,7 +1882,7 @@ TRACE_EVENT(xfs_dir2_leafn_moveents,
 		__field(int, count)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(args->dp))->s_dev;
+		__entry->dev = inode_view(VFS_I(args->dp))->v_dev;
 		__entry->ino = args->dp->i_ino;
 		__entry->op_flags = args->op_flags;
 		__entry->src_idx = src_idx;
@@ -1922,7 +1922,7 @@ DECLARE_EVENT_CLASS(xfs_swap_extent_class,
 		__field(int, fork_off)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->which = which;
 		__entry->ino = ip->i_ino;
 		__entry->format = ip->i_d.di_format;
@@ -2972,7 +2972,7 @@ DECLARE_EVENT_CLASS(xfs_inode_error_class,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->error = error;
 		__entry->caller_ip = caller_ip;
@@ -3010,7 +3010,7 @@ DECLARE_EVENT_CLASS(xfs_double_io_class,
 		__field(loff_t, dest_offset)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(src))->s_dev;
+		__entry->dev = inode_view(VFS_I(src))->v_dev;
 		__entry->src_ino = src->i_ino;
 		__entry->src_isize = VFS_I(src)->i_size;
 		__entry->src_disize = src->i_d.di_size;
@@ -3055,7 +3055,7 @@ DECLARE_EVENT_CLASS(xfs_inode_irec_class,
 		__field(int, state)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->lblk = irec->br_startoff;
 		__entry->len = irec->br_blockcount;
@@ -3096,7 +3096,7 @@ TRACE_EVENT(xfs_reflink_remap_blocks_loop,
 		__field(xfs_fileoff_t, dest_lblk)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(src))->s_dev;
+		__entry->dev = inode_view(VFS_I(src))->v_dev;
 		__entry->src_ino = src->i_ino;
 		__entry->src_lblk = soffset;
 		__entry->len = len;
@@ -3124,7 +3124,7 @@ TRACE_EVENT(xfs_reflink_punch_range,
 		__field(xfs_extlen_t, len)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->lblk = lblk;
 		__entry->len = len;
@@ -3147,7 +3147,7 @@ TRACE_EVENT(xfs_reflink_remap,
 		__field(xfs_fsblock_t, new_pblk)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
+		__entry->dev = inode_view(VFS_I(ip))->v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->lblk = lblk;
 		__entry->len = len;
@@ -3183,7 +3183,7 @@ TRACE_EVENT(xfs_ioctl_clone,
 		__field(loff_t, dest_isize)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(src)->s_dev;
+		__entry->dev = inode_view(src)->v_dev;
 		__entry->src_ino = src->i_ino;
 		__entry->src_isize = i_size_read(src);
 		__entry->dest_ino = dest->i_ino;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 89943e59ae36..500ae412f483 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -91,7 +91,7 @@ TRACE_EVENT(ext4_other_inode_update_time,
 
 	TP_fast_assign(
 		__entry->orig_ino = orig_ino;
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->uid	= i_uid_read(inode);
 		__entry->gid	= i_gid_read(inode);
@@ -120,7 +120,7 @@ TRACE_EVENT(ext4_free_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->uid	= i_uid_read(inode);
 		__entry->gid	= i_gid_read(inode);
@@ -146,7 +146,7 @@ TRACE_EVENT(ext4_request_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(dir)->s_dev;
+		__entry->dev	= inode_view(dir)->v_dev;
 		__entry->dir	= dir->i_ino;
 		__entry->mode	= mode;
 	),
@@ -169,7 +169,7 @@ TRACE_EVENT(ext4_allocate_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->dir	= dir->i_ino;
 		__entry->mode	= mode;
@@ -193,7 +193,7 @@ TRACE_EVENT(ext4_evict_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->nlink	= inode->i_nlink;
 	),
@@ -215,7 +215,7 @@ TRACE_EVENT(ext4_drop_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->drop	= drop;
 	),
@@ -237,7 +237,7 @@ TRACE_EVENT(ext4_mark_inode_dirty,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->ip	= IP;
 	),
@@ -259,7 +259,7 @@ TRACE_EVENT(ext4_begin_ordered_truncate,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->new_size	= new_size;
 	),
@@ -286,7 +286,7 @@ DECLARE_EVENT_CLASS(ext4__write_begin,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
@@ -330,7 +330,7 @@ DECLARE_EVENT_CLASS(ext4__write_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
@@ -386,7 +386,7 @@ TRACE_EVENT(ext4_writepages,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->pages_skipped	= wbc->pages_skipped;
@@ -424,7 +424,7 @@ TRACE_EVENT(ext4_da_write_pages,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->first_page	= first_page;
 		__entry->nr_to_write	= wbc->nr_to_write;
@@ -452,7 +452,7 @@ TRACE_EVENT(ext4_da_write_pages_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->lblk		= map->m_lblk;
 		__entry->len		= map->m_len;
@@ -482,7 +482,7 @@ TRACE_EVENT(ext4_writepages_result,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->ret		= ret;
 		__entry->pages_written	= pages_written;
@@ -513,7 +513,7 @@ DECLARE_EVENT_CLASS(ext4__page_op,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(page->mapping->host)->s_dev;
+		__entry->dev	= inode_view(page->mapping->host)->v_dev;
 		__entry->ino	= page->mapping->host->i_ino;
 		__entry->index	= page->index;
 	),
@@ -559,7 +559,7 @@ DECLARE_EVENT_CLASS(ext4_invalidatepage_op,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(page->mapping->host)->s_dev;
+		__entry->dev	= inode_view(page->mapping->host)->v_dev;
 		__entry->ino	= page->mapping->host->i_ino;
 		__entry->index	= page->index;
 		__entry->offset	= offset;
@@ -669,7 +669,7 @@ TRACE_EVENT(ext4_mb_release_inode_pa,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(pa->pa_inode)->s_dev;
+		__entry->dev		= inode_view(pa->pa_inode)->v_dev;
 		__entry->ino		= pa->pa_inode->i_ino;
 		__entry->block		= block;
 		__entry->count		= count;
@@ -716,7 +716,7 @@ TRACE_EVENT(ext4_discard_preallocations,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 	),
 
@@ -765,7 +765,7 @@ TRACE_EVENT(ext4_request_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(ar->inode)->s_dev;
+		__entry->dev	= inode_view(ar->inode)->v_dev;
 		__entry->ino	= ar->inode->i_ino;
 		__entry->len	= ar->len;
 		__entry->logical = ar->logical;
@@ -806,7 +806,7 @@ TRACE_EVENT(ext4_allocate_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(ar->inode)->s_dev;
+		__entry->dev	= inode_view(ar->inode)->v_dev;
 		__entry->ino	= ar->inode->i_ino;
 		__entry->block	= block;
 		__entry->len	= ar->len;
@@ -844,7 +844,7 @@ TRACE_EVENT(ext4_free_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->block		= block;
 		__entry->count		= count;
@@ -898,7 +898,7 @@ TRACE_EVENT(ext4_sync_file_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->ret		= ret;
 	),
@@ -942,7 +942,7 @@ TRACE_EVENT(ext4_alloc_da_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 	),
@@ -982,7 +982,7 @@ TRACE_EVENT(ext4_mballoc_alloc,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(ac->ac_inode)->s_dev;
+		__entry->dev		= inode_view(ac->ac_inode)->v_dev;
 		__entry->ino		= ac->ac_inode->i_ino;
 		__entry->orig_logical	= ac->ac_o_ex.fe_logical;
 		__entry->orig_start	= ac->ac_o_ex.fe_start;
@@ -1039,7 +1039,7 @@ TRACE_EVENT(ext4_mballoc_prealloc,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(ac->ac_inode)->s_dev;
+		__entry->dev		= inode_view(ac->ac_inode)->v_dev;
 		__entry->ino		= ac->ac_inode->i_ino;
 		__entry->orig_logical	= ac->ac_o_ex.fe_logical;
 		__entry->orig_start	= ac->ac_o_ex.fe_start;
@@ -1128,7 +1128,7 @@ TRACE_EVENT(ext4_forget,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->block	= block;
 		__entry->is_metadata = is_metadata;
@@ -1157,7 +1157,7 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->used_blocks = used_blocks;
@@ -1190,7 +1190,7 @@ TRACE_EVENT(ext4_da_reserve_space,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
@@ -1220,7 +1220,7 @@ TRACE_EVENT(ext4_da_release_space,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->freed_blocks = freed_blocks;
@@ -1299,7 +1299,7 @@ TRACE_EVENT(ext4_direct_IO_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->len	= len;
@@ -1328,7 +1328,7 @@ TRACE_EVENT(ext4_direct_IO_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->len	= len;
@@ -1357,7 +1357,7 @@ DECLARE_EVENT_CLASS(ext4__fallocate_mode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->offset	= offset;
 		__entry->len	= len;
@@ -1407,7 +1407,7 @@ TRACE_EVENT(ext4_fallocate_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->blocks	= max_blocks;
@@ -1481,7 +1481,7 @@ DECLARE_EVENT_CLASS(ext4__truncate,
 	),
 
 	TP_fast_assign(
-		__entry->dev    = inode_sb(inode)->s_dev;
+		__entry->dev    = inode_view(inode)->v_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->blocks	= inode->i_blocks;
 	),
@@ -1523,7 +1523,7 @@ TRACE_EVENT(ext4_ext_convert_to_initialized_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_len		= map->m_len;
@@ -1564,7 +1564,7 @@ TRACE_EVENT(ext4_ext_convert_to_initialized_fastpath,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_len		= map->m_len;
@@ -1601,7 +1601,7 @@ DECLARE_EVENT_CLASS(ext4__map_blocks_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev    = inode_sb(inode)->s_dev;
+		__entry->dev    = inode_view(inode)->v_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
@@ -1646,7 +1646,7 @@ DECLARE_EVENT_CLASS(ext4__map_blocks_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev    = inode_sb(inode)->s_dev;
+		__entry->dev    = inode_view(inode)->v_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->flags	= flags;
 		__entry->pblk	= map->m_pblk;
@@ -1691,7 +1691,7 @@ TRACE_EVENT(ext4_ext_load_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev    = inode_sb(inode)->s_dev;
+		__entry->dev    = inode_view(inode)->v_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->pblk	= pblk;
 		__entry->lblk	= lblk;
@@ -1714,7 +1714,7 @@ TRACE_EVENT(ext4_load_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 	),
 
@@ -1837,7 +1837,7 @@ TRACE_EVENT(ext4_ext_handle_unwritten_extents,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->flags		= flags;
 		__entry->lblk		= map->m_lblk;
@@ -1901,7 +1901,7 @@ TRACE_EVENT(ext4_ext_put_in_cache,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
@@ -1929,7 +1929,7 @@ TRACE_EVENT(ext4_ext_in_cache,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->ret	= ret;
@@ -1960,7 +1960,7 @@ TRACE_EVENT(ext4_find_delalloc_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->from		= from;
 		__entry->to		= to;
@@ -1991,7 +1991,7 @@ TRACE_EVENT(ext4_get_reserved_cluster_alloc,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
@@ -2019,7 +2019,7 @@ TRACE_EVENT(ext4_ext_show_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pblk	= pblk;
 		__entry->lblk	= lblk;
@@ -2053,7 +2053,7 @@ TRACE_EVENT(ext4_remove_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->from		= from;
 		__entry->to		= to;
@@ -2093,7 +2093,7 @@ TRACE_EVENT(ext4_ext_rm_leaf,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->partial	= partial_cluster;
 		__entry->start		= start;
@@ -2125,7 +2125,7 @@ TRACE_EVENT(ext4_ext_rm_idx,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pblk	= pblk;
 	),
@@ -2151,7 +2151,7 @@ TRACE_EVENT(ext4_ext_remove_space,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->start	= start;
 		__entry->end	= end;
@@ -2183,7 +2183,7 @@ TRACE_EVENT(ext4_ext_remove_space_done,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->start		= start;
 		__entry->end		= end;
@@ -2218,7 +2218,7 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
@@ -2258,7 +2258,7 @@ TRACE_EVENT(ext4_es_remove_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
@@ -2282,7 +2282,7 @@ TRACE_EVENT(ext4_es_find_delayed_extent_range_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 	),
@@ -2307,7 +2307,7 @@ TRACE_EVENT(ext4_es_find_delayed_extent_range_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
@@ -2334,7 +2334,7 @@ TRACE_EVENT(ext4_es_lookup_extent_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 	),
@@ -2361,7 +2361,7 @@ TRACE_EVENT(ext4_es_lookup_extent_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
@@ -2447,7 +2447,7 @@ TRACE_EVENT(ext4_collapse_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->offset	= offset;
 		__entry->len	= len;
@@ -2472,7 +2472,7 @@ TRACE_EVENT(ext4_insert_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->offset	= offset;
 		__entry->len	= len;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 8e958dd92412..effb2704f3ae 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -171,7 +171,7 @@ DECLARE_EVENT_CLASS(f2fs__inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pino	= F2FS_I(inode)->i_pino;
 		__entry->mode	= inode->i_mode;
@@ -205,7 +205,7 @@ DECLARE_EVENT_CLASS(f2fs__inode_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->ret	= ret;
 	),
@@ -237,7 +237,7 @@ TRACE_EVENT(f2fs_sync_file_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->cp_reason	= cp_reason;
 		__entry->datasync	= datasync;
@@ -319,7 +319,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(dir)->s_dev;
+		__entry->dev	= inode_view(dir)->v_dev;
 		__entry->ino	= dir->i_ino;
 		__entry->size	= dir->i_size;
 		__entry->blocks	= dir->i_blocks;
@@ -370,7 +370,7 @@ TRACE_EVENT(f2fs_truncate_data_blocks_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->nid	= nid;
 		__entry->ofs	= ofs;
@@ -399,7 +399,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->size	= inode->i_size;
 		__entry->blocks	= inode->i_blocks;
@@ -456,7 +456,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_node,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->nid		= nid;
 		__entry->blk_addr	= blk_addr;
@@ -504,7 +504,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->nid[0]	= nid[0];
 		__entry->nid[1]	= nid[1];
@@ -538,7 +538,7 @@ TRACE_EVENT(f2fs_map_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_pblk		= map->m_pblk;
@@ -756,7 +756,7 @@ TRACE_EVENT(f2fs_lookup_start,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(dir)->s_dev;
+		__entry->dev	= inode_view(dir)->v_dev;
 		__entry->ino	= dir->i_ino;
 		__entry->name	= dentry->d_name.name;
 		__entry->flags	= flags;
@@ -784,7 +784,7 @@ TRACE_EVENT(f2fs_lookup_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(dir)->s_dev;
+		__entry->dev	= inode_view(dir)->v_dev;
 		__entry->ino	= dir->i_ino;
 		__entry->name	= dentry->d_name.name;
 		__entry->cino	= ino;
@@ -813,7 +813,7 @@ TRACE_EVENT(f2fs_readdir,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(dir)->s_dev;
+		__entry->dev	= inode_view(dir)->v_dev;
 		__entry->ino	= dir->i_ino;
 		__entry->start	= start_pos;
 		__entry->end	= end_pos;
@@ -846,7 +846,7 @@ TRACE_EVENT(f2fs_fallocate,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->mode	= mode;
 		__entry->offset	= offset;
@@ -882,7 +882,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->len	= len;
@@ -913,7 +913,7 @@ TRACE_EVENT(f2fs_direct_IO_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->len	= len;
@@ -945,7 +945,7 @@ TRACE_EVENT(f2fs_reserve_new_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->nid	= nid;
 		__entry->ofs_in_node = ofs_in_node;
 		__entry->count = count;
@@ -977,7 +977,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(page->mapping->host)->s_dev;
+		__entry->dev		= inode_view(page->mapping->host)->v_dev;
 		__entry->ino		= page->mapping->host->i_ino;
 		__entry->index		= page->index;
 		__entry->old_blkaddr	= fio->old_blkaddr;
@@ -1104,7 +1104,7 @@ TRACE_EVENT(f2fs_write_begin,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
@@ -1134,7 +1134,7 @@ TRACE_EVENT(f2fs_write_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
@@ -1165,7 +1165,7 @@ DECLARE_EVENT_CLASS(f2fs__page,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(page->mapping->host)->s_dev;
+		__entry->dev	= inode_view(page->mapping->host)->v_dev;
 		__entry->ino	= page->mapping->host->i_ino;
 		__entry->type	= type;
 		__entry->dir	= S_ISDIR(page->mapping->host->i_mode);
@@ -1259,7 +1259,7 @@ TRACE_EVENT(f2fs_writepages,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode_sb(inode)->s_dev;
+		__entry->dev		= inode_view(inode)->v_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->type		= type;
 		__entry->dir		= S_ISDIR(inode->i_mode);
@@ -1311,7 +1311,7 @@ TRACE_EVENT(f2fs_readpages,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->start	= page->index;
 		__entry->nrpage	= nrpage;
@@ -1454,7 +1454,7 @@ TRACE_EVENT(f2fs_lookup_extent_tree_start,
 	),
 
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
 	),
@@ -1483,7 +1483,7 @@ TRACE_EVENT_CONDITION(f2fs_lookup_extent_tree_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
 		__entry->fofs = ei->fofs;
@@ -1516,7 +1516,7 @@ TRACE_EVENT(f2fs_update_extent_tree_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
 		__entry->blk = blkaddr;
@@ -1569,7 +1569,7 @@ TRACE_EVENT(f2fs_destroy_extent_tree,
 	),
 
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->node_cnt = node_cnt;
 	),
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 522d2740a56f..cbd545058cf3 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -48,7 +48,7 @@ TRACE_EVENT(locks_get_lock_context,
 	),
 
 	TP_fast_assign(
-		__entry->s_dev = inode_sb(inode)->s_dev;
+		__entry->s_dev = inode_view(inode)->v_dev;
 		__entry->i_ino = inode->i_ino;
 		__entry->type = type;
 		__entry->ctx = ctx;
@@ -80,7 +80,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
 
 	TP_fast_assign(
 		__entry->fl = fl ? fl : NULL;
-		__entry->s_dev = inode_sb(inode)->s_dev;
+		__entry->s_dev = inode_view(inode)->v_dev;
 		__entry->i_ino = inode->i_ino;
 		__entry->fl_next = fl ? fl->fl_next : NULL;
 		__entry->fl_owner = fl ? fl->fl_owner : NULL;
@@ -132,7 +132,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
 
 	TP_fast_assign(
 		__entry->fl = fl ? fl : NULL;
-		__entry->s_dev = inode_sb(inode)->s_dev;
+		__entry->s_dev = inode_view(inode)->v_dev;
 		__entry->i_ino = inode->i_ino;
 		__entry->fl_next = fl ? fl->fl_next : NULL;
 		__entry->fl_owner = fl ? fl->fl_owner : NULL;
@@ -182,7 +182,7 @@ TRACE_EVENT(generic_add_lease,
 	),
 
 	TP_fast_assign(
-		__entry->s_dev = inode_sb(inode)->s_dev;
+		__entry->s_dev = inode_view(inode)->v_dev;
 		__entry->i_ino = inode->i_ino;
 		__entry->wcount = atomic_read(&inode->i_writecount);
 		__entry->dcount = d_count(fl->fl_file->f_path.dentry);
diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index 0517759b4b8f..1e32f104ac54 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -31,7 +31,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
 		__entry->i_ino = page->mapping->host->i_ino;
 		__entry->index = page->index;
 		if (inode_sb(page->mapping->host))
-			__entry->s_dev = inode_sb(page->mapping->host)->s_dev;
+			__entry->s_dev = inode_view(page->mapping->host)->v_dev;
 		else
 			__entry->s_dev = page->mapping->host->i_rdev;
 	),
@@ -69,7 +69,7 @@ TRACE_EVENT(filemap_set_wb_err,
 			__entry->i_ino = mapping->host->i_ino;
 			__entry->errseq = eseq;
 			if (inode_sb(mapping->host))
-				__entry->s_dev = inode_sb(mapping->host)->s_dev;
+				__entry->s_dev = inode_view(mapping->host)->v_dev;
 			else
 				__entry->s_dev = mapping->host->i_rdev;
 		),
@@ -97,7 +97,7 @@ TRACE_EVENT(file_check_and_advance_wb_err,
 			__entry->i_ino = file->f_mapping->host->i_ino;
 			if (inode_sb(file->f_mapping->host))
 				__entry->s_dev =
-					inode_sb(file->f_mapping->host)->s_dev;
+					inode_view(file->f_mapping->host)->v_dev;
 			else
 				__entry->s_dev =
 					file->f_mapping->host->i_rdev;
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index d3173cae131d..d287a210119a 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -24,7 +24,7 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
 		__field(int, result)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_start = vmf->vma->vm_start;
 		__entry->vm_end = vmf->vma->vm_end;
@@ -74,7 +74,7 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
 		__field(dev_t, dev)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
@@ -117,7 +117,7 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__field(int, write)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
@@ -163,7 +163,7 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
 		__field(int, result)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
@@ -206,7 +206,7 @@ TRACE_EVENT(dax_insert_mapping,
 		__field(int, write)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
@@ -234,7 +234,7 @@ DECLARE_EVENT_CLASS(dax_writeback_range_class,
 		__field(dev_t, dev)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->start_index = start_index;
 		__entry->end_index = end_index;
@@ -266,7 +266,7 @@ TRACE_EVENT(dax_writeback_one,
 		__field(dev_t, dev)
 	),
 	TP_fast_assign(
-		__entry->dev = inode_sb(inode)->s_dev;
+		__entry->dev = inode_view(inode)->v_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgoff = pgoff;
 		__entry->pglen = pglen;
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 95e0cb226d30..9c6b6c595835 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -124,7 +124,7 @@ TRACE_EVENT(jbd2_submit_inode_data,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 	),
 
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index d5ae5ea65bc4..7a5bfa93f938 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -710,7 +710,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode_sb(inode)->s_dev;
+		__entry->dev	= inode_view(inode)->v_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->state	= inode->i_state;
 		__entry->mode	= inode->i_mode;
diff --git a/kernel/audit.c b/kernel/audit.c
index 23159573aafd..b28999994512 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2050,7 +2050,7 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode)
 {
 	name->ino   = inode->i_ino;
-	name->dev   = inode_sb(inode)->s_dev;
+	name->dev   = inode_view(inode)->v_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 981432cef19c..5daffedbfd67 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -76,7 +76,7 @@ int audit_mark_compare(struct audit_fsnotify_mark *mark, unsigned long ino, dev_
 static void audit_update_mark(struct audit_fsnotify_mark *audit_mark,
 			     const struct inode *inode)
 {
-	audit_mark->dev = inode ? inode_sb(inode)->s_dev : AUDIT_DEV_UNSET;
+	audit_mark->dev = inode ? inode_view(inode)->v_dev : AUDIT_DEV_UNSET;
 	audit_mark->ino = inode ? inode->i_ino : AUDIT_INO_UNSET;
 }
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 3e785d4cf8aa..b9f571cc6a7f 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -499,7 +499,7 @@ static int audit_watch_handle_event(struct fsnotify_group *group,
 	}
 
 	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
-		audit_update_watch(parent, dname, inode_sb(inode)->s_dev,
+		audit_update_watch(parent, dname, inode_view(inode)->v_dev,
 				   inode->i_ino, 0);
 	else if (mask & (FS_DELETE|FS_MOVED_FROM))
 		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
@@ -554,7 +554,7 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 	if (!exe_file)
 		return 0;
 	ino = file_inode(exe_file)->i_ino;
-	dev = inode_sb(file_inode(exe_file))->s_dev;
+	dev = inode_view(file_inode(exe_file))->v_dev;
 	fput(exe_file);
 	return audit_mark_compare(mark, ino, dev);
 }
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 9cb16a1ebedd..36b7cca89ec5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1797,7 +1797,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 		if (n->ino) {
 			/* valid inode number, use that for the comparison */
 			if (n->ino != inode->i_ino ||
-			    n->dev != inode_sb(inode)->s_dev)
+			    n->dev != inode_view(inode)->v_dev)
 				continue;
 		} else if (n->name) {
 			/* inode number has not been set, check the name */
@@ -1906,7 +1906,7 @@ void __audit_inode_child(struct inode *parent,
 		     n->type != AUDIT_TYPE_UNKNOWN))
 			continue;
 
-		if (n->ino == parent->i_ino && n->dev == inode_sb(parent)->s_dev &&
+		if (n->ino == parent->i_ino && n->dev == inode_view(parent)->v_dev &&
 		    !audit_compare_dname_path(dname,
 					      n->name->name, n->name_len)) {
 			if (n->type == AUDIT_TYPE_UNKNOWN)
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 6ff86b395175..6aed7bade9fd 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -265,7 +265,7 @@ int bpf_prog_offload_info_fill(struct bpf_prog_info *info,
 	up_read(&bpf_devs_lock);
 
 	ns_inode = ns_path.dentry->d_inode;
-	info->netns_dev = new_encode_dev(inode_sb(ns_inode)->s_dev);
+	info->netns_dev = new_encode_dev(inode_view(ns_inode)->v_dev);
 	info->netns_ino = ns_inode->i_ino;
 	path_put(&ns_path);
 
@@ -461,7 +461,7 @@ int bpf_map_offload_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 	}
 
 	ns_inode = ns_path.dentry->d_inode;
-	info->netns_dev = new_encode_dev(inode_sb(ns_inode)->s_dev);
+	info->netns_dev = new_encode_dev(inode_view(ns_inode)->v_dev);
 	info->netns_ino = ns_inode->i_ino;
 	path_put(&ns_path);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 58c02221e066..9c1e45243007 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6713,7 +6713,7 @@ static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
 	error = ns_get_path(&ns_path, task, ns_ops);
 	if (!error) {
 		ns_inode = ns_path.dentry->d_inode;
-		ns_link_info->dev = new_encode_dev(inode_sb(ns_inode)->s_dev);
+		ns_link_info->dev = new_encode_dev(inode_view(ns_inode)->v_dev);
 		ns_link_info->ino = ns_inode->i_ino;
 		path_put(&ns_path);
 	}
@@ -6918,7 +6918,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 			goto cpy_name;
 		}
 		inode = file_inode(vma->vm_file);
-		dev = inode_sb(inode)->s_dev;
+		dev = inode_view(inode)->v_dev;
 		ino = inode->i_ino;
 		gen = inode->i_generation;
 		maj = MAJOR(dev);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 08e2367985f8..64e8626df474 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -98,7 +98,7 @@ static int hwpoison_filter_dev(struct page *p)
 	if (mapping == NULL || mapping->host == NULL)
 		return -EINVAL;
 
-	dev = inode_sb(mapping->host)->s_dev;
+	dev = inode_view(mapping->host)->v_dev;
 	if (hwpoison_filter_dev_major != ~0U &&
 	    hwpoison_filter_dev_major != MAJOR(dev))
 		return -EINVAL;
diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c
index 3422f5f57e43..b8419d9ac789 100644
--- a/security/tomoyo/condition.c
+++ b/security/tomoyo/condition.c
@@ -722,7 +722,7 @@ void tomoyo_get_attributes(struct tomoyo_obj_info *obj)
 			stat->gid  = inode->i_gid;
 			stat->ino  = inode->i_ino;
 			stat->mode = inode->i_mode;
-			stat->dev  = inode_sb(inode)->s_dev;
+			stat->dev  = inode_view(inode)->v_dev;
 			stat->rdev = inode->i_rdev;
 			obj->stat_valid[i] = true;
 		}
-- 
2.15.1

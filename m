Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbeBTCOS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 21:14:18 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34267 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbeBTCON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 21:14:13 -0500
X-Google-Smtp-Source: AH8x224rfzEnMGrVXY3i4mdcwfZYdLjs3nHe521YRZqGK7YLdFEmf+lSuF8lA1r3QRsNuESCQWHtdg==
Date: Tue, 20 Feb 2018 02:14:10 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: james.l.morris@oracle.com, penguin-kernel@i-love.sakura.ne.jp,
        keescook@chromium.org, igor.stoppa@huawei.com, casey@schaufler-ca.com
Subject: [RFC PATCH v3 1/3] security: Refactor LSM hooks into an array
Message-ID: <3ba03d99019ed91f04221dc5d79f4564ec6ce124.1519092378.git.sargun@sargun.me>
References: <cover.1519092378.git.sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519092378.git.sargun@sargun.me>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit should have no functional change. It changes the security hook
list heads struct into an array. Additionally, it exposes all of the hooks
via an enum. This loses memory layout randomization as the enum is not
randomized.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h | 433 +++++++++++++++++++++++-----------------------
 security/security.c       |  30 ++--
 2 files changed, 233 insertions(+), 230 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7161d8e7ee79..d28c7f5b01c1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1729,241 +1729,243 @@ union security_list_options {
 #endif /* CONFIG_BPF_SYSCALL */
 };
 
-struct security_hook_heads {
-	struct list_head binder_set_context_mgr;
-	struct list_head binder_transaction;
-	struct list_head binder_transfer_binder;
-	struct list_head binder_transfer_file;
-	struct list_head ptrace_access_check;
-	struct list_head ptrace_traceme;
-	struct list_head capget;
-	struct list_head capset;
-	struct list_head capable;
-	struct list_head quotactl;
-	struct list_head quota_on;
-	struct list_head syslog;
-	struct list_head settime;
-	struct list_head vm_enough_memory;
-	struct list_head bprm_set_creds;
-	struct list_head bprm_check_security;
-	struct list_head bprm_committing_creds;
-	struct list_head bprm_committed_creds;
-	struct list_head sb_alloc_security;
-	struct list_head sb_free_security;
-	struct list_head sb_copy_data;
-	struct list_head sb_remount;
-	struct list_head sb_kern_mount;
-	struct list_head sb_show_options;
-	struct list_head sb_statfs;
-	struct list_head sb_mount;
-	struct list_head sb_umount;
-	struct list_head sb_pivotroot;
-	struct list_head sb_set_mnt_opts;
-	struct list_head sb_clone_mnt_opts;
-	struct list_head sb_parse_opts_str;
-	struct list_head dentry_init_security;
-	struct list_head dentry_create_files_as;
+enum lsm_hook {
+	LSM_HOOK_binder_set_context_mgr,
+	LSM_HOOK_binder_transaction,
+	LSM_HOOK_binder_transfer_binder,
+	LSM_HOOK_binder_transfer_file,
+	LSM_HOOK_ptrace_access_check,
+	LSM_HOOK_ptrace_traceme,
+	LSM_HOOK_capget,
+	LSM_HOOK_capset,
+	LSM_HOOK_capable,
+	LSM_HOOK_quotactl,
+	LSM_HOOK_quota_on,
+	LSM_HOOK_syslog,
+	LSM_HOOK_settime,
+	LSM_HOOK_vm_enough_memory,
+	LSM_HOOK_bprm_set_creds,
+	LSM_HOOK_bprm_check_security,
+	LSM_HOOK_bprm_committing_creds,
+	LSM_HOOK_bprm_committed_creds,
+	LSM_HOOK_sb_alloc_security,
+	LSM_HOOK_sb_free_security,
+	LSM_HOOK_sb_copy_data,
+	LSM_HOOK_sb_remount,
+	LSM_HOOK_sb_kern_mount,
+	LSM_HOOK_sb_show_options,
+	LSM_HOOK_sb_statfs,
+	LSM_HOOK_sb_mount,
+	LSM_HOOK_sb_umount,
+	LSM_HOOK_sb_pivotroot,
+	LSM_HOOK_sb_set_mnt_opts,
+	LSM_HOOK_sb_clone_mnt_opts,
+	LSM_HOOK_sb_parse_opts_str,
+	LSM_HOOK_dentry_init_security,
+	LSM_HOOK_dentry_create_files_as,
 #ifdef CONFIG_SECURITY_PATH
-	struct list_head path_unlink;
-	struct list_head path_mkdir;
-	struct list_head path_rmdir;
-	struct list_head path_mknod;
-	struct list_head path_truncate;
-	struct list_head path_symlink;
-	struct list_head path_link;
-	struct list_head path_rename;
-	struct list_head path_chmod;
-	struct list_head path_chown;
-	struct list_head path_chroot;
+	LSM_HOOK_path_unlink,
+	LSM_HOOK_path_mkdir,
+	LSM_HOOK_path_rmdir,
+	LSM_HOOK_path_mknod,
+	LSM_HOOK_path_truncate,
+	LSM_HOOK_path_symlink,
+	LSM_HOOK_path_link,
+	LSM_HOOK_path_rename,
+	LSM_HOOK_path_chmod,
+	LSM_HOOK_path_chown,
+	LSM_HOOK_path_chroot,
 #endif
-	struct list_head inode_alloc_security;
-	struct list_head inode_free_security;
-	struct list_head inode_init_security;
-	struct list_head inode_create;
-	struct list_head inode_link;
-	struct list_head inode_unlink;
-	struct list_head inode_symlink;
-	struct list_head inode_mkdir;
-	struct list_head inode_rmdir;
-	struct list_head inode_mknod;
-	struct list_head inode_rename;
-	struct list_head inode_readlink;
-	struct list_head inode_follow_link;
-	struct list_head inode_permission;
-	struct list_head inode_setattr;
-	struct list_head inode_getattr;
-	struct list_head inode_setxattr;
-	struct list_head inode_post_setxattr;
-	struct list_head inode_getxattr;
-	struct list_head inode_listxattr;
-	struct list_head inode_removexattr;
-	struct list_head inode_need_killpriv;
-	struct list_head inode_killpriv;
-	struct list_head inode_getsecurity;
-	struct list_head inode_setsecurity;
-	struct list_head inode_listsecurity;
-	struct list_head inode_getsecid;
-	struct list_head inode_copy_up;
-	struct list_head inode_copy_up_xattr;
-	struct list_head file_permission;
-	struct list_head file_alloc_security;
-	struct list_head file_free_security;
-	struct list_head file_ioctl;
-	struct list_head mmap_addr;
-	struct list_head mmap_file;
-	struct list_head file_mprotect;
-	struct list_head file_lock;
-	struct list_head file_fcntl;
-	struct list_head file_set_fowner;
-	struct list_head file_send_sigiotask;
-	struct list_head file_receive;
-	struct list_head file_open;
-	struct list_head task_alloc;
-	struct list_head task_free;
-	struct list_head cred_alloc_blank;
-	struct list_head cred_free;
-	struct list_head cred_prepare;
-	struct list_head cred_transfer;
-	struct list_head kernel_act_as;
-	struct list_head kernel_create_files_as;
-	struct list_head kernel_read_file;
-	struct list_head kernel_post_read_file;
-	struct list_head kernel_module_request;
-	struct list_head task_fix_setuid;
-	struct list_head task_setpgid;
-	struct list_head task_getpgid;
-	struct list_head task_getsid;
-	struct list_head task_getsecid;
-	struct list_head task_setnice;
-	struct list_head task_setioprio;
-	struct list_head task_getioprio;
-	struct list_head task_prlimit;
-	struct list_head task_setrlimit;
-	struct list_head task_setscheduler;
-	struct list_head task_getscheduler;
-	struct list_head task_movememory;
-	struct list_head task_kill;
-	struct list_head task_prctl;
-	struct list_head task_to_inode;
-	struct list_head ipc_permission;
-	struct list_head ipc_getsecid;
-	struct list_head msg_msg_alloc_security;
-	struct list_head msg_msg_free_security;
-	struct list_head msg_queue_alloc_security;
-	struct list_head msg_queue_free_security;
-	struct list_head msg_queue_associate;
-	struct list_head msg_queue_msgctl;
-	struct list_head msg_queue_msgsnd;
-	struct list_head msg_queue_msgrcv;
-	struct list_head shm_alloc_security;
-	struct list_head shm_free_security;
-	struct list_head shm_associate;
-	struct list_head shm_shmctl;
-	struct list_head shm_shmat;
-	struct list_head sem_alloc_security;
-	struct list_head sem_free_security;
-	struct list_head sem_associate;
-	struct list_head sem_semctl;
-	struct list_head sem_semop;
-	struct list_head netlink_send;
-	struct list_head d_instantiate;
-	struct list_head getprocattr;
-	struct list_head setprocattr;
-	struct list_head ismaclabel;
-	struct list_head secid_to_secctx;
-	struct list_head secctx_to_secid;
-	struct list_head release_secctx;
-	struct list_head inode_invalidate_secctx;
-	struct list_head inode_notifysecctx;
-	struct list_head inode_setsecctx;
-	struct list_head inode_getsecctx;
+	LSM_HOOK_inode_alloc_security,
+	LSM_HOOK_inode_free_security,
+	LSM_HOOK_inode_init_security,
+	LSM_HOOK_inode_create,
+	LSM_HOOK_inode_link,
+	LSM_HOOK_inode_unlink,
+	LSM_HOOK_inode_symlink,
+	LSM_HOOK_inode_mkdir,
+	LSM_HOOK_inode_rmdir,
+	LSM_HOOK_inode_mknod,
+	LSM_HOOK_inode_rename,
+	LSM_HOOK_inode_readlink,
+	LSM_HOOK_inode_follow_link,
+	LSM_HOOK_inode_permission,
+	LSM_HOOK_inode_setattr,
+	LSM_HOOK_inode_getattr,
+	LSM_HOOK_inode_setxattr,
+	LSM_HOOK_inode_post_setxattr,
+	LSM_HOOK_inode_getxattr,
+	LSM_HOOK_inode_listxattr,
+	LSM_HOOK_inode_removexattr,
+	LSM_HOOK_inode_need_killpriv,
+	LSM_HOOK_inode_killpriv,
+	LSM_HOOK_inode_getsecurity,
+	LSM_HOOK_inode_setsecurity,
+	LSM_HOOK_inode_listsecurity,
+	LSM_HOOK_inode_getsecid,
+	LSM_HOOK_inode_copy_up,
+	LSM_HOOK_inode_copy_up_xattr,
+	LSM_HOOK_file_permission,
+	LSM_HOOK_file_alloc_security,
+	LSM_HOOK_file_free_security,
+	LSM_HOOK_file_ioctl,
+	LSM_HOOK_mmap_addr,
+	LSM_HOOK_mmap_file,
+	LSM_HOOK_file_mprotect,
+	LSM_HOOK_file_lock,
+	LSM_HOOK_file_fcntl,
+	LSM_HOOK_file_set_fowner,
+	LSM_HOOK_file_send_sigiotask,
+	LSM_HOOK_file_receive,
+	LSM_HOOK_file_open,
+	LSM_HOOK_task_alloc,
+	LSM_HOOK_task_free,
+	LSM_HOOK_cred_alloc_blank,
+	LSM_HOOK_cred_free,
+	LSM_HOOK_cred_prepare,
+	LSM_HOOK_cred_transfer,
+	LSM_HOOK_kernel_act_as,
+	LSM_HOOK_kernel_create_files_as,
+	LSM_HOOK_kernel_read_file,
+	LSM_HOOK_kernel_post_read_file,
+	LSM_HOOK_kernel_module_request,
+	LSM_HOOK_task_fix_setuid,
+	LSM_HOOK_task_setpgid,
+	LSM_HOOK_task_getpgid,
+	LSM_HOOK_task_getsid,
+	LSM_HOOK_task_getsecid,
+	LSM_HOOK_task_setnice,
+	LSM_HOOK_task_setioprio,
+	LSM_HOOK_task_getioprio,
+	LSM_HOOK_task_prlimit,
+	LSM_HOOK_task_setrlimit,
+	LSM_HOOK_task_setscheduler,
+	LSM_HOOK_task_getscheduler,
+	LSM_HOOK_task_movememory,
+	LSM_HOOK_task_kill,
+	LSM_HOOK_task_prctl,
+	LSM_HOOK_task_to_inode,
+	LSM_HOOK_ipc_permission,
+	LSM_HOOK_ipc_getsecid,
+	LSM_HOOK_msg_msg_alloc_security,
+	LSM_HOOK_msg_msg_free_security,
+	LSM_HOOK_msg_queue_alloc_security,
+	LSM_HOOK_msg_queue_free_security,
+	LSM_HOOK_msg_queue_associate,
+	LSM_HOOK_msg_queue_msgctl,
+	LSM_HOOK_msg_queue_msgsnd,
+	LSM_HOOK_msg_queue_msgrcv,
+	LSM_HOOK_shm_alloc_security,
+	LSM_HOOK_shm_free_security,
+	LSM_HOOK_shm_associate,
+	LSM_HOOK_shm_shmctl,
+	LSM_HOOK_shm_shmat,
+	LSM_HOOK_sem_alloc_security,
+	LSM_HOOK_sem_free_security,
+	LSM_HOOK_sem_associate,
+	LSM_HOOK_sem_semctl,
+	LSM_HOOK_sem_semop,
+	LSM_HOOK_netlink_send,
+	LSM_HOOK_d_instantiate,
+	LSM_HOOK_getprocattr,
+	LSM_HOOK_setprocattr,
+	LSM_HOOK_ismaclabel,
+	LSM_HOOK_secid_to_secctx,
+	LSM_HOOK_secctx_to_secid,
+	LSM_HOOK_release_secctx,
+	LSM_HOOK_inode_invalidate_secctx,
+	LSM_HOOK_inode_notifysecctx,
+	LSM_HOOK_inode_setsecctx,
+	LSM_HOOK_inode_getsecctx,
 #ifdef CONFIG_SECURITY_NETWORK
-	struct list_head unix_stream_connect;
-	struct list_head unix_may_send;
-	struct list_head socket_create;
-	struct list_head socket_post_create;
-	struct list_head socket_bind;
-	struct list_head socket_connect;
-	struct list_head socket_listen;
-	struct list_head socket_accept;
-	struct list_head socket_sendmsg;
-	struct list_head socket_recvmsg;
-	struct list_head socket_getsockname;
-	struct list_head socket_getpeername;
-	struct list_head socket_getsockopt;
-	struct list_head socket_setsockopt;
-	struct list_head socket_shutdown;
-	struct list_head socket_sock_rcv_skb;
-	struct list_head socket_getpeersec_stream;
-	struct list_head socket_getpeersec_dgram;
-	struct list_head sk_alloc_security;
-	struct list_head sk_free_security;
-	struct list_head sk_clone_security;
-	struct list_head sk_getsecid;
-	struct list_head sock_graft;
-	struct list_head inet_conn_request;
-	struct list_head inet_csk_clone;
-	struct list_head inet_conn_established;
-	struct list_head secmark_relabel_packet;
-	struct list_head secmark_refcount_inc;
-	struct list_head secmark_refcount_dec;
-	struct list_head req_classify_flow;
-	struct list_head tun_dev_alloc_security;
-	struct list_head tun_dev_free_security;
-	struct list_head tun_dev_create;
-	struct list_head tun_dev_attach_queue;
-	struct list_head tun_dev_attach;
-	struct list_head tun_dev_open;
+	LSM_HOOK_unix_stream_connect,
+	LSM_HOOK_unix_may_send,
+	LSM_HOOK_socket_create,
+	LSM_HOOK_socket_post_create,
+	LSM_HOOK_socket_bind,
+	LSM_HOOK_socket_connect,
+	LSM_HOOK_socket_listen,
+	LSM_HOOK_socket_accept,
+	LSM_HOOK_socket_sendmsg,
+	LSM_HOOK_socket_recvmsg,
+	LSM_HOOK_socket_getsockname,
+	LSM_HOOK_socket_getpeername,
+	LSM_HOOK_socket_getsockopt,
+	LSM_HOOK_socket_setsockopt,
+	LSM_HOOK_socket_shutdown,
+	LSM_HOOK_socket_sock_rcv_skb,
+	LSM_HOOK_socket_getpeersec_stream,
+	LSM_HOOK_socket_getpeersec_dgram,
+	LSM_HOOK_sk_alloc_security,
+	LSM_HOOK_sk_free_security,
+	LSM_HOOK_sk_clone_security,
+	LSM_HOOK_sk_getsecid,
+	LSM_HOOK_sock_graft,
+	LSM_HOOK_inet_conn_request,
+	LSM_HOOK_inet_csk_clone,
+	LSM_HOOK_inet_conn_established,
+	LSM_HOOK_secmark_relabel_packet,
+	LSM_HOOK_secmark_refcount_inc,
+	LSM_HOOK_secmark_refcount_dec,
+	LSM_HOOK_req_classify_flow,
+	LSM_HOOK_tun_dev_alloc_security,
+	LSM_HOOK_tun_dev_free_security,
+	LSM_HOOK_tun_dev_create,
+	LSM_HOOK_tun_dev_attach_queue,
+	LSM_HOOK_tun_dev_attach,
+	LSM_HOOK_tun_dev_open,
 #endif	/* CONFIG_SECURITY_NETWORK */
 #ifdef CONFIG_SECURITY_INFINIBAND
-	struct list_head ib_pkey_access;
-	struct list_head ib_endport_manage_subnet;
-	struct list_head ib_alloc_security;
-	struct list_head ib_free_security;
+	LSM_HOOK_ib_pkey_access,
+	LSM_HOOK_ib_endport_manage_subnet,
+	LSM_HOOK_ib_alloc_security,
+	LSM_HOOK_ib_free_security,
 #endif	/* CONFIG_SECURITY_INFINIBAND */
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-	struct list_head xfrm_policy_alloc_security;
-	struct list_head xfrm_policy_clone_security;
-	struct list_head xfrm_policy_free_security;
-	struct list_head xfrm_policy_delete_security;
-	struct list_head xfrm_state_alloc;
-	struct list_head xfrm_state_alloc_acquire;
-	struct list_head xfrm_state_free_security;
-	struct list_head xfrm_state_delete_security;
-	struct list_head xfrm_policy_lookup;
-	struct list_head xfrm_state_pol_flow_match;
-	struct list_head xfrm_decode_session;
+	LSM_HOOK_xfrm_policy_alloc_security,
+	LSM_HOOK_xfrm_policy_clone_security,
+	LSM_HOOK_xfrm_policy_free_security,
+	LSM_HOOK_xfrm_policy_delete_security,
+	LSM_HOOK_xfrm_state_alloc,
+	LSM_HOOK_xfrm_state_alloc_acquire,
+	LSM_HOOK_xfrm_state_free_security,
+	LSM_HOOK_xfrm_state_delete_security,
+	LSM_HOOK_xfrm_policy_lookup,
+	LSM_HOOK_xfrm_state_pol_flow_match,
+	LSM_HOOK_xfrm_decode_session,
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 #ifdef CONFIG_KEYS
-	struct list_head key_alloc;
-	struct list_head key_free;
-	struct list_head key_permission;
-	struct list_head key_getsecurity;
+	LSM_HOOK_key_alloc,
+	LSM_HOOK_key_free,
+	LSM_HOOK_key_permission,
+	LSM_HOOK_key_getsecurity,
 #endif	/* CONFIG_KEYS */
 #ifdef CONFIG_AUDIT
-	struct list_head audit_rule_init;
-	struct list_head audit_rule_known;
-	struct list_head audit_rule_match;
-	struct list_head audit_rule_free;
+	LSM_HOOK_audit_rule_init,
+	LSM_HOOK_audit_rule_known,
+	LSM_HOOK_audit_rule_match,
+	LSM_HOOK_audit_rule_free,
 #endif /* CONFIG_AUDIT */
 #ifdef CONFIG_BPF_SYSCALL
-	struct list_head bpf;
-	struct list_head bpf_map;
-	struct list_head bpf_prog;
-	struct list_head bpf_map_alloc_security;
-	struct list_head bpf_map_free_security;
-	struct list_head bpf_prog_alloc_security;
-	struct list_head bpf_prog_free_security;
+	LSM_HOOK_bpf,
+	LSM_HOOK_bpf_map,
+	LSM_HOOK_bpf_prog,
+	LSM_HOOK_bpf_map_alloc_security,
+	LSM_HOOK_bpf_map_free_security,
+	LSM_HOOK_bpf_prog_alloc_security,
+	LSM_HOOK_bpf_prog_free_security,
 #endif /* CONFIG_BPF_SYSCALL */
-} __randomize_layout;
+	__MAX_LSM_HOOK,
+};
 
+#define HOOK_IDX(NAME)	LSM_HOOK_##NAME
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
  */
 struct security_hook_list {
 	struct list_head		list;
-	struct list_head		*head;
+	enum lsm_hook			head_idx;
 	union security_list_options	hook;
 	char				*lsm;
 } __randomize_layout;
@@ -1975,9 +1977,8 @@ struct security_hook_list {
  * text involved.
  */
 #define LSM_HOOK_INIT(HEAD, HOOK) \
-	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+	{ .head_idx = HOOK_IDX(HEAD), .hook = { .HEAD = HOOK } }
 
-extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
diff --git a/security/security.c b/security/security.c
index 1cd8526cb0b7..b9fb297b824e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -35,9 +35,11 @@
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+static struct list_head security_hook_heads[__MAX_LSM_HOOK] __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
+#define HOOK_HEAD(NAME)	(&security_hook_heads[HOOK_IDX(NAME)])
+
 char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
@@ -61,11 +63,9 @@ static void __init do_security_initcalls(void)
 int __init security_init(void)
 {
 	int i;
-	struct list_head *list = (struct list_head *) &security_hook_heads;
 
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct list_head);
-	     i++)
-		INIT_LIST_HEAD(&list[i]);
+	for (i = 0; i < ARRAY_SIZE(security_hook_heads); i++)
+		INIT_LIST_HEAD(&security_hook_heads[i]);
 	pr_info("Security Framework initialized\n");
 
 	/*
@@ -159,11 +159,14 @@ int __init security_module_enable(const char *module)
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm)
 {
+	enum lsm_hook hook_idx;
 	int i;
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
-		list_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		hook_idx = hooks[i].head_idx;
+		list_add_tail_rcu(&hooks[i].list,
+				  &security_hook_heads[hook_idx]);
 	}
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
@@ -201,7 +204,7 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 	do {							\
 		struct security_hook_list *P;			\
 								\
-		list_for_each_entry(P, &security_hook_heads.FUNC, list)	\
+		list_for_each_entry(P, HOOK_HEAD(FUNC), list)	\
 			P->hook.FUNC(__VA_ARGS__);		\
 	} while (0)
 
@@ -210,7 +213,7 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 	do {							\
 		struct security_hook_list *P;			\
 								\
-		list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+		list_for_each_entry(P, HOOK_HEAD(FUNC), list) { \
 			RC = P->hook.FUNC(__VA_ARGS__);		\
 			if (RC != 0)				\
 				break;				\
@@ -317,7 +320,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
-	list_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
+	list_for_each_entry(hp, HOOK_HEAD(vm_enough_memory), list) {
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
@@ -805,7 +808,7 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	list_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
+	list_for_each_entry(hp, HOOK_HEAD(inode_getsecurity), list) {
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
 			return rc;
@@ -823,7 +826,7 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	list_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
+	list_for_each_entry(hp, HOOK_HEAD(inode_setsecurity), list) {
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
 								flags);
 		if (rc != -EOPNOTSUPP)
@@ -1126,7 +1129,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
 
-	list_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
+	list_for_each_entry(hp, HOOK_HEAD(task_prctl), list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
@@ -1629,8 +1632,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
-	list_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
+	list_for_each_entry(hp, HOOK_HEAD(xfrm_state_pol_flow_match), list) {
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
-- 
2.14.1

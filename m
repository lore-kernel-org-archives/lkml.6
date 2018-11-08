Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB3DECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A158E20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A158E20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeKIAEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:04:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60231 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKIAEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:04:41 -0500
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1gKlIl-0004w1-9l
        for linux-kernel@vger.kernel.org; Thu, 08 Nov 2018 14:28:55 +0000
Received: by mail-wm1-f71.google.com with SMTP id 143-v6so998142wmv.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f8gAa9euBjqwyPlC0tTLDbGt2Q6gGpV0EA5TytDB7fI=;
        b=WBWEJuqVjdEkjqZrtiVPgs1SoA72VSiIzXaSFnx5PvPEnkWC9J3dvQkZ7LoXbFOuaj
         R7XdsdHVFelOmLRQ5LnhVMiEFFFo9qZwO88Wmg4Bu2N1TNwC42+i+x3zsPdaL+dv6H+A
         m8IAcTJqm44OapjeE/Vdnnu1KVxIbNremFrml1+eN+0CdLfK+nxx3JyKWdANWDhfWspI
         LK9D2hPsJCYHO0vrd9Nv2YQRhwQ9XiDjsbsOPyy78eN3tXVTBLJuxDcrfR4hQKDT06sj
         ddTKRBrMlwQFwX5iuIYEzJ/YYsZ9dSD7p1Tb8lEr5+ZgU9KZKe6L+YTM8HTl9vVVpOc0
         JGFQ==
X-Gm-Message-State: AGRZ1gI8Of30Uo1nGnu9hJa9/DZFRG6uKbwNx2GU8XZNTIDz/SiT5zjv
        Da9gDoVkCQQz+tO6BVs532FXeO8/Jt/UJmiY6yTu4c3xgCuyglFmfgVEDQKD7rHx5SoneD0O/7H
        RGTYX8PMg4Hf46b6MWvisnrirQcaI/xeReTcHIfG0Pw==
X-Received: by 2002:a1c:58c5:: with SMTP id m188-v6mr1333160wmb.85.1541687334612;
        Thu, 08 Nov 2018 06:28:54 -0800 (PST)
X-Google-Smtp-Source: AJdET5fIH4I/IplBOdYn/T79k6kK6vuC9LARBtgaXWhcpglSdu2eRHJzkWU8v9MdVM1sYTgGffUHkw==
X-Received: by 2002:a1c:58c5:: with SMTP id m188-v6mr1333117wmb.85.1541687333870;
        Thu, 08 Nov 2018 06:28:53 -0800 (PST)
Received: from gmail.com ([2a02:8070:8895:9700:887:8ecc:df73:24eb])
        by smtp.gmail.com with ESMTPSA id p20-v6sm5364349wmd.10.2018.11.08.06.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:28:53 -0800 (PST)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Thu, 8 Nov 2018 15:28:51 +0100
To:     =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] binder: ipc namespace support for android binder
Message-ID: <20181108142850.olwst426kmiskhil@gmail.com>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:02:32PM +0000, chouryzhou(周威) wrote:
>   We are working for running android in container, but we found that binder is
> not isolated by ipc namespace. Since binder is a form of IPC and therefore should
> be tied to ipc namespace. With this patch, we can run more than one android
> container on one host.
>   This patch move "binder_procs" and "binder_context" into ipc_namespace,
> driver will find the context from it when opening. Although statistics in debugfs
> remain global.
> 
> Signed-off-by: chouryzhou <chouryzhou@tencent.com>
> ---
>  drivers/android/binder.c      | 128 +++++++++++++++++++++++++++++++-----------
>  include/linux/ipc_namespace.h |  15 +++++
>  ipc/namespace.c               |  10 +++-
>  3 files changed, 117 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index cb30a524d16d..22e45bb937e6 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -68,6 +68,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
>  #include <linux/pid_namespace.h>
> +#include <linux/ipc_namespace.h>
>  #include <linux/security.h>
>  #include <linux/spinlock.h>
>  #include <linux/ratelimit.h>
> @@ -80,13 +81,18 @@
>  #include "binder_alloc.h"
>  #include "binder_trace.h"
>  
> +
> +#if !defined(CONFIG_SYSVIPC) &&  !defined(CONFIG_POSIX_MQUEUE)
> +struct ipc_namespace init_ipc_ns;
> +#define ipcns  (&init_ipc_ns)
> +#else
> +#define ipcns  (current->nsproxy->ipc_ns)
> +#endif
> +
>  static HLIST_HEAD(binder_deferred_list);
>  static DEFINE_MUTEX(binder_deferred_lock);
>  
>  static HLIST_HEAD(binder_devices);
> -static HLIST_HEAD(binder_procs);
> -static DEFINE_MUTEX(binder_procs_lock);
> -
>  static HLIST_HEAD(binder_dead_nodes);
>  static DEFINE_SPINLOCK(binder_dead_nodes_lock);
>  
> @@ -232,7 +238,7 @@ struct binder_transaction_log_entry {
>         int return_error_line;
>         uint32_t return_error;
>         uint32_t return_error_param;
> -       const char *context_name;
> +       int context_device;
>  };
>  struct binder_transaction_log {
>         atomic_t cur;
> @@ -263,19 +269,64 @@ static struct binder_transaction_log_entry *binder_transaction_log_add(
>  }
>  
>  struct binder_context {
> +       struct hlist_node hlist;
>         struct binder_node *binder_context_mgr_node;
>         struct mutex context_mgr_node_lock;
>  
>         kuid_t binder_context_mgr_uid;
> -       const char *name;
> +       int    device;
>  };
>  
>  struct binder_device {
>         struct hlist_node hlist;
>         struct miscdevice miscdev;
> -       struct binder_context context;
>  };
>  
> +void binder_exit_ns(struct ipc_namespace *ns)
> +{
> +       struct binder_context *context;
> +       struct hlist_node *tmp;
> +
> +       mutex_destroy(&ns->binder_procs_lock);
> +       hlist_for_each_entry_safe(context, tmp, &ns->binder_contexts, hlist) {
> +               mutex_destroy(&context->context_mgr_node_lock);
> +               hlist_del(&context->hlist);
> +               kfree(context);
> +       }
> +}
> +
> +int binder_init_ns(struct ipc_namespace *ns)
> +{
> +       int ret;
> +       struct binder_device *device;
> +
> +       mutex_init(&ns->binder_procs_lock);
> +       INIT_HLIST_HEAD(&ns->binder_procs);
> +       INIT_HLIST_HEAD(&ns->binder_contexts);
> +
> +       hlist_for_each_entry(device, &binder_devices, hlist) {
> +               struct binder_context *context;
> +
> +               context = kzalloc(sizeof(*context), GFP_KERNEL);
> +               if (!context) {
> +                       ret = -ENOMEM;
> +                       goto err;
> +               }
> +
> +               context->device = device->miscdev.minor;
> +               context->binder_context_mgr_uid = INVALID_UID;
> +               mutex_init(&context->context_mgr_node_lock);
> +
> +               hlist_add_head(&context->hlist, &ns->binder_contexts);
> +       }
> +
> +       return 0;
> +err:
> +       binder_exit_ns(ns);
> +       return ret;
> +}
> +
> +
>  /**
>   * struct binder_work - work enqueued on a worklist
>   * @entry:             node enqueued on list
> @@ -2727,7 +2778,7 @@ static void binder_transaction(struct binder_proc *proc,
>         e->target_handle = tr->target.handle;
>         e->data_size = tr->data_size;
>         e->offsets_size = tr->offsets_size;
> -       e->context_name = proc->context->name;
> +       e->context_device = proc->context->device;
>  
>         if (reply) {
>                 binder_inner_proc_lock(proc);
> @@ -4922,6 +4973,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
>  {
>         struct binder_proc *proc;
>         struct binder_device *binder_dev;
> +       struct binder_context *context;
>  
>         binder_debug(BINDER_DEBUG_OPEN_CLOSE, "%s: %d:%d\n", __func__,
>                      current->group_leader->pid, current->pid);
> @@ -4937,7 +4989,15 @@ static int binder_open(struct inode *nodp, struct file *filp)

So the idea is that on open() of a binder device you attach an ipc
namespace to the opening process?
So you'd basically be able to create a new device node with the same
minor and major number as the one in the host ipc namespace in another
ipc namespace and it would give you a different context.
That's basically namespacing binder devices without *properly*
namespacing them.

What happens if I do:

/* in initial ipc namespace */
binder_fd = open(/dev/binder0)

Now I send binder_fd via SCM_RIGHTs from initial ipc namespace to
non-initial ipc namespace.

/* in non-initial ipc namespace */
new_binder_fd = open(/proc/self/binder_fd);

What ipc namespace do you intend new_binder_fd to refer to? It seems
a re-open on such an fd would switch ipc namespaces. I find that odd
semantics. Are there other things that behave that way? If you send a
pty fd to another namespace it won't switch mount and user namespaces
just because you re-open it via /proc.

>         proc->default_priority = task_nice(current);
>         binder_dev = container_of(filp->private_data, struct binder_device,
>                                   miscdev);
> -       proc->context = &binder_dev->context;
> +       hlist_for_each_entry(context, &ipcns->binder_contexts, hlist) {
> +               if (context->device == binder_dev->miscdev.minor) {
> +                       proc->context = context;
> +                       break;
> +               }
> +       }
> +       if (!proc->context)
> +               return -ENOENT;
> +
>         binder_alloc_init(&proc->alloc);
>  
>         binder_stats_created(BINDER_STAT_PROC);
> @@ -4946,9 +5006,9 @@ static int binder_open(struct inode *nodp, struct file *filp)
>         INIT_LIST_HEAD(&proc->waiting_threads);
>         filp->private_data = proc;
>  
> -       mutex_lock(&binder_procs_lock);
> -       hlist_add_head(&proc->proc_node, &binder_procs);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_add_head(&proc->proc_node, &ipcns->binder_procs);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>  
>         if (binder_debugfs_dir_entry_proc) {
>                 char strbuf[11];
> @@ -5082,9 +5142,9 @@ static void binder_deferred_release(struct binder_proc *proc)
>         struct rb_node *n;
>         int threads, nodes, incoming_refs, outgoing_refs, active_transactions;
>  
> -       mutex_lock(&binder_procs_lock);
> +       mutex_lock(&ipcns->binder_procs_lock);
>         hlist_del(&proc->proc_node);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>  
>         mutex_lock(&context->context_mgr_node_lock);
>         if (context->binder_context_mgr_node &&
> @@ -5377,7 +5437,7 @@ static void print_binder_proc(struct seq_file *m,
>         struct binder_node *last_node = NULL;
>  
>         seq_printf(m, "proc %d\n", proc->pid);
> -       seq_printf(m, "context %s\n", proc->context->name);
> +       seq_printf(m, "context %d\n", proc->context->device);
>         header_pos = m->count;
>  
>         binder_inner_proc_lock(proc);
> @@ -5538,7 +5598,7 @@ static void print_binder_proc_stats(struct seq_file *m,
>                 binder_alloc_get_free_async_space(&proc->alloc);
>  
>         seq_printf(m, "proc %d\n", proc->pid);
> -       seq_printf(m, "context %s\n", proc->context->name);
> +       seq_printf(m, "context %d\n", proc->context->device);
>         count = 0;
>         ready_threads = 0;
>         binder_inner_proc_lock(proc);
> @@ -5623,10 +5683,10 @@ static int binder_state_show(struct seq_file *m, void *unused)
>         if (last_node)
>                 binder_put_node(last_node);
>  
> -       mutex_lock(&binder_procs_lock);
> -       hlist_for_each_entry(proc, &binder_procs, proc_node)
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_for_each_entry(proc, &ipcns->binder_procs, proc_node)
>                 print_binder_proc(m, proc, 1);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>  
>         return 0;
>  }
> @@ -5639,10 +5699,10 @@ static int binder_stats_show(struct seq_file *m, void *unused)
>  
>         print_binder_stats(m, "", &binder_stats);
>  
> -       mutex_lock(&binder_procs_lock);
> -       hlist_for_each_entry(proc, &binder_procs, proc_node)
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_for_each_entry(proc, &ipcns->binder_procs, proc_node)
>                 print_binder_proc_stats(m, proc);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>  
>         return 0;
>  }
> @@ -5652,10 +5712,10 @@ static int binder_transactions_show(struct seq_file *m, void *unused)
>         struct binder_proc *proc;
>  
>         seq_puts(m, "binder transactions:\n");
> -       mutex_lock(&binder_procs_lock);
> -       hlist_for_each_entry(proc, &binder_procs, proc_node)
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_for_each_entry(proc, &ipcns->binder_procs, proc_node)
>                 print_binder_proc(m, proc, 0);
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>  
>         return 0;
>  }
> @@ -5665,14 +5725,14 @@ static int binder_proc_show(struct seq_file *m, void *unused)
>         struct binder_proc *itr;
>         int pid = (unsigned long)m->private;
>  
> -       mutex_lock(&binder_procs_lock);
> -       hlist_for_each_entry(itr, &binder_procs, proc_node) {
> +       mutex_lock(&ipcns->binder_procs_lock);
> +       hlist_for_each_entry(itr, &ipcns->binder_procs, proc_node) {
>                 if (itr->pid == pid) {
>                         seq_puts(m, "binder proc state:\n");
>                         print_binder_proc(m, itr, 1);
>                 }
>         }
> -       mutex_unlock(&binder_procs_lock);
> +       mutex_unlock(&ipcns->binder_procs_lock);
>  
>         return 0;
>  }
> @@ -5687,10 +5747,10 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
>          */
>         smp_rmb();
>         seq_printf(m,
> -                  "%d: %s from %d:%d to %d:%d context %s node %d handle %d size %d:%d ret %d/%d l=%d",
> +                  "%d: %s from %d:%d to %d:%d context %d node %d handle %d size %d:%d ret %d/%d l=%d",
>                    e->debug_id, (e->call_type == 2) ? "reply" :
>                    ((e->call_type == 1) ? "async" : "call "), e->from_proc,
> -                  e->from_thread, e->to_proc, e->to_thread, e->context_name,
> +                  e->from_thread, e->to_proc, e->to_thread, e->context_device,
>                    e->to_node, e->target_handle, e->data_size, e->offsets_size,
>                    e->return_error, e->return_error_param,
>                    e->return_error_line);
> @@ -5753,10 +5813,6 @@ static int __init init_binder_device(const char *name)
>         binder_device->miscdev.minor = MISC_DYNAMIC_MINOR;
>         binder_device->miscdev.name = name;
>  
> -       binder_device->context.binder_context_mgr_uid = INVALID_UID;
> -       binder_device->context.name = name;
> -       mutex_init(&binder_device->context.context_mgr_node_lock);
> -
>         ret = misc_register(&binder_device->miscdev);
>         if (ret < 0) {
>                 kfree(binder_device);
> @@ -5832,8 +5888,12 @@ static int __init binder_init(void)
>                         goto err_init_binder_device_failed;
>         }
>  
> -       return ret;
> +       ret = binder_init_ns(&init_ipc_ns);
> +       if (ret)
> +               goto err_init_namespace_failed;
>  
> +       return ret;
> +err_init_namespace_failed:
>  err_init_binder_device_failed:
>         hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
>                 misc_deregister(&device->miscdev);
> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> index 6ab8c1bada3f..d7f850a2ded8 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -63,6 +63,13 @@ struct ipc_namespace {
>         unsigned int    mq_msg_default;
>         unsigned int    mq_msgsize_default;
>  
> +#ifdef CONFIG_ANDROID_BINDER_IPC
> +       /* next fields are for binder */
> +       struct mutex      binder_procs_lock;
> +       struct hlist_head binder_procs;
> +       struct hlist_head binder_contexts;
> +#endif
> +
>         /* user_ns which owns the ipc ns */
>         struct user_namespace *user_ns;
>         struct ucounts *ucounts;
> @@ -118,6 +125,14 @@ extern int mq_init_ns(struct ipc_namespace *ns);
>  static inline int mq_init_ns(struct ipc_namespace *ns) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_ANDROID_BINDER_IPC
> +extern int binder_init_ns(struct ipc_namespace *ns);
> +extern void binder_exit_ns(struct ipc_namespace *ns);
> +#else
> +static inline int binder_init_ns(struct ipc_namespace *ns) { return 0; }
> +static inline void binder_exit_ns(struct ipc_namespace *ns) { }
> +#endif
> +
>  #if defined(CONFIG_IPC_NS)
>  extern struct ipc_namespace *copy_ipcs(unsigned long flags,
>         struct user_namespace *user_ns, struct ipc_namespace *ns);
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 21607791d62c..68c6e983b002 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -57,7 +57,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  
>         err = mq_init_ns(ns);
>         if (err)
> -               goto fail_put;
> +               goto fail_init_mq;
> +       err = binder_init_ns(ns);
> +       if (err)
> +               goto fail_init_binder;
>  
>         sem_init_ns(ns);
>         msg_init_ns(ns);
> @@ -65,7 +68,9 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  
>         return ns;
>  
> -fail_put:
> +fail_init_binder:
> +       mq_put_mnt(ns);
> +fail_init_mq:
>         put_user_ns(ns->user_ns);
>         ns_free_inum(&ns->ns);
>  fail_free:
> @@ -120,6 +125,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>         sem_exit_ns(ns);
>         msg_exit_ns(ns);
>         shm_exit_ns(ns);
> +       binder_exit_ns(ns);
>  
>         dec_ipc_namespaces(ns->ucounts);
>         put_user_ns(ns->user_ns);
> -- 
> 2.11.0

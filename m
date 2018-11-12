Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5D7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A71F22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="L9c+2yx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A71F22504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeKMFTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:19:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36644 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:19:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so9048996otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=N80soCWBeS1QGaoJwbo43pXPUUejapZ6/jht6XcWvZc=;
        b=L9c+2yx096X7VDHIf4Vz7mindNVaIsp0rl1uBrXWdhiXPZfokwLgnicHckZ26emAK8
         d1Y4zSBz5admdfs7tIl4DNBIw00qpzhEaaUbk59u0Pvqbn5SCxTBtnc/JSw2hjTAGaqF
         oP63hdfpPcjPC++URsenuuT28C8CI6Xxq4UAQP5AXb7KQcHD2RdOT3Jk0WGMfH8fI9g4
         QcvjVWsz3eRapos8Dd2lz8hiuUi96XHkDlE2oczCYvtcgMyQ34pnAPa71nG1b+XKBaqh
         3a6BLZJwwVTBU8mwZHK7ctkdQiW77E2+P9lOzIuGIIZKxNZ+JvRvYgVmAoY4ngoGLOFl
         RlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=N80soCWBeS1QGaoJwbo43pXPUUejapZ6/jht6XcWvZc=;
        b=IGgwC/J8rhmt62mm4MWhPMmQsn48bAUu8LLQW+x0HAk1cqQAz1rT/OcI0C46lGecn0
         Qmf7KLFY7a8FmRk1rDoTx9rltWPqWEIXKvhOGeOJv6BIn/B7B0uh4k+ja4TK8tLnR9PW
         bXDcZO/evyVopeMxQuGYr3U/cIUuNMp5ZKv68pZjCrxDvNBG28cgIpneOEu1rKjOHmxn
         SEd4pZfZ9gxnF0UMtPCENz/MUgUFwlvZpam8PrZmssd9vE3VNdm3ZpN2jmzTXhddk3HS
         8atMHXH+BBS1OAPhh6nIm7VNeEu6LvcWutuRBljtc1ixWawsRfDskBu5Hx+dPi6StfwH
         HOUQ==
X-Gm-Message-State: AGRZ1gIBO9U+xbIaQgtACvbqcIpVI+D11HgIyAix+FPoyNFyywUyHQNC
        EvAJHmSjVkhtS/lUkMB8RUDVUg==
X-Google-Smtp-Source: AJdET5fy4hlQ2mmPYmyEId9HbVyUitHKZdQY52hl+XeOBhwsceeerGN/HgWrgWgTGgBQBt6H3ijcUQ==
X-Received: by 2002:a9d:460e:: with SMTP id y14mr1433980ote.198.1542050706408;
        Mon, 12 Nov 2018 11:25:06 -0800 (PST)
Received: from [100.146.230.146] ([172.56.6.27])
        by smtp.gmail.com with ESMTPSA id 35sm6625313ott.13.2018.11.12.11.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 11:25:05 -0800 (PST)
Date:   Mon, 12 Nov 2018 11:24:59 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHRSSEwf67AkOtwsAEuqmmwSf2OV8BbqYFiGft9qXcrDQvhzHA@mail.gmail.com>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F8FA41@EXMBX-SZMAIL022.tencent.com> <CAHRSSEwf67AkOtwsAEuqmmwSf2OV8BbqYFiGft9qXcrDQvhzHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V4] binder: ipc namespace support for android binder
To:     Todd Kjos <tkjos@google.com>, chouryzhou@tencent.com,
        Martijn Coenen <maco@android.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, akpm@linux-foundation.org,
        dave@stgolabs.net,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <EF459CC7-2383-49D6-82DB-6C21517B5CD9@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 12, 2018 8:45:07 AM PST, Todd Kjos <tkjos@google=2Ecom> wrote:
>+christian@brauner=2Eio +Martijn Coenen
>
>Christian,
>
>Does this patch work for your container use-cases? If not, please
>comment on this thread=2E Let's discuss at LPC this week=2E

I have not received an answer to my questions in the last version of this =
patch set=2E Also it would be good if I could be Cc'ed by default=2E I can'=
t hunt down all patches=2E
I do not know of any kernel entity, specifically devices, that change name=
spaces on open()=2E
This seems like an invitation for all kinds of security bugs=2E
A device node belongs to one namespace only which is attached to the under=
lying kobject=2E Opening the device should never change that=2E
Please look at how mqueue or shm are doing this=2E They don't change names=
paces on open either=2E
I have to say that is one of the main reasons why I disagree with that des=
ign=2E


>
>-Todd
>
>On Mon, Nov 12, 2018 at 1:38 AM chouryzhou(=E5=91=A8=E5=A8=81) <chouryzho=
u@tencent=2Ecom>
>wrote:
>>
>> Currently android's binder is not isolated by ipc namespace=2E Since
>binder
>> is a form of IPC and therefore should be tied to ipc namespace=2E With
>this
>> patch, we can run multiple instances of  android container on one
>host=2E
>>
>> This patch move "binder_procs" and "binder_context" into
>ipc_namespace,
>> driver will find the context from it when opening=2E For debugfs,
>binder_proc
>> is namespace-aware, but not for binder dead nodes, binder_stats and
>> binder_transaction_log_entry (we added ipc inum to trace it)=2E
>>
>> Signed-off-by: chouryzhou <chouryzhou@tencent=2Ecom>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs=2Enet>
>> ---
>>  drivers/android/binder=2Ec      | 133
>++++++++++++++++++++++++++++++++----------
>>  include/linux/ipc_namespace=2Eh |  15 +++++
>>  ipc/namespace=2Ec               |  10 +++-
>>  3 files changed, 125 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/android/binder=2Ec b/drivers/android/binder=2Ec
>> index cb30a524d16d=2E=2E453265505b04 100644
>> --- a/drivers/android/binder=2Ec
>> +++ b/drivers/android/binder=2Ec
>> @@ -67,6 +67,8 @@
>>  #include <linux/sched/mm=2Eh>
>>  #include <linux/seq_file=2Eh>
>>  #include <linux/uaccess=2Eh>
>> +#include <linux/proc_ns=2Eh>
>> +#include <linux/ipc_namespace=2Eh>
>>  #include <linux/pid_namespace=2Eh>
>>  #include <linux/security=2Eh>
>>  #include <linux/spinlock=2Eh>
>> @@ -80,13 +82,21 @@
>>  #include "binder_alloc=2Eh"
>>  #include "binder_trace=2Eh"
>>
>> +
>> +#ifndef CONFIG_IPC_NS
>> +static struct ipc_namespace binder_ipc_ns =3D {
>> +       =2Ens=2Einum =3D PROC_IPC_INIT_INO,
>> +};
>> +
>> +#define ipcns  (&binder_ipc_ns)
>> +#else
>> +#define ipcns  (current->nsproxy->ipc_ns)
>> +#endif
>> +
>>  static HLIST_HEAD(binder_deferred_list);
>>  static DEFINE_MUTEX(binder_deferred_lock);
>>
>>  static HLIST_HEAD(binder_devices);
>> -static HLIST_HEAD(binder_procs);
>> -static DEFINE_MUTEX(binder_procs_lock);
>> -
>>  static HLIST_HEAD(binder_dead_nodes);
>>  static DEFINE_SPINLOCK(binder_dead_nodes_lock);
>>
>> @@ -233,6 +243,7 @@ struct binder_transaction_log_entry {
>>         uint32_t return_error;
>>         uint32_t return_error_param;
>>         const char *context_name;
>> +       unsigned int ipc_inum;
>>  };
>>  struct binder_transaction_log {
>>         atomic_t cur;
>> @@ -263,19 +274,66 @@ static struct binder_transaction_log_entry
>*binder_transaction_log_add(
>>  }
>>
>>  struct binder_context {
>> +       struct hlist_node hlist;
>>         struct binder_node *binder_context_mgr_node;
>>         struct mutex context_mgr_node_lock;
>>
>>         kuid_t binder_context_mgr_uid;
>> +       int   device;
>>         const char *name;
>>  };
>>
>>  struct binder_device {
>>         struct hlist_node hlist;
>>         struct miscdevice miscdev;
>> -       struct binder_context context;
>>  };
>>
>> +void binder_exit_ns(struct ipc_namespace *ns)
>> +{
>> +       struct binder_context *context;
>> +       struct hlist_node *tmp;
>> +
>> +       mutex_destroy(&ns->binder_procs_lock);
>> +       hlist_for_each_entry_safe(context, tmp, &ns->binder_contexts,
>hlist) {
>> +               mutex_destroy(&context->context_mgr_node_lock);
>> +               hlist_del(&context->hlist);
>> +               kfree(context);
>> +       }
>> +}
>> +
>> +int binder_init_ns(struct ipc_namespace *ns)
>> +{
>> +       int ret;
>> +       struct binder_device *device;
>> +
>> +       mutex_init(&ns->binder_procs_lock);
>> +       INIT_HLIST_HEAD(&ns->binder_procs);
>> +       INIT_HLIST_HEAD(&ns->binder_contexts);
>> +
>> +       hlist_for_each_entry(device, &binder_devices, hlist) {
>> +               struct binder_context *context;
>> +
>> +               context =3D kzalloc(sizeof(*context), GFP_KERNEL);
>> +               if (!context) {
>> +                       ret =3D -ENOMEM;
>> +                       goto err;
>> +               }
>> +
>> +               context->device =3D device->miscdev=2Eminor;
>> +               context->name =3D device->miscdev=2Ename;
>> +               context->binder_context_mgr_uid =3D INVALID_UID;
>> +               mutex_init(&context->context_mgr_node_lock);
>> +
>> +               hlist_add_head(&context->hlist,
>&ns->binder_contexts);
>> +       }
>> +
>> +       return 0;
>> +err:
>> +       binder_exit_ns(ns);
>> +       return ret;
>> +}
>> +
>> +
>>  /**
>>   * struct binder_work - work enqueued on a worklist
>>   * @entry:             node enqueued on list
>> @@ -2728,6 +2786,7 @@ static void binder_transaction(struct
>binder_proc *proc,
>>         e->data_size =3D tr->data_size;
>>         e->offsets_size =3D tr->offsets_size;
>>         e->context_name =3D proc->context->name;
>> +       e->ipc_inum =3D ipcns->ns=2Einum;
>>
>>         if (reply) {
>>                 binder_inner_proc_lock(proc);
>> @@ -4922,6 +4981,7 @@ static int binder_open(struct inode *nodp,
>struct file *filp)
>>  {
>>         struct binder_proc *proc;
>>         struct binder_device *binder_dev;
>> +       struct binder_context *context;
>>
>>         binder_debug(BINDER_DEBUG_OPEN_CLOSE, "%s: %d:%d\n",
>__func__,
>>                      current->group_leader->pid, current->pid);
>> @@ -4937,7 +4997,15 @@ static int binder_open(struct inode *nodp,
>struct file *filp)
>>         proc->default_priority =3D task_nice(current);
>>         binder_dev =3D container_of(filp->private_data, struct
>binder_device,
>>                                   miscdev);
>> -       proc->context =3D &binder_dev->context;
>> +       hlist_for_each_entry(context, &ipcns->binder_contexts, hlist)
>{
>> +               if (context->device =3D=3D binder_dev->miscdev=2Eminor)=
 {
>> +                       proc->context =3D context;
>> +                       break;
>> +               }
>> +       }
>> +       if (!proc->context)
>> +               return -ENOENT;
>> +
>>         binder_alloc_init(&proc->alloc);
>>
>>         binder_stats_created(BINDER_STAT_PROC);
>> @@ -4946,9 +5014,9 @@ static int binder_open(struct inode *nodp,
>struct file *filp)
>>         INIT_LIST_HEAD(&proc->waiting_threads);
>>         filp->private_data =3D proc;
>>
>> -       mutex_lock(&binder_procs_lock);
>> -       hlist_add_head(&proc->proc_node, &binder_procs);
>> -       mutex_unlock(&binder_procs_lock);
>> +       mutex_lock(&ipcns->binder_procs_lock);
>> +       hlist_add_head(&proc->proc_node, &ipcns->binder_procs);
>> +       mutex_unlock(&ipcns->binder_procs_lock);
>>
>>         if (binder_debugfs_dir_entry_proc) {
>>                 char strbuf[11];
>> @@ -5082,9 +5150,9 @@ static void binder_deferred_release(struct
>binder_proc *proc)
>>         struct rb_node *n;
>>         int threads, nodes, incoming_refs, outgoing_refs,
>active_transactions;
>>
>> -       mutex_lock(&binder_procs_lock);
>> +       mutex_lock(&ipcns->binder_procs_lock);
>>         hlist_del(&proc->proc_node);
>> -       mutex_unlock(&binder_procs_lock);
>> +       mutex_unlock(&ipcns->binder_procs_lock);
>>
>>         mutex_lock(&context->context_mgr_node_lock);
>>         if (context->binder_context_mgr_node &&
>> @@ -5623,10 +5691,10 @@ static int binder_state_show(struct seq_file
>*m, void *unused)
>>         if (last_node)
>>                 binder_put_node(last_node);
>>
>> -       mutex_lock(&binder_procs_lock);
>> -       hlist_for_each_entry(proc, &binder_procs, proc_node)
>> +       mutex_lock(&ipcns->binder_procs_lock);
>> +       hlist_for_each_entry(proc, &ipcns->binder_procs, proc_node)
>>                 print_binder_proc(m, proc, 1);
>> -       mutex_unlock(&binder_procs_lock);
>> +       mutex_unlock(&ipcns->binder_procs_lock);
>>
>>         return 0;
>>  }
>> @@ -5639,10 +5707,10 @@ static int binder_stats_show(struct seq_file
>*m, void *unused)
>>
>>         print_binder_stats(m, "", &binder_stats);
>>
>> -       mutex_lock(&binder_procs_lock);
>> -       hlist_for_each_entry(proc, &binder_procs, proc_node)
>> +       mutex_lock(&ipcns->binder_procs_lock);
>> +       hlist_for_each_entry(proc, &ipcns->binder_procs, proc_node)
>>                 print_binder_proc_stats(m, proc);
>> -       mutex_unlock(&binder_procs_lock);
>> +       mutex_unlock(&ipcns->binder_procs_lock);
>>
>>         return 0;
>>  }
>> @@ -5652,10 +5720,10 @@ static int binder_transactions_show(struct
>seq_file *m, void *unused)
>>         struct binder_proc *proc;
>>
>>         seq_puts(m, "binder transactions:\n");
>> -       mutex_lock(&binder_procs_lock);
>> -       hlist_for_each_entry(proc, &binder_procs, proc_node)
>> +       mutex_lock(&ipcns->binder_procs_lock);
>> +       hlist_for_each_entry(proc, &ipcns->binder_procs, proc_node)
>>                 print_binder_proc(m, proc, 0);
>> -       mutex_unlock(&binder_procs_lock);
>> +       mutex_unlock(&ipcns->binder_procs_lock);
>>
>>         return 0;
>>  }
>> @@ -5665,14 +5733,14 @@ static int binder_proc_show(struct seq_file
>*m, void *unused)
>>         struct binder_proc *itr;
>>         int pid =3D (unsigned long)m->private;
>>
>> -       mutex_lock(&binder_procs_lock);
>> -       hlist_for_each_entry(itr, &binder_procs, proc_node) {
>> +       mutex_lock(&ipcns->binder_procs_lock);
>> +       hlist_for_each_entry(itr, &ipcns->binder_procs, proc_node) {
>>                 if (itr->pid =3D=3D pid) {
>>                         seq_puts(m, "binder proc state:\n");
>>                         print_binder_proc(m, itr, 1);
>>                 }
>>         }
>> -       mutex_unlock(&binder_procs_lock);
>> +       mutex_unlock(&ipcns->binder_procs_lock);
>>
>>         return 0;
>>  }
>> @@ -5687,12 +5755,12 @@ static void
>print_binder_transaction_log_entry(struct seq_file *m,
>>          */
>>         smp_rmb();
>>         seq_printf(m,
>> -                  "%d: %s from %d:%d to %d:%d context %s node %d
>handle %d size %d:%d ret %d/%d l=3D%d",
>> +                  "%d: %s from %d:%d to %d:%d ipc %d context %s node
>%d handle %d size %d:%d ret %d/%d l=3D%d",
>>                    e->debug_id, (e->call_type =3D=3D 2) ? "reply" :
>>                    ((e->call_type =3D=3D 1) ? "async" : "call "),
>e->from_proc,
>> -                  e->from_thread, e->to_proc, e->to_thread,
>e->context_name,
>> -                  e->to_node, e->target_handle, e->data_size,
>e->offsets_size,
>> -                  e->return_error, e->return_error_param,
>> +                  e->from_thread, e->to_proc, e->to_thread,
>e->ipc_inum,
>> +                  e->context_name, e->to_node, e->target_handle,
>e->data_size,
>> +                  e->offsets_size, e->return_error,
>e->return_error_param,
>>                    e->return_error_line);
>>         /*
>>          * read-barrier to guarantee read of debug_id_done after
>> @@ -5753,10 +5821,6 @@ static int __init init_binder_device(const
>char *name)
>>         binder_device->miscdev=2Eminor =3D MISC_DYNAMIC_MINOR;
>>         binder_device->miscdev=2Ename =3D name;
>>
>> -       binder_device->context=2Ebinder_context_mgr_uid =3D INVALID_UID=
;
>> -       binder_device->context=2Ename =3D name;
>> -       mutex_init(&binder_device->context=2Econtext_mgr_node_lock);
>> -
>>         ret =3D misc_register(&binder_device->miscdev);
>>         if (ret < 0) {
>>                 kfree(binder_device);
>> @@ -5831,9 +5895,16 @@ static int __init binder_init(void)
>>                 if (ret)
>>                         goto err_init_binder_device_failed;
>>         }
>> +#ifdef CONFIG_IPC_NS
>> +       ret =3D binder_init_ns(&init_ipc_ns);
>> +#else
>> +       ret =3D binder_init_ns(&binder_ipc_ns);
>> +#endif
>> +       if (ret)
>> +               goto err_init_namespace_failed;
>>
>>         return ret;
>> -
>> +err_init_namespace_failed:
>>  err_init_binder_device_failed:
>>         hlist_for_each_entry_safe(device, tmp, &binder_devices,
>hlist) {
>>                 misc_deregister(&device->miscdev);
>> diff --git a/include/linux/ipc_namespace=2Eh
>b/include/linux/ipc_namespace=2Eh
>> index 6ab8c1bada3f=2E=2Ed7f850a2ded8 100644
>> --- a/include/linux/ipc_namespace=2Eh
>> +++ b/include/linux/ipc_namespace=2Eh
>> @@ -63,6 +63,13 @@ struct ipc_namespace {
>>         unsigned int    mq_msg_default;
>>         unsigned int    mq_msgsize_default;
>>
>> +#ifdef CONFIG_ANDROID_BINDER_IPC
>> +       /* next fields are for binder */
>> +       struct mutex      binder_procs_lock;
>> +       struct hlist_head binder_procs;
>> +       struct hlist_head binder_contexts;
>> +#endif
>> +
>>         /* user_ns which owns the ipc ns */
>>         struct user_namespace *user_ns;
>>         struct ucounts *ucounts;
>> @@ -118,6 +125,14 @@ extern int mq_init_ns(struct ipc_namespace *ns);
>>  static inline int mq_init_ns(struct ipc_namespace *ns) { return 0; }
>>  #endif
>>
>> +#ifdef CONFIG_ANDROID_BINDER_IPC
>> +extern int binder_init_ns(struct ipc_namespace *ns);
>> +extern void binder_exit_ns(struct ipc_namespace *ns);
>> +#else
>> +static inline int binder_init_ns(struct ipc_namespace *ns) { return
>0; }
>> +static inline void binder_exit_ns(struct ipc_namespace *ns) { }
>> +#endif
>> +
>>  #if defined(CONFIG_IPC_NS)
>>  extern struct ipc_namespace *copy_ipcs(unsigned long flags,
>>         struct user_namespace *user_ns, struct ipc_namespace *ns);
>> diff --git a/ipc/namespace=2Ec b/ipc/namespace=2Ec
>> index 21607791d62c=2E=2E68c6e983b002 100644
>> --- a/ipc/namespace=2Ec
>> +++ b/ipc/namespace=2Ec
>> @@ -57,7 +57,10 @@ static struct ipc_namespace *create_ipc_ns(struct
>user_namespace *user_ns,
>>
>>         err =3D mq_init_ns(ns);
>>         if (err)
>> -               goto fail_put;
>> +               goto fail_init_mq;
>> +       err =3D binder_init_ns(ns);
>> +       if (err)
>> +               goto fail_init_binder;
>>
>>         sem_init_ns(ns);
>>         msg_init_ns(ns);
>> @@ -65,7 +68,9 @@ static struct ipc_namespace *create_ipc_ns(struct
>user_namespace *user_ns,
>>
>>         return ns;
>>
>> -fail_put:
>> +fail_init_binder:
>> +       mq_put_mnt(ns);
>> +fail_init_mq:
>>         put_user_ns(ns->user_ns);
>>         ns_free_inum(&ns->ns);
>>  fail_free:
>> @@ -120,6 +125,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>>         sem_exit_ns(ns);
>>         msg_exit_ns(ns);
>>         shm_exit_ns(ns);
>> +       binder_exit_ns(ns);
>>
>>         dec_ipc_namespaces(ns->ucounts);
>>         put_user_ns(ns->user_ns);
>> --
>> 2=2E11=2E0


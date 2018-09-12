Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EABC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE14213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MZI/HCSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE14213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeIMEEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:04:08 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37375 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeIMEEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:04:06 -0400
Received: by mail-yb1-f193.google.com with SMTP id f145-v6so2497312ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=saNEh+vSqPfdZdMSAibALB3tt4+r0fzLZ/YwPx3Wwio=;
        b=MZI/HCShk8+0YX/BpxP3/7DxnGe8aTLYnK6q2j3oIehBTBdqV1gBsggM2AaB5wnykf
         njJPi84lb4cFe6nfH2j0RfHHKIx5sxtFCfu5dZ8NfaaWI30TIlBmSMF6JjdFjIOYGz6h
         XzrsuF9PzhJmWcattvVAVsPno7UEPNTzrT7KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=saNEh+vSqPfdZdMSAibALB3tt4+r0fzLZ/YwPx3Wwio=;
        b=mdvgvMS5QDMYvpaspDxwA6L1rjObjtA9dKatuy8rwyfABEuad/Q8MaqUoUx1Zce5/f
         uOUS2NWD6LDrPNSxdzPKe7j13AxCnPod2vYmkraqGRHyQ8fAZpqp1xTYPdt1FYTcP1HI
         XHMIbByCMQORHnjeNCp7eA+BWq2i1TGtiayoCvG2I6d8F62Ekk4xN7BKy+EX96jfXdbN
         /KWytEU8zImme0RQhDx2f9pNdfOer39eEwujUnZC2MI6oIIunxmn4fwRoEQo62Lb1lqm
         ILq86S0xqi0VCnBS3DshyItg0m6+vVesjDB00BjQRk+ssN4yw34lVHp2lMfcgBIDS5Zc
         Kflg==
X-Gm-Message-State: APzg51AHGuaoPHB9FuY3j0KB/5vZdBjdhoBeE6m/e/tw5neyitCwS11b
        WGk7OtXdykNPcWbhIaoOPj3fFFanNfE=
X-Google-Smtp-Source: ANB0VdZe0HKGGcPsRMzJswH5mySoT2Zmg11rqeSQzEXhH7tvzHUdSk/+wiphg4dFIskHGVBJO9QSng==
X-Received: by 2002:a25:4c03:: with SMTP id z3-v6mr2066297yba.156.1536793044927;
        Wed, 12 Sep 2018 15:57:24 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id d21-v6sm1246679ywb.16.2018.09.12.15.57.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 15:57:23 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id m62-v6so397776ywd.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:57:23 -0700 (PDT)
X-Received: by 2002:a81:4e01:: with SMTP id c1-v6mr2197422ywb.237.1536793043085;
 Wed, 12 Sep 2018 15:57:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 15:57:22
 -0700 (PDT)
In-Reply-To: <c43599b8-20f6-0cc6-28d7-abff4c0d0a0d@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com> <c43599b8-20f6-0cc6-28d7-abff4c0d0a0d@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 15:57:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK3ztMtwRed3SmTSMMSbv5UrYBAKuBMDyXuW2ETd3PHxQ@mail.gmail.com>
Message-ID: <CAGXu5jK3ztMtwRed3SmTSMMSbv5UrYBAKuBMDyXuW2ETd3PHxQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] procfs: add smack subdir to attrs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Back in 2007 I made what turned out to be a rather serious
> mistake in the implementation of the Smack security module.
> The SELinux module used an interface in /proc to manipulate
> the security context on processes. Rather than use a similar
> interface, I used the same interface. The AppArmor team did
> likewise. Now /proc/.../attr/current will tell you the
> security "context" of the process, but it will be different
> depending on the security module you're using.
>
> This patch provides a subdirectory in /proc/.../attr for
> Smack. Smack user space can use the "current" file in
> this subdirectory and never have to worry about getting
> SELinux attributes by mistake. Programs that use the
> old interface will continue to work (or fail, as the case
> may be) as before.
>
> The proposed S.A.R.A security module is dependent on
> the mechanism to create its own attr subdirectory.
>
> The original implementation is by Kees Cook.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/admin-guide/LSM/index.rst | 13 +++--
>  fs/proc/base.c                          | 64 +++++++++++++++++++++----
>  fs/proc/internal.h                      |  1 +
>  include/linux/security.h                | 15 ++++--
>  security/security.c                     | 24 ++++++++--
>  5 files changed, 96 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
> index c980dfe9abf1..9842e21afd4a 100644
> --- a/Documentation/admin-guide/LSM/index.rst
> +++ b/Documentation/admin-guide/LSM/index.rst
> @@ -17,9 +17,8 @@ MAC extensions, other extensions can be built using the LSM to provide
>  specific changes to system operation when these tweaks are not available
>  in the core functionality of Linux itself.
>
> -Without a specific LSM built into the kernel, the default LSM will be the
> -Linux capabilities system. Most LSMs choose to extend the capabilities
> -system, building their checks on top of the defined capability hooks.
> +The Linux capabilities modules will always be included. This may be
> +followed by any number of "minor" modules and at most one "major" module.
>  For more details on capabilities, see ``capabilities(7)`` in the Linux
>  man-pages project.
>
> @@ -30,6 +29,14 @@ order in which checks are made. The capability module will always
>  be first, followed by any "minor" modules (e.g. Yama) and then
>  the one "major" module (e.g. SELinux) if there is one configured.
>
> +Process attributes associated with "major" security modules should
> +be accessed and maintained using the special files in ``/proc/.../attr``.
> +A security module may maintain a module specific subdirectory there,
> +named after the module. ``/proc/.../attr/smack`` is provided by the Smack
> +security module and contains all its special files. The files directly
> +in ``/proc/.../attr`` remain as legacy interfaces for modules that provide
> +subdirectories.
> +
>  .. toctree::
>     :maxdepth: 1
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ccf86f16d9f0..bd2dd85310fe 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -140,9 +140,13 @@ struct pid_entry {
>  #define REG(NAME, MODE, fops)                          \
>         NOD(NAME, (S_IFREG|(MODE)), NULL, &fops, {})
>  #define ONE(NAME, MODE, show)                          \
> -       NOD(NAME, (S_IFREG|(MODE)),                     \
> +       NOD(NAME, (S_IFREG|(MODE)),                     \
>                 NULL, &proc_single_file_operations,     \
>                 { .proc_show = show } )
> +#define ATTR(LSM, NAME, MODE)                          \
> +       NOD(NAME, (S_IFREG|(MODE)),                     \
> +               NULL, &proc_pid_attr_operations,        \
> +               { .lsm = LSM })
>
>  /*
>   * Count the number of hardlinks for the pid_entry table, excluding the .
> @@ -2503,7 +2507,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
>         if (!task)
>                 return -ESRCH;
>
> -       length = security_getprocattr(task,
> +       length = security_getprocattr(task, PROC_I(inode)->op.lsm,
>                                       (char*)file->f_path.dentry->d_name.name,
>                                       &p);
>         put_task_struct(task);
> @@ -2552,7 +2556,9 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>         if (rv < 0)
>                 goto out_free;
>
> -       rv = security_setprocattr(file->f_path.dentry->d_name.name, page, count);
> +       rv = security_setprocattr(PROC_I(inode)->op.lsm,
> +                                 file->f_path.dentry->d_name.name, page,
> +                                 count);
>         mutex_unlock(&current->signal->cred_guard_mutex);
>  out_free:
>         kfree(page);
> @@ -2566,13 +2572,53 @@ static const struct file_operations proc_pid_attr_operations = {
>         .llseek         = generic_file_llseek,
>  };
>
> +#define LSM_DIR_OPS(LSM) \
> +static int proc_##LSM##_attr_dir_iterate(struct file *filp, \
> +                            struct dir_context *ctx) \
> +{ \
> +       return proc_pident_readdir(filp, ctx, \
> +                                  LSM##_attr_dir_stuff, \
> +                                  ARRAY_SIZE(LSM##_attr_dir_stuff)); \
> +} \
> +\
> +static const struct file_operations proc_##LSM##_attr_dir_ops = { \
> +       .read           = generic_read_dir, \
> +       .iterate        = proc_##LSM##_attr_dir_iterate, \
> +       .llseek         = default_llseek, \
> +}; \
> +\
> +static struct dentry *proc_##LSM##_attr_dir_lookup(struct inode *dir, \
> +                               struct dentry *dentry, unsigned int flags) \
> +{ \
> +       return proc_pident_lookup(dir, dentry, \
> +                                 LSM##_attr_dir_stuff, \
> +                                 ARRAY_SIZE(LSM##_attr_dir_stuff)); \
> +} \
> +\
> +static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
> +       .lookup         = proc_##LSM##_attr_dir_lookup, \
> +       .getattr        = pid_getattr, \
> +       .setattr        = proc_setattr, \
> +}
> +
> +#ifdef CONFIG_SECURITY_SMACK
> +static const struct pid_entry smack_attr_dir_stuff[] = {
> +       ATTR("smack", "current",        0666),
> +};
> +LSM_DIR_OPS(smack);
> +#endif
> +
>  static const struct pid_entry attr_dir_stuff[] = {
> -       REG("current",    S_IRUGO|S_IWUGO, proc_pid_attr_operations),
> -       REG("prev",       S_IRUGO,         proc_pid_attr_operations),
> -       REG("exec",       S_IRUGO|S_IWUGO, proc_pid_attr_operations),
> -       REG("fscreate",   S_IRUGO|S_IWUGO, proc_pid_attr_operations),
> -       REG("keycreate",  S_IRUGO|S_IWUGO, proc_pid_attr_operations),
> -       REG("sockcreate", S_IRUGO|S_IWUGO, proc_pid_attr_operations),
> +       ATTR(NULL, "current",           0666),
> +       ATTR(NULL, "prev",              0444),
> +       ATTR(NULL, "exec",              0666),
> +       ATTR(NULL, "fscreate",          0666),
> +       ATTR(NULL, "keycreate",         0666),
> +       ATTR(NULL, "sockcreate",        0666),
> +#ifdef CONFIG_SECURITY_SMACK
> +       DIR("smack",                    0555,
> +           proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> +#endif
>  };
>
>  static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 5185d7f6a51e..d4f9989063d0 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -81,6 +81,7 @@ union proc_op {
>         int (*proc_show)(struct seq_file *m,
>                 struct pid_namespace *ns, struct pid *pid,
>                 struct task_struct *task);
> +       const char *lsm;
>  };
>
>  struct proc_inode {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 75f4156c84d7..418de5d20ffb 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -390,8 +390,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
>  int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>                         unsigned nsops, int alter);
>  void security_d_instantiate(struct dentry *dentry, struct inode *inode);
> -int security_getprocattr(struct task_struct *p, char *name, char **value);
> -int security_setprocattr(const char *name, void *value, size_t size);
> +int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
> +                        char **value);
> +int security_setprocattr(const char *lsm, const char *name, void *value,
> +                        size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> @@ -1139,15 +1141,18 @@ static inline int security_sem_semop(struct kern_ipc_perm *sma,
>         return 0;
>  }
>
> -static inline void security_d_instantiate(struct dentry *dentry, struct inode *inode)
> +static inline void security_d_instantiate(struct dentry *dentry,
> +                                         struct inode *inode)
>  { }
>
> -static inline int security_getprocattr(struct task_struct *p, char *name, char **value)
> +static inline int security_getprocattr(struct task_struct *p, const char *lsm,
> +                                      char *name, char **value)
>  {
>         return -EINVAL;
>  }
>
> -static inline int security_setprocattr(char *name, void *value, size_t size)
> +static inline int security_setprocattr(const char *lsm, char *name,
> +                                      void *value, size_t size)
>  {
>         return -EINVAL;
>  }
> diff --git a/security/security.c b/security/security.c
> index 736e78da1ab9..3dfe75d0d373 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1288,14 +1288,30 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>
> -int security_getprocattr(struct task_struct *p, char *name, char **value)
> +int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
> +                               char **value)
>  {
> -       return call_int_hook(getprocattr, -EINVAL, p, name, value);
> +       struct security_hook_list *hp;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> +               if (lsm != NULL && strcmp(lsm, hp->lsm))
> +                       continue;
> +               return hp->hook.getprocattr(p, name, value);
> +       }

Walking this list to do strcmp() makes my eye twitch. ;) I see that
procfs doesn't let us do a late evaluation and attr_dir_stuff is
const. We already have security_initcall() exporting a per-LSM
function, why not expand this slightly to include enough information
that we could resolve all this at build time?

Anyway, I view that as a potential improvement, and not something that
should block this. So:

Reviewed-by: Kees Cook <keescook@chromium.org>

> +       return -EINVAL;
>  }
>
> -int security_setprocattr(const char *name, void *value, size_t size)
> +int security_setprocattr(const char *lsm, const char *name, void *value,
> +                        size_t size)
>  {
> -       return call_int_hook(setprocattr, -EINVAL, name, value, size);
> +       struct security_hook_list *hp;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> +               if (lsm != NULL && strcmp(lsm, hp->lsm))
> +                       continue;
> +               return hp->hook.setprocattr(name, value, size);
> +       }
> +       return -EINVAL;
>  }
>
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb)
> --
> 2.17.1
>
>



-- 
Kees Cook
Pixel Security

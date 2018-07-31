Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81AF2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pIGdfLzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81AF2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbeGaXsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:48:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34582 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731484AbeGaXsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=02I1lDV20N4OrFRRAZ43YLAf17Cd+2CkBk49sL6aBH4=; b=pIGdfLzb8qGbS2rIecmpOooaxh
        vSePYkdY+iD8dXDzMUg5Dttt2+1tWPVMRQVlYHATe16AOXhlmeylT4fYr8F1nPq6iGSzTxuUhFh8l
        fuU3Ai3I1AhM3ZAaJy/gkIMhZsbzrUDJbYomqN5H3DkAlNA5XcM29FbMSiwlRIuk4+Fq/dpaei183
        mY0il007cvUtfTzsq/5U60J5Wvz1tsgMZKb4S3sdnb8iS1kjc8IoVtjJvWSD2MYXyWmxedLczjaEh
        B6kR+/aFIvw5gRBSFqrnHvmwzGG19jL/+0TlWTloAFTlo2NVomUIdzGcbP6Cy08vRJXJBqYk/Jr9e
        5YUtOODA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkcmO-0000Tn-4n; Tue, 31 Jul 2018 22:06:08 +0000
Subject: Re: [PATCH v2] security: Add LSM fixup hooks to set*gid syscalls.
To:     Micah Morton <mortonm@chromium.org>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
References: <CAJ-EccNNCNrA7to85WrYFjRUP7Z1XC+sJ2JXkargiEvXd11AVg@mail.gmail.com>
 <alpine.LRH.2.21.1808010608080.8072@namei.org>
 <CAJ-EccOMdg370kMfU2=gMbSEyOE3sRVLpca86BHgr+i0_C=J9Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a5ce4d5d-833f-8994-9070-df0e587e5023@infradead.org>
Date:   Tue, 31 Jul 2018 15:06:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ-EccOMdg370kMfU2=gMbSEyOE3sRVLpca86BHgr+i0_C=J9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 02:47 PM, Micah Morton wrote:
> The ChromiumOS LSM used by ChromeOS will provide a hook for this, in
> order to enforce ChromeOS-specific policies regarding which UIDs/GIDs a
> process with CAP_SET{UID/GID} can transition to. The
> security_task_fix_setuid LSM hook is very helpful in enabling such a feature
> for ChromeOS that governs UID transitions, but unfortunately for us it looks
> like the equivalent hook that would allow us to govern GID transitions from an
> LSM never got added.
> 
> Resending with plain text mode enabled.
> 
> ---
> 
> The set*uid system calls all call an LSM fixup hook called
> security_task_fix_setuid, which allows for altering the behavior of those
> calls by a security module. Comments explaining the LSM_SETID_* constants
> in /include/linux/security.h imply that the constants are to be used for
> both the set*uid and set*gid syscalls, but the set*gid syscalls do not
> have the relevant hooks, meaning a security module can only alter syscalls
> that change user identity attributes but not ones that change group
> identity attributes. This patch adds the necessary LSM hook, called
> security_task_fix_setgid, and calls the hook from the appropriate places
> in the set*gid syscalls.Tested by putting a print statement in the hook and
> seeing it triggered from the various set*gid syscalls.
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> Acked-by: Kees Cook <keescook@chromium.org>
> ---
> NOTE: the security_task_fix_setgid line in sys_setfsgid is over 80
> characters, but I figured I'd just follow how it was done in sys_setfsuid
> rather than trying to wrap the line, since the functions are nearly
> identical.
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 8f1131c8dd54..a2166c812a97 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -599,6 +599,15 @@
>   * @old is the set of credentials that are being replaces
>   * @flags contains one of the LSM_SETID_* values.
>   * Return 0 on success.
> + * @task_fix_setgid:
> + *     Update the module's state after setting one or more of the group
> + *     identity attributes of the current process.  The @flags parameter
> + *     indicates which of the set*gid system calls invoked this hook.
> + *     @new is the set of credentials that will be installed.  Modifications
> + *     should be made to this rather than to @current->cred.
> + *     @old is the set of credentials that are being replaced
> + *     @flags contains one of the LSM_SETID_* values.
> + *     Return 0 on success.
>   * @task_setpgid:
>   * Check permission before setting the process group identifier of the
>   * process @p to @pgid.
> @@ -1587,6 +1596,8 @@ union security_list_options {
>        enum kernel_read_file_id id);
>   int (*task_fix_setuid)(struct cred *new, const struct cred *old,
>   int flags);
> + int (*task_fix_setgid)(struct cred *new, const struct cred *old,
> + int flags);
>   int (*task_setpgid)(struct task_struct *p, pid_t pgid);
>   int (*task_getpgid)(struct task_struct *p);
>   int (*task_getsid)(struct task_struct *p);
> @@ -1876,6 +1887,7 @@ struct security_hook_heads {
>   struct hlist_head kernel_post_read_file;
>   struct hlist_head kernel_module_request;
>   struct hlist_head task_fix_setuid;
> + struct hlist_head task_fix_setgid;
>   struct hlist_head task_setpgid;
>   struct hlist_head task_getpgid;
>   struct hlist_head task_getsid;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 63030c85ee19..a82d97cf13ab 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -325,6 +325,8 @@ int security_kernel_post_read_file(struct file
> *file, char *buf, loff_t size,
>      enum kernel_read_file_id id);
>  int security_task_fix_setuid(struct cred *new, const struct cred *old,
>        int flags);
> +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> +      int flags);
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
>  int security_task_getpgid(struct task_struct *p);
>  int security_task_getsid(struct task_struct *p);
> @@ -929,6 +931,13 @@ static inline int security_task_fix_setuid(struct
> cred *new,
>   return cap_task_fix_setuid(new, old, flags);
>  }
> 
> +static inline int security_task_fix_setgid(struct cred *new,
> +    const struct cred *old,
> +    int flags)
> +{
> + return 0;
> +}
> +
>  static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>   return 0;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 38509dc1f77b..f6ef922c6815 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -392,6 +392,10 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>   new->sgid = new->egid;
>   new->fsgid = new->egid;
> 
> + retval = security_task_fix_setgid(new, old, LSM_SETID_RE);
> + if (retval < 0)
> + goto error;
> +
>   return commit_creds(new);
> 
>  error:
> @@ -434,6 +438,10 @@ long __sys_setgid(gid_t gid)
>   else
>   goto error;
> 
> + retval = security_task_fix_setgid(new, old, LSM_SETID_ID);
> + if (retval < 0)
> + goto error;
> +
>   return commit_creds(new);
> 
>  error:
> @@ -755,6 +763,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
>   new->sgid = ksgid;
>   new->fsgid = new->egid;
> 
> + retval = security_task_fix_setgid(new, old, LSM_SETID_RES);
> + if (retval < 0)
> + goto error;
> +
>   return commit_creds(new);
> 
>  error:
> @@ -861,7 +873,8 @@ long __sys_setfsgid(gid_t gid)
>       ns_capable(old->user_ns, CAP_SETGID)) {
>   if (!gid_eq(kgid, old->fsgid)) {
>   new->fsgid = kgid;
> - goto change_okay;
> + if (security_task_fix_setgid(new, old, LSM_SETID_FS) == 0)
> + goto change_okay;
>   }
>   }
> 
> diff --git a/security/security.c b/security/security.c
> index 68f46d849abe..587786fc0aaa 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1062,6 +1062,12 @@ int security_task_fix_setuid(struct cred *new,
> const struct cred *old,
>   return call_int_hook(task_fix_setuid, 0, new, old, flags);
>  }
> 
> +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> +      int flags)
> +{
> + return call_int_hook(task_fix_setgid, 0, new, old, flags);
> +}
> +
>  int security_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>   return call_int_hook(task_setpgid, 0, p, pgid);
> 
> --
> 4.18-rc2
> 
> --
> 
> On Tue, Jul 31, 2018 at 1:09 PM James Morris <jmorris@namei.org> wrote:
>>
>> On Tue, 31 Jul 2018, Micah Morton wrote:
>>
>>> +static inline int security_task_fix_setgid(struct cred *new,
>>> +    const struct cred *old,
>>> +    int flags)
>>> +{
>>> + return 0;
>>> +}
>>> +
>>
>> This looks whitespace-damaged.  Please send patches as plain text.

Still is ...

-- 
~Randy

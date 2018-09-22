Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D5C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690602156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YccBqdSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690602156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeIVIrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:47:37 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41290 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeIVIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:47:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id d14-v6so1173093ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6otO7SLkDvex97TB+xRMF+IJbcpWNmBJ4hGZwL+OQew=;
        b=YccBqdSapR/dFUqYjiwr8px7VDnwNQwyVF9KxRQGQE6uscHqvhEbbxROoJZIpeFDNs
         lWDOdA/TbgHkkJAC90iFKEh7N3x7HyezHT5nmCbpNY5SZt3t/j3O4LXysOSY0vMV9CeH
         bTLKyzlTz/pH3+B6Isb3HLA6Up2yisQ9q8UAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6otO7SLkDvex97TB+xRMF+IJbcpWNmBJ4hGZwL+OQew=;
        b=NL3Uya+IQMQ3AClmjeVAQhQgZb/a06HYJvgIsUlF/qtZU1N3kOmIfYt3k6JQ5g7m4/
         Cp58fMQSgVlFltjNOHp+6UUDi6u71UOuCibmO2lkbbpxGSzmc4RT/cVTplIyovXqSkEQ
         tYdLKfwkfk9tFD6GTf0FjGUo69XSvOz+FLrtKNDgu7QJ4wWmLx7M7zG+3UxVGupd+KZY
         Un2JQbHXw+MXZVZfBfvOyj18MTgfYcNkxTjnEWvs++DULZ/evnQc79a5KwjFGTiKP0fU
         RAW/JwwsowxNAgi4oqx5MIt3mvujprFDcuKCS3Ci5qiFGinjddR1dn2ozgs64P8BDpcg
         uJcw==
X-Gm-Message-State: ABuFfogDhCxQKGXTn3w/srGe2buXiWrPdqhHqWEjrZCHnrR+pqU62a46
        pjNZDB4EPt7vuyTV1SPCbfCgU5Y5U3g=
X-Google-Smtp-Source: ACcGV63C7ZVLh0NFy0rn33x4Et7TOJTQ1lxjaMi3mT6Z2NfmT44mjgxj2r649Z0YEctJqb0zldS1ww==
X-Received: by 2002:a25:cd83:: with SMTP id d125-v6mr219397ybf.353.1537584945058;
        Fri, 21 Sep 2018 19:55:45 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id j6-v6sm5140045ywe.107.2018.09.21.19.55.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:55:42 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id b3-v6so5207599yba.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:55:42 -0700 (PDT)
X-Received: by 2002:a25:249:: with SMTP id 70-v6mr211900ybc.421.1537584941733;
 Fri, 21 Sep 2018 19:55:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:55:41
 -0700 (PDT)
In-Reply-To: <f24ab6a2-aa1d-1c36-9e51-22c924ad37e5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <f24ab6a2-aa1d-1c36-9e51-22c924ad37e5@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:55:41 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL1Ek85Hky+PZ2pGQF09_cd_odn-LanYU=vVKgw24b8vg@mail.gmail.com>
Message-ID: <CAGXu5jL1Ek85Hky+PZ2pGQF09_cd_odn-LanYU=vVKgw24b8vg@mail.gmail.com>
Subject: Re: [PATCH v4 14/19] LSM: Infrastructure management of the inode security
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the inode->i_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  3 ++
>  security/security.c               | 83 ++++++++++++++++++++++++++++++-
>  security/selinux/hooks.c          | 32 +-----------
>  security/selinux/include/objsec.h |  5 +-
>  security/smack/smack_lsm.c        | 70 ++++----------------------
>  5 files changed, 98 insertions(+), 95 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 167ffbd4d0c0..416b20c3795b 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2030,6 +2030,7 @@ struct security_hook_list {
>  struct lsm_blob_sizes {
>         int     lbs_cred;
>         int     lbs_file;
> +       int     lbs_inode;
>  };
>
>  /*
> @@ -2092,9 +2093,11 @@ static inline void loadpin_add_hooks(void) { };
>  #endif
>
>  extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
> +extern int lsm_inode_alloc(struct inode *inode);
>
>  #ifdef CONFIG_SECURITY
>  void lsm_early_cred(struct cred *cred);
> +void lsm_early_inode(struct inode *inode);
>  #endif
>
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index 5430cae73cf6..a8f00fdff4d8 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -41,6 +41,7 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>
>  static struct kmem_cache *lsm_file_cache;
> +static struct kmem_cache *lsm_inode_cache;
>
>  char *lsm_names;
>  static struct lsm_blob_sizes blob_sizes;
> @@ -101,6 +102,10 @@ int __init security_init(void)
>                 lsm_file_cache = kmem_cache_create("lsm_file_cache",
>                                                    blob_sizes.lbs_file, 0,
>                                                    SLAB_PANIC, NULL);
> +       if (blob_sizes.lbs_inode)
> +               lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
> +                                                   blob_sizes.lbs_inode, 0,
> +                                                   SLAB_PANIC, NULL);
>         /*
>          * The second call to a module specific init function
>          * adds hooks to the hook lists and does any other early
> @@ -111,6 +116,7 @@ int __init security_init(void)
>  #ifdef CONFIG_SECURITY_LSM_DEBUG
>         pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
>         pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
> +       pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
>  #endif
>
>         return 0;
> @@ -288,6 +294,13 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
>  {
>         lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
>         lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
> +       /*
> +        * The inode blob gets an rcu_head in addition to
> +        * what the modules might need.
> +        */
> +       if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
> +               blob_sizes.lbs_inode = sizeof(struct rcu_head);
> +       lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>  }
>
>  /**
> @@ -311,6 +324,46 @@ int lsm_file_alloc(struct file *file)
>         return 0;
>  }
>
> +/**
> + * lsm_inode_alloc - allocate a composite inode blob
> + * @inode: the inode that needs a blob
> + *
> + * Allocate the inode blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +int lsm_inode_alloc(struct inode *inode)
> +{
> +       if (!lsm_inode_cache) {
> +               inode->i_security = NULL;
> +               return 0;
> +       }
> +
> +       inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
> +       if (inode->i_security == NULL)
> +               return -ENOMEM;
> +       return 0;
> +}
> +
> +/**
> + * lsm_early_inode - during initialization allocate a composite inode blob
> + * @inode: the inode that needs a blob
> + *
> + * Allocate the inode blob for all the modules if it's not already there
> + */
> +void lsm_early_inode(struct inode *inode)
> +{
> +       int rc;
> +
> +       if (inode == NULL)
> +               panic("%s: NULL inode.\n", __func__);
> +       if (inode->i_security != NULL)
> +               return;
> +       rc = lsm_inode_alloc(inode);
> +       if (rc)
> +               panic("%s: Early inode alloc failed.\n", __func__);
> +}

I'm still advising against using panic(), but I'll leave it up to James.

For everything else here:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security

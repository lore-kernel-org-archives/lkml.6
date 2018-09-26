Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172BCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FA721527
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FR0Ghs+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FA721527
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeI0Dl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:41:29 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32853 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeI0Dl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:41:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id a203-v6so428194oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IzDJ/eoB3sTyWNTakhTU9+r1jnTZKswEG10kzHhshw=;
        b=FR0Ghs+zp/iZrHCo0Oo60kuoseSEMFFE84jpEMw3bfW+U/yo1kNkshv3KmpapgDELB
         xAp7nzB+/aHkv4VWggcBW64GIesXoILuLLNkwnGQCoG6KfhEJvVFLFVD5tzis8XH7CRx
         sgKiIfV6QNTbxH7x+0HM5ePIqloQ4hzdZ4q7YjXIXt1CHmFJ9zXhs5SNrKC9/4HePt3l
         i37KefXvnS4UY/yMNCeWk+OEjjEAZ+g7jaDy/OaqaPKNa6RuhN8wywiLjHf+qVh1zOhB
         axDiu5WfKYG3ARw71MyiRPLRV2QMTnya8OXwCdbRwRvVPEH0Ume46WTOGuYYvUxfsick
         M+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IzDJ/eoB3sTyWNTakhTU9+r1jnTZKswEG10kzHhshw=;
        b=Fs1Qv0GrZSQqtqpRqMHaCdv6Zcphu76AZaf4kzA0qZr2BK900JbAyOCRJk63GgNsx/
         D/ldq+WEAsbwSWr7Zmt1NP01+0O9IsHfHbAFodxhJA4+xiY5BjzW9cgHbXphQ20Cp4ox
         nRed13YpFCABBPBiKFEK34yyAxfanrpPrILLxZ5XK1KsPdeulGjE5vGcGItr98BQyxGp
         dXYIHrwIBseMLj8D95d/KlZiGsqDkhBsHPRmkUBWYe8EFgssxX4B8m0J7rfhWzyBbs/a
         fTszHP9DrYy5iPzyFO0CtnZkI3Rslw5gOrg4HzPdxUeiLeV1Gre7fY40nFnzAb2fkig5
         kMHQ==
X-Gm-Message-State: ABuFfogV26iKlFzYknGO5ChgPuzkHV2tckK/C6ma3G8aKiu+7Qh8TbyH
        uoFS+VefYLThA4XuFmaSsfhEfwuz+iIcRMY9fPnGjQ==
X-Google-Smtp-Source: ACcGV60yBL9EiML69+Eio5i/m6ajQNQwshAh5Jm6BSi5LanOOLLpKV6zB7bkHXz9/MsxDfalxVlR0alw8EEG6JeSags=
X-Received: by 2002:aca:d513:: with SMTP id m19-v6mr1792292oig.82.1537997193569;
 Wed, 26 Sep 2018 14:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180926203446.2004-1-casey.schaufler@intel.com> <20180926203446.2004-5-casey.schaufler@intel.com>
In-Reply-To: <20180926203446.2004-5-casey.schaufler@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Sep 2018 23:26:07 +0200
Message-ID: <CAG48ez1NqoW8bByrYe30MdyCn2th3X+tth=VhMHA2MA-PoaQVw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] Capability: Complete PTRACE_MODE_SCHED
To:     Casey Schaufler <casey.schaufler@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:35 PM Casey Schaufler
<casey.schaufler@intel.com> wrote:
> Allow a complete ptrace access check with mode PTRACE_MODE_SCHED.
> Disable the inappropriate privilege check in the capability code
> that does incompatible locking.

What's that locking you're talking about?

> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>  kernel/ptrace.c      | 2 --
>  security/commoncap.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 99cfddde6a55..0b6a9df51c3b 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -331,8 +331,6 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
>              !ptrace_has_cap(mm->user_ns, mode)))
>             return -EPERM;
>
> -       if (mode & PTRACE_MODE_SCHED)
> -               return 0;
>         return security_ptrace_access_check(task, mode);
>  }
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 2e489d6a3ac8..e77457110d05 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -152,6 +152,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
>         if (cred->user_ns == child_cred->user_ns &&
>             cap_issubset(child_cred->cap_permitted, *caller_caps))
>                 goto out;
> +       if (mode & PTRACE_MODE_SCHED)
> +               goto out;

So for PTRACE_MODE_SCHED, this function always returns 0, right? If
that's intentional, perhaps you should instead just put "if (mode &
PTRACE_MODE_SCHED) return 0;" at the start of the function, to avoid
taking the RCU read lock in this case.

>         if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
>                 goto out;
>         ret = -EPERM;

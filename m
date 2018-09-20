Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8956FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4332A21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LFuyo+qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4332A21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbeITXlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:41:14 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37562 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbeITXlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:41:13 -0400
Received: by mail-yb1-f194.google.com with SMTP id b3-v6so3241715yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kn50+P8/uP7dtkuW3PKZfNCNCBS/4I7LKjfU27Vk4I4=;
        b=LFuyo+qeViShYCLyi4wjbO9y3+EGDm+r2zHR9S6ztMhgLksrUwvI8zT7dqyiLn/ASh
         v8qu2nGR7r/FbU+s4koDRoF8/1USHyiAA2+3nv9qxXa9WF5AaAHiueQoKjQ3fqZNiVaK
         gaYqnB3qaO6mUGMGGLJcTMiqjSKsxfQubd7Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kn50+P8/uP7dtkuW3PKZfNCNCBS/4I7LKjfU27Vk4I4=;
        b=GPiq/nVRybVbAstj8tISjThQYTJoSh8WZ2ZvaG1uIdtD2Mrl15gfngvqM7Fzwfy8Rx
         R5v4f853unSewT761j2njTvhAOUUs2YwVrhC3bLC29npx8K1BCfVLUN2v3iP7rYOfKqH
         PhXiHM/gIa8os1WLq4PuyvgHdYEB8FUVbKR+7aXYAAzZvxhKl5BaE1VNsq+drvWN4R5A
         B2To7XixO2mUagyHV3T9JTcxGTGOnO0IBwZqI2i9aEdgWZHLcn2XpZ38Z+NsDddAvvhZ
         DTxJUVlO1BGuUzVZaQhWerkDw9KfIPLq/4bH1i/K2aN8/9MNWqUstfI+m1/NiSNtooWj
         ESCw==
X-Gm-Message-State: APzg51DBaRflTKh8x74YFY5svksfIuKq8z5XuWM9i50+kjkUmcc9XV6j
        5kB/A81EJWcy2PJ+ug+34JqlOIKSYYc=
X-Google-Smtp-Source: ANB0Vda9f2wG8bKIt+gjCmdfcNCek6zcgHNcRUpXv9ycXThSaODlM2suZNfrl81cQVu7zk9G0UgHOA==
X-Received: by 2002:a25:5507:: with SMTP id j7-v6mr13541362ybb.133.1537466193550;
        Thu, 20 Sep 2018 10:56:33 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id z193-v6sm4479396ywd.90.2018.09.20.10.56.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:56:31 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id l9-v6so4105057ywc.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:56:30 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr2763603ywi.288.1537466190637;
 Thu, 20 Sep 2018 10:56:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 10:56:30
 -0700 (PDT)
In-Reply-To: <8ef63a94-c7b6-226d-2d60-a05f79406819@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com> <8ef63a94-c7b6-226d-2d60-a05f79406819@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 10:56:30 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+aWyiQ_aGCkeoyvYC7Aj2hfuvKei+SAOMrfOWyfpP8xw@mail.gmail.com>
Message-ID: <CAGXu5j+aWyiQ_aGCkeoyvYC7Aj2hfuvKei+SAOMrfOWyfpP8xw@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] LSM: Blob sharing support for S.A.R.A and LandLock
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

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8f3b809d7c26..0156ffea7f8c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3475,18 +3475,16 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>  {
>         struct smack_known *skp = smk_of_task_struct(p);
>         char *cp;
> -       int slen;
>
> -       if (strcmp(name, "current") != 0)
> +       if (strcmp(name, "current") == 0) {
> +               cp = kstrdup(skp->smk_known, GFP_KERNEL);
> +               if (cp == NULL)
> +                       return -ENOMEM;
> +       } else
>                 return -EINVAL;
>
> -       cp = kstrdup(skp->smk_known, GFP_KERNEL);
> -       if (cp == NULL)
> -               return -ENOMEM;
> -
> -       slen = strlen(cp);
>         *value = cp;
> -       return slen;
> +       return strlen(cp);
>  }

This should be separate: it looks like unrelated refactoring? (I
mentioned this before, I think?)

> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 0110bebe86e2..f386f92c57c5 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -1216,8 +1221,13 @@ static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
>   */
>  static inline struct tomoyo_domain_info *tomoyo_domain(void)
>  {
> -       struct tomoyo_domain_info **blob = tomoyo_cred(current_cred());
> +       const struct cred *cred = current_cred();
> +       struct tomoyo_domain_info **blob;
> +
> +       if (cred->security == NULL)
> +               return NULL;
>
> +       blob = tomoyo_cred(cred);
>         return *blob;
>  }

I think this is another lost hunk?

-Kees

-- 
Kees Cook
Pixel Security

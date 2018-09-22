Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF41ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363E121569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BM/5Cfk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363E121569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeIVIfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:35:10 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40671 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeIVIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:35:10 -0400
Received: by mail-yw1-f68.google.com with SMTP id z143-v6so5967803ywa.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a1F0qMtQnaSQ4BfN2Qd8tviFqAlyz5lbDnvZV34+gUo=;
        b=BM/5Cfk2qrNn84jZfLGUdsyZFRgHFODpIoox+FDgW9BOqRBcQ2W+l6EnOR0BNL6K6y
         iw5d0eYuPLKP+iTg6ebN5ySWubyZhP27lWlMX7oa/OWBTASh4mWPIjxpFI3x+69he39z
         Ypj1PEr6Bo3A6GBtIhLMwKETo+V36qWXtbpP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a1F0qMtQnaSQ4BfN2Qd8tviFqAlyz5lbDnvZV34+gUo=;
        b=ldLuy+1aeINS4aBcn4YhWHbKWsSralLV9eNrlRGUkq6w7v02Gbot/mEucPnMotCCXC
         a9Ff5KkFdeDscXwa1+7Oe4fpqBdoOO5XvAmiorXqMAeP42HWBmpyyx63k4MHDSTOpSmX
         D89JcSpPK+MzZe3wFW1DQY0TOj6YbY9ifo4DP8S0tWTy1njWbsbQY9p6yOoNayjjpXp5
         C4alkaOT2nmFaElUQh8+/tDxQUInLCOEHeKEmTTg+baVfNuMc59Pv5eZFnH2uMJjRoB0
         ztim6cjwaDIPRywVhw6VUdV0dXAgo5IUCrT8AgkNyS1mlKEFWEK+zYWj7PjBquhCwL+x
         E5EA==
X-Gm-Message-State: ABuFfoiciV9eztCWSnTa0PhXrpMJlPQKg/xJ5JIMD9veeby7+CGUv5mX
        68qqvDr8a+FGA1S7c1T57jq0pHF+kBQ=
X-Google-Smtp-Source: ANB0VdZTxtJj065jCHkH3fG3f2Qukivlld/ybk2t+6RUr1m4QUgFFxrxzvcPowkWSRNoBcdbq/C1kQ==
X-Received: by 2002:a0d:ed47:: with SMTP id w68-v6mr178164ywe.479.1537584200954;
        Fri, 21 Sep 2018 19:43:20 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id j66-v6sm5308895ywc.61.2018.09.21.19.43.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:43:19 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id d193-v6so3096905ywb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:43:18 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr189732ywg.47.1537584198385;
 Fri, 21 Sep 2018 19:43:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:43:16
 -0700 (PDT)
In-Reply-To: <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:43:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+9w-+i2F3-w=5QRzNEC1QaF_nwSZRgdLk+M4LpwmZ2Qg@mail.gmail.com>
Message-ID: <CAGXu5j+9w-+i2F3-w=5QRzNEC1QaF_nwSZRgdLk+M4LpwmZ2Qg@mail.gmail.com>
Subject: Re: [PATCH v4 04/19] SELinux: Remove cred security blob poisoning
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

On Fri, Sep 21, 2018 at 5:17 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> The SELinux specific credential poisioning only makes sense
> if SELinux is managing the credentials. As the intent of this
> patch set is to move the blob management out of the modules
> and into the infrastructure, the SELinux specific code has
> to go. The poisioning could be introduced into the infrastructure
> at some later date.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees


> ---
>  kernel/cred.c            | 13 -------------
>  security/selinux/hooks.c |  6 ------
>  2 files changed, 19 deletions(-)
>
> diff --git a/kernel/cred.c b/kernel/cred.c
> index ecf03657e71c..fa2061ee4955 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -704,19 +704,6 @@ bool creds_are_invalid(const struct cred *cred)
>  {
>         if (cred->magic != CRED_MAGIC)
>                 return true;
> -#ifdef CONFIG_SECURITY_SELINUX
> -       /*
> -        * cred->security == NULL if security_cred_alloc_blank() or
> -        * security_prepare_creds() returned an error.
> -        */
> -       if (selinux_is_enabled() && cred->security) {
> -               if ((unsigned long) cred->security < PAGE_SIZE)
> -                       return true;
> -               if ((*(u32 *)cred->security & 0xffffff00) ==
> -                   (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
> -                       return true;
> -       }
> -#endif
>         return false;
>  }
>  EXPORT_SYMBOL(creds_are_invalid);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9d6cdd21acb6..80614ca25a2b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3920,12 +3920,6 @@ static void selinux_cred_free(struct cred *cred)
>  {
>         struct task_security_struct *tsec = selinux_cred(cred);
>
> -       /*
> -        * cred->security == NULL if security_cred_alloc_blank() or
> -        * security_prepare_creds() returned an error.
> -        */
> -       BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
> -       cred->security = (void *) 0x7UL;
>         kfree(tsec);
>  }
>
> --
> 2.17.1
>
>



-- 
Kees Cook
Pixel Security

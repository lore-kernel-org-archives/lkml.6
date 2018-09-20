Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821FEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8C921525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d2dsvaH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8C921525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbeITXar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:30:47 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46304 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbeITXar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:30:47 -0400
Received: by mail-yb1-f196.google.com with SMTP id y20-v6so4264477ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TmVTWGLR76QMk3tEBw6+PmkwH+fQBCY6/OJW1HryIuo=;
        b=d2dsvaH5EjOQFR+qqUuIxG0t3k2AVb5OqMPtEr1ED8QFd/JqF17z1255Va+DCvi1E8
         Kp8PLlCLHu2uTIzq94udIzkX2nMyw+kns8P98HWSZQ33CvrFjVGybM1hGHYhyGobYK9s
         8LrArBtcT5i6xSIJsZ7lNHMLB7TKHq0WCqZag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TmVTWGLR76QMk3tEBw6+PmkwH+fQBCY6/OJW1HryIuo=;
        b=DModg9Kl8ucM+u7h1scL8mROXDyOJMgHhTwty8+ktEX+z3Xg9BK2f5QUcaFOWZBGP4
         Vek8pApUywsSn6DT2CF83pw7SaTb3+wSVaWRt4WUtCv23TIWPkgVkrMuV3Z6M6rWFKun
         wuAgfcJEv8wpxYRnU2NF2EdccQTpuA+1i5h83DD9/y/5A1d++tJ70DZXYS1N4350FAT9
         e9TPkphryfcSPNpiSYVIbrKcTx11ah+qhS6lYkHnvidTt0chhirh2fBh7D9fzz3iEFdx
         uwcb93io3Nv3xQlYRa/CObQ2LsVDMUAGkePprl92cBNQ7GofquBRWXLKY2PDb/97zr3e
         fktw==
X-Gm-Message-State: APzg51DBy3LoowYzxvSvbR2qmuuc0/5gB5P1ERR80uc8+Kpt0rOl7WYp
        moXZNeqRsLsGZdoh2tl+Gg6br2cWcz8=
X-Google-Smtp-Source: ANB0VdbmXj3bhTbMNcAt+4WPvRmvMETOCgabkVMopDL1HpuDEAUx7i0488nRty5EZQiIf3OfgGGUlg==
X-Received: by 2002:a5b:14a:: with SMTP id c10-v6mr7237623ybp.145.1537465569547;
        Thu, 20 Sep 2018 10:46:09 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id 200-v6sm3423883ywr.102.2018.09.20.10.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:46:09 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id x83-v6so4105594ywd.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:46:09 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr2730045ywi.288.1537465166599;
 Thu, 20 Sep 2018 10:39:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 10:39:26
 -0700 (PDT)
In-Reply-To: <6456aa25-6890-6d54-51c5-03c5daf0c6fb@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com> <6456aa25-6890-6d54-51c5-03c5daf0c6fb@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 10:39:26 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ6xF0zvDThL+z9VxH2Y2WZg+0vKw4RUa=c8+dUQOGKpg@mail.gmail.com>
Message-ID: <CAGXu5jJ6xF0zvDThL+z9VxH2Y2WZg+0vKw4RUa=c8+dUQOGKpg@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] LSM: Infrastructure management of the task
 security blob
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

> diff --git a/security/security.c b/security/security.c
> index 2501cdcbebff..7e11de7eec21 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -116,7 +116,8 @@ int __init security_init(void)
>  #ifdef CONFIG_SECURITY_LSM_DEBUG
>         pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
>         pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
> -       pr_info("LSM: inode blob size       = %d\n", blob_sizes.lbs_inode);
> +       pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
> +       pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
>  #endif

This alignment adjustment should be moved to the patch that adds the inode line.

(And this patch might want to mention it is changing the only task
blob user, AppArmor, or split that out into a separate patch.)

-Kees

-- 
Kees Cook
Pixel Security

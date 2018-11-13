Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3D621780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HMXqcKMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3D621780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeKNGQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:16:17 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34620 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeKNGQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:16:17 -0500
Received: by mail-yb1-f194.google.com with SMTP id n140-v6so5964756yba.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 12:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xDwJKA7a9/1zySW4GCEoPliPcO++fw7YIoSz99wHR8o=;
        b=HMXqcKMkoQsOh/jYTRBtTxAj8tQ2j3wn7DxtnqZcEMVWJMxclyNpXFvvFHQktl27o7
         pQtb4hMZs9RXsDZ/9jMhZeeFBYG+rHbc8yqMIWAhrud/DTQpWf46Duv0B5dcOuCTFLY8
         ETuRdDRdJYMrNOFlwKHrppeppIeAJ4y9+QF98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xDwJKA7a9/1zySW4GCEoPliPcO++fw7YIoSz99wHR8o=;
        b=FQGKVyVjGshLFWlS22cw/f6Rku08yEAckLtgD8VvENzIeEYSHGK1uEqKwbb7EcTFxG
         UvEveH6aDuY/XkdUFKhi9gAzLvmHr+7grYx06nGZxcwhnYFBXS3yi2Bp1RGvNZS7zoxd
         fOud4p0rXeG/ra/WcMYQ3dI5A4WHDjhTLiiYIVye9o1uGSBJECu/h+hUuYPwEwkKkMs3
         9r+8OHFMHpwI35Mv2rig02sRG2xWcUSvzu8aykCeLYknQ1TYtGeWUdl3d+CTk9EIioGE
         Guy5epA7IdjNwCrSJwQERUBHt4y0zsE9P4czhorKJ98hH1gJ3H32g9WPzjwGP4vNm5As
         zjtQ==
X-Gm-Message-State: AGRZ1gLe5rfUqXZrICOEud/bN2fVwsfzZneqRgUd0AvxpOii9TRTi1Fe
        1FxZVFlGC9l7XwmkkSdAELGvX45zZ0Y=
X-Google-Smtp-Source: AJdET5e4eN6qnsm4r4EMMYMM8ZSorYP0ukhZyzCtCXZRXPupyLYMpaXnL/NgdSe26hGIzqzB2N6/lg==
X-Received: by 2002:a25:8041:: with SMTP id a1-v6mr6446287ybn.411.1542140191499;
        Tue, 13 Nov 2018 12:16:31 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 200-v6sm6244113ywq.97.2018.11.13.12.16.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:16:30 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id g192-v6so5954330ybf.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 12:16:30 -0800 (PST)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr6525056yba.410.1542140189975;
 Tue, 13 Nov 2018 12:16:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 13 Nov 2018 12:16:29
 -0800 (PST)
In-Reply-To: <20181112160931.GA28463@redhat.com>
References: <20181112160931.GA28463@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 13 Nov 2018 14:16:29 -0600
X-Gmail-Original-Message-ID: <CAGXu5jLCdWZ1qdTvo_VK0VT8AbGQ44wsKPypRPRzNVed7f1xeg@mail.gmail.com>
Message-ID: <CAGXu5jLCdWZ1qdTvo_VK0VT8AbGQ44wsKPypRPRzNVed7f1xeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] exec: load_script: don't blindly truncate shebang string
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 10:09 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> load_script() simply truncates bprm->buf and this is very wrong if the
> length of shebang string exceeds BINPRM_BUF_SIZE-2. This can silently
> truncate i_arg or (worse) we can execute the wrong binary if buf[2:126]
> happens to be the valid executable path.
>
> Change load_script() to return ENOEXEC if it can't find '\n' or zero in
> bprm->buf. Note that '\0' can come from either prepare_binprm()->memset()
> or from kernel_read(), we do not care.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/binfmt_script.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
> index 7cde3f4..d0078cb 100644
> --- a/fs/binfmt_script.c
> +++ b/fs/binfmt_script.c
> @@ -42,10 +42,14 @@ static int load_script(struct linux_binprm *bprm)
>         fput(bprm->file);
>         bprm->file = NULL;
>
> -       bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
> -       if ((cp = strchr(bprm->buf, '\n')) == NULL)
> -               cp = bprm->buf+BINPRM_BUF_SIZE-1;
> +       for (cp = bprm->buf+2;; cp++) {
> +               if (cp >= bprm->buf + BINPRM_BUF_SIZE)
> +                       return -ENOEXEC;
> +               if (!*cp || (*cp == '\n'))
> +                       break;
> +       }
>         *cp = '\0';
> +
>         while (cp > bprm->buf) {
>                 cp--;
>                 if ((*cp == ' ') || (*cp == '\t'))
> --
> 2.5.0
>
>



-- 
Kees Cook

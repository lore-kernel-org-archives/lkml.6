Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC029C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3702077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GmjexAbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3702077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeIFCz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:55:27 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36317 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeIFCz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:55:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id d34-v6so3355346yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8vnAH5qkzbH07z69lEci9DyJ1rUdDPuAng5c7CscdgA=;
        b=GmjexAbFnGal589O945hJZGSkvf3rMAySDyPR5le02p0aAYF34QEK544CgTplYwhEV
         jGsiuuiE8cNk2yJKy4PTolZVDddgBG2ot/MVC5CyumXLzGqmIsLyyRT+kBXro6vuJYyp
         jYEzSZysW1+wuy6QCpcVU+SgzbndWe3qFBKA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8vnAH5qkzbH07z69lEci9DyJ1rUdDPuAng5c7CscdgA=;
        b=IcRXiOzU88Hf5Gx0O04buhKaQf+WTJbDtT5dOH7EtONiIHk3TfXSojwUNrx1o4jO5G
         AqyuxwFop7zEFknKvdJcX/QlzJajhb/pc4e3uLbbu/3K8kMDCwPE7SQhEqQEa5pslIp/
         Us3jJr4yl/n/Ewtp1yyGdTyLGsNHErR+z6f43tXroVlX4tfKjUaN8uvIKEvc7GG55R57
         Qafk6ApjtJtyfcFKhXkJ2F7Xjikjns3YLgZLLo8oEGFJ7Vzp1iW/uQk3hIU6vzj3E3iS
         R+QLuf2odgsRf95w6S6Ncve/0AofenENzuF7CeilZBif13TDUR3lCesdo/0RPR2ls+hc
         bvHg==
X-Gm-Message-State: APzg51A7E+kCdCxYDCXWsomSUlTGMB2IiWb1nMz0mg0dMppLy9BkQSuI
        77OB3uFVdcSNWQpZpajXETkWAt7qvUM=
X-Google-Smtp-Source: ANB0Vdad4KHlFkSRj+SEO4gg99ZFO/C864Y5lSdC3cskNYT3/DtbsDt0CrSI56z8Dp4uwd3NJ9j1IQ==
X-Received: by 2002:a25:6dd4:: with SMTP id i203-v6mr20094222ybc.438.1536186190562;
        Wed, 05 Sep 2018 15:23:10 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id w80-v6sm2480617ywd.55.2018.09.05.15.23.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 15:23:09 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id k5-v6so3338443ybo.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 15:23:09 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr22528809ybz.410.1536186188732;
 Wed, 05 Sep 2018 15:23:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 15:23:08 -0700 (PDT)
In-Reply-To: <20180905203443.32289-1-igor.stoppa@huawei.com>
References: <20180905203443.32289-1-igor.stoppa@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Sep 2018 15:23:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com>
Message-ID: <CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com>
Subject: Re: [PATCH] seccomp: remove unnecessary unlikely()
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 1:34 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
> into another.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Acked-by: Kees Cook <keescook@chromium.org>

Should I take this, or is it part of your series going somewhere else?

-Kees

> Cc: linux-security-module@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/seccomp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index fd023ac24e10..5a2a9af4663e 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -195,7 +195,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>                         READ_ONCE(current->seccomp.filter);
>
>         /* Ensure unexpected behavior doesn't result in failing open. */
> -       if (unlikely(WARN_ON(f == NULL)))
> +       if (WARN_ON(f == NULL))
>                 return SECCOMP_RET_KILL_PROCESS;
>
>         if (!sd) {
> @@ -297,7 +297,7 @@ static inline pid_t seccomp_can_sync_threads(void)
>                 /* Return the first thread that cannot be synchronized. */
>                 failed = task_pid_vnr(thread);
>                 /* If the pid cannot be resolved, then return -ESRCH */
> -               if (unlikely(WARN_ON(failed == 0)))
> +               if (WARN_ON(failed == 0))
>                         failed = -ESRCH;
>                 return failed;
>         }
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security

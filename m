Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D32C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D87E20843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 21:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mi6rmZrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D87E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeICBoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 21:44:09 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44654 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeICBoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 21:44:09 -0400
Received: by mail-yb1-f196.google.com with SMTP id l16-v6so2667499ybk.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wNPYIxiMcZIT2aK5prVrUOAsUcjACj4BfRXNS6KYbgc=;
        b=Mi6rmZrh1BlvLaVwmm8X80+eM2rUAe69ZgkQtF0MMGvksrxjuypkSggIEsoBLBwTAH
         KUvjeOtDNhWAtODcG2kWb5uPryffJEG/CfV48eEjCPVhQ/tFSFcFcrgSnNx5GQ7W4niX
         B9sxtSUTZFXY5lZuNbuIWG9dfoaruK8UC7NEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wNPYIxiMcZIT2aK5prVrUOAsUcjACj4BfRXNS6KYbgc=;
        b=PG/wniWfEvMX8O1eFs6vzCvItUhwXleRuxNyC9m7GewUHsLnpnx931vGEn8t39B8o/
         9+fLwIeqY8bP5fHElzCBPDWEP7/zpPnPvjF9UbtCGLFWd91d8fdqdxh/VD/c2YEF8azL
         HX4P7qzlrNWdvQQ7aFBFHM4nEP1xWWKRKscm2afWN4LQismZUZuhYiiGYe7yzp/dt3XA
         RkPLa8qKHnERv0YFKA627VKqnWufuHRD8kHNm9CMzf2a2Fdh1YtSbMqAGRa2fpq0XTmv
         vZWFXEUpVYMzY0z8hr8o0SVI2ravLmWxXtZrjdEz9cStmND/x3lWN80qipdTxCJ4QjKN
         mJ9w==
X-Gm-Message-State: APzg51At3vHiLW67hMHo61KeXRp8hYlgfIrCvdjso5AiTMcJ+aOpQOz0
        ybOKWO7JYX6pmgc3m1s9B5oSFXDKpgM=
X-Google-Smtp-Source: ANB0VdZzOJ83BZQTci5SvGXHLKUqQE+uPKIrR5DHc2BuoTszsnXZkwMhzu3iea2c360sWP5W+yPEaA==
X-Received: by 2002:a25:d001:: with SMTP id h1-v6mr14298926ybg.522.1535923619824;
        Sun, 02 Sep 2018 14:26:59 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id v11-v6sm5658928ywb.13.2018.09.02.14.26.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 14:26:58 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id q18-v6so2666026ybg.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 14:26:58 -0700 (PDT)
X-Received: by 2002:a25:1345:: with SMTP id 66-v6mr14033163ybt.171.1535923618316;
 Sun, 02 Sep 2018 14:26:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 14:26:57 -0700 (PDT)
In-Reply-To: <20180830223429.30051-8-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com> <20180830223429.30051-8-igor.stoppa@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 2 Sep 2018 14:26:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK9ru6o+bMu=y3uhQGojq3UyUSU3Mf9+qtmSSvCEWd1=Q@mail.gmail.com>
Message-ID: <CAGXu5jK9ru6o+bMu=y3uhQGojq3UyUSU3Mf9+qtmSSvCEWd1=Q@mail.gmail.com>
Subject: Re: [PATCH 07/23] seccomp: remove unnecessary unlikely()
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 3:34 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
> into another.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Kees Cook <keescook@chromium.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

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

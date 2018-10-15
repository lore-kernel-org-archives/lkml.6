Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76761C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C2A2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jt0iHrFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C2A2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeJOX5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:57:48 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38599 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOX5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:57:48 -0400
Received: by mail-yb1-f195.google.com with SMTP id e190-v6so7693869ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cz9ZwCZm/9dr8JoCyeBAuy29rs5StonFiOE3JZGQiqw=;
        b=jt0iHrFTMrqjDcEBL1rcnAaOhISgM6wjZvJm6mk3TlQwtZG+Ccyrhh0x6KB0446maP
         dpCjpyDsgyI+s6+ObdwQLFS6ErPQbi7QnD0qBHJa4LxIdWZHuEgXQV3tZDn+V1N3uD/8
         5hqIO7AfCI79MitL7/AJLFzPzd5tLh6j5UdXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cz9ZwCZm/9dr8JoCyeBAuy29rs5StonFiOE3JZGQiqw=;
        b=oZnIhXa4TVADmMsdaZSiUA+sYLJgCyDR6fM1BTJ3Y3fLEalUL+xCHnVQ2KxDzC2odr
         VMgFGZXdquDV5i6efEQXJlOUPiZWftKcr5FfM6rtfz4jTtEnzC/7Sl61b+OiKzoGMlDT
         7S7BILL8RCyt+Ahb2BBamC9xDb3lw7GjKX63tVJG9M5PzVP029uZRvBAlINkejpzpuGH
         bI29PvTaS5Jsbbm552x0s/fqndJpXnq1g6EgRNwmC3KjRaXUOTX+BKjy8Q890mZrmuTO
         Ff76Zz1LfeKUg16HZGMgN12ZnqDg9KchDBMvz6s/Vui40kvJrLtxZrCJn96MFSWDoOEK
         Edng==
X-Gm-Message-State: ABuFfojV6Q1WAiV0PyjwSQvc/+QU7AwQHbIdQEaQQo+rcD7G3+KYim1e
        PNBs2HNP7AJosjGydormnKL1bjFJbkQ=
X-Google-Smtp-Source: ACcGV61rXzfwCe2mzAkh1DzvS4x51KUQB7QXo337kP1KauutSKvfHLVK5hnzLWlBJrfbDRNArLaaGQ==
X-Received: by 2002:a25:9348:: with SMTP id g8-v6mr3130120ybo.219.1539619914694;
        Mon, 15 Oct 2018 09:11:54 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id y126-v6sm3235999ywe.26.2018.10.15.09.11.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 09:11:53 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id w7-v6so7697639ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:11:53 -0700 (PDT)
X-Received: by 2002:a25:396:: with SMTP id 144-v6mr9577409ybd.403.1539619912785;
 Mon, 15 Oct 2018 09:11:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 09:11:51
 -0700 (PDT)
In-Reply-To: <20181015105544.4395-3-christian@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io> <20181015105544.4395-3-christian@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 09:11:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL2j+9ey4732XmTrU4ZJQwJvxmkHMCzwgar9FnVNZhjwg@mail.gmail.com>
Message-ID: <CAGXu5jL2j+9ey4732XmTrU4ZJQwJvxmkHMCzwgar9FnVNZhjwg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] sysctl: handle overflow for file-max
To:     Christian Brauner <christian@brauner.io>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 3:55 AM, Christian Brauner <christian@brauner.io> wrote:
> Currently, when writing
>
> echo 18446744073709551616 > /proc/sys/fs/file-max
>
> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> crashes the system.
> This commit explicitly caps the value for file-max to ULONG_MAX.
>
> Note, this isn't technically necessary since proc_get_long() will already
> return ULONG_MAX. However, two reason why we still should do this:
> 1. it makes it explicit what the upper bound of file-max is instead of
>    making readers of the code infer it from proc_get_long() themselves
> 2. other tunebles than file-max may want to set a lower max value than
>    ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
>    such cases too
>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> v0->v1:
> - if max value is < than ULONG_MAX use max as upper bound
> - (Dominik) remove double "the" from commit message
> ---
>  kernel/sysctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 97551eb42946..226d4eaf4b0e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;
>  static unsigned long one_ul = 1;
> +static unsigned long ulong_max = ULONG_MAX;
>  static int one_hundred = 100;
>  static int one_thousand = 1000;
>  #ifdef CONFIG_PRINTK
> @@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
>                 .maxlen         = sizeof(files_stat.max_files),
>                 .mode           = 0644,
>                 .proc_handler   = proc_doulongvec_minmax,
> +               .extra2         = &ulong_max,

Don't we want this capped lower? The percpu comparisons, for example,
are all signed long. And there is at least this test, which could
overflow:

        if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
                goto out;

Seems like max-files should be  SLONG_MAX / 2 or something instead?

>         },
>         {
>                 .procname       = "nr_open",
> @@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
>                                 break;
>                         if (neg)
>                                 continue;
> +                       if (max && val > *max)
> +                               val = *max;
>                         val = convmul * val / convdiv;
>                         if ((min && val < *min) || (max && val > *max))
>                                 continue;
> --
> 2.17.1
>

-Kees

-- 
Kees Cook
Pixel Security

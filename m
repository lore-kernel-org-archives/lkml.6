Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA110C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DC3222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550013707;
	bh=jjT0UPWQ8cXni9owG4kTLw76uYBwJ8qfhXI/5Vh6jJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K/CNWxENa0/hrrZg0YksYJK7hrT9H4SvMSSLxUmQIlCNBBAuly+4k6qhsTr09lDMY
	 Tit5nNwP65yS3pbYpgnS8lF9rYO1LVZW4P6bVSt0r28oNaCauFCk9LNeyFCxPei2tL
	 +b9h9HDdu5w0DX+k0KM0r7PBt76tU1RH+Wg/28q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfBLXVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:21:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35216 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731619AbfBLXVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:21:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so848932otm.2;
        Tue, 12 Feb 2019 15:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vIKzjZ5jJGo2OS/7uJ7xWKmz5DtJYtusuGOvogkAM8=;
        b=AtjB185N3IeQWLFH9KuYeVglpNcyjgXtqNMoDo44NKla2WSXwgNqXyig8UKPlRt++P
         NHMwHjkIMMO5MfM+nUfAY577f3QEzquP3sHttYcbxGu3MuU4m+ZJHfAje9KM1T/1lUis
         t1xYIw/0pEWRA0m1S/lzpqFOEg9+t0sfnuXNrlsMsxbCOmrOBoRl9R0HSFBFpGlNIUpg
         hob9m/etP2M6hVKdId+OI84SZ7uyvkmZOu2LSZf4jHyaWR7lI3EzrreuznyrAZYmlYIW
         47aA8KM/vRGYs3y4vKETJS/5lLfjdNsPJhsmL8r/VIPkrQlWE5Fzex6L6kYcvgngkg3x
         mNjQ==
X-Gm-Message-State: AHQUAuaPlQ1UIsn3Nk3nmcxdGf8S3yriiEbgaJsJ3hy1V225icF7xIMV
        m4lPD0XTiukSkIrEC9TPR7T6afBb+Sj7M3U2nx8=
X-Google-Smtp-Source: AHgI3IZfM+0++eNDNfKdQtJ0agZShoZ92/kAfXABWmEs90TENunGvvYsinsBIwrp5gGEJpFu/eugaILpn7Wkzlc0n+E=
X-Received: by 2002:a9d:718d:: with SMTP id o13mr5981500otj.119.1550013702692;
 Tue, 12 Feb 2019 15:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20190203052007.27392-1-harry.pan@intel.com> <20190206144257.21464-1-harry.pan@intel.com>
In-Reply-To: <20190206144257.21464-1-harry.pan@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Feb 2019 00:21:31 +0100
Message-ID: <CAJZ5v0j+JEs5G+ySmkxEc0kbomTckX=wRg_DbnQ6svnX+EZaTg@mail.gmail.com>
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 4:57 PM Harry Pan <harry.pan@intel.com> wrote:
>
> This patch gives the reader an intuitive metric of the time cost by
> the kernel issuing a filesystem sync during suspend; although developer
> can guess by the timestamp of next log or enable the ftrace power event
> for manual calculation, this manner is easier to read and benefits the
> automatic script.
>
> v2: simplify the variables, apply the simplest form of ktime API.
>
> Signed-off-by: Harry Pan <harry.pan@intel.com>
> ---
>  kernel/power/suspend.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 0bd595a0b610..87c0073f0c9d 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -550,6 +550,8 @@ static void suspend_finish(void)
>  static int enter_state(suspend_state_t state)
>  {
>         int error;
> +       ktime_t start;
> +       unsigned int elapsed_msecs;

You only need these two if CONFIG_SUSPEND_SKIP_SYNC is set, ->

>
>         trace_suspend_resume(TPS("suspend_enter"), state, true);
>         if (state == PM_SUSPEND_TO_IDLE) {
> @@ -570,9 +572,12 @@ static int enter_state(suspend_state_t state)
>
>  #ifndef CONFIG_SUSPEND_SKIP_SYNC

-> so I would change this to

if (IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
     ktime_t start;
     unsigned int elapsed_msecs;

>         trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> +       start = ktime_get();

Why don't you do this after printing the message below?

>         pr_info("Syncing filesystems ... ");
>         ksys_sync();
> -       pr_cont("done.\n");
> +       elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
> +       pr_cont("(elapsed %d.%03d seconds) done.\n", elapsed_msecs / 1000,
> +               elapsed_msecs % 1000);

Use MSEC_PER_SEC here.

>         trace_suspend_resume(TPS("sync_filesystems"), 0, false);
>  #endif
>

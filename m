Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A62C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6601D222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550014024;
	bh=iWNzlTUQvubwHZnEHjLw6ofAvGqKw57YDG6PDQqRgWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iwDOInZxLYy8VD4rebrAJS7y11QR55drJAD6BoxR0cPH/EYRMmZrsiayNmKRHeXSc
	 2MtwRaOGZJKcQ2YAhofo7ZL+oRi8EDBGcTl0dKt/AL2qJdU1KTZFHaEljtORXkQhCU
	 hVtwii9lfOjus+VscVFbCDYI1iKewFPXUwdvdXTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfBLX1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:27:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33001 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbfBLX1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:27:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so889674otl.0;
        Tue, 12 Feb 2019 15:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Cos5lVwWbpurrhrpSa0YT6qGbgr5VDJak4cKUsbQAw=;
        b=jEz/nXWaStHfe7gxSt1I74/VyewOu+CD5iizoNNlbvC/KHHlqCBERCziwobGEc9PSL
         yjfyTbjSqgS+qtt2p6wbdS/Ko3knxPhD/hfxo3WcHy8x83FCz9w63qeTyMJ6bcNGigia
         GIxV8tC5dI3xpxZqcSIL1Vwxs5ihAPeuXTZ8uTnyIe70se7KCoa3OhlufgVf6sOUhVZL
         XGx2antvJdHoKRzC1lsvdFNCvVFZichtgfStoZFNwwh5hPplsKwkKbuiKT1BLWXQ4cwR
         aYcm/t4wyxSIMRFI1Me1DNkPuhkYN5WqJkTjwcaXd0Yebugj46+yd8ES7aPqk8K9Xvmb
         weDw==
X-Gm-Message-State: AHQUAub43J2qjNmxt12Zi+6JrgkIO9MSHSve+r3vCs1mud1PSIZAvoJo
        MHlFUdZDDJxoEL/Iu+2ChWc3lGPcuTcJlmj6c9E=
X-Google-Smtp-Source: AHgI3IbxdqYbY+bTSUibouMU4mJpDtTGiK/CnO4H/uOd7Oi2j74RFJulm3Tfqf5c2xBTjT3cootFDByWDNyVL7gy4DY=
X-Received: by 2002:a9d:5a09:: with SMTP id v9mr4643891oth.244.1550014021038;
 Tue, 12 Feb 2019 15:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20190203052007.27392-1-harry.pan@intel.com> <20190206144257.21464-1-harry.pan@intel.com>
 <CAJZ5v0j+JEs5G+ySmkxEc0kbomTckX=wRg_DbnQ6svnX+EZaTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+JEs5G+ySmkxEc0kbomTckX=wRg_DbnQ6svnX+EZaTg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Feb 2019 00:26:50 +0100
Message-ID: <CAJZ5v0hRY_KdJ5LJY9O4vm3cU+meKdgoNW-9xzMFjT8wsQuvxw@mail.gmail.com>
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

On Wed, Feb 13, 2019 at 12:21 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 6, 2019 at 4:57 PM Harry Pan <harry.pan@intel.com> wrote:
> >
> > This patch gives the reader an intuitive metric of the time cost by
> > the kernel issuing a filesystem sync during suspend; although developer
> > can guess by the timestamp of next log or enable the ftrace power event
> > for manual calculation, this manner is easier to read and benefits the
> > automatic script.
> >
> > v2: simplify the variables, apply the simplest form of ktime API.
> >
> > Signed-off-by: Harry Pan <harry.pan@intel.com>
> > ---
> >  kernel/power/suspend.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 0bd595a0b610..87c0073f0c9d 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -550,6 +550,8 @@ static void suspend_finish(void)
> >  static int enter_state(suspend_state_t state)
> >  {
> >         int error;
> > +       ktime_t start;
> > +       unsigned int elapsed_msecs;
>
> You only need these two if CONFIG_SUSPEND_SKIP_SYNC is set, ->
>
> >
> >         trace_suspend_resume(TPS("suspend_enter"), state, true);
> >         if (state == PM_SUSPEND_TO_IDLE) {
> > @@ -570,9 +572,12 @@ static int enter_state(suspend_state_t state)
> >
> >  #ifndef CONFIG_SUSPEND_SKIP_SYNC
>
> -> so I would change this to
>
> if (IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {

if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {

that is (missing "!").

>      ktime_t start;
>      unsigned int elapsed_msecs;
>
> >         trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> > +       start = ktime_get();
>
> Why don't you do this after printing the message below?
>
> >         pr_info("Syncing filesystems ... ");
> >         ksys_sync();
> > -       pr_cont("done.\n");
> > +       elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
> > +       pr_cont("(elapsed %d.%03d seconds) done.\n", elapsed_msecs / 1000,
> > +               elapsed_msecs % 1000);
>
> Use MSEC_PER_SEC here.
>
> >         trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> >  #endif
> >

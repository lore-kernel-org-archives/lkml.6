Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7FDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E958921903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfBSIBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:01:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39195 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfBSIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:01:06 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so4109190iti.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 00:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2XYKbQq4bQ8lpqIwfZ6bYklGSI1OQMVNBfCHUZOBsY=;
        b=JxFGTI02/hlqmSt2o10yYCHCxNlDjFqW7HepaXH0bRbz61DFdTRl0QuB313v4PQW2L
         evj3SkbArRUsFUyhpEoAlWrl8D5944gunpF3IFo0nBubusUGc2ZGqXdlg8yE8AKMweLb
         +7R5xwHcGdvCSxLI8ASPanCS6vJo7X0u4+yY8EDHVzae3F4B9OYMeSlCXGqEp9KkU2KA
         PgAMnGybNyPb2AIBA+nPZpR7J7gizdPoogBW/gDR3nc2aX2WXyJlas2igYIuSZw+2LSf
         a3UAkUFLOjHABLV6XrYFOHRSXTkcQ2en29JWoDaDVyeGGXYYIlL3lfC6WmTaU1CxMM5A
         wvEA==
X-Gm-Message-State: AHQUAuZgCP0/n78dVtnXviCTKGxorh1SCTZEgmEo1p4VmZugP7UQTmAp
        ypoeXGupFAxzQ3E3INXQ1aVNKFgBkBD1QFg1Lswutw==
X-Google-Smtp-Source: AHgI3IaIyf3gl4MNuD+42eB13AKtAbk9cr0OWQ33GkBBPM0rNyn6aKrm7BqCQ6Kiq8JYrhwzRbcada9ifKOGE69LOcQ=
X-Received: by 2002:a24:9795:: with SMTP id k143mr1625034ite.147.1550563265399;
 Tue, 19 Feb 2019 00:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20190102105408.7124-1-kasong@redhat.com> <20190123141432.GA19177@MiWiFi-R3L-srv>
 <CACPcB9faut+9p8oJ_4nUv6ZnQ42=N4b9vqjCFtbyrs1K1SCWvg@mail.gmail.com> <20190124021744.GB19177@MiWiFi-R3L-srv>
In-Reply-To: <20190124021744.GB19177@MiWiFi-R3L-srv>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 19 Feb 2019 16:00:54 +0800
Message-ID: <CACPcB9cL_YfwORAhZEzz-C0QdVfXD6UrJ1Dc-eLQjDTJ8zP60A@mail.gmail.com>
Subject: Re: [PATCH v2] x86/gart/kcore: Exclude GART aperture from kcore
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jbohac@suse.cz,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, osandov@fb.com,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:17 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 01/23/19 at 10:50pm, Kairui Song wrote:
> > > >  int fix_aperture __initdata = 1;
> > > >
> > > > -#ifdef CONFIG_PROC_VMCORE
> > > > +#if defined(CONFIG_PROC_VMCORE) || defined(CONFIG_PROC_KCORE)
> > > >  /*
> > > >   * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
> > > >   * use the same range because it will remain configured in the northbridge.
> > > > @@ -66,7 +67,7 @@ int fix_aperture __initdata = 1;
> > > >   */
> > > >  static unsigned long aperture_pfn_start, aperture_page_count;
> > > >
> > > > -static int gart_oldmem_pfn_is_ram(unsigned long pfn)
> > > > +static int gart_mem_pfn_is_ram(unsigned long pfn)
> > > >  {
> > > >       return likely((pfn < aperture_pfn_start) ||
> > > >                     (pfn >= aperture_pfn_start + aperture_page_count));
> > > > @@ -76,7 +77,12 @@ static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
> > >
> > > Shouldn't this function name be changed? It's not only handling vmcore
> > > stuff any more, but also kcore. And this function is not excluding, but
> > > resgistering.
> > >
> > > Other than this, it looks good to me.
> > >
> > > Thanks
> > > Baoquan
> > >
> >
> > Good suggestion, it's good to change this function name too to avoid
> > any misleading. This patch hasn't got any other reviews recently, I'll
> > update it shortly.
>
> There's more.
>
> These two are doing the same thing:
>   register_mem_pfn_is_ram
>   register_oldmem_pfn_is_ram
>
> Need remove one of them and put it in a right place. Furthermore, may
> need see if there's existing function which is used to register a
> function to a hook.
>
> Secondly, exclude_from_vmcore() is not excluding anthing, it's only
> registering a function which is used to judge if oldmem/pfn is ram. Need
> rename it.
>
> Thanks
> Baoquan

Thanks a lot for the review! I've sent V3, using a different approach.
It's true repeating the hook infrastructure cause duplication, but I
see vmcore/kcore didn't share much code, so instead of sharing a
common hook infrastructure / registering entry, I used a new kcore
memory mapping list enum type to fix it, it also introduced less code.
Please have a look at V3, let me know how you think about it, thanks!


--
Best Regards,
Kairui Song

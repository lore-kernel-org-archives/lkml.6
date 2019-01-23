Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD27C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0160E2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfAWOuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:50:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33101 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAWOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:50:43 -0500
Received: by mail-io1-f66.google.com with SMTP id t24so1881959ioi.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrzeEWxLWp8kbEaxUd3KoaEM8/V9XnT3uiVFB1dyXFY=;
        b=kQHFbdBQO9pj7MSoYKiQd7ZsiC3x44Vce95/R3OIIqM8Oh0MwT15JkIqaW9DWh6Gjp
         eQtS+5hDsJAwIDLREoDsvyNt1eV46Pf2qM8Tsa7mTmQcGBmFJ+RG19T1h1dhLmzZ1pHU
         33yBAt0tJIw4xDlFMW1kKkACktWo8nJKLE8v3lw3J8ZFQxM2fsonz4kc55qWfF9JOjUW
         C37MHIXwYR+sAsmwsP/Ss7j92L+MmU3hCqZp99tFwrnJMJrxfrTTy7RnfBGkCn98mIff
         F9IzgVB2KlkZfxGQKZgsOD8+Ac2SJPLtC1UNrH1Me6F4/CmqkhQPD0WLMF9du/8TqOMU
         S4zw==
X-Gm-Message-State: AHQUAuatARrGV/Qr/jESNqCOk0pxjfdiX38o0fGIIC/cEIh0KnryB8j5
        hYS/Ofy9xz/532WKc6wQuQ1/DTsTxWyKP7uyFoSNwA==
X-Google-Smtp-Source: ALg8bN4kd0y51nYaU15VyrdJiQ9Z05m2SVWs1HSTsJxqRT8rK0NeG3+hhBMsxiC+kkhQKPmlo7DEtA0uV6O33TzqwXM=
X-Received: by 2002:a5e:de01:: with SMTP id e1mr1380661iok.137.1548255042918;
 Wed, 23 Jan 2019 06:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20190102105408.7124-1-kasong@redhat.com> <20190123141432.GA19177@MiWiFi-R3L-srv>
In-Reply-To: <20190123141432.GA19177@MiWiFi-R3L-srv>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 23 Jan 2019 22:50:31 +0800
Message-ID: <CACPcB9faut+9p8oJ_4nUv6ZnQ42=N4b9vqjCFtbyrs1K1SCWvg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/gart/kcore: Exclude GART aperture from kcore
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jbohac@suse.cz,
        adobriyan@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        osandov@fb.com, Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 10:14 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 01/02/19 at 06:54pm, Kairui Song wrote:
> > diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
> > index 58176b56354e..c8a56f083419 100644
> > --- a/arch/x86/kernel/aperture_64.c
> > +++ b/arch/x86/kernel/aperture_64.c
> > @@ -14,6 +14,7 @@
> >  #define pr_fmt(fmt) "AGP: " fmt
> >
> >  #include <linux/kernel.h>
> > +#include <linux/kcore.h>
> >  #include <linux/types.h>
> >  #include <linux/init.h>
> >  #include <linux/memblock.h>
> > @@ -57,7 +58,7 @@ int fallback_aper_force __initdata;
> >
> >  int fix_aperture __initdata = 1;
> >
> > -#ifdef CONFIG_PROC_VMCORE
> > +#if defined(CONFIG_PROC_VMCORE) || defined(CONFIG_PROC_KCORE)
> >  /*
> >   * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
> >   * use the same range because it will remain configured in the northbridge.
> > @@ -66,7 +67,7 @@ int fix_aperture __initdata = 1;
> >   */
> >  static unsigned long aperture_pfn_start, aperture_page_count;
> >
> > -static int gart_oldmem_pfn_is_ram(unsigned long pfn)
> > +static int gart_mem_pfn_is_ram(unsigned long pfn)
> >  {
> >       return likely((pfn < aperture_pfn_start) ||
> >                     (pfn >= aperture_pfn_start + aperture_page_count));
> > @@ -76,7 +77,12 @@ static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
>
> Shouldn't this function name be changed? It's not only handling vmcore
> stuff any more, but also kcore. And this function is not excluding, but
> resgistering.
>
> Other than this, it looks good to me.
>
> Thanks
> Baoquan
>

Good suggestion, it's good to change this function name too to avoid
any misleading. This patch hasn't got any other reviews recently, I'll
update it shortly.

-- 
Best Regards,
Kairui Song

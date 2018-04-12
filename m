Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeDLHJY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:09:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33895 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeDLHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:09:22 -0400
X-Google-Smtp-Source: AIpwx4+cdvmwcZSUFXrpCAAqj7aDvbzEX7+7iJLK0c0qMZ8OFxF5W8zin8jyVhT29Ts7RRyVbXdf2A==
Date: Thu, 12 Apr 2018 09:09:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ingo Molnar <mingo@elte.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: x86-tip.today (4cdf573) early instaboot
Message-ID: <20180412070917.kbqozhkscnphjk7i@gmail.com>
References: <1523347959.4724.2.camel@gmx.de>
 <20180410085917.bo526ueprf7zfare@gmail.com>
 <1523363877.4942.2.camel@gmx.de>
 <430ee27a-fbef-9717-792b-bbd06b04996f@amd.com>
 <1523375305.4909.0.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523375305.4909.0.camel@gmx.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> On Tue, 2018-04-10 at 09:06 -0500, Tom Lendacky wrote:
> > 
> > Just out of curiosity, can you try the following patch and see if it
> > fixes your reboot issue:
> 
> Yup, all better.
> 
> > diff --git a/arch/x86/boot/compressed/kaslr.c
> > b/arch/x86/boot/compressed/kaslr.c
> > index c5196d2..a0a50b9 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -55,7 +55,7 @@
> >  extern unsigned long get_cmd_line_ptr(void);
> > 
> >  /* Used by PAGE_KERN* macros: */
> > -pteval_t __default_kernel_pte_mask __read_mostly;
> > +pteval_t __default_kernel_pte_mask __read_mostly = ~0;
> > 
> >  /* Simplified build-specific string for starting entropy. */
> >  static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"

Thanks guys!

I ended up back-merging this fix (and another fix) into:

  fb43d6cb91ef: x86/mm: Do not auto-massage page protections

I added credits as:

    - printk format warning fix from: Arnd Bergmann <arnd@arndb.de>
    - boot crash fix from:            Tom Lendacky <thomas.lendacky@amd.com>
    - crash bisected by:              Mike Galbraith <efault@gmx.de>

    ...
    
    Reported-and-fixed-by: Arnd Bergmann <arnd@arndb.de>
    Fixed-by: Tom Lendacky <thomas.lendacky@amd.com>
    Bisected-by: Mike Galbraith <efault@gmx.de>

Thanks,

	Ingo

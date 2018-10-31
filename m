Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26632ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F8C2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hRfi3Kd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F8C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeKAGt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:49:29 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43407 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeKAGt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:49:29 -0400
Received: by mail-vk1-f193.google.com with SMTP id g144so2847918vke.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9OZBU7xBbZRq91LmWRsKb1e+HamrGUSqJjfkZGsW5iY=;
        b=hRfi3Kd5G9/BLYolaPFaixRBSy8QElOUfTm0fyNwi5G2el/3A087MYoMPAXTtCvmr6
         aqtzB3yUpqwbaMtfyXn9KPe/xCBryhqzS5lXRDQiilI7KlDKS9tpNMeE3EhIpseZtToC
         y5ZSqIZ1fBG/MJmna3J4vq+E8lJ01mfbgfTEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OZBU7xBbZRq91LmWRsKb1e+HamrGUSqJjfkZGsW5iY=;
        b=T2Lys1QeezHoBxc4f0qTBGM1w7UHv6W+Nzm/FaRe8uceg5VSIbLw7orWI7CwZN+Lcl
         NbwfUfnELos0jxNv5n3h8C3Nz+DcfBVfz6vDMh+te2Z2dt92nCgHHOiZVOPakQZzDnAn
         Lvsu5/JNOIYvkpKzaGduBOdEHfJLPI/eReGyMv00OYkCDmz9/eIDNmwytLD7KUIm59TJ
         daDKIZRarXW1YJswe7ugzCbNjS/Gip4dXNUN9DyBI+58BuKUr4D/xx66qavhRZIyKYRF
         YnhNkRfboKClR/IOXeQ0EbZh5bBkFnpH63wd1bY1NLfue28zyGmTu8uuW82K+KnMClcC
         ozsA==
X-Gm-Message-State: AGRZ1gJ1kIrPUacasSbcm1fs7IzhZOlEqgaNlwUTL5zdjXY7yaOqW/20
        zzNfWDlyPAaZC3rs+8DGkbcBKs+cwbI=
X-Google-Smtp-Source: AJdET5cbfl7krHbj6TmN7ii8tKw2VB0+EuM1DalTvvTuMwHxgBqIkhcRcMgD3lmoaS5tuY7SE/7cpA==
X-Received: by 2002:a1f:1d4b:: with SMTP id d72-v6mr2130600vkd.34.1541022573666;
        Wed, 31 Oct 2018 14:49:33 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id p191-v6sm4337622vkd.23.2018.10.31.14.49.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 14:49:33 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id q15so11063341vso.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:49:33 -0700 (PDT)
X-Received: by 2002:a67:6642:: with SMTP id a63mr2174631vsc.42.1541022087194;
 Wed, 31 Oct 2018 14:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org> <20181031184050.sd5opni3mznaapkv@holly.lan>
In-Reply-To: <20181031184050.sd5opni3mznaapkv@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Oct 2018 14:41:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
Message-ID: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, dalias@libc.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>, paulus@samba.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, paul.burton@mips.com,
        LKML <linux-kernel@vger.kernel.org>, rkuo@codeaurora.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 31, 2018 at 11:40 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index f3cadda45f07..9a3f952de6ed 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/vmacache.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/irq.h>
> >
> >  #include <asm/cacheflush.h>
> >  #include <asm/byteorder.h>
> > @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
> >       return 0;
> >  }
> >
> > +/*
> > + * Default (weak) implementation for kgdb_roundup_cpus
> > + */
> > +
> > +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> > +
> > +void __weak kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> > +}
> > +
> > +void __weak kgdb_roundup_cpus(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, cpu_online_mask) {
> > +             csd = &per_cpu(kgdb_roundup_csd, cpu);
> > +             smp_call_function_single_async(cpu, csd);
> > +     }
>
> smp_call_function() automatically skips the calling CPU but this code does
> not. It isn't a hard bug since kgdb_nmicallback() does a re-entrancy
> check but I'd still prefer to skip the calling CPU.

I'll incorporate this into the next version.


> As mentioned in another part of the thread we can also add robustness
> by skipping a cpu where csd->flags != 0 (and adding an appropriately
> large comment regarding why). Doing the check directly is abusing
> internal knowledge that smp.c normally keeps to itself so an accessor
> of some kind would be needed.

Sure.  I could add smp_async_func_finished() that just looked like:

int smp_async_func_finished(call_single_data_t *csd)
{
  return !(csd->flags & CSD_FLAG_LOCK);
}

My understanding of all the mutual exclusion / memory barrier concepts
employed by smp.c is pretty weak, though.  I'm hoping that it's safe
to just access the structure and check the bit directly.

...but do you think adding a generic accessor like this is better than
just keeping track of this in kgdb directly?  I could avoid the
accessor by adding a "rounding_up" member to "struct
debuggerinfo_struct" and doing something like this in roundup:

  /* If it didn't round up last time, don't try again */
  if (kgdb_info[cpu].rounding_up)
    continue

  kgdb_info[cpu].rounding_up = true
  smp_call_function_single_async(cpu, csd);

...and then in kgdb_nmicallback() I could just add:

  kgdb_info[cpu].rounding_up = false

In that case we're not adding a generic accessor to smp.c that most
people should never use.


I'll wait to hear back from you if you think the accessor is OK.  It
seems like it might be nice not to have to add something to smp.c just
for this one use case.


> > +}
> > +
> > +static void kgdb_generic_roundup_init(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             csd = &per_cpu(kgdb_roundup_csd, cpu);
> > +             csd->func = kgdb_call_nmi_hook;
> > +     }
> > +}
>
> I can't help noticing this code is very similar to kgdb_roundup_cpus. Do
> we really gain much from ahead-of-time initializing csd->func?

Oh!  Right...  At first I thought about just trying to put the "csd"
on the stack in kgdb_roundup_cpus() but then I realized that it needed
to persist past the end of kgdb_roundup_cpus().  ...and once I gave up
on the idea of putting it on the stack I decided I needed the init.

...but you're right that I don't really.  The only thing I'm initting
is the function pointer and it totally wouldn't hurt to just init that
over and over again every time kgdb_roundup_cpus() is called.

-Doug

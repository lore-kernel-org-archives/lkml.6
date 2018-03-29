Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeC2LDT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:03:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54100 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC2LDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:03:18 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: David Wang <DavidWang@zhaoxin.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pm@kernel.org" <linux-pm@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bruce Chang (VAS)" <BruceChang@via-alliance.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        Benjamin Pan <BenjaminPan@viatech.com>, Luke Lin <LukeLin@viacpu.com>,
        "Tim Guo(BJ-RD)" <TimGuo@zhaoxin.com>,
        "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>,
        "Jiangbo Wang(BJ-RD)" <JiangboWang@zhaoxin.com>
Subject: Re: =?UTF-8?B?562U5aSNOiDnrZTlpI06?= [PATCH] Delete some unusefull operations for centaur CPU/platform
Date: Thu, 29 Mar 2018 13:03:35 +0200
Message-ID: <7112264.IUdZzFR1Qm@aspire.rjw.lan>
In-Reply-To: <0230c32412474e97bf7d2ef45cc64c4d@zhaoxin.com>
References: <1519963908-4359-1-git-send-email-davidwang@zhaoxin.com> <20180312094609.46sw3ojaa7sw3mee@gmail.com> <0230c32412474e97bf7d2ef45cc64c4d@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 28, 2018 11:21:15 AM CEST David Wang wrote:
> Dear Rafael,
> 
> After disscusion with engineer from Centaur,   the orginal patch maybe not safe for some older Centaur CPU/platform. So, I want to use another patch like the following:

OK

I will drop the previous one, no problem.

Please resumbit the new one on top of the Linus' tree.

Thanks!

> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 6c74dec..d92a7f3 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -52,17 +52,15 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>             (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
>                         flags->bm_control = 0;
> 
> -        if (c->x86_vendor == X86_VENDOR_CENTAUR) {
> -               /*
> -                * On all Centaur CPUs, software need not flush the CPU caches
> -                * when entering C3-type C-states.
> -                *
> -                * On all Centaur platforms, software need not disable bus
> -                * master arbitration when entering C3-type C-states.
> -                */
> -               flags->bm_check = 1;
> -               flags->bm_control = 0;
> -       }
> +       /*
> +        * For all recent Centaur CPUs, the ucode will make sure that each core can keep
> +        * cache coherence with each other while entering C3 type state.
> +        * So, set bm_check to 1 to indicate that the kernel need not execute a cache
> +        * flush operation (WBINVD) when entering C3 type state.
> +        */
> +       if (c->x86_vendor == X86_VENDOR_CENTAUR &&
> +           (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f && c->x86_mask>=0x0e)))
> +                       flags->bm_check = 1;
>  }
>  EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
> 
> Can you help to drop the orignal patch you queued up to the linux-next?
> Thank you.
> 
> 
> David
> 
> ________________________________
> 发件人: Ingo Molnar <mingo.kernel.org@gmail.com> 代表 Ingo Molnar <mingo@kernel.org>
> 发送时间: 2018年3月12日 17:46:09
> 收件人: Rafael J. Wysocki
> 抄送: David Wang; len.brown@intel.com; pavel@ucw.cz; tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org; linux-pm@kernel.org; linux-kernel@vger.kernel.org; Bruce Chang (VAS); Cooper Yan(BJ-RD); Qiyuan Wang(BJ-RD); Benjamin Pan; Luke Lin; Tim Guo(BJ-RD); Cobe Chen(BJ-RD); Jiangbo Wang(BJ-RD)
> 主题: Re: 答复: [PATCH] Delete some unusefull operations for centaur CPU/platform
> 
> 
> * Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > On Monday, March 12, 2018 9:40:33 AM CET Ingo Molnar wrote:
> > >
> > > * David Wang <DavidWang@zhaoxin.com> wrote:
> > >
> > > > [David] pr->flags.has_cst means BIOS define valid C state table.  And at lease
> > > > define 2 entries. On all centaur platform which support C3, this condition is
> > > > always true.
> > >
> > > > [David] Just as the following comment said, we need not execute WBINVD and
> > > > ARB_DISABLE/ARB_ENABLE when entering C3 if bm_check=1 and bm_control=0.  This
> > > > logic is valid for all platform not only for Centaur, I think.
> > >
> > > Ok, fair enough!
> >
> > Well, I still have this one queued up as cpuidle material.
> >
> > I can drop it if you want to take it instead.
> 
> No need to drop it, it looks good to me!
> 
> Thanks,
> 
>         Ingo
> 

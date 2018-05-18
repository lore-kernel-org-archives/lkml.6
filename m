Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeERGWy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:22:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42039 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbeERGWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:22:52 -0400
X-Google-Smtp-Source: AB8JxZrwjmV3kZeGme0N6F4CGg5Xyk8193acpX0YtLbZ0ssOC++8mm0piNQ18m4ADW8Qc5ReXZy9aA==
Date: Fri, 18 May 2018 15:22:49 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 03/11] arm64: kexec_file: invoke the kernel without
 purgatory
Message-ID: <20180518062248.GK2737@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-4-takahiro.akashi@linaro.org>
 <9c830fe8-56d8-b43a-6265-43d31dffe61a@arm.com>
 <20180507052208.GD11326@linaro.org>
 <ece8d3cc-127f-6855-52fb-24e4a1d4e823@arm.com>
 <20180515044542.GC2737@linaro.org>
 <fbd2c6c6-be20-a9fa-0303-e4448225df18@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbd2c6c6-be20-a9fa-0303-e4448225df18@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Tue, May 15, 2018 at 05:15:52PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 15/05/18 05:45, AKASHI Takahiro wrote:
> > On Fri, May 11, 2018 at 06:03:49PM +0100, James Morse wrote:
> >> On 07/05/18 06:22, AKASHI Takahiro wrote:
> >>> On Tue, May 01, 2018 at 06:46:06PM +0100, James Morse wrote:
> >>>> On 25/04/18 07:26, AKASHI Takahiro wrote:
> >>>>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> >>>>> index f76ea92dff91..f7dbba00be10 100644
> >>>>> --- a/arch/arm64/kernel/machine_kexec.c
> >>>>> +++ b/arch/arm64/kernel/machine_kexec.c
> >>>>> @@ -205,10 +205,17 @@ void machine_kexec(struct kimage *kimage)
> >>
> >>>>>  	cpu_soft_restart(kimage != kexec_crash_image,
> >>>>> -		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
> >>>>> +		reboot_code_buffer_phys, kimage->head, kimage->start,
> >>>>> +#ifdef CONFIG_KEXEC_FILE
> >>>>> +				kimage->purgatory_info.purgatory_buf ?
> >>>>> +						0 : kimage->arch.dtb_mem);
> >>>>> +#else
> >>>>> +				0);
> >>>>> +#endif
> >>
> >>
> >>>> purgatory_buf seems to only be set in kexec_purgatory_setup_kbuf(), called from
> >>>> kexec_load_purgatory(), which we don't use. How does this get a value?
> >>>>
> >>>> Would it be better to always use kimage->arch.dtb_mem, and ensure that is 0 for
> >>>> regular kexec (as we can't know where the dtb is)? (image_arg may then be a
> >>>> better name).
> >>>
> >>> The problem is arch.dtb_mem is currently defined only if CONFIG_KEXEC_FILE.
> >>
> >> I thought it was ARCH_HAS_KIMAGE_ARCH, which we can define all the time if
> >> that's what we want.
> >>
> >>
> >>> So I would like to
> >>> - merge this patch with patch#8
> >>> - change the condition
> >>>         #ifdef CONFIG_KEXEC_FILE
> >>>        				kimage->file_mode ? kimage->arch.dtb_mem : 0);

We don't need "kimage->file_mode ?" since arch.dtb_mem is 0 if !file_mode.

> >>>         #else
> >>>         			0);
> >>>         #endif
> >>
> >> If we can avoid even this #ifdef by always having kimage->arch, I'd prefer that.
> >> If we do that 'dtb_mem' would need some thing that indicates its for kexec_file,
> >> as kexec has a DTB too, we just don't know where it is...
> > 
> > OK, but I want to have a minimum of kexec.arch always exist.
> 
> I'm curious, why? Its 32bytes that is allocated a maximum of twice.

I believe that I'm a stingy minimalist :)


> (my questions on what needs to go in there were because it looked like a third
> user was missing...)
> 
> 
> > How about this?
> >
> > | struct kimage_arch {
> > | 	phys_addr_t dtb_mem;
> > | #ifdef CONFIG_KEXEC_FILE
> 
> #ifdef in structs just breeds more #ifdefs, as the code that accesses those
> members has to be behind the same set of conditions.
> 
> Given this, I prefer the #ifdefs around cpu_soft_restart() as it doesn't force
> us to add more #ifdefs later.

OK

> For either option without purgatory_info:
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James

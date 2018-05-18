Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeERJvG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:51:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36774 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeERJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:51:02 -0400
X-Google-Smtp-Source: AB8JxZoYPJWPmLUWYKBL7N6LbKrCDIOeyAkiQlGIIjUIA9n2Ij0oecsVCOBr6+FslOTqiCmzTCtUqQ==
Date: Fri, 18 May 2018 18:50:59 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/11] arm64: kexec_file: add crash dump support
Message-ID: <20180518095057.GN2737@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-8-takahiro.akashi@linaro.org>
 <f8d8305d-42f5-e1e2-20c4-733cb38cbb8d@arm.com>
 <512cde7d-d84b-3623-cb09-a2d78acc11dc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512cde7d-d84b-3623-cb09-a2d78acc11dc@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:06:02AM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 15/05/18 18:11, James Morse wrote:
> > On 25/04/18 07:26, AKASHI Takahiro wrote:
> >> Enabling crash dump (kdump) includes
> >> * prepare contents of ELF header of a core dump file, /proc/vmcore,
> >>   using crash_prepare_elf64_headers(), and
> >> * add two device tree properties, "linux,usable-memory-range" and
> >>   "linux,elfcorehdr", which represent repsectively a memory range
> >>   to be used by crash dump kernel and the header's location
> 
> >> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >> index 37c0a9dc2e47..ec674f4d267c 100644
> >> --- a/arch/arm64/kernel/machine_kexec_file.c
> >> +++ b/arch/arm64/kernel/machine_kexec_file.c
> 
> >> +static struct crash_mem *get_crash_memory_ranges(void)
> >> +{
> >> +	unsigned int nr_ranges;
> >> +	struct crash_mem *cmem;
> >> +
> >> +	nr_ranges = 1; /* for exclusion of crashkernel region */
> >> +	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ranges_callback);
> >> +
> >> +	cmem = vmalloc(sizeof(struct crash_mem) +
> >> +			sizeof(struct crash_mem_range) * nr_ranges);
> >> +	if (!cmem)
> >> +		return NULL;
> >> +
> >> +	cmem->max_nr_ranges = nr_ranges;
> >> +	cmem->nr_ranges = 0;
> >> +	walk_system_ram_res(0, -1, cmem, add_mem_range_callback);
> >> +
> >> +	/* Exclude crashkernel region */
> >> +	if (crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end)) {
> >> +		vfree(cmem);
> >> +		return NULL;
> >> +	}
> >> +
> >> +	return cmem;
> >> +}
> > 
> > Could this function be included in prepare_elf_headers() so that the alloc() and
> > free() occur together.
> > 
> > 
> >> +static int prepare_elf_headers(void **addr, unsigned long *sz)
> >> +{
> >> +	struct crash_mem *cmem;
> >> +	int ret = 0;
> >> +
> >> +	cmem = get_crash_memory_ranges();
> >> +	if (!cmem)
> >> +		return -ENOMEM;
> >> +
> >> +	ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> >> +
> >> +	vfree(cmem);
> > 
> >> +	return ret;
> >> +}
> > 
> > All this is moving memory-range information from core-code's
> > walk_system_ram_res() into core-code's struct crash_mem, and excluding
> > crashk_res, which again is accessible to the core code.
> > 
> > It looks like this is duplicated in arch/x86 and arch/arm64 because arm64
> > doesn't have a second 'crashk_low_res' region, and always wants elf64, instead
> > of when IS_ENABLED(CONFIG_X86_64).
> 
> Thinking about it some more: don't we want to walk memblock here, not
> walk_system_ram_res()? What we want is a list of not-nomap regions that the
> kernel may have been using, to form part of vmcore.
> walk_system_ram_res() is becoming a murkier list of maybe-nomap, maybe-reserved.
> 
> I think we should walk the same list here as we do in patch 4.

For consistency, yes.
I missed that.

-Takahiro AKASHI

> 
> 
> Thanks,
> 
> James

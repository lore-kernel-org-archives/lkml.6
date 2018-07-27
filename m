Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDD9C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0B420673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aT4rFPL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0B420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbeG0IT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:19:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45012 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeG0IT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:19:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so2673874pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 23:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DrwXN0lnZyEtNP7fSC4yp+Ct1fvcLFammFPrQ18DXiU=;
        b=aT4rFPL3h0GatvLWd+ohi264DviSusYKUGzA8hJpwKgPh+8i/zw67M4gidXsNuiziW
         InqVNlQkmPSqFcxVTBdfQy6Ax4q9TZvW5ALqhdBMpTIlfbCzVFynJdPZ1KCzEeEN+/pW
         yqKONhYfJgoXPKE9J4aljOyPu8Pw6oaJRFo0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DrwXN0lnZyEtNP7fSC4yp+Ct1fvcLFammFPrQ18DXiU=;
        b=K6ouO3Y2as7iC3ZTpMU+ysehDoAlkHy2I9L0Rp7pKKBzfvyIS93XnaUE5DTvxEiMwK
         SCdxN4A/F9rUki990Yl0rU3dvgDvKHAxnEPrRXiI2kgL4cDSiZqNwc9icgpuiKCpgv8J
         MOEbSuZYdUYJxdFJVfSas8RCiUDaSI0Jy2OpOu1UB1p+F9sE/fBmT55DQj+qyYaQTio8
         s2+MHMbX2QN28T7xTliJG31iVR0tWEadg9aucT433tJ/7rBL+d857/qLmegy9Uw3GoTR
         bJaIG+7CeipozpLmAdn5lecheM/bCcMVjp01wb8yBr6CyPmN9BK3GtEBHPuDPgdzIgvf
         66Sg==
X-Gm-Message-State: AOUpUlERxrMXerxZ1+tS45sPXcSdM8+9R7Yn/nZ1/4E9G0ux7VEwpbOY
        1zGwO8hqj7nOSiHkZMZvCf4H/Q==
X-Google-Smtp-Source: AAOMgpfCLr1oYAAw5unhQ3LD3UHJsngkj+7oc96ot4jaRLRQsqTmsN0bABwtL/P0yLrAUrV00L8KQA==
X-Received: by 2002:a65:5106:: with SMTP id f6-v6mr4857600pgq.72.1532674737769;
        Thu, 26 Jul 2018 23:58:57 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm5119055pgi.33.2018.07.26.23.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 23:58:57 -0700 (PDT)
Date:   Fri, 27 Jul 2018 16:00:31 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 12/16] arm64: kexec_file: add crash dump support
Message-ID: <20180727070030.GG11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-13-takahiro.akashi@linaro.org>
 <e7605411-c54f-c744-43a7-aecc0e36e3f3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7605411-c54f-c744-43a7-aecc0e36e3f3@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 02:36:58PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 24/07/18 07:57, AKASHI Takahiro wrote:
> > Enabling crash dump (kdump) includes
> > * prepare contents of ELF header of a core dump file, /proc/vmcore,
> >   using crash_prepare_elf64_headers(), and
> > * add two device tree properties, "linux,usable-memory-range" and
> >   "linux,elfcorehdr", which represent respectively a memory range
> >   to be used by crash dump kernel and the header's location
> 
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index 5d102a1054b3..1b2c27026ae0 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -97,8 +97,12 @@ static inline void crash_post_resume(void) {}
> >  #define ARCH_HAS_KIMAGE_ARCH
> >  
> >  struct kimage_arch {
> 
> > -	void *dtb_buf;
> > +	void *dtb;
> 
> This change should be in an earlier patch, otherwise this series doesn't build
> during bisect.

Will fix.

> With the build-issues fixed:
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> Some boring Nits:
> 
> >  	unsigned long dtb_mem;
> > +	/* Core ELF header buffer */
> > +	void *elf_headers;
> > +	unsigned long elf_headers_mem;
> > +	unsigned long elf_headers_sz;
> >  };
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index b8297f10e2ef..7356da5a53d5 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > @@ -38,12 +44,30 @@ static int setup_dtb(struct kimage *image,
> >  		void **dtb_buf, unsigned long *dtb_buf_len)
> >  {
> >  	void *buf = NULL;
> > -	size_t buf_size;
> > +	size_t buf_size, range_size;
> >  	int nodeoffset;
> >  	int ret;
> >  
> >  	/* duplicate dt blob */
> >  	buf_size = fdt_totalsize(initial_boot_params);
> > +	range_size = of_fdt_reg_cells_size();
> > +
> > +	if (image->type == KEXEC_TYPE_CRASH) {
> > +		buf_size += fdt_prop_len("linux,elfcorehdr", range_size);
> > +		buf_size += fdt_prop_len("linux,usable-memory-range",
> > +								range_size);
> > +	}
> 
> Nit: it would be better if these strings were defined in a header file somewhere
> so we don't risk a typo if this gets refactored.

Nit??
Well, I do understand your concern, but it's a bit headache.
If we handle them in such a way, we may want to handle others, such as
linux,initrd-start/end, chosen and bootargs, as well in this file.
They are not kexec specific and should go into a common header. This will
end up propagating similar changes to other no-kexec-related occurrences
under drivers/of.

So I want to keep the following def's local in this file for easy
maintenance.
#define FDT_PSTR_KEXEC_ELFHDR  "linux,elfcorehdr"
#define FDT_PSTR_MEM_RANGE     "linux,usable-memory-range"
#define FDT_PSTR_INITRD_ST     "linux,initrd-start"
#define FDT_PSTR_INITRD_END    "linux,initrd-end"
#define FDT_PSTR_BOOTARGS       "bootargs"
#define FDT_PSTR_KASLR_SEED     "kaslr-seed"

> 
> 
> > @@ -129,6 +170,43 @@ static int setup_dtb(struct kimage *image,
> >  	return ret;
> >  }
> >  
> > +static int prepare_elf_headers(void **addr, unsigned long *sz)
> > +{
> > +	struct crash_mem *cmem;
> > +	unsigned int nr_ranges;
> > +	int ret;
> > +	u64 i;
> > +	phys_addr_t start, end;
> > +
> > +	nr_ranges = 1; /* for exclusion of crashkernel region */
> 
> > +	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
> > +							&start, &end, NULL)
> 
> Nit: MEMBLOCK_NONE

OK

-Takahiro AKASHI


> 
> Thanks,
> 
> James

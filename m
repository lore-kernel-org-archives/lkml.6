Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9D7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6C920673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3bId1lV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6C920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeG0Gnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:43:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37155 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeG0Gnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:43:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so1336895pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 22:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DkujKsyZwB6+XrtJYQ2JmwDaKL0Q1eftBWs81ZFPFHk=;
        b=C3bId1lVSieuYXTTmX2j6438IHzDO9OayuxCTPRmYKGEkjeZbSq4fR8vxt4vetu7fF
         WzuAy1qx/S80C6YP892Iv8RBJ62wIgWsjy3J6p9nVc7KBHbg1dJc80g8y/GGzCjAn+c6
         1V0j3we54FcIOD3JmgOU2R8A9ZJdEHWVgIoMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DkujKsyZwB6+XrtJYQ2JmwDaKL0Q1eftBWs81ZFPFHk=;
        b=QPcuZ2DpopybT5bNKxT1c74/7AXm7dDZIvRMpb9PGQJbu8mrEYyzOd/kjZp1D4bo0O
         EGpQ/iyvXftSK5yukUR9J8IirJeLdgKO5xj/qLxmeTm72PR0LE47OoLHzUn+4ux9Y2I2
         mt/DJW0bQbN8Q/JJ8ytMsBtV6R7f9JaomRDHx+pTPh9Tifj02jAm7WO3/vdOuOH52T03
         nWxiLRs1g8LPele64V7c+i4CxEOd48s+zV4oHgnrZq6Ace1ZUx7hp/eTBWldWiRgauRq
         wVPoE6Gq6XW19wmuAdLOspB/nWLdEnm2sorlSPSCeE0QlsS3AnNCbBTPzLiComBTvFnD
         9deg==
X-Gm-Message-State: AOUpUlEW1K2QPIKgpuveHhx+FZ6ob5ROSbZpvpFovFXGAhEaSUC1ttia
        2vbwrmUPxKw6DOVTdQ2HX84gTw==
X-Google-Smtp-Source: AAOMgpdO64+Yih++9ttUszbeWD7H/XCmXtjFhcbvbGgiRfrKfIL5F2R3FoAtR+F64YFMtBTkNEUmNg==
X-Received: by 2002:a62:ff0e:: with SMTP id b14-v6mr5112056pfn.135.1532669021109;
        Thu, 26 Jul 2018 22:23:41 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id c68-v6sm6751486pfj.51.2018.07.26.22.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 22:23:40 -0700 (PDT)
Date:   Fri, 27 Jul 2018 14:25:14 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v12 04/16] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
Message-ID: <20180727052513.GE11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-5-takahiro.akashi@linaro.org>
 <20180725123129.GA2361@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725123129.GA2361@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:31:29PM +0800, Dave Young wrote:
> On 07/24/18 at 03:57pm, AKASHI Takahiro wrote:
> > Memblock list is another source for usable system memory layout.
> > So move powerpc's arch_kexec_walk_mem() to common code so that other
> > memblock-based architectures, particularly arm64, can also utilise it.
> > A moved function is now renamed to kexec_walk_memblock() and integrated
> > into kexec_locate_mem_hole(), which will now be usable for all
> > architectures with no need for overriding arch_kexec_walk_mem().
> > 
> > kexec_walk_memblock() will not work for kdump in this form, this will be
> > fixed in the next patch.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Acked-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/powerpc/kernel/machine_kexec_file_64.c | 54 -------------------
> >  include/linux/kexec.h                       |  2 -
> >  kernel/kexec_file.c                         | 58 ++++++++++++++++++++-
> >  3 files changed, 56 insertions(+), 58 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
> > index 0bd23dc789a4..5357b09902c5 100644
> > --- a/arch/powerpc/kernel/machine_kexec_file_64.c
> > +++ b/arch/powerpc/kernel/machine_kexec_file_64.c
> > @@ -24,7 +24,6 @@
> >  
> >  #include <linux/slab.h>
> >  #include <linux/kexec.h>
> > -#include <linux/memblock.h>
> >  #include <linux/of_fdt.h>
> >  #include <linux/libfdt.h>
> >  #include <asm/ima.h>
> > @@ -46,59 +45,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> >  	return kexec_image_probe_default(image, buf, buf_len);
> >  }
> >  
> > -/**
> > - * arch_kexec_walk_mem - call func(data) for each unreserved memory block
> > - * @kbuf:	Context info for the search. Also passed to @func.
> > - * @func:	Function to call for each memory block.
> > - *
> > - * This function is used by kexec_add_buffer and kexec_locate_mem_hole
> > - * to find unreserved memory to load kexec segments into.
> > - *
> > - * Return: The memory walk will stop when func returns a non-zero value
> > - * and that value will be returned. If all free regions are visited without
> > - * func returning non-zero, then zero will be returned.
> > - */
> > -int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > -			int (*func)(struct resource *, void *))
> > -{
> > -	int ret = 0;
> > -	u64 i;
> > -	phys_addr_t mstart, mend;
> > -	struct resource res = { };
> > -
> > -	if (kbuf->top_down) {
> > -		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
> > -						&mstart, &mend, NULL) {
> > -			/*
> > -			 * In memblock, end points to the first byte after the
> > -			 * range while in kexec, end points to the last byte
> > -			 * in the range.
> > -			 */
> > -			res.start = mstart;
> > -			res.end = mend - 1;
> > -			ret = func(&res, kbuf);
> > -			if (ret)
> > -				break;
> > -		}
> > -	} else {
> > -		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
> > -					NULL) {
> > -			/*
> > -			 * In memblock, end points to the first byte after the
> > -			 * range while in kexec, end points to the last byte
> > -			 * in the range.
> > -			 */
> > -			res.start = mstart;
> > -			res.end = mend - 1;
> > -			ret = func(&res, kbuf);
> > -			if (ret)
> > -				break;
> > -		}
> > -	}
> > -
> > -	return ret;
> > -}
> > -
> >  /**
> >   * setup_purgatory - initialize the purgatory's global variables
> >   * @image:		kexec image.
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 49ab758f4d91..c196bfd11bee 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -184,8 +184,6 @@ int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
> >  					const Elf_Shdr *relsec,
> >  					const Elf_Shdr *symtab);
> >  
> > -int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > -			       int (*func)(struct resource *, void *));
> >  extern int kexec_add_buffer(struct kexec_buf *kbuf);
> >  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
> >  
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index bf39df5e5bb9..2f0691b0f8ad 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/file.h>
> >  #include <linux/slab.h>
> >  #include <linux/kexec.h>
> > +#include <linux/memblock.h>
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> >  #include <linux/fs.h>
> > @@ -501,6 +502,55 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> >  	return locate_mem_hole_bottom_up(start, end, kbuf);
> >  }
> >  
> > +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
> > +static int kexec_walk_memblock(struct kexec_buf *kbuf,
> > +			       int (*func)(struct resource *, void *))
> > +{
> > +	int ret = 0;
> > +	u64 i;
> > +	phys_addr_t mstart, mend;
> > +	struct resource res = { };
> > +
> > +	if (kbuf->top_down) {
> > +		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
> > +						&mstart, &mend, NULL) {
> > +			/*
> > +			 * In memblock, end points to the first byte after the
> > +			 * range while in kexec, end points to the last byte
> > +			 * in the range.
> > +			 */
> > +			res.start = mstart;
> > +			res.end = mend - 1;
> > +			ret = func(&res, kbuf);
> > +			if (ret)
> > +				break;
> > +		}
> > +	} else {
> > +		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
> > +					NULL) {
> > +			/*
> > +			 * In memblock, end points to the first byte after the
> > +			 * range while in kexec, end points to the last byte
> > +			 * in the range.
> > +			 */
> > +			res.start = mstart;
> > +			res.end = mend - 1;
> > +			ret = func(&res, kbuf);
> > +			if (ret)
> > +				break;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +#else
> > +static int kexec_walk_memblock(struct kexec_buf *kbuf,
> > +			       int (*func)(struct resource *, void *))
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  /**
> >   * arch_kexec_walk_mem - call func(data) on free memory regions
> >   * @kbuf:	Context info for the search. Also passed to @func.
> > @@ -510,7 +560,7 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> >   * and that value will be returned. If all free regions are visited without
> >   * func returning non-zero, then zero will be returned.
> >   */
> > -int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > +static int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> >  			       int (*func)(struct resource *, void *))
> >  {
> >  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> > @@ -538,7 +588,11 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> >  	if (kbuf->mem)
> >  		return 0;
> >  
> > -	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > +		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
> > +	else
> > +		ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> 
> AKASHI, since it is not weak function now, it would be better to rename
> the function for example name it as kexec_walk_resource()

OK.

-Takahiro AKASHI


> Other than this,
> 
> Acked-by: Dave Young <dyoung@redhat.com>
> 
> >  
> >  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
> >  }
> > -- 
> > 2.18.0
> > 
> 
> Thanks
> Dave

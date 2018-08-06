Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38931C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4491219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4491219CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeHFH63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 03:58:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbeHFH63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 03:58:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9576440216EA;
        Mon,  6 Aug 2018 05:51:02 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFAB716873;
        Mon,  6 Aug 2018 05:50:52 +0000 (UTC)
Date:   Mon, 6 Aug 2018 13:50:47 +0800
From:   Dave Young <dyoung@redhat.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Philipp Rudo <prudo@linux.ibm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Message-ID: <20180806055047.GC4246@dhcp-128-65.nay.redhat.com>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
 <20180801075820.3753-4-takahiro.akashi@linaro.org>
 <20180801102951.527cfc57@ThinkPad>
 <20180802000150.GN11258@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802000150.GN11258@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 06 Aug 2018 05:51:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 06 Aug 2018 05:51:02 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Thiago in cc so that he can review from powerpc point of view. 

On 08/02/18 at 09:01am, AKASHI Takahiro wrote:
> Hi,
> 
> On Wed, Aug 01, 2018 at 10:29:51AM +0200, Philipp Rudo wrote:
> > Hey Akashi,
> > 
> > I kept thinking about this patch and remembered why I didn't made the change
> > you are suggesting now.
> 
> Hmm.
> 
> > The problem is when you only check for kbuf->mem you are excluding address 0,
> > which might be a valid address to load the kernel to. On s390 this is actually
> > done when the kernel is not loaded via a boot loader. For kexec_file however,
> > we cut off the first few kB of the image and jump directly to 'startup'. So
> > checking for !0 does not cause a problem here.
> 
> Yeah, as Dave(RedHat) described, all the current kexec-capable architectures,
> except arm64, implicitly initialize kbuf.mem to zero with "kbuf = { ... }"
> initializer. So surely my change would not break anything on the existing code.
> On the other hand, I also see your concern here.
> 
> > Anyway, the long term safer solution would be something like
> > 
> > #define KEXEC_BUF_MEM_UNKNOWN (-1UL)
> > 
> > for architectures to tell common code to search a fitting mem hole.
> 
> This would require the existing code on every arch to be modified, which
> I think should be avoided if possible. Instead,
> we'd better define in linux/kexec.h:
>   #ifndef KEXEC_BUF_MEM_UNKNOWN
>   #define KEXEC_BUF_MEM_UNKNOWN 0
>   #endif
> and then check for kbuf in kexec_locate_mem_hole():
>   if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
>         return 0;
>   ...
> 
> This way if some arch wants to treat *zero* as a valid address, it can
> redefine this macro in arch/asm/kexec.h.

I think this way works if powerpc is safe for using zero as the unknown
address in this case.  Thiago, can you provide some review?

Philipp, thanks for catching the problem!

> 
> Thanks,
> -Takahiro AKASHI
> 
> > 
> > Back then I didn't do the change because I had the other workaround, which
> > didn't require a common code change. But when you are touching the code now it
> > is worth thinking about it.
> > 
> > Just wanted to let you know
> > Philipp
> > 
> > 
> > On Wed,  1 Aug 2018 16:58:07 +0900
> > AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > 
> > > Since s390 already knows where to locate buffers, calling
> > > arch_kexec_mem_walk() has no sense. So we can just drop it as kbuf->mem
> > > indicates this while all other architectures sets it to 0 initially.
> > > 
> > > This change is a preparatory work for the next patch, where all the
> > > variant memory walks, either on system resource or memblock, will be
> > > put in one common place so that it will satisfy all the architectures'
> > > need.
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
> > > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > ---
> > >  arch/s390/kernel/machine_kexec_file.c | 10 ----------
> > >  kernel/kexec_file.c                   |  4 ++++
> > >  2 files changed, 4 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> > > index f413f57f8d20..32023b4f9dc0 100644
> > > --- a/arch/s390/kernel/machine_kexec_file.c
> > > +++ b/arch/s390/kernel/machine_kexec_file.c
> > > @@ -134,16 +134,6 @@ int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
> > >  	return ret;
> > >  }
> > >  
> > > -/*
> > > - * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
> > > - * and provide kbuf->mem by hand.
> > > - */
> > > -int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > -			int (*func)(struct resource *, void *))
> > > -{
> > > -	return 1;
> > > -}
> > > -
> > >  int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> > >  				     Elf_Shdr *section,
> > >  				     const Elf_Shdr *relsec,
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 63c7ce1c0c3e..bf39df5e5bb9 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> > >  {
> > >  	int ret;
> > >  
> > > +	/* Arch knows where to place */
> > > +	if (kbuf->mem)
> > > +		return 0;
> > > +
> > >  	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > >  
> > >  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
> > 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

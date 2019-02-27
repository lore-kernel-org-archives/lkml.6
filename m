Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D344C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C55218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551285694;
	bh=RnTCGLr7NGCBpQEanbI0wrXnYJkExp58+Yn8/dl27mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bDXTaTzjPu7KKp+48Wttt8PlHSXvJbAfi4rssDU5tijKYY63fY6DwhzXku/k2i2+7
	 9KSeWheFhiDOhEVUDHJ5LjCQQnuqZI6sMOO/m1NTManMXujgG5lLbHlnTDOMNfJOYA
	 C6cKhoX8NPyIcNRE/B/iB0+Aq1ko4ExjXxe86pmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfB0Qlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:41:32 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37798 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfB0Qlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:41:32 -0500
Received: by mail-yw1-f66.google.com with SMTP id k14so8595446ywe.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 08:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jNzRPllHbXzBk5WYe7f3lRJ+kSXDkAC5RCs6HE5sl1c=;
        b=rQm1XM7ZCxe9pynHtwYRlEnLTepAgF3sC1YwXAxJZIMXoYt7Lo5KmymNgcrSsuiuAs
         cMVTxQ79x4hgaKH+inyIT6DFhbnEUGC1SgrXv9d+n7vl0Fkj5HwHwy4w0JevS+lAA315
         OCZAgfmaZ8y18uCoWXL8X4eJNBQbYLW1iyAVyYaMC7cB7wRPUEqODyCDhb+PzC93GISk
         hl92f0ryiiAwEQaq1KCqvr8PntSOd+OdLILFizIaQakXK48tyHZ7h0QdtrlC13AxIw6j
         5/fJAArSbL2RAH/gIOW+6NkKk2kdGfJBYGIRpuMIlXh+9afJ/HqAatnFS1thXKThYB+d
         bQ8w==
X-Gm-Message-State: AHQUAub1JNOdzrH3R22U+G7gtRayaId8qxvsm1FM5N1uepsMbMiBODiX
        +wpGP0vYEgcbjUq+OXLG2po=
X-Google-Smtp-Source: AHgI3IbKH3+fgAypoAZtrtfyFnKP+trAnXt2RuqX5SR1W3x9nJtUN9pQo4drfhvFOmUZDHM6j1W9Bw==
X-Received: by 2002:a25:b9c3:: with SMTP id y3mr2789679ybj.77.1551285690682;
        Wed, 27 Feb 2019 08:41:30 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:8416])
        by smtp.gmail.com with ESMTPSA id 142sm3762157ywl.31.2019.02.27.08.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 08:41:28 -0800 (PST)
Date:   Wed, 27 Feb 2019 11:41:25 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 1/2] percpu: km: remove SMP check
Message-ID: <20190227164125.GA2379@dennisz-mbp.dhcp.thefacebook.com>
References: <20190224132518.20586-1-peng.fan@nxp.com>
 <20190225151330.GA49611@dennisz-mbp.dhcp.thefacebook.com>
 <010001692a612815-46229701-ea3f-4a89-8f88-0c74194ba257-000000@email.amazonses.com>
 <20190226170339.GB47262@dennisz-mbp.dhcp.thefacebook.com>
 <AM0PR04MB44814B3BA09388DFF3681E1388740@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB44814B3BA09388DFF3681E1388740@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 01:02:16PM +0000, Peng Fan wrote:
> Hi Dennis
> 
> > -----Original Message-----
> > From: Dennis Zhou [mailto:dennis@kernel.org]
> > Sent: 2019年2月27日 1:04
> > To: Christopher Lameter <cl@linux.com>
> > Cc: Peng Fan <peng.fan@nxp.com>; tj@kernel.org; linux-mm@kvack.org;
> > linux-kernel@vger.kernel.org; van.freenix@gmail.com
> > Subject: Re: [PATCH 1/2] percpu: km: remove SMP check
> > 
> > On Tue, Feb 26, 2019 at 03:16:44PM +0000, Christopher Lameter wrote:
> > > On Mon, 25 Feb 2019, Dennis Zhou wrote:
> > >
> > > > > @@ -27,7 +27,7 @@
> > > > >   *   chunk size is not aligned.  percpu-km code will whine about it.
> > > > >   */
> > > > >
> > > > > -#if defined(CONFIG_SMP) &&
> > > > > defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
> > > > > +#if defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
> > > > >  #error "contiguous percpu allocation is incompatible with paged first
> > chunk"
> > > > >  #endif
> > > > >
> > > > > --
> > > > > 2.16.4
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > I think keeping CONFIG_SMP makes this easier to remember
> > > > dependencies rather than having to dig into the config. So this is a NACK
> > from me.
> > >
> > > But it simplifies the code and makes it easier to read.
> > >
> > >
> > 
> > I think the check isn't quite right after looking at it a little longer.
> > Looking at x86, I believe you can compile it with !SMP and
> > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK will still be set. This should
> > still work because x86 has an MMU.
> 
> You are right, x86 could boots up with NEED_PER_CPU_PAGE_FIRST_CHUNK
> =y and SMP=n. Tested with qemu, info as below:
> 
> / # zcat /proc/config.gz | grep NEED_PER_CPU_KM
> CONFIG_NEED_PER_CPU_KM=y
> / # zcat /proc/config.gz | grep SMP
> CONFIG_BROKEN_ON_SMP=y
> # CONFIG_SMP is not set
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> / # zcat /proc/config.gz | grep NEED_PER_CPU_PAGE_FIRST_CHUNK
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> / # cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : QEMU Virtual CPU version 2.5+
> stepping        : 3
> cpu MHz         : 3192.613
> cache size      : 512 KB
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 13
> wp              : yes
> flags           : fpu de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx lm nopl cpuid pni cx16 hypervisor lahf_lm svm 3dnowprefetl
> bugs            : fxsave_leak sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
> bogomips        : 6385.22
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 42 bits physical, 48 bits virtual
> power management:
> 
> 
> But from the comments in this file:
> "
> * - CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK must not be defined.  It's
>  *   not compatible with PER_CPU_KM.  EMBED_FIRST_CHUNK should work
>  *   fine.
> "
> 
> I did not read into details why it is not allowed, but x86 could still work with KM
> and NEED_PER_CPU_PAGE_FIRST_CHUNK.
> 

The first chunk requires special handling on SMP to bring the static
variables into the percpu address space. On UP, identity mapping makes
static variables indistinguishable by aligning the percpu address space
and the virtual adress space. The percpu-km allocator allocates full
chunks at a time to deal with NOMMU archs. So the difference is if the
virtual address space is the same as the physical.

> > 
> > I think more correctly it would be something like below, but I don't have the
> > time to fully verify it right now.
> > 
> > Thanks,
> > Dennis
> > 
> > ---
> > diff --git a/mm/percpu-km.c b/mm/percpu-km.c index
> > 0f643dc2dc65..69ccad7d9807 100644
> > --- a/mm/percpu-km.c
> > +++ b/mm/percpu-km.c
> > @@ -27,7 +27,7 @@
> >   *   chunk size is not aligned.  percpu-km code will whine about it.
> >   */
> > 
> > -#if defined(CONFIG_SMP) &&
> > defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
> > +#if !defined(CONFIG_MMU) &&
> > +defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
> >  #error "contiguous percpu allocation is incompatible with paged first chunk"
> >  #endif
> > 
> 
> Acked-by: Peng Fan <peng.fan@nxp.com>
> 
> Thanks,
> Peng

While this change may seem right to me. Verification would be to double
check other architectures too. x86 just happened to be a counter example
I had in mind. Unless someone reports this as being an issue or someone
takes the time to validate this more thoroughly than my cursory look.
I think the risk of this outweighs the benefit. This may be something I
fix in the future when I have more time. This would also involve making
sure the comments are consistent.

Thanks,
Dennis

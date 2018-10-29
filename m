Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF30C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDD420824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDD420824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeJ3Bvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:51:47 -0400
Received: from foss.arm.com ([217.140.101.70]:43328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbeJ3Bvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:51:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA4EA80D;
        Mon, 29 Oct 2018 10:02:19 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA69E3F71D;
        Mon, 29 Oct 2018 10:02:19 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CA6221AE091C; Mon, 29 Oct 2018 17:02:26 +0000 (GMT)
Date:   Mon, 29 Oct 2018 17:02:26 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Anders Roxell <anders.roxell@linaro.org>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH] arm64: kprobe: make page to RO mode when allocate it
Message-ID: <20181029170226.GA16739@arm.com>
References: <20181015111600.5479-1-anders.roxell@linaro.org>
 <20181029120434.GA15446@arm.com>
 <CAK8P3a0oSn8Z6wJT1X2si8+A2wttkh7EjqD_MZYt4+L5a_XKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0oSn8Z6wJT1X2si8+A2wttkh7EjqD_MZYt4+L5a_XKLg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 01:11:24PM +0100, Arnd Bergmann wrote:
> On 10/29/18, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Oct 15, 2018 at 01:16:00PM +0200, Anders Roxell wrote:
> 
> >> -static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> >> +void *alloc_insn_page(void)
> >>  {
> >> -	void *addrs[1];
> >> -	u32 insns[1];
> >> +	void *page;
> >>
> >> -	addrs[0] = (void *)addr;
> >> -	insns[0] = (u32)opcode;
> >> +	page = vmalloc_exec(PAGE_SIZE);
> >> +	if (page)
> >> +		set_memory_ro((unsigned long)page & PAGE_MASK, 1);
> >
> > This looks a bit strange to me -- you're allocating PAGE_SIZE bytes so
> > that we can adjust the permissions, yet we can't guarantee that page is
> > actually page-aligned and therefore end up explicitly masking down.
> >
> > In which case allocating an entire page isn't actually helping us, and
> > we could end up racing with somebody else changing permission on the
> > same page afaict.
> >
> > I think we need to ensure we really have an entire page, perhaps using
> > vmap() instead? Or have I missed some subtle detail here?
> 
> I'm fairly sure that vmalloc() and vmalloc_exec() is guaranteed to be page
> aligned everywhere. The documentation is a bit vague here, but I'm
> still confident enough that we can make that assumption based on
> 
> /**
>  *      vmalloc_exec  -  allocate virtually contiguous, executable memory
>  *      @size:          allocation size
>  *
>  *      Kernel-internal function to allocate enough pages to cover @size
>  *      the page level allocator and map them into contiguous and
>  *      executable kernel virtual space.
>  *
>  *      For tight control over page level allocator and protection flags
>  *      use __vmalloc() instead.
>  */
> void *vmalloc_exec(unsigned long size)

FWIW, I did a bit of digging and I agree with your conclusion. vmalloc()
allocations end up getting installed in map_vm_area() via
__vmalloc_area_node(), which allocates things a page at a time.

So we can simplify this patch to drop the masking when calling
set_memory_ro().

Will

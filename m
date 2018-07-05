Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED9C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D5824114
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D5824114
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeGEORw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:17:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753870AbeGEORt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:17:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8E2040073BA;
        Thu,  5 Jul 2018 14:17:48 +0000 (UTC)
Received: from ovpn-121-174.rdu2.redhat.com (ovpn-121-174.rdu2.redhat.com [10.10.121.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27133111E418;
        Thu,  5 Jul 2018 14:17:48 +0000 (UTC)
Message-ID: <535c14f5856b912fb4adb0c4c3c7bd16ae12c691.camel@redhat.com>
Subject: Re: [PATCH] c6x: switch to NO_BOOTMEM
From:   Mark Salter <msalter@redhat.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        linux-c6x <linux-c6x-dev@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Thu, 05 Jul 2018 10:17:47 -0400
In-Reply-To: <20180704132510.GI4352@rapoport-lnx>
References: <1530101360-5768-1-git-send-email-rppt@linux.vnet.ibm.com>
         <20180704132510.GI4352@rapoport-lnx>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 05 Jul 2018 14:17:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 05 Jul 2018 14:17:48 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msalter@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 16:25 +0300, Mike Rapoport wrote:
> Any comments on this?
> 
> On Wed, Jun 27, 2018 at 03:09:20PM +0300, Mike Rapoport wrote:
> > The c6x is already using memblock and does most of early memory
> > reservations with it, so it was only a matter of removing the bootmem
> > initialization and handover of the memory from memblock to bootmem.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> >  arch/c6x/Kconfig        |  1 +
> >  arch/c6x/kernel/setup.c | 26 +-------------------------
> >  2 files changed, 2 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
> > index bf59855628ac..054c7c963180 100644
> > --- a/arch/c6x/Kconfig
> > +++ b/arch/c6x/Kconfig
> > @@ -14,6 +14,7 @@ config C6X
> >  	select GENERIC_IRQ_SHOW
> >  	select HAVE_ARCH_TRACEHOOK
> >  	select HAVE_MEMBLOCK
> > +	select NO_BOOTMEM
> >  	select SPARSE_IRQ
> >  	select IRQ_DOMAIN
> >  	select OF
> > diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
> > index 786e36e2f61d..cc74cb9d349b 100644
> > --- a/arch/c6x/kernel/setup.c
> > +++ b/arch/c6x/kernel/setup.c
> > @@ -296,7 +296,6 @@ notrace void __init machine_init(unsigned long dt_ptr)
> > 
> >  void __init setup_arch(char **cmdline_p)
> >  {
> > -	int bootmap_size;
> >  	struct memblock_region *reg;
> > 
> >  	printk(KERN_INFO "Initializing kernel\n");
> > @@ -353,16 +352,6 @@ void __init setup_arch(char **cmdline_p)
> >  	init_mm.end_data   = memory_start;
> >  	init_mm.brk        = memory_start;
> > 
> > -	/*
> > -	 * Give all the memory to the bootmap allocator,  tell it to put the
> > -	 * boot mem_map at the start of memory
> > -	 */
> > -	bootmap_size = init_bootmem_node(NODE_DATA(0),
> > -					 memory_start >> PAGE_SHIFT,
> > -					 PAGE_OFFSET >> PAGE_SHIFT,
> > -					 memory_end >> PAGE_SHIFT);
> > -	memblock_reserve(memory_start, bootmap_size);
> > -
> >  	unflatten_device_tree();
> > 
> >  	c6x_cache_init();
> > @@ -397,22 +386,9 @@ void __init setup_arch(char **cmdline_p)
> >  	/* Initialize the coherent memory allocator */
> >  	coherent_mem_init(dma_start, dma_size);
> > 
> > -	/*
> > -	 * Free all memory as a starting point.
> > -	 */
> > -	free_bootmem(PAGE_OFFSET, memory_end - PAGE_OFFSET);
> > -
> > -	/*
> > -	 * Then reserve memory which is already being used.
> > -	 */
> > -	for_each_memblock(reserved, reg) {
> > -		pr_debug("reserved - 0x%08x-0x%08x\n",
> > -			 (u32) reg->base, (u32) reg->size);
> > -		reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
> > -	}
> > -
> >  	max_low_pfn = PFN_DOWN(memory_end);
> >  	min_low_pfn = PFN_UP(memory_start);
> > +	max_pfn = max_low_pfn;
> >  	max_mapnr = max_low_pfn - min_low_pfn;
> > 
> >  	/* Get kmalloc into gear */
> > -- 
> > 2.7.4
> > 
> 
> 
Thanks. Looks fine. I'll pull it into c6x tree for next merge window.



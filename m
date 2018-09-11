Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C21C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC5F20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC5F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeIKNQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:16:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeIKNQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:16:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1841681663CE;
        Tue, 11 Sep 2018 08:18:15 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33ECB2022EEE;
        Tue, 11 Sep 2018 08:18:13 +0000 (UTC)
Date:   Tue, 11 Sep 2018 16:18:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/3] x86/mm/KASLR: Calculate the actual size of
 vmemmap region
Message-ID: <20180911081811.GY1740@192.168.1.3>
References: <20180909124946.17988-1-bhe@redhat.com>
 <20180909124946.17988-2-bhe@redhat.com>
 <20180910061151.GA85199@gmail.com>
 <20180911073057.GW1740@192.168.1.3>
 <20180911075946.GA97454@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911075946.GA97454@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 11 Sep 2018 08:18:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 11 Sep 2018 08:18:15 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/18 at 09:59am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> >  /*
> > + * Memory regions randomized by KASLR (except modules that use a separate
> > + * logic earlier during boot). Currently they are the physical memory
> > + * mapping, vmalloc and vmemmap regions, are ordered based on virtual
> > + * addresses. The order is kept after randomization.
> > + *
> > + * @base: points to various global variables used by the MM to get the
> > + * virtual base address of the above regions, which base addresses can
> > + * thus be modified by the very early KASLR code to dynamically shape
> > + * the virtual memory layout of these kernel memory regions on a per
> > + * bootup basis.
> > + *
> > + * @size_tb: size in TB of each memory region. Thereinto, the size of
> > + * the physical memory mapping region is variable, calculated according
> > + * to the actual size of system RAM in order to save more space for
> > + * randomization. The rest are fixed values related to paging mode.
> >   */
> >  static __initdata struct kaslr_memory_region {
> >  	unsigned long *base;
> 
> LGTM mostly, except the @size_tb field, see my comments further below.
> 
> Here's an edited version:
> 
> /*
>  * 'struct kasl_memory_region' entries represent continuous chunks of
>  * kernel virtual memory regions, to be randomized by KASLR.
>  *
>  * ( The exception is the module space virtual memory window which
>  *   uses separate logic earlier during bootup. )
>  *
>  * Currently there are three such regions: the physical memory mapping,
>  * vmalloc and vmemmap regions.
>  *
>  * The array below has the entries ordered based on virtual addresses.
>  * The order is kept after randomization, i.e. the randomized
>  * virtual addresses of these regions are still ascending.
>  *
>  * Here are the fields:
>  *
>  * @base: points to a global variable used by the MM to get the
>  * virtual base address of any of the above regions. This allows the
>  * early KASLR code to modify these base addresses early during bootup,
>  * on a per bootup basis, without the MM code even being aware of whether
>  * it got changed and to what value.
>  *
>  * When KASLR is active then the MM code makes sure that for each region
>  * there's such a single, dynamic, global base address 'unsigned long'
>  * variable available for the KASLR code to point to and modify directly:

>  *
>  *       { &page_offset_base, 0 },
>  *       { &vmalloc_base,     0 },
>  *       { &vmemmap_base,     1 },
>  *
>  * @size_tb: size in TB of each memory region. Thereinto, the size of
>  * the physical memory mapping region is variable, calculated according
>  * to the actual size of system RAM in order to save more space for
>  * randomization. The rest are fixed values related to paging mode.
>  */
> 
> The role of @size_tb is still murky to me. What is it telling us?
> Maximum virtual memory range to randomize into? Why does this depend
> on system RAM at all - aren't these all virtual addresses in a 64-bit
> (well, 48-bit or 56-bit) address ranges?

* @size_tb: size in TB of each memory region. Thereinto, the size of
* the physical memory mapping region is variable, calculated according
* to the actual size of system RAM. Since most of systems own RAM memory
* which is much less than 64 TB which is reserved for mapping the maximum
* physical memory in 4-level paging mode, not to mention 5-level. The
* left space can be saved to enhance randomness.
* 
How about this? And please forgive my poor english.

Thanks
Baoquan

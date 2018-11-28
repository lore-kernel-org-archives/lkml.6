Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F16C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BF52081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BF52081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeK1U6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:58:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33266 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbeK1U6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:58:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B393610;
        Wed, 28 Nov 2018 01:57:17 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 527303F5A0;
        Wed, 28 Nov 2018 01:57:17 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 699C61AE0B6A; Wed, 28 Nov 2018 09:57:35 +0000 (GMT)
Date:   Wed, 28 Nov 2018 09:57:35 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        mingo@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        jeyu@kernel.org, netdev@vger.kernel.org, ard.biesheuvel@linaro.org,
        jannh@google.com, kristen@linux.intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com
Subject: Re: [PATCH 0/2] =?utf-8?B?RG9u4oCZ?= =?utf-8?Q?t?= leave executable
 TLB entries to freed pages
Message-ID: <20181128095734.GA23467@arm.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <CDB8B7C1-FD55-44AD-9B71-B3A750BF5489@gmail.com>
 <449E6648-5599-476D-8136-EE570101F930@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <449E6648-5599-476D-8136-EE570101F930@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 05:21:08PM -0800, Nadav Amit wrote:
> > On Nov 27, 2018, at 5:06 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> > 
> >> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
> >> 
> >> Sometimes when memory is freed via the module subsystem, an executable
> >> permissioned TLB entry can remain to a freed page. If the page is re-used to
> >> back an address that will receive data from userspace, it can result in user
> >> data being mapped as executable in the kernel. The root of this behavior is
> >> vfree lazily flushing the TLB, but not lazily freeing the underlying pages. 
> >> 
> >> There are sort of three categories of this which show up across modules, bpf,
> >> kprobes and ftrace:
> >> 
> >> 1. When executable memory is touched and then immediatly freed
> >> 
> >>  This shows up in a couple error conditions in the module loader and BPF JIT
> >>  compiler.
> > 
> > Interesting!
> > 
> > Note that this may cause conflict with "x86: avoid W^X being broken during
> > modules loading”, which I recently submitted.
> 
> I actually have not looked on the vmalloc() code too much recent, but it
> seems … strange:
> 
>   void vm_unmap_aliases(void)
>   {       
> 
>   ...
>   	mutex_lock(&vmap_purge_lock);
>   	purge_fragmented_blocks_allcpus();
>   	if (!__purge_vmap_area_lazy(start, end) && flush)
>   		flush_tlb_kernel_range(start, end);
>   	mutex_unlock(&vmap_purge_lock);
>   }
> 
> Since __purge_vmap_area_lazy() releases the memory, it seems there is a time
> window between the release of the region and the TLB flush, in which the
> area can be allocated for another purpose. This can result in a
> (theoretical) correctness issue. No?

If __purge_vmap_area_lazy() returns false, then it hasn't freed the memory,
so we only invalidate the TLB if 'flush' is true in that case. If
__purge_vmap_area_lazy() returns true instead, then it takes care of the TLB
invalidation before the freeing.

Will

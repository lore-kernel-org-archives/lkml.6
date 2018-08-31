Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93102C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9AC20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9AC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeHaPkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:40:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52369 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:40:17 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvhfo-0003lu-Mn; Fri, 31 Aug 2018 13:33:08 +0200
Date:   Fri, 31 Aug 2018 13:33:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
In-Reply-To: <20180831061519.3zbxsjs4rd6mmsuo@shbuild888>
Message-ID: <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de>
References: <20180830090319.985-1-feng.tang@intel.com> <20180830104401.GZ24124@hirez.programming.kicks-ass.net> <20180830111207.GE2656@dhcp22.suse.cz> <alpine.DEB.2.21.1808301352410.1210@nanos.tec.linutronix.de> <20180830124915.GH2656@dhcp22.suse.cz>
 <20180830125909.uq3e76akcmep6j2u@shbuild888> <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de> <20180830131920.w2jqjvlkpfb4ejb2@shbuild888> <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de>
 <20180831061519.3zbxsjs4rd6mmsuo@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018, Feng Tang wrote:
> On Thu, Aug 30, 2018 at 03:25:42PM +0200, Thomas Gleixner wrote:
> This panic happens as the earlycon's fixmap address has no
> pmd/pte ready, and __set_fixmap will try to allocate memory to
> setup the page table, and trigger panic due to no memory.
> 
> x86 kernel actually prepares the page table for fixmap in head_64.S:
> 
> 	NEXT_PAGE(level2_fixmap_pgt)
> 		.fill	506,8,0
> 		.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
> 		/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
> 		.fill	5,8,0
> 
> and it expects the fixmap address is in [-12M, -10M] range, but
> current code in fixmap.h will break the expectation when
> X86_VSYSCALL_EMULATION=n
> 
> 	#ifdef CONFIG_X86_VSYSCALL_EMULATION
> 		VSYSCALL_PAGE = (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
> 	#endif
> 
> So removing the "#ifdef" will make the fixmap address space stable in
> [-12M, -10M] and fix the issue.

Why on earth are you not fixing the damned PTE setup which is the obvious
and correct thing to do?

Thanks,

	tglx



Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853EAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C1C20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfBHKjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:39:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43288 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHKjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:39:20 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gs3Yy-0007JF-U4; Fri, 08 Feb 2019 11:39:17 +0100
Date:   Fri, 8 Feb 2019 11:39:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH V3 01/13] perf/core, x86: Add
 PERF_SAMPLE_DATA_PAGE_SIZE
In-Reply-To: <6ecaa29b-af17-938d-8638-acb9de5454be@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902081138050.1595@nanos.tec.linutronix.de>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com> <20190131123725.GB31516@hirez.programming.kicks-ass.net> <6ecaa29b-af17-938d-8638-acb9de5454be@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Liang, Kan wrote:
> > > +u64 perf_get_page_size(u64 virt)
> > > +{
> > > +	unsigned long flags;
> > > +	unsigned int level;
> > > +	pte_t *pte;
> > > +
> > > +	if (!virt)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * Interrupts are disabled, so it prevents any tear down
> > > +	 * of the page tables.
> > > +	 * See the comment near struct mmu_table_batch.
> > > +	 */
> > > +	local_irq_save(flags);
> > > +	if (virt >= TASK_SIZE)
> > > +		pte = lookup_address(virt, &level);
> > > +	else {
> > > +		if (current->mm)
> > > +			pte = lookup_address_in_pgd(pgd_offset(current->mm,
> > > virt),
> > > +						    virt, &level);
> > 
> > Aside from all the missin {}, I'm fairly sure this is broken since this
> > happens from NMI context. This can interrupt switch_mm() and things like
> > use_temporary_mm().
> > 
> > Also; why does this live in the x86 code and not in the generic code?
> > 
> 
> This is x86 implementation.
> In generic code, there is a __weak function. I'll make it clear in the change
> log in v4.

No, instead of hiding it in the changelog, split the patch into two:

 #1 Adding the core stuff including the weak function

 #2 Adding the x86 implementation.

Thanks,

	tglx

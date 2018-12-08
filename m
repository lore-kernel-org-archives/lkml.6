Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1854CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF29A2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vkBRGpbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF29A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLHKwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 05:52:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45078 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 05:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NVvPx3iDHeHdNxEt/jMkPVpYf00zjygi86WbaLVtTko=; b=vkBRGpbf0hulaEwho0pic6HK8/
        bTXTQ++/fTK+ayvldzDCrc8czDT+fXzid0puCjq2d/Vh3y6NC/LuEkyyFVf7ZYLw2sRbDBJzkj0Qp
        xijaOUoDcW01Xee42NBjugUy3DaaLysE2QwC1YJRk0huCPUXk278KXlLkYtnJguomd2Se15qU1p63
        w5uRAg1Ss3tTXyEZ8uvTeK/S65mKr0DbTdLckPvPTQcZR+DteoBqWI1vHyuF05uabmurlf1uK1Cxe
        M2j/szHMRocCjx/hTDcrwngh3WBtCPA76y8/0cc/m5g7vxaB//IvkhL3jKTBleEgi32MYjOyW7+Em
        D702CVEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVaDg-0001yl-Eg; Sat, 08 Dec 2018 10:52:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A4D920725F5D; Sat,  8 Dec 2018 11:52:20 +0100 (CET)
Date:   Sat, 8 Dec 2018 11:52:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Should this_cpu_read() be volatile?
Message-ID: <20181208105220.GF5289@hirez.programming.kicks-ass.net>
References: <20181203161352.GP10377@bombadil.infradead.org>
 <4F09425C-C9AB-452F-899C-3CF3D4B737E1@gmail.com>
 <20181203224920.GQ10377@bombadil.infradead.org>
 <C377D9EF-A0F4-4142-8145-6942DC29A353@gmail.com>
 <EB579DAE-B25F-4869-8529-8586DF4AECFF@gmail.com>
 <20181206102559.GG13538@hirez.programming.kicks-ass.net>
 <55B665E1-3F64-4D87-B779-D1B4AFE719A9@gmail.com>
 <20181207084550.GA2237@hirez.programming.kicks-ass.net>
 <C29C792A-3F47-482D-B0D8-99EABEDF8882@gmail.com>
 <C064896E-268A-4462-8D51-E43C1CF10104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C064896E-268A-4462-8D51-E43C1CF10104@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:40:52PM -0800, Nadav Amit wrote:

> > I'm actually having difficulty finding the this_cpu_read() in any of the
> > functions you mention, so I cannot make any concrete suggestions other
> > than pointing at the alternative functions available.
> 
> 
> So I got deeper into the code to understand a couple of differences. In the
> case of select_idle_sibling(), the patch (Peter’s) increase the function
> code size by 123 bytes (over the baseline of 986). The per-cpu variable is
> called through the following call chain:
> 
> 	select_idle_sibling()
> 	=> select_idle_cpu()
> 	=> local_clock()
> 	=> raw_smp_processor_id()
> 
> And results in 2 more calls to sched_clock_cpu(), as the compiler assumes
> the processor id changes in between (which obviously wouldn’t happen).

That is the thing with raw_smp_processor_id(), it is allowed to be used
in preemptible context, and there it _obviously_ can change between
subsequent invocations.

So again, this change is actually good.

If we want to fix select_idle_cpu(), we should maybe not use
local_clock() there but use sched_clock_cpu() with a stable argument,
this code runs with IRQs disabled and therefore the CPU number is stable
for us here.

> There may be more changes around, which I didn’t fully analyze. But
> the very least reading the processor id should not get “volatile”.
> 
> As for finish_task_switch(), the impact is only few bytes, but still
> unnecessary. It appears that with your patch preempt_count() causes multiple
> reads of __preempt_count in this code:
> 
>        if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
>                      "corrupted preempt_count: %s/%d/0x%x\n",
>                      current->comm, current->pid, preempt_count()))
>                preempt_count_set(FORK_PREEMPT_COUNT);

My patch proposed here:

  https://marc.info/?l=linux-mm&m=154409548410209

would actually fix that one I think, preempt_count() uses
raw_cpu_read_4() which will loose the volatile with that patch.

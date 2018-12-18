Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CCCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03D420874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c20w6q/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeLRMef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:34:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xFn2chBMafgeDEOLbH/HQf4MPxQ3I/rnZQ44Oadr52c=; b=c20w6q/IcpZs7UCN0+L4lf2nYz
        95hSTsO5oR4/DwH98RfxFBm5LZWVW5QYlhyfFDXucavYmspGkOWdM8LJ4lWoZnZaYBbJewM+nWwia
        qKc5H0paFCdQ2w0Iu41F9XMxhWRZ3dk71jaX8MLuk6/pTvjmcfUBCPm6OcUnU1+42DCio7APbHfti
        qgFu0kTpOwO15byN8dCAE4g+fg0EvzNSkcqjuxsPisTIWLbdggswxZwOZiRfYvNwzipLCfKSKDSCu
        /nMjblikuwvErU3CKB4ryMkM8tO8+aujTlhszHM/aeGxG3jKPdMeldiUAk6Ad63FHLL12Vy8+/MYz
        +q5rdL5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZEZs-00084v-Id; Tue, 18 Dec 2018 12:34:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A423205817B4; Tue, 18 Dec 2018 13:34:22 +0100 (CET)
Date:   Tue, 18 Dec 2018 13:34:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     zhe.he@windriver.com, acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Message-ID: <20181218123421.GI15430@hirez.programming.kicks-ass.net>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
 <20181218111637.b53u5pi3nxnyldaq@linutronix.de>
 <20181218113119.GG15430@hirez.programming.kicks-ass.net>
 <20181218113700.GC16284@hirez.programming.kicks-ass.net>
 <20181218114708.p6fpz447brob4kzz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218114708.p6fpz447brob4kzz@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:47:08PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-12-18 12:37:00 [+0100], Peter Zijlstra wrote:
> > On Tue, Dec 18, 2018 at 12:31:19PM +0100, Peter Zijlstra wrote:
> > > On Tue, Dec 18, 2018 at 12:16:37PM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2018-12-18 12:02:09 [+0100], Peter Zijlstra wrote:
> > > > > On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
> > > > > > Besides, in preempt-rt full mode, the freeing can happen in atomic context and
> > > > > > thus cause the following BUG.
> > > > > 
> > > > > Hurm, I though we fixed all those long ago..
> > > > > 
> > > > > And no, the patch is horrible; that's what we have things like
> > > > > x86_pmu::cpu_dead() for.
> > > > 
> > > > ehm, you say we keep memory allocation +free on CPU up/down?
> > > 
> > > Sure, why not?
> 
> It does not seem to be useful to allocate & free memory which you need
> anyway. So you could avoid the refcnt for instance.

It makes the code simpler and hotplug is not what you'd call a fast path
anyway.

> Also I doubt the memory will remain unallocated for a longer period of
> time (like you would remove the CPU for good and not boot it again a
> minute later).

SMT disable comes to mind...

> *Maybe* it is different in cloud environment where you attach vcpus
> depending on guest load at runtime but still…

And that..


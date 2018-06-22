Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA18C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706E223EC7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oZHqfsN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706E223EC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933257AbeFVIMH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:12:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41236 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeFVIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=51DIVPjuAJ+iNSAkcrS8UwWpiAFFC1duZrFh6dYE3zk=; b=oZHqfsN6GY1/RxP1flfmNJvT4
        mDjq+IZLPqXmODHnzHFGWzblPUNh6le3Kmq0DO4uLuVnAkOnV1Jj28V3/aaRHi/B6zQqxu2/xSoxo
        HIRTGqU/K3m6CfRmuJrJ7upRMebg1dIoacYl7lV5MdbvBdwIdis3zqeC79TV276o3pbUSuCP36Jnh
        ABh0hQmdUMKK0jVFTbGbgu5Di5saTsMMVbI65S6vuSiLEAvzXr0utPmviz85Na3sOsyt4s0k+sD7B
        /kRf3vXH811j2r9SwnwdxNhsU1PDSoHZam18S1f693PwufYKI9/w/zxzdBFfXKPlsrSPOMTD/zWSn
        GRKQl7ffw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWHAa-0005qk-M1; Fri, 22 Jun 2018 08:11:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 283E32029F1D5; Fri, 22 Jun 2018 10:11:46 +0200 (CEST)
Date:   Fri, 22 Jun 2018 10:11:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180622081146.GG2494@hirez.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
 <20180621201851.GC114883@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
 <20180621220003.GD114883@romley-ivt3.sc.intel.com>
 <20180621220844.GB2494@hirez.programming.kicks-ass.net>
 <6fbff2df-96c9-db51-371b-a23d1a84d070@intel.com>
 <20180621224203.GA18979@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621224203.GA18979@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 03:42:03PM -0700, Fenghua Yu wrote:
> On Thu, Jun 21, 2018 at 03:18:19PM -0700, Dave Hansen wrote:
> > On 06/21/2018 03:08 PM, Peter Zijlstra wrote:
> > > On Thu, Jun 21, 2018 at 03:00:03PM -0700, Fenghua Yu wrote:
> > >> The control knob for kernel is to choose re-executing the faulting
> > >> instruction (default) or kernel panic. Kernel panic may be useful in hard
> > >> real time which has less tolerant to bad performance.
> > > The kernel should never trigger this, ever. Any #AC is a plain bug and
> > > should be fixed. So unconditional WARN+disable is suffient.
> > 
> > It sounds like we need to start with that functionality and then if
> > Fenghua wants to do more, we have add-on patches that can be evaluated
> > by themselves.
> 
> For split lock in kernel, by default, I just do warning, disable feature
> in #AC handler, continue to execute the faulting instruction, and re-enable
> #AC for split lock after a delay. This is the default behavior in the
> current patches.
> 
> By "WAR+disable", you mean I just do this default behavior and remove the
> control knob?

No, remove all that broken delay crap, remove the knob. Basically remove
everything.

The handler really should be:

do_handle_ac_trap()
{
	if (user_mode(regs)) {
		send_signal(SIGBUS);
		return;
	}

	WARN_ON(1);
	disable_ac_on_all_cpus();
}

done. No broken delay code, no nothing.

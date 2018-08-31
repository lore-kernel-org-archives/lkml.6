Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84CBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D39F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeHaOAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:00:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55438 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbeHaOAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:00:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1285918A;
        Fri, 31 Aug 2018 02:53:39 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D75673F721;
        Fri, 31 Aug 2018 02:53:38 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7288B1AE3614; Fri, 31 Aug 2018 10:53:51 +0100 (BST)
Date:   Fri, 31 Aug 2018 10:53:51 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180831095351.GD13166@arm.com>
References: <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
 <20180830204515.GC24124@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090FF3@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090FF3@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:30:50AM +0000, Vineet Gupta wrote:
> On 08/30/2018 01:45 PM, Peter Zijlstra wrote:
> >>
> >> Indeed this is the mother of all issues, I tried and system is clearly hosed with
> >> and works after.
> >> What's amazing is the commit 4aef66c8ae9 which introduced it is from 2016 ;-)
> >> Back then we had a retry branch with backoff stuff which I'd reverted for new
> >> cores and the merge conflict somehow missed it.
> >>
> >> @PeterZ I'll create a patch with you as author ? do I need any formal sign offs,
> >> acks etc ?
> > Well, Will spotted it, give authorship to him, you have my ack per the
> > above.
> 
> Oops, sorry for the mixup. I have him as author now and pushed to ARC for-curr
> (will trickle into linux-next eventually).

Okey doke: you can have my Signed-off-by for all the diffs I sent. Just
stick something like [vineet: wrote commit message] in there so I don't
read it in the future and confuse myself.

Will

Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE08C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0643B208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0643B208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934766AbeGFFxD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:53:03 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:59728 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934713AbeGFFw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 27645181D3368;
        Fri,  6 Jul 2018 05:52:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: joke35_366546ba7eb3b
X-Filterd-Recvd-Size: 5433
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Jul 2018 05:52:53 +0000 (UTC)
Message-ID: <ebc3e5cafdf2a11a08940357c91b8ce64e7d3200.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add exceptions for dsb keyword usage
From:   Joe Perches <joe@perches.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        apw@canonical.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org
Date:   Thu, 05 Jul 2018 22:52:52 -0700
In-Reply-To: <20180706054510.puli24y6i6ylghxt@salmiak>
References: <1530814776-16988-1-git-send-email-pheragu@codeaurora.org>
         <f3ce3ca8741f774b63e8a67a278384747b1de522.camel@perches.com>
         <20180706054510.puli24y6i6ylghxt@salmiak>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 06:45 +0100, Mark Rutland wrote:
> On Thu, Jul 05, 2018 at 02:14:28PM -0700, Joe Perches wrote:
> > On Thu, 2018-07-05 at 11:19 -0700, Prakruthi Deepak Heragu wrote:
> > > mb() API can relpace the dsb() API in the kernel code. So, dsb() usage
> > > is discouraged. However, there are exceptions when dsb is used in a
> > > variable or a function name. Exceptions are when 'dsb' is prefixed with
> > > class [-_>*\.] and/or suffixed with class [-_\.;].
> 
> This is a really confusing way of describing the match behaviour, and doesn't
> explain why this is a big problem.
> 
> In C it's either:
> 
> 	dsb()
> 	dsb(scope)	// e.g. dsb(ish)
> 
> ... where scope is [a-z]*.
> 
> ... which can be matched as something like 'dsb([a-z]*)' if necessary.
> 
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > 
> > []
> > > @@ -5372,6 +5372,12 @@ sub process {
> > >  			     "Avoid line continuations in quoted strings\n" . $herecurr);
> > >  		}
> > >  
> > > +# dsb is too ARMish, and should usually be mb.
> > > +        if ($line =~ /[^-_>*\.]\bdsb\b[^-_\.;]/) {
> > > +            WARN("ARM_BARRIER",
> > > +                 "Use of dsb is discouranged: prefer mb.\n" .
> > > +                 $herecurr);
> > > +		}
> > 
> > This patch is whitespace damaged with a spelling error.
> > 
> > Also, if this is reasonable test, and I don't know
> > that it is, it should be cc'd to the linux-arm list
> > linux-arm-kernel@lists.infradead.org
> > 
> > Also, I suggest 2 tests, one for .S files and
> > another for .[ch] files, and this be made specific
> > to arch/arm... files
> > 
> > Something like:
> > 
> > 	if ($realfile =~ @^arch/arm@ &&
> > 	    ($realfile =~ /\.S$/ && $line =~ /\bdsb\b/) ||
> > 	    ($realfile =~ /\.[ch]$/ && $line =~ /\bdsb\s*\(/)) {
> > 		WARN("ARM_DSB",
> > 		     "Prefer mb over dsb as an ARM memory barrier\n" . $herecurr);
> > 	}
> > 
> > ARM people, is this reasonable?
> 
> I don't think this is a big deal today. 
> 
> For code under arch/{arm,arm64}, it's perfectly reasonable to use dsb.
> 
> For code *ouside* of arch/{arm,arm64}, there are a number of cases where we
> want to use dsb(), e.g. when dealing with architectural drivers that require
> special barriers, or for common code shared across arm and arm64.
> 
> It doesn't look like this is a big problem today, anyhow:
> 
> [mark@salmiak:~/src/linux]% git grep -w 'dsb(.*)' -- ^arch          
> drivers/irqchip/irq-armada-370-xp.c:    dsb();
> drivers/irqchip/irq-gic-v3-its.c:               dsb(ishst);
> drivers/irqchip/irq-gic-v3-its.c:               dsb(ishst);
> drivers/irqchip/irq-gic-v3-its.c:       dsb(sy);
> drivers/irqchip/irq-gic-v3-its.c:               dsb(sy);
> drivers/irqchip/irq-gic-v3-its.c:       dsb(sy);
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/perf/arm_spe_pmu.c:     dsb(nsh);
> drivers/perf/arm_spe_pmu.c:     dsb(nsh);
> drivers/power/reset/arm-versatile-reboot.c:     dsb();
> drivers/soc/rockchip/pm_domains.c:      dsb(sy);
> drivers/soc/rockchip/pm_domains.c:      dsb(sy);
> drivers/staging/mt7621-mmc/sd.c:        //dsb(); /* --- by chhung */
> drivers/staging/mt7621-mmc/sd.c:        //dsb(); /* --- by chhung */
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h:#define dsb(a)
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:     dsb(sy);         /* data barrier operation */
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:         dsb(sy);
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h: do { debug_ptr[DEBUG_ ## d] = __LINE__; dsb(sy); } while (0)
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h: do { debug_ptr[DEBUG_ ## d] = (v); dsb(sy); } while (0)
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h: do { debug_ptr[DEBUG_ ## d]++; dsb(sy); } while (0)
> virt/kvm/arm/hyp/vgic-v3-sr.c:                  dsb(sy);
> virt/kvm/arm/hyp/vgic-v3-sr.c:                  dsb(sy);
> virt/kvm/arm/hyp/vgic-v3-sr.c:                  dsb(sy);

Thanks Mark.

So it seems this shouldn't be applied.


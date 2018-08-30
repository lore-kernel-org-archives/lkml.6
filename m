Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C11C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1BC2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1BC2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeH3NgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:36:17 -0400
Received: from foss.arm.com ([217.140.101.70]:38376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbeH3NgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:36:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBCA57A9;
        Thu, 30 Aug 2018 02:35:01 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93A603F721;
        Thu, 30 Aug 2018 02:35:01 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id BCC8E1AE3490; Thu, 30 Aug 2018 10:35:13 +0100 (BST)
Date:   Thu, 30 Aug 2018 10:35:13 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180830093513.GA5942@arm.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:16:43PM +0000, Vineet Gupta wrote:
> On 08/29/2018 11:33 AM, Eugeniy Paltsev wrote:
> > Hi Guys,
> > Since v4.19-rc1 we are getting a serious regression on platforms with ARC architecture.
> > The kernel have become unstable and spontaneously crashes on LTP tests execution / IO tests or
> > even on boot.
> >
> > I don't know exactly what breaks but bisect clearly assign the blame to this commit:
> > 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
> > https://github.com/torvalds/linux/commit/84c6591103dbeaf393a092a3fc7b09510825f6b9
> >
> > Reverting the commit solves this problem.
> >
> > I tested v4.19-rc1 on ARM (wandboard, i.mx6, 32bit, quard core, ARMv7) which uses same
> > generic bitops implementation and it works fine.
> >
> > Do you have any ideas what went wrong?
> 
> Back in 2016, Peter had fixed this file due to a problem I reported on ARC. See
> commit f75d48644c56a ("bitops: Do not default to __clear_bit() for
> __clear_bit_unlock()")
> That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic
> __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock() same.
> 
> This patch undoes that which could explain the issues you see. @Peter, @Will ?

/me grabs arc toolchain (incidentally, make.cross fuzzy matches "arc" to
"sparc", so that was fun for a few minutes).

I'll take a look today, thanks for the report.

Will

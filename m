Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9110FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CDD20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CDD20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeJBTkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:40:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36762 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeJBTkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:40:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69CC77A9;
        Tue,  2 Oct 2018 05:57:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0063F5B7;
        Tue,  2 Oct 2018 05:57:36 -0700 (PDT)
Date:   Tue, 2 Oct 2018 13:57:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 2/4] arm64: implement ftrace with regs
Message-ID: <20181002125734.mhkz4o46oxf3mtu6@lakrids.cambridge.arm.com>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141648.1DBED68BDF@newverein.lst.de>
 <20181002112741.mvav4ar4v25gj46e@lakrids.cambridge.arm.com>
 <20181002121817.GB2398@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002121817.GB2398@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:18:17PM +0200, Torsten Duwe wrote:
> Hi Mark,

Hi,
 
> thank you for your very detailed feedback, I'll incorporate it
> all into the next version, besides one issue:
> 
> On Tue, Oct 02, 2018 at 12:27:41PM +0100, Mark Rutland wrote:
> > 
> > Please use the insn framework, as we do to generate all the other
> > instruction sequences in ftrace.
> > 
> > MOV (register) is an alias of ORR (shifted register), i.e.
> > 
> > 	mov	<xd>, <xm>
> > 
> > ... is:
> > 
> > 	orr	<xd>, xzr, <xm>
> > 
> > ... and we have code to generate ORR, so we can add a trivial wrapper to
> > generate MOV.
> 
> I had something similar in v2; but it was hardly any better to read or
> understand. My main question however is: how do you justify the runtime
> overhead of aarch64_insn_gen_logical_shifted_reg for every function that
> gets its tracing switched on or off?

How do you justify doing something different from the established
pattern? Do you have any numbers indicating that this overhead is a
problem on a real workload?

For the moment at least, please use aarch64_insn_gen_*(), as we do for
all other instructions generated in the ftrace code. It's vastly simpler
for everyone if we have consistency here.

> The result is always the same 4-byte constant, so why not use a macro
> and a comment that says what it does?

I'd rather that we stick to the usual pattern that we have in arm64.

Note that aarch64_insn_gen_nop() also always returns the same 4-byte
constant, but it's an out-of-line function in insn.c. There haven't been
any complaints as to its overhead so far...

Thanks,
Mark.

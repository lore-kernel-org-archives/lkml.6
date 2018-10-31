Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BEDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579572064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579572064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeJaVH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:07:56 -0400
Received: from foss.arm.com ([217.140.101.70]:40054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeJaVHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:07:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A4E180D;
        Wed, 31 Oct 2018 05:10:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64963F71D;
        Wed, 31 Oct 2018 05:10:07 -0700 (PDT)
Date:   Wed, 31 Oct 2018 12:10:03 +0000
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
        live-patching@vger.kernel.org, kristina.martsenko@arm.com
Subject: Re: [PATCH v4 1/3] arm64: implement ftrace with regs
Message-ID: <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142148.6353A68C94@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026142148.6353A68C94@newverein.lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

On Fri, Oct 26, 2018 at 04:21:48PM +0200, Torsten Duwe wrote:
> Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
> of each function. Replace the first NOP thus generated with a quick LR
> saver (move it to scratch reg x9), so the 2nd replacement insn, the call
> to ftrace, does not clobber the value. Ftrace will then generate the
> standard stack frames.

I'd like to understand why you need patchable-function-entry to
implement DYNAMIC_FTRACE_WITH_REGS on arm64. No other architectures with
DYNAMIC_FTRACE_WITH_REGS require this, including arm.

I guess skipping the original function prologue would simplify the
implementation of the replacement function (and would mean that the regs
held the function arguments per the procedure call standard), but AFAICT
other architectures aren't relying on that, so it doesn't seem to be a
strict requirement.

What am I missing?

How does livepatching handle the pre-mcount function preambles on
architectures with existing support?

FWIW, I think that patchable-function-entry would solve an upcoming
problem on arm64. To support in-kernel pointer authentication with the
function graph tracer, we need to snapshot the SP at function entry
(before any preamble), and we can't do that reliably with mcount.

Thanks,
Mark.

Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB9CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6EE2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6EE2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJBTBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:01:22 -0400
Received: from verein.lst.de ([213.95.11.211]:42982 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJBTBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:01:22 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id CCF0668BDF; Tue,  2 Oct 2018 14:18:17 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:18:17 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20181002121817.GB2398@lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141648.1DBED68BDF@newverein.lst.de> <20181002112741.mvav4ar4v25gj46e@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002112741.mvav4ar4v25gj46e@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

thank you for your very detailed feedback, I'll incorporate it
all into the next version, besides one issue:

On Tue, Oct 02, 2018 at 12:27:41PM +0100, Mark Rutland wrote:
> 
> Please use the insn framework, as we do to generate all the other
> instruction sequences in ftrace.
> 
> MOV (register) is an alias of ORR (shifted register), i.e.
> 
> 	mov	<xd>, <xm>
> 
> ... is:
> 
> 	orr	<xd>, xzr, <xm>
> 
> ... and we have code to generate ORR, so we can add a trivial wrapper to
> generate MOV.

I had something similar in v2; but it was hardly any better to read or
understand. My main question however is: how do you justify the runtime
overhead of aarch64_insn_gen_logical_shifted_reg for every function that
gets its tracing switched on or off? The result is always the same 4-byte
constant, so why not use a macro and a comment that says what it does?

	Torsten


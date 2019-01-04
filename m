Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91404218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfADSGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:06:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADSGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:06:52 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D612218D3;
        Fri,  4 Jan 2019 18:06:50 +0000 (UTC)
Date:   Fri, 4 Jan 2019 13:06:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190104130648.02657f3f@gandalf.local.home>
In-Reply-To: <20190104175017.GA7157@lakrids.cambridge.arm.com>
References: <20190104141053.360F768D93@newverein.lst.de>
        <20190104175017.GA7157@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2019 17:50:18 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> At Linux Plumbers, I had a conversation with Steve Rostedt, and we came
> to the conclusion that (withut heavyweight synchronization) patching two
> NOPs at runtime isn't safe, since a CPU might have executed the first
> NOP as a NOP before another CPU patches both instructions. So a CPU
> might execute:
> 
> 	NOP
> 	BL	ftrace_regs_caller
> 
> ... rather than the expected:
> 
> 	MOV	X9, X30
> 	BL	ftrace_regs_caller
> 
> ... and therefore X9 contains some UNKNOWN value, rather than the
> original LR value.
> 
> I wonder if we could solve that by patching the kernel at build-time, to
> add the MOV X9, X30 in place of the first NOP. If we were to do that, we
> could also update the addresses to pooint at the second NOP, simplifying
> the changes to the runtime code.

You can also patch it at boot up when there's only one CPU running, and
interrupts are disabled.

-- Steve

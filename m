Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF8CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC7C2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC7C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbeKFUZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:25:07 -0500
Received: from foss.arm.com ([217.140.101.70]:59046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbeKFUZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:25:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20C0BA78;
        Tue,  6 Nov 2018 03:00:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C5A43F5CF;
        Tue,  6 Nov 2018 03:00:26 -0800 (PST)
Date:   Tue, 6 Nov 2018 11:00:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Michael Weiser <michael.weiser@gmx.de>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/arm64 : fix error in dump_backtrace
Message-ID: <20181106110019.36ps3tyakvocwst4@lakrids.cambridge.arm.com>
References: <1541488775-29610-1-git-send-email-huangzhaoyang@gmail.com>
 <20181106083901.erezwtcomiijvdrk@salmiak>
 <20181106085751.hrp7qkp53cftgew6@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106085751.hrp7qkp53cftgew6@holly.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 08:57:51AM +0000, Daniel Thompson wrote:
> On Tue, Nov 06, 2018 at 08:39:01AM +0000, Mark Rutland wrote:
> > On Tue, Nov 06, 2018 at 03:19:35PM +0800, Zhaoyang Huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > 
> > > In some cases, the instruction of "bl foo1" will be the last one of the
> > > foo2[1], which will cause the lr be the first instruction of the adjacent
> > > foo3[2]. Hence, the backtrace will show the weird result as bellow[3].
> > > The patch will fix it by miner 4 of the lr when dump_backtrace
> > 
> > This has come up in the past (and a similar patch has been applied, then
> > reverted).
> > 
> > In general, we don't know that a function call was made via BL, and therefore
> > cannot know that LR - 4 is the address of the caller. The caller could set up
> > the LR as it likes, then B or BR to the callee, and depending on how the basic
> > blocks get laid out in memory, LR - 4 might point at something completely
> > different.
> > 
> > More ideally, the compiler wouldn't end a function with a BL. When does that
> > happen, and is there some way we could arrange for that to not happen? e.g.
> > somehow pad a NOP after the BL.
> 
> It's a consequence of having __noreturn isn't it? __noreturn frees the
> compiler from the burden of having to produce a valid return stack... so
> it doesn't and unwinding becomes hard.

In that case, the compiler could equally just use B rather than BL,
which this patch doesn't solve.

The documentation for the GCC noreturn attribute [1] says:

| In order to preserve backtraces, GCC will never turn calls to noreturn
| functions into tail calls. 

... so clearly it's not intended to mess up backtracing.

IIUC we mostly use noreturn to prevent warings about uninitialised
variables and such after a call to a noreturn function. I think
optimization is a secondary concern.

We could ask the GCC folk if they can ensure that a noreturn function
call leave thes LR pointing into the caller, e.g. by padding with a NOP:

	BL	<noreturn function>
	NOP

That seems cheap enough, and would keep backtraces reliable.

Thanks,
Mark.

[1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noreturn-function-attribute

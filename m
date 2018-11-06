Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595CFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0909620869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHZVHAID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0909620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeKFVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:30:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51094 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:30:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so6232012wmw.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 04:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ihD/hM2HTxE7M0zg9lTRAfTdRdJCN/VBGoL4XIWGUJQ=;
        b=FHZVHAIDyB5duNWne9eSqLBR75F/VQpg0kQPBaqhRKTOUSRdUSqGJunYZX4EyFzXH1
         dvbRjZIk13svtE6okubWTUsDcfd5QUunomC3CT8H0FHoWIGV5//2ovfVVaZs3DA0VUKi
         iGm78lZSHTuEI0YfItzop6iT25En/RZM7TZVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ihD/hM2HTxE7M0zg9lTRAfTdRdJCN/VBGoL4XIWGUJQ=;
        b=mUk/h0XegNmpZiSGfpvneczbhW0yJmJ9XoeJifzA7Gr2Dp7mR0aIci2PWmIqEC6MlP
         j3kL3pJIsH7R6MPxjdzXjqj7smNvjU2md5F4reDg8wdsIgMzsamXgIVrBDEtYRbNSigY
         pKTOctnYuIPH6VsMAvkNpH31ANB8iEnPEnI+E6XnzA4gp1F090Pwrv86cAu8vjeN0RRm
         1Ro+FyFR82PLueJXoCxm9nAjDFs8PNbK8B7AZZmP/M/rDagVARHWvOiys5xeA+fcc45U
         a6AB0VK9ta9TZjDLuSThDOtCVY8PtOZkD2G+vf2egtDYFCsF+muDK6hDP3JEPpzRBbT+
         dLvw==
X-Gm-Message-State: AGRZ1gKjZl6/eYoyfHjHsd1bb85aRMZpwopR11+VoSm2LeqA4terLJnE
        ng2eGrBBa2ocpi5GnNjawwS8gyjg5+OPVw==
X-Google-Smtp-Source: AJdET5crV07b+35fKJ/UBrZzvbNPF7b4vPe2q1gZsP9Rsekbaj44O7uT8j+H1KpGnknzxawzicCUyw==
X-Received: by 2002:a1c:1b91:: with SMTP id b139-v6mr1803955wmb.37.1541505911199;
        Tue, 06 Nov 2018 04:05:11 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m13-v6sm8111796wrw.14.2018.11.06.04.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 04:05:10 -0800 (PST)
Date:   Tue, 6 Nov 2018 12:05:08 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Michael Weiser <michael.weiser@gmx.de>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/arm64 : fix error in dump_backtrace
Message-ID: <20181106120508.hftgyoj47qygt7b2@holly.lan>
References: <1541488775-29610-1-git-send-email-huangzhaoyang@gmail.com>
 <20181106083901.erezwtcomiijvdrk@salmiak>
 <20181106085751.hrp7qkp53cftgew6@holly.lan>
 <20181106110019.36ps3tyakvocwst4@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106110019.36ps3tyakvocwst4@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 11:00:19AM +0000, Mark Rutland wrote:
> On Tue, Nov 06, 2018 at 08:57:51AM +0000, Daniel Thompson wrote:
> > On Tue, Nov 06, 2018 at 08:39:01AM +0000, Mark Rutland wrote:
> > > On Tue, Nov 06, 2018 at 03:19:35PM +0800, Zhaoyang Huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > 
> > > > In some cases, the instruction of "bl foo1" will be the last one of the
> > > > foo2[1], which will cause the lr be the first instruction of the adjacent
> > > > foo3[2]. Hence, the backtrace will show the weird result as bellow[3].
> > > > The patch will fix it by miner 4 of the lr when dump_backtrace
> > > 
> > > This has come up in the past (and a similar patch has been applied, then
> > > reverted).
> > > 
> > > In general, we don't know that a function call was made via BL, and therefore
> > > cannot know that LR - 4 is the address of the caller. The caller could set up
> > > the LR as it likes, then B or BR to the callee, and depending on how the basic
> > > blocks get laid out in memory, LR - 4 might point at something completely
> > > different.
> > > 
> > > More ideally, the compiler wouldn't end a function with a BL. When does that
> > > happen, and is there some way we could arrange for that to not happen? e.g.
> > > somehow pad a NOP after the BL.
> > 
> > It's a consequence of having __noreturn isn't it? __noreturn frees the
> > compiler from the burden of having to produce a valid return stack... so
> > it doesn't and unwinding becomes hard.
> 
> In that case, the compiler could equally just use B rather than BL,
> which this patch doesn't solve.
> 
> The documentation for the GCC noreturn attribute [1] says:
> 
> | In order to preserve backtraces, GCC will never turn calls to noreturn
> | functions into tail calls. 
> 
> ... so clearly it's not intended to mess up backtracing.

I guess that explains why the compiler chooses BL over B (since B would
be a tail call).


> IIUC we mostly use noreturn to prevent warings about uninitialised
> variables and such after a call to a noreturn function. I think
> optimization is a secondary concern.
> 
> We could ask the GCC folk if they can ensure that a noreturn function
> call leave thes LR pointing into the caller, e.g. by padding with a NOP:
> 
> 	BL	<noreturn function>
> 	NOP
> 
> That seems cheap enough, and would keep backtraces reliable.

It might be worth discussing. One related question though... is there
any other case there the symbol name other than __noreturn where the
symbol can change between LR and LR-1?

If not can't we just switch over to %pB which is designed for this case
(and in case you ask: no... I didn't know about %pB until this morning
when I started trying to implement the heuristic it uses by hand and
then discovering it by accident).

Something like:

From 70a2c9ffc962a650ff894d40b775f8310190bf86 Mon Sep 17 00:00:00 2001
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 6 Nov 2018 11:59:56 +0000
Subject: [PATCH] arm64: Use %pB to print backtrace symbols

Currently arm64 uses %pS to print backtrace symbols but %pB (which takes
into consideration the effect of compiler optimisations which may occur
when tail-calls are used and marked with the noreturn GCC attribute)
is a better alternative.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5f4d9acb32f5..ea571d3a1373 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -62,7 +62,7 @@ int show_unhandled_signals = 0;
 
 static void dump_backtrace_entry(unsigned long where)
 {
-	printk(" %pS\n", (void *)where);
+	printk(" %pB\n", (void *)where);
 }
 
 static void __dump_instr(const char *lvl, struct pt_regs *regs)
-- 
2.19.1


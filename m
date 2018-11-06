Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC804C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C2E2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUbLi7tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C2E2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbeKFSWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:22:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42211 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbeKFSWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:22:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so12494618wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 00:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=npu6f52scOaswph7S3xG5VI0stM9qgkrpmiNFYq66BE=;
        b=UUbLi7trCZYfFstMsNWjDdL5358z4tivmV/zZqUa7Nn11EaPnqlVxkDDksGcZgO4Ed
         mgp4cbKtL3wAPP/lBPLgp8BkxuDCVROkHwWQGUxTw/HEtbU1GJ+nBuI//ezom5dLsG09
         b/4GakvmMIDD0uvyseNj3Ab0IFgx9ITjYvf5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=npu6f52scOaswph7S3xG5VI0stM9qgkrpmiNFYq66BE=;
        b=bxfSz/iNUF6KHY+rfGhdqyF+VwWWIv1unzYVr295VDMREwFjynBjIyEp8m8rlV/ddF
         O/yYz10eSxh8aQgUYJdt/JJp21wtR8nZatYKMwycpgH+4K+T6EJNzEv3jF/6Cm7tC52c
         ceHNkplf/Udva82rpX5vAuZYUpdFqRTqUT98q1rY/ghL53Ay01v2RvjJun1E2fB1RcNB
         gb0PCU4zNLfGxMp9H97I9BwyxCWL43IxmIlMjWC3bQaWd/wW/ZppV6pJTySZRx6PfVhh
         VyKlZ648JGa1b2n7XZQZj46vUzWKo3cx+AfnWVWqDg4XmcbopEZThjvG0HZAK7cTEU1s
         DLRA==
X-Gm-Message-State: AGRZ1gKLaDCPesKHcwtvoZPHSGno0jqSlkboWaSpUiC4Y9VXRQvyAJnw
        55H/Q84wgdaJ4OQ1fnsPoGnLxw==
X-Google-Smtp-Source: AJdET5ctOWmd2/UvDSpOIlMRCdbJwkP7Ez46yKDKlA8NsT604u6DUiuFDFA3jljo42MYmX55+PaICg==
X-Received: by 2002:adf:e28c:: with SMTP id v12-v6mr4260409wri.26.1541494674669;
        Tue, 06 Nov 2018 00:57:54 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x8-v6sm108736952wrd.54.2018.11.06.00.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 00:57:53 -0800 (PST)
Date:   Tue, 6 Nov 2018 08:57:51 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Michael Weiser <michael.weiser@gmx.de>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/arm64 : fix error in dump_backtrace
Message-ID: <20181106085751.hrp7qkp53cftgew6@holly.lan>
References: <1541488775-29610-1-git-send-email-huangzhaoyang@gmail.com>
 <20181106083901.erezwtcomiijvdrk@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106083901.erezwtcomiijvdrk@salmiak>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 08:39:01AM +0000, Mark Rutland wrote:
> On Tue, Nov 06, 2018 at 03:19:35PM +0800, Zhaoyang Huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > In some cases, the instruction of "bl foo1" will be the last one of the
> > foo2[1], which will cause the lr be the first instruction of the adjacent
> > foo3[2]. Hence, the backtrace will show the weird result as bellow[3].
> > The patch will fix it by miner 4 of the lr when dump_backtrace
> 
> This has come up in the past (and a similar patch has been applied, then
> reverted).
> 
> In general, we don't know that a function call was made via BL, and therefore
> cannot know that LR - 4 is the address of the caller. The caller could set up
> the LR as it likes, then B or BR to the callee, and depending on how the basic
> blocks get laid out in memory, LR - 4 might point at something completely
> different.
> 
> More ideally, the compiler wouldn't end a function with a BL. When does that
> happen, and is there some way we could arrange for that to not happen? e.g.
> somehow pad a NOP after the BL.

It's a consequence of having __noreturn isn't it? __noreturn frees the
compiler from the burden of having to produce a valid return stack... so
it doesn't and unwinding becomes hard.


Daniel.


> > [1]
> > 0xffffff80081e6b04 <handle_mm_fault+3996>:      adrp    x0, 0xffffff8008ca8000
> > 0xffffff80081e6b08 <handle_mm_fault+4000>:      add     x0, x0, #0x5a8
> > 0xffffff80081e6b0c <handle_mm_fault+4004>:      bl      0xffffff80081b0ca0 <panic>
> > 0xffffff80081e6b10 <access_remote_vm>:  stp     x29, x30, [sp,#-64]!
> > 0xffffff80081e6b14 <access_remote_vm+4>:        mov     x29, sp
> > 
> > [2]
> > crash_arm64> rd ffffffc02eec3bd0 2
> > ffffffc02eec3bd0:  ffffffc02eec3cb0 ffffff80081e6b10
> > 
> > [3]
> > wrong:
> > [<ffffff80081b0d90>] panic+0xf0/0x24c
> > [<ffffff80081e6b10>] access_remote_vm+0x0/0x5c
> > [<ffffff800809d7b0>] do_page_fault+0x290/0x3b8
> > [<ffffff8008081570>] do_mem_abort+0x64/0xdc
> > 
> > correct:
> > [ffffffc02eec3bd0] panic at ffffff80081b0da4
> > [ffffffc02eec3cb0] handle_mm_fault at ffffff80081e6b0c
> > [ffffffc02eec3d80] do_page_fault at ffffff800809d7ac
> > [ffffffc02eec3df0] do_mem_abort at ffffff800808156c
> > 
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  arch/arm64/kernel/traps.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index d399d45..7a097cc 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -113,7 +113,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
> >  
> >  	if (tsk == current) {
> >  		frame.fp = (unsigned long)__builtin_frame_address(0);
> > -		frame.pc = (unsigned long)dump_backtrace;
> > +		frame.pc = (unsigned long)dump_backtrace + 4;
> >  	} else {
> >  		/*
> >  		 * task blocked in __switch_to
> > @@ -130,7 +130,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
> >  	do {
> >  		/* skip until specified stack frame */
> >  		if (!skip) {
> > -			dump_backtrace_entry(frame.pc);
> > +			dump_backtrace_entry(frame.pc - 4);
> >  		} else if (frame.fp == regs->regs[29]) {
> >  			skip = 0;
> >  			/*
> > -- 
> > 1.9.1
> > 

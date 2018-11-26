Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57281C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1851620672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HbjTCqUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1851620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeK0G4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:56:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42760 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0G4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hw554VldoyK5bRBi8Tr1Wot585O+P5V5cizP6fB/5b4=; b=HbjTCqUQsk4raET+6eOsfo9ve
        cfcU29DeGfvAVR9salMqvkzv6XaLcnzBXtJ9UR9JKAYt4kixUaVEqDn/JUkvtowKn+qbHfS6cfLMp
        k5II2jlGb2OiAMUoiQ7OzqdRfvbNVlyDPY88EjzPleNIN/xQ8F0mdYALQlzwNXI515iZa8MxAQtgi
        WHa/Ix+ZYwkzFAzYChPUZ//t/4DX6Z2EZiRj8oE2vrbvhBHnaYJVB5Bma+Xgry+Ra2VIE/rymM6my
        GGpn5au2LnBkHYpqi7cynW1h52Zct1B8Z35SlpN5ON+3N0qpLBnWmaBEl10gnjdzdZQxgQjwPnhNu
        pjHoi2cEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRN3w-0003OY-GV; Mon, 26 Nov 2018 20:00:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA71D2029FD58; Mon, 26 Nov 2018 21:00:53 +0100 (CET)
Date:   Mon, 26 Nov 2018 21:00:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181126200053.GV2113@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
 <20181126175624.bruqfbkngbucpvxr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126175624.bruqfbkngbucpvxr@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:56:24AM -0600, Josh Poimboeuf wrote:
> Peter suggested updating the text_poke_bp() interface to add a handler
> which is called from int3 context.  This seems to work.

> @@ -760,8 +761,10 @@ int poke_int3_handler(struct pt_regs *regs)
>  	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
>  		return 0;
>  
> -	/* set up the specified breakpoint handler */
> -	regs->ip = (unsigned long) bp_int3_handler;
> +	if (bp_int3_handler)
> +		bp_int3_handler(regs);
> +
> +	regs->ip = (unsigned long)bp_int3_resume;
>  
>  	return 1;
>  

Peter also suggested you write that like:

	if (bp_int3_handler)
		bp_int3_handler(regs, resume);
	else
		regs->ip = resume;

That allows 'abusing' @resume as 'data' pointer for @handler. Which
allows for more complicated handlers.

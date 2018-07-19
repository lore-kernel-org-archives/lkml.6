Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F34C20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TlzQ/65V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F34C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbeGSOji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:39:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbeGSOji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NMYchCdJx9tK5Mn1rrjFsqXPv2lzF+7CfplF+GYHlSY=; b=TlzQ/65V8I7hEhB9KyUKYmfFA
        gQDCn3mWFz3B4yMpqWPzXK6EiNAgxLf/xdoVT786glKe8FLCg3UNvwYw+2VO1A4MVvw2R7i0a+YRG
        aGVMGIMCaXVsUYgGmRtWc6SHFklh2U+Dmd/vr3HhXvXhHe/o25B3I2O9BltQSNQD7WM6wrwkcs2fM
        XnlCMEM+SuZxvJndvKZLvzj3vrjOZg2Q9icXvPJ763ZTRrEs5XaAy5qRcHMznAUxFSSWEpOAh+upN
        9irVCz/GGAIMyJWFujLlOTE+kyAKsf8ghZ9LnzgglVT4BMgUneiuEL5wVW/CBYYvNXHos7d1ivEdY
        A4hvSYeCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg9Pa-0003fx-Go; Thu, 19 Jul 2018 13:56:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 417B820275F37; Thu, 19 Jul 2018 15:56:05 +0200 (CEST)
Date:   Thu, 19 Jul 2018 15:56:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     mingo@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        joe@perches.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6] x86: Avoid pr_cont() in show_opcodes().
Message-ID: <20180719135605.GG2494@hirez.programming.kicks-ass.net>
References: <1532008383-3797-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532008383-3797-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:53:03PM +0900, Tetsuo Handa wrote:
> +	if (probe_kernel_read(opcodes, rip - PROLOGUE_SIZE, OPCODE_BUFSIZE))
> +		printk("%sCode: Bad RIP value.\n", loglvl);
> +	else
> +		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
> +		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
> +		       opcodes[PROLOGUE_SIZE], opcodes + PROLOGUE_SIZE + 1);
>  }

Kernel coding style wants { } on the else branch because multi-line, and
if we have { } on one leg of an if-else it should also be on the other.


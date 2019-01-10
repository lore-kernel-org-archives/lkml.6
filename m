Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0E9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B21820879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jbtzpFcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfAJUau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:30:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfAJUau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kS+e3Aid9PD2KOCEcBF8gvRBmqCNOwO/L0+AA7MYSeM=; b=jbtzpFcxhY5u7e2NcI7hzFJbE
        Yf49pU+7QQDDYu/xq4X6oan96lTtd4oGnfSZiBI4OqAg6yg8XgEQWf6IARtg4UIAMmBi32rpbLQtr
        ExiiXJ0VAKUm0T+oUWgeWFd0MTzjUjzcN4Dhx9yU+7YxrmqjYdKj++oL7RYG8P6dxFWuGGUHt33iW
        w3Tu4p3kMS5H6/57tnfrPO0oxOAM/zki3QntFxG37R8gh59GpjIMsjus5w91JMnVca9NhmmKTCQo1
        52ot5sFBzRc5f9lRG0Jm785DVN5lA0TYDsUlOsd1j6NNplKkxhXticJecOiar3BI2H+6ScACPpGY3
        G76/TqpRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghgyA-0002LZ-Al; Thu, 10 Jan 2019 20:30:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 718239844AF; Thu, 10 Jan 2019 21:30:23 +0100 (CET)
Date:   Thu, 10 Jan 2019 21:30:23 +0100
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
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Message-ID: <20190110203023.GL2861@worktop.programming.kicks-ass.net>
References: <cover.1547073843.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547073843.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 04:59:35PM -0600, Josh Poimboeuf wrote:
> With this version, I stopped trying to use text_poke_bp(), and instead
> went with a different approach: if the call site destination doesn't
> cross a cacheline boundary, just do an atomic write.  Otherwise, keep
> using the trampoline indefinitely.

> - Get rid of the use of text_poke_bp(), in favor of atomic writes.
>   Out-of-line calls will be promoted to inline only if the call sites
>   don't cross cache line boundaries. [Linus/Andy]

Can we perserve why text_poke_bp() didn't work? I seem to have forgotten
again. The problem was poking the return address onto the stack from the
int3 handler, or something along those lines?

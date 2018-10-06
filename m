Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B6C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9542147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmGquFOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9542147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeJFTPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:15:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeJFTPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aG1FcGFSDYIVigsvtdAWrXnZDykDmhyslHi2bgdrC88=; b=lmGquFOrlfRhXDZ36VVpnS6fy
        CbrYFdRKe45XL2b6DMWvhvLkDBDPzLo1IZAY4njt5r9kAJUnzTdUIgMj0MTVreVN/F15WOPx8Kaq4
        A5SZVvUBFe9exl2c0e5FJGBGuNxx/xe8SZhDYdRg9YzN5p9TMKZBp8j5p9a/RDx7AYCIf9ph/X2Qv
        uTOn8sWO2OhzAifxo5mUoTLmItFiyPRG/ZbigBiGFOkLfFqRjyoqC6EnWNmRnVEC+yC/Vbam7/BMG
        qL7JyzxlOlBJA8nmFDRMHxthWBTCHNdqVZ6GDwi+1sKq9poIaAdScB2mh+9+WfMBEOZ+Ft6EExJIz
        VEqyFGqFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g8lRU-0006jv-2T; Sat, 06 Oct 2018 12:12:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 917DC201EF080; Sat,  6 Oct 2018 14:12:11 +0200 (CEST)
Date:   Sat, 6 Oct 2018 14:12:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        ard.biesheuvel@linaro.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Message-ID: <20181006121211.GA5663@hirez.programming.kicks-ass.net>
References: <20181006015110.653946300@goodmis.org>
 <20181006015720.634688468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006015720.634688468@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 09:51:11PM -0400, Steven Rostedt wrote:
> +#define arch_dynfunc_trampoline(name, def)	\
> +	asm volatile (				\
> +	".globl dynfunc_" #name "; \n\t"	\
> +	"dynfunc_" #name ": \n\t"		\
> +	"jmp " #def " \n\t"			\
> +	".balign 8 \n \t"			\
> +	: : : "memory" )

Bah, what is it with you people and trampolines. Why can't we, just like
jump_label, patch the call directly?

The whole call+jmp thing is silly, don't do that. It just wrecks I$ and
is slower for no real reason afaict.

Steve, also see:

  https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org

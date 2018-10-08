Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F40C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF9021479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eB8y+K6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF9021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeJHXKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:10:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58180 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeJHXKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eK4fDbrsjTJidp5MHrzu3rt5LFl7HH2NjGNM9RULQ/c=; b=eB8y+K6sKRnxiVusKwaNKLHNVn
        MgXjfGTAsmA0nBm3iZc6dF64HFGMMqm2CMftpwZyyYPhpLIxYicd5NxXtA3gU8F2RhQhiwIG6HsJx
        pcLtPjbCfBTb+KE4sGsOCBJIm8xthMtLIdO0YiV3XtGWqwvHS61QPpZSBWHv58wYyDhTXh6laeSge
        ci2yk+FQC3dNXVJNGdgbdQT6TAaJxSTrFera1UGiDrsFRILtHSsiBKOp7tVMjDoMvSOL4Ubw75rg4
        USReVb/VBnVOqx9qAxW/6L2yPCmNyg16nD4BEt9raUuLS04nRSlHSQrzllHE6kEUGok7eilG/KBRC
        ftotf2ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9Xux-00068k-3i; Mon, 08 Oct 2018 15:57:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89951206F0EC5; Mon,  8 Oct 2018 17:57:57 +0200 (CEST)
Date:   Mon, 8 Oct 2018 17:57:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20181008155757.GC5663@hirez.programming.kicks-ass.net>
References: <20181006015110.653946300@goodmis.org>
 <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net>
 <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net>
 <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 01:33:14AM -0700, Andy Lutomirski wrote:
> > Can't we hijack the relocation records for these functions before they
> > get thrown out in the (final) link pass or something?
> 
> I could be talking out my arse here, but I thought we could do this,
> too, then changed my mind.  The relocation records give us the
> location of the call or jump operand, but they don’t give the address
> of the beginning of the instruction.

But that's like 1 byte before the operand, right? We could even double check
this by reading back that byte and ensuring it is in fact 0xE8 (CALL).

AFAICT there is only the _1_ CALL encoding, and that is the 5 byte: E8 <PLT32>,
so if we have the PLT32 location, we also have the instruction location. Or am
I missing something?

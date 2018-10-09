Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832DC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CB22086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CB22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJIJbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeJIJbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:31:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F5ECC004AA1;
        Tue,  9 Oct 2018 02:17:15 +0000 (UTC)
Received: from treble (ovpn-120-103.rdu2.redhat.com [10.10.120.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9208E26565;
        Tue,  9 Oct 2018 02:17:12 +0000 (UTC)
Date:   Mon, 8 Oct 2018 21:17:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
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
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        ard.biesheuvel@linaro.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Message-ID: <20181009021710.qwt5hpntyeps44h3@treble>
References: <20181006015110.653946300@goodmis.org>
 <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net>
 <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net>
 <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net>
 <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 09 Oct 2018 02:17:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:29:56AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Oct 8, 2018, at 8:57 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Mon, Oct 08, 2018 at 01:33:14AM -0700, Andy Lutomirski wrote:
> >>> Can't we hijack the relocation records for these functions before they
> >>> get thrown out in the (final) link pass or something?
> >> 
> >> I could be talking out my arse here, but I thought we could do this,
> >> too, then changed my mind.  The relocation records give us the
> >> location of the call or jump operand, but they don’t give the address
> >> of the beginning of the instruction.
> > 
> > But that's like 1 byte before the operand, right? We could even double check
> > this by reading back that byte and ensuring it is in fact 0xE8 (CALL).
> > 
> > AFAICT there is only the _1_ CALL encoding, and that is the 5 byte: E8 <PLT32>,
> > so if we have the PLT32 location, we also have the instruction location. Or am
> > I missing something?
> 
> There’s also JMP and Jcc, any of which can be used for rail calls, but
> those are also one byte. I suppose GCC is unlikely to emit a prefixed
> form of any of these. So maybe we really can assume they’re all one
> byte.

I'm pretty sure only a basic JMP is used for tail calls.

> But there is a nasty potential special case: anything that takes the
> function’s address. This includes jump tables, computed gotos, and
> plain old function pointers. And I suspect that any of these could
> have one of the rather large number of CALL/JMP/Jcc bytes before the
> relocation by coincidence.

But those special cases aren't in a text section, right?  If we just
make sure the relocations are applied to a text section, and that
they're preceded by the CALL or JMP byte, wouldn't that be sufficient?

I'm not really convinced we need objtool for this, maybe I'll try
whipping up a POC.

-- 
Josh

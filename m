Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BE52145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BE52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJHXoR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeJHXoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:44:17 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C912089D;
        Mon,  8 Oct 2018 16:31:43 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:31:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        ard.biesheuvel@linaro.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Message-ID: <20181008123140.666fa405@gandalf.local.home>
In-Reply-To: <20181008155757.GC5663@hirez.programming.kicks-ass.net>
References: <20181006015110.653946300@goodmis.org>
        <20181006015720.634688468@goodmis.org>
        <20181006121211.GA5663@hirez.programming.kicks-ass.net>
        <20181006093905.46276505@vmware.local.home>
        <20181008072134.GB5663@hirez.programming.kicks-ass.net>
        <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
        <20181008155757.GC5663@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 17:57:57 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Oct 08, 2018 at 01:33:14AM -0700, Andy Lutomirski wrote:
> > > Can't we hijack the relocation records for these functions before they
> > > get thrown out in the (final) link pass or something?  
> > 
> > I could be talking out my arse here, but I thought we could do this,
> > too, then changed my mind.  The relocation records give us the
> > location of the call or jump operand, but they don’t give the address
> > of the beginning of the instruction.  
> 
> But that's like 1 byte before the operand, right? We could even double check
> this by reading back that byte and ensuring it is in fact 0xE8 (CALL).
> 
> AFAICT there is only the _1_ CALL encoding, and that is the 5 byte: E8 <PLT32>,
> so if we have the PLT32 location, we also have the instruction location. Or am
> I missing something?

Yes, this is exactly what I was thinking of doing. All we need to do is
have objtool (or a modification of whatever we come up with), to find
the call sites of a specific function (we can have a table to look up
for), that creates a section listing all these call sites, and on boot
up, we can confirm that they are indeed calls (e8 operations).

-- Steve

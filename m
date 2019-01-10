Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7740C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3421213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfAJUwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:52:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbfAJUwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:52:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90ECC2090D;
        Thu, 10 Jan 2019 20:52:37 +0000 (UTC)
Received: from treble (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A736104812A;
        Thu, 10 Jan 2019 20:52:28 +0000 (UTC)
Date:   Thu, 10 Jan 2019 14:52:26 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20190110205226.iburt6mrddsxnjpk@treble>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110203023.GL2861@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 10 Jan 2019 20:52:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:30:23PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 09, 2019 at 04:59:35PM -0600, Josh Poimboeuf wrote:
> > With this version, I stopped trying to use text_poke_bp(), and instead
> > went with a different approach: if the call site destination doesn't
> > cross a cacheline boundary, just do an atomic write.  Otherwise, keep
> > using the trampoline indefinitely.
> 
> > - Get rid of the use of text_poke_bp(), in favor of atomic writes.
> >   Out-of-line calls will be promoted to inline only if the call sites
> >   don't cross cache line boundaries. [Linus/Andy]
> 
> Can we perserve why text_poke_bp() didn't work? I seem to have forgotten
> again. The problem was poking the return address onto the stack from the
> int3 handler, or something along those lines?

Right, emulating a call instruction from the #BP handler is ugly,
because you have to somehow grow the stack to make room for the return
address.  Personally I liked the idea of shifting the iret frame by 16
bytes in the #DB entry code, but others hated it.

So many bad-but-not-completely-unacceptable options to choose from.

-- 
Josh

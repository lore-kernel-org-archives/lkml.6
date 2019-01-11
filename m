Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F036C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CCF20879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfAKBeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:34:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:15757 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbfAKBeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:34:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 17:34:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,463,1539673200"; 
   d="scan'208";a="290661265"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2019 17:34:21 -0800
Date:   Thu, 10 Jan 2019 17:34:21 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     hpa@zytor.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
Message-ID: <20190111013421.GD2365@linux.intel.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
 <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
 <20190110172004.wuh45xoafynfm2df@treble>
 <20190110123243.3b9e0856@gandalf.local.home>
 <20190110174257.GE16556@linux.intel.com>
 <1955E727-BF68-4C00-A8C2-54FA9487A5A6@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1955E727-BF68-4C00-A8C2-54FA9487A5A6@zytor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:59:55PM -0800, hpa@zytor.com wrote:
> On January 10, 2019 9:42:57 AM PST, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> >On Thu, Jan 10, 2019 at 12:32:43PM -0500, Steven Rostedt wrote:
> >> On Thu, 10 Jan 2019 11:20:04 -0600
> >> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >> 
> >> 
> >> > > While I can't find a reason for hypervisors to emulate this
> >instruction,
> >> > > smarter people might find ways to turn it into a security
> >exploit.  
> >> > 
> >> > Interesting point... but I wonder if it's a realistic concern. 
> >BTW,
> >> > text_poke_bp() also relies on undocumented behavior.
> >> 
> >> But we did get an official OK from Intel that it will work. Took a
> >bit
> >> of arm twisting to get them to do so, but they did. And it really is
> >> pretty robust.
> >
> >Did we (they?) list any caveats for this behavior?  E.g. I'm fairly
> >certain atomicity guarantees go out the window if WC memtype is used.
> 
> If you run code from non-WB memory, all bets are off and you better
> not be doing cross-modifying code.

I wasn't thinking of running code from non-WB, but rather running code
in WB while doing a CMC write via WC.

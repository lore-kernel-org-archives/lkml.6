Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E56C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91E8218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547235575;
	bh=X9R5/A2n10Q7alTbGqCU+pu4jrbT/F0EP4yxURLF3bI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ay7mlnyH8N/wZjBj6QUJCFo3Epixtcd9lK7JiKg5rEq/haHziWgk6z/MNNSlsO+jG
	 3BY4NDr2Qdxs2seMy5NKvbnbt+6UOeVM+J70BHkWXEmGlYVMu5CDbYbJurxCZQMYgQ
	 OPk/5m9ZLeUPF8il+BuAYyi73x62TDuYPo0H+7p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfAKTje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:39:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:45642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730371AbfAKTjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:39:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5E9BB055;
        Fri, 11 Jan 2019 19:39:31 +0000 (UTC)
Date:   Fri, 11 Jan 2019 20:39:28 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     hpa@zytor.com
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
In-Reply-To: <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
Message-ID: <nycvar.YFH.7.76.1901112035570.6626@cbobk.fhfr.pm>
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net> <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com> <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble> <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019, hpa@zytor.com wrote:

> I still don't see why can't simply spin in the #BP handler until the 
> patch is complete.

I think this brings us to the already discussed possible deadlock, when 
one CPU#0 is in the middle of text_poke_bp(), CPU#1 is spinning inside 
spin_lock_irq*(&lock) and CPU#2 hits the breakpont while holding that very 
'lock'.

Then we're stuck forever, because CPU#1 will never handle the pending 
sync_core() IPI (it's not NMI).

Or have I misunderstood what you meant?

-- 
Jiri Kosina
SUSE Labs


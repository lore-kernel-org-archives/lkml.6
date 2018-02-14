Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754576AbeBNHgA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 02:36:00 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53219 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754562AbeBNHf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 02:35:57 -0500
X-Google-Smtp-Source: AH8x2256Js+HmG4umCCt5XmcYoEYDR2WpBtuy/uWaD5jjdCSXIv8MkzgGTZdK+P4kjuQFgo7HSopow==
Date: Wed, 14 Feb 2018 08:35:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/entry/64: Fix CR3 restore order in paranoid_exit()
Message-ID: <20180214073553.qsdnpetdgd4mkjdx@gmail.com>
References: <2b8ce3a31bcdfffa434269f4abf5d46816b75773.1518575248.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8ce3a31bcdfffa434269f4abf5d46816b75773.1518575248.git.jpoimboe@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> I haven't actually seen any real-world bugs caused by this, so I'm not
> sure how theoretical it is.  I just stumbled upon it in code review when
> looking for another bug.

I believe it's a real bug, but the fix is wrong with irq tracing or lockdep 
enabled as Dave points out.

I think the reason we haven't seen this bug yet is that "paranoid" entry points 
are limited to:

idtentry double_fault			do_double_fault			has_error_code=1 paranoid=2
idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
idtentry int3			do_int3			has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
idtentry machine_check		do_mce			has_error_code=0	paranoid=1

Only machine_check is one that will interrupt an IRQS-off critical section 
asynchronously - and machine check events are rare.

The other main asynchronous entries are NMI entries, which can be very high-freq 
with perf profiling, but they are special: they don't use the 'idtentry' macro but 
are open coded and restore user CR3 unconditionally so don't seem to have this 
bug.

Thanks,

	Ingo

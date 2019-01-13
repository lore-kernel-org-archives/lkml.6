Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EFDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C782086C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfAMAhi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 19:37:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57827 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfAMAhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 19:37:38 -0500
Received: from [IPv6:2607:fb90:3095:7b5f:c01c:f28c:b0dd:a254] ([172.58.39.235])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0D0aifJ1362661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 12 Jan 2019 16:36:45 -0800
Date:   Sat, 12 Jan 2019 16:36:38 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wgQR1RfjA9V70cL-vTrhYBF9FWhPRaZahQuDaSazL+kAQ@mail.gmail.com>
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net> <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com> <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com> <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble> <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com> <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com> <CAHk-=wgQR1RfjA9V70cL-vTrhYBF9FWhPRaZahQuDaSazL+kAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 0/6] Static calls
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
From:   hpa@zytor.com
Message-ID: <E2076BDA-FED4-449F-805F-F255755C78A2@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 11, 2019 11:34:34 AM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Fri, Jan 11, 2019 at 11:24 AM <hpa@zytor.com> wrote:
>>
>> I still don't see why can't simply spin in the #BP handler until the
>patch is complete.
>
>So here's at least one problem:
>
>text_poke_bp()
>  text_poke(addr, &int3, sizeof(int3));
>   *interrupt*
>      interrupt has a static call
>        *BP*
>          poke_int3_handler
>             *BOOM*
>
>Note how at BOOM we cannot just spin (or return) to wait for the
>'int3' to be switched back. Becuase it never will. Because we are
>interrupting the thing that would do that switch-back.
>
>So we'd have to do the 'text_poke_bp()' sequence with interrupts
>disabled. Which we can't do right now at least, because part of that
>sequence involves that on_each_cpu(do_sync_core) thing, which needs
>interrupts enabled.
>
>See?
>
>Or am I missing something?
>
>            Linus

Ok, I was thinking far more about spinning with an IRET and letting the exception be delivered. Patching with interrupts disabled have other problems... 
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeBBSvA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:51:00 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:37303 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeBBSuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:50:51 -0500
X-Google-Smtp-Source: AH8x224CR+45AdDrMEH4MOUjfZ6LAe3H7iNMsGM7JtBe2JzToeL8r/FayMNP+732Oa7eGYKQILK2uBo6CC7b7wgQ6x0=
MIME-Version: 1.0
In-Reply-To: <1517583559-424-1-git-send-email-dwmw@amazon.co.uk>
References: <1517583559-424-1-git-send-email-dwmw@amazon.co.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2018 10:50:50 -0800
X-Google-Sender-Auth: 2e56jUv7bDgvemdW_JVXgOQTz5I
Message-ID: <CA+55aFwg88mxuOiJSh+xLnAfqEwAC-ReB9rdNx+r8fy=FTSHJw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Reduce retpoline performance impact in slot_handle_level_range()
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        KarimAllah Ahmed <karahmed@amazon.de>, sironi@amazon.de,
        "the arch/x86 maintainers" <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 6:59 AM, David Woodhouse <dwmw@amazon.co.uk> wrote:
> With retpoline, tight loops of "call this function for every XXX" are
> very much pessimised by taking a prediction miss *every* time.
>
> This one showed up very high in our early testing, and it only has five
> things it'll ever call so make it take an 'op' enum instead of a
> function pointer and let's see how that works out...

Umm. May I suggest a different workaround?

Honestly, if this is so performance-critical, the *real* fix is to
actually just mark all those "slot_handle_*()" functions as
"always_inline".

Because that will *really* improve performance, by simply removing the
indirection entirely - since then the functions involved will become
static. You might get other code improvements too, because I suspect
it will end up removing an extra level of function call due to those
trivial wrapper functions. And there's a couple of "bool
lock_flush_tlb" arguments that will simply become constant and
generate much better code that way.

And maybe you don't want to inline all of the slot_handle_*()
functions, and it's only one or two of them that matter because they
loop over a lot of entries, but honestly, most of those
slot_handle_xyz() functions seem to have just a couple of call sites
anyway.

slot_handle_large_level() is probably already inlined by the compiler
because it only has a single call-site.

Will it make for bigger code? Yes. But probably not really all *that*
much bigger, because of how it also will allow the compiler to
simplify some things.  An dif this really is so critical that those
non-predicted calls were that noticeable, those other simplifications
probably also matter.

And then  you get rid of all run-time conditionals, and all the
indirect jumps entirely. Plus the patch will be smaller and simpler
too.

Hmm?

              Linus

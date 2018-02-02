Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBBVYW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:24:22 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:37072 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbeBBVYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:24:16 -0500
Date: Fri, 2 Feb 2018 21:23:33 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        KarimAllah Ahmed <karahmed@amazon.de>, sironi@amazon.de,
        the arch/x86 maintainers <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] KVM: x86: Reduce retpoline performance impact in
 slot_handle_level_range()
Message-ID: <20180202212321.5186c13c@alans-desktop>
In-Reply-To: <1517599033.31953.71.camel@infradead.org>
References: <1517583559-424-1-git-send-email-dwmw@amazon.co.uk>
        <CA+55aFwg88mxuOiJSh+xLnAfqEwAC-ReB9rdNx+r8fy=FTSHJw@mail.gmail.com>
        <CA+55aFwqCc1UOkdBjEgiuL9fMkRj7RPrGFYQ376YhrqTUpLwrg@mail.gmail.com>
        <1517599033.31953.71.camel@infradead.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Either way, that does look like a reasonable answer. I had looked at
> the various one-line wrappers around slot_handle_level_range() and
> thought "hm, those should be inline", but I hadn't made the next step
> and pondered putting the whole thing inline. We'll give it a spin and
> work out where the next performance bottleneck is. Thanks.

In addition the problem with switch() is that gcc might decide in some
cases that the best way to implement your switch is an indirect call
from a lookup table.

For the simple case how about wrapping the if into

                call_likely(foo->bar, usualfunction, args)

as a companion to 

                 foo->bar(args)

that can resolve to nothing special on architectures that don't need it,
an if/else case on platforms with spectre, and potentially clever
stuff on any platform where you can beat the compiler by knowing
probabilities it can't infer ?

Alan

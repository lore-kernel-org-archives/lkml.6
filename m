Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932661AbeCLRMl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:12:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39688 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbeCLRMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:12:40 -0400
X-Google-Smtp-Source: AG47ELv3j7q4mCt251Nx5C34xEppq0A34QjCACTHqcjESVCC9tOlTZLu2jF8n3EBQTDFHlXImxS6iwvtWxFME31OTvc=
MIME-Version: 1.0
In-Reply-To: <CALCETrU8=_A9VzJMWuLouoyVQVLbnh_1etQK4tB4kvD8b51opQ@mail.gmail.com>
References: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
 <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
 <20180312124027.GG4064@hirez.programming.kicks-ass.net> <20180312124337.vw7bchm6brfzghfa@node.shutemov.name>
 <20180312131055.GH4064@hirez.programming.kicks-ass.net> <20180312140449.oyngtgqppnjuh3lf@node.shutemov.name>
 <20180312143212.77z2ptyqbsbqdll3@gmail.com> <20180312145049.boh3wmaotim6sfh2@black.fi.intel.com>
 <CA+55aFyKOkO1BBYX+-SZyON2FA_FSc9YqVDLU9-pRj1=jh9sUw@mail.gmail.com> <CALCETrU8=_A9VzJMWuLouoyVQVLbnh_1etQK4tB4kvD8b51opQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 10:12:38 -0700
X-Google-Sender-Auth: tIOkVjdJhbCxUo05JmkNBwzi0Pk
Message-ID: <CA+55aFya-fZQVi45axVpv4PF_b8yhHfDxx3xCTX+gbN5Ec9VUQ@mail.gmail.com>
Subject: Re: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind
 the LA57 check
To: Andy Lutomirski <luto@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        linux-tip-commits@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:06 AM, Andy Lutomirski <luto@kernel.org> wrote:
>
> I'd be surprised if there's a noticeable performance hit on anything
> except the micro-est of benchmarks.  We're talking one extra
> intermediate paging structure cache entry in use, maybe a few data
> cache lines, and (wild guess) 0 extra cycles on a TLB miss in the
> normal case.  This is because the walks are almost never going to
> start at the root.

Probably. But VM people may disagree if they already have high TLB miss costs.

> The real hit will be the extra page table for every task.

.. and it's unclear how noticeable that might be. It's not like it's
per-thread, only per process, and very few people have so many
processes that a page per process matters.

But regardless, I think we're better off with a "wait and see" approach.

IOW, try to use 5-level whenever possible for now, and _if_ somebody
actually can show that 4-level page tables perform better or have some
other advantage, we can then try to be clever later when it's all
tested and it's just an optimization, not a "that code won't even run
normally and gets basically zero coverage".

                Linus

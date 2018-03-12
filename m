Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeCLRqX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:46:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:59025 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbeCLRqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:46:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,462,1515484800";
   d="scan'208";a="36659564"
Subject: Re: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind
 the LA57 check
To: Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
 <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
 <20180312124027.GG4064@hirez.programming.kicks-ass.net>
 <20180312124337.vw7bchm6brfzghfa@node.shutemov.name>
 <20180312131055.GH4064@hirez.programming.kicks-ass.net>
 <20180312140449.oyngtgqppnjuh3lf@node.shutemov.name>
 <20180312143212.77z2ptyqbsbqdll3@gmail.com>
 <20180312145049.boh3wmaotim6sfh2@black.fi.intel.com>
 <CA+55aFyKOkO1BBYX+-SZyON2FA_FSc9YqVDLU9-pRj1=jh9sUw@mail.gmail.com>
 <CALCETrU8=_A9VzJMWuLouoyVQVLbnh_1etQK4tB4kvD8b51opQ@mail.gmail.com>
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
        linux-tip-commits@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <1248489e-6776-7731-0dad-36f8b62b1925@intel.com>
Date: Mon, 12 Mar 2018 10:21:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrU8=_A9VzJMWuLouoyVQVLbnh_1etQK4tB4kvD8b51opQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 10:06 AM, Andy Lutomirski wrote:
> I'd be surprised if there's a noticeable performance hit on anything
> except the micro-est of benchmarks.  We're talking one extra
> intermediate paging structure cache entry in use, maybe a few data
> cache lines, and (wild guess) 0 extra cycles on a TLB miss in the
> normal case.  This is because the walks are almost never going to
> start at the root.

The hardware guys are keenly aware of the concerns about the extra
latency that the extra level might cause us.  I frankly expect that
we'll see the overhead in *software* via get_user_pages() and friends
before we ever see a practical bump in TLB fill latency.

I'm also super in favor of enabling LA57 everywhere that we can, up
front, and only disabling selectively it if it has real-world problems.
It makes our lives (as Intel software people) massively easier because
we don't have to go tell everyone how to turn it on in the first place
to test it.

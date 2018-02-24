Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbeBXBtj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:49:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:24455 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751873AbeBXBti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:49:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,385,1515484800";
   d="scan'208";a="33201594"
Subject: Re: [RFC][PATCH 00/10] Use global pages with PTI
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <CA+55aFy064KtXdduyM2E4rU6-ZJsOB69x2aJdZxbXgJPh2HUOQ@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <7e81fb89-5908-7d31-9225-defc48dbfa41@linux.intel.com>
Date: Fri, 23 Feb 2018 17:49:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFy064KtXdduyM2E4rU6-ZJsOB69x2aJdZxbXgJPh2HUOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 01:52 PM, Linus Torvalds wrote:
> Side note - and this may be crazy talk - I wonder if it might make
> sense to have a mode where we allow executable read-only kernel pages
> to be marked global too (but only in the kernel mapping).

We did that accidentally, somewhere.  It causes machine checks on K8's
iirc, which is fun (52994c256df fixed it).  So, we'd need to make sure
we avoid it there, or just make it global in the user mapping too.

> Of course, maybe the performance advantage from keeping the ITLB
> entries around isn't huge, but this *may* be worth at least asking
> some Intel architects about?

I kinda doubt it's worth the trouble.  Like you said, this probably
doesn't even matter when we have PCID support.  Also, we'll usually map
all of this text with 2M pages, minus whatever hangs over into the last
2M page of text.  My laptop looks like this:

> 0xffffffff81000000-0xffffffff81c00000          12M     ro         PSE         x  pmd
> 0xffffffff81c00000-0xffffffff81c0b000          44K     ro                     x  pte

So, even if we've flushed these entries, we can get all of them back
with a single cacheline worth of PMD entries.

Just for fun, I tried a 4-core Skylake system with KPTI and nopcid and
compiled a random kernel 10 times.  I did three configs: no global, all
kernel text global + cpu_entry_area, and only cpu_entry_area + entry
text.  The delta percentages are from the Baseline.  The deltas are
measurable, but the largest bang for our buck is obviously the entry text.

			User Time	Kernel Time	Clock Elapsed
Baseline (33 GLB PTEs)	907.6	        81.6		264.7
Entry    (28 GLB PTEs)	910.9 (+0.4%)	84.0 (+2.9%)	265.2 (+0.2%)
No global( 0 GLB PTEs)  914.2 (+0.7%)	89.2 (+9.3%)	267.8 (+1.2%)

It's a single line of code to go from the "33" to "28" configuration, so
it's totally doable.  But, it means having and parsing another boot
option that confuses people and then I have to go write actual
documentation, which I detest. :)

My inclination would be to just do the "entry" stuff as global just as
this set left things and leave it at that.

I also measured frontend stalls with the toplev.py tool[1].  They show
roughly the same thing, but a bit magnified since I was only monitoring
the kernel and because in some of these cases, even if we stop being
iTLB bound we just bottleneck on something else.

I ran:

	python ~/pmu-tools/toplev.py --kernel --level 3 make -j8

And looked for the relevant ITLB misses in the output:

Baseline
> FE             Frontend_Bound:        24.33 % Slots  [  7.68%]
> FE                ITLB_Misses:         5.16 % Clocks [  7.73%]
Entry:
> FE             Frontend_Bound:        26.62 % Slots  [  7.75%]
> FE                ITLB_Misses:        12.50 % Clocks [  7.74%]
No global:
> FE             Frontend_Bound:        27.58 % Slots  [  7.65%]
> FE                ITLB_Misses:        14.74 % Clocks [  7.71%]

1. https://github.com/andikleen/pmu-tools

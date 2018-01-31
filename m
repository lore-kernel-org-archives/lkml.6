Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeAaVJ3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:09:29 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:51034 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbeAaVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:09:27 -0500
X-Google-Smtp-Source: AH8x227lX+iAx+0Z2TnwPZn56w1yKlKygdEg2ahn3C8QANrhzDg662mVE66YSKjOW/owDd/kQyhjcw==
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] x86: Align TLB invalidation info
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <8bb352bc-4e1f-4e87-80e3-a8e65d618d2a@linux.intel.com>
Date: Wed, 31 Jan 2018 13:09:22 -0800
Cc: the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <0E65629C-0D7D-4602-A43D-B18E62F330A6@gmail.com>
References: <20180131201118.1694-1-namit@vmware.com>
 <8bb352bc-4e1f-4e87-80e3-a8e65d618d2a@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 01/31/2018 12:11 PM, Nadav Amit wrote:
>> The TLB invalidation info is allocated on the stack, which might cause
>> it to be unaligned. Since this information may be transferred to
>> different cores for TLB shootdown, this might result in an additional
>> cache-line bouncing between the cores.
>> 
>> GCC provides a way to deal with it by using
>> __builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.
> 
> It doesn't really *bounce*, though, does it?  I don't see any writes on
> the remote side.  The remote use seems entirely read-only.
> 
> You also don't have to exhaustively test this, but I'd love to see at
> least a sanity check with a microbenchmark (or something) that, yes,
> this does help *something*.  Maybe it makes the remote
> flush_tlb_func_common() run faster because it's pulling in fewer lines,
> or maybe you can even detect fewer misses in there.

I agree that with the whole Meltdown/Spectre entry-cost it might not even be
measurable, at least on small ( < 2 sockets) machines. But I do not think it
worth profiling. Basically, AFAIK, all the data structures that are used for
inter-processor communication by the kernel are aligned, and this is an
exception.

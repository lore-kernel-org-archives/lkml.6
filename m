Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeBAFiv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 00:38:51 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:42495 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeBAFiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 00:38:50 -0500
X-Google-Smtp-Source: AH8x226DCr7Y20FI/I8DuRz5E8gWGrGbOi9Qf0HI+n5LPIbTrvdKxAeD7vv5kxShhUxi9U8uSTzIuA==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] x86: Align TLB invalidation info
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <f7270e0d-d1d1-599d-d2c9-ddc2c263e090@linux.intel.com>
Date: Wed, 31 Jan 2018 21:38:46 -0800
Cc: the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Message-Id: <DBF48795-2F4B-4C65-A5DD-A78D2214DF9B@gmail.com>
References: <20180131201118.1694-1-namit@vmware.com>
 <8bb352bc-4e1f-4e87-80e3-a8e65d618d2a@linux.intel.com>
 <0E65629C-0D7D-4602-A43D-B18E62F330A6@gmail.com>
 <f7270e0d-d1d1-599d-d2c9-ddc2c263e090@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w115d3x9018524

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 01/31/2018 01:09 PM, Nadav Amit wrote:
>>> You also don't have to exhaustively test this, but I'd love to see at
>>> least a sanity check with a microbenchmark (or something) that, yes,
>>> this does help *something*.  Maybe it makes the remote
>>> flush_tlb_func_common() run faster because it's pulling in fewer lines,
>>> or maybe you can even detect fewer misses in there.
>> I agree that with the whole Meltdown/Spectre entry-cost it might not even be
>> measurable, at least on small ( < 2 sockets) machines. But I do not think it
>> worth profiling. Basically, AFAIK, all the data structures that are used for
>> inter-processor communication by the kernel are aligned, and this is an
>> exception.
> 
> I'm certainly not nak'ing this.  I think your patch is likely a good
> idea.  But, could you please take ten or twenty minutes to go see if
> practice matches your assumptions?  I'd really appreciate it.  If you
> can't measure it, then no biggie.

[CC’ing the mailing list]

Per your request, I measured it (which perhaps I should have done before). I
caused a misalignment intentionally by adding some padding to flush_tlb_info
and compared it with an aligned version.

I used ftrace to measure the execution time of flush_tlb_func_remote() on a
2-socket Haswell machine, using a microbenchmark I wrote for some research
project.

It turns out that your skepticism may be correct - In both cases the
function execution time is roughly 400ns (2% improvement on the aligned case
which is probably noise).

So it is up to you whether you want to discard the patch.

Regards,
Nadav

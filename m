Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbeAaVRl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:17:41 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36020 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeAaVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:17:40 -0500
X-Google-Smtp-Source: AH8x227KN2NB9MRpoT9VdwS39or/4BojPXUL4HA1xngP+5ewg5fTmOPeF/iEHB4os1qToJdLKAwMew==
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] x86: Align TLB invalidation info
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrX-zmhoLgZzL_VJZqZF+XTS26o+HHA7=vA+E7T88yO_uA@mail.gmail.com>
Date: Wed, 31 Jan 2018 13:17:36 -0800
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-Id: <C841B1F3-9A76-4D09-88AB-EEC4447DB70F@gmail.com>
References: <20180131201118.1694-1-namit@vmware.com>
 <8bb352bc-4e1f-4e87-80e3-a8e65d618d2a@linux.intel.com>
 <0E65629C-0D7D-4602-A43D-B18E62F330A6@gmail.com>
 <CALCETrX-zmhoLgZzL_VJZqZF+XTS26o+HHA7=vA+E7T88yO_uA@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VLHpcc011242

Andy Lutomirski <luto@kernel.org> wrote:

> On Wed, Jan 31, 2018 at 1:09 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>> 
>>> On 01/31/2018 12:11 PM, Nadav Amit wrote:
>>>> The TLB invalidation info is allocated on the stack, which might cause
>>>> it to be unaligned. Since this information may be transferred to
>>>> different cores for TLB shootdown, this might result in an additional
>>>> cache-line bouncing between the cores.
>>>> 
>>>> GCC provides a way to deal with it by using
>>>> __builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.
>>> 
>>> It doesn't really *bounce*, though, does it?  I don't see any writes on
>>> the remote side.  The remote use seems entirely read-only.
>>> 
>>> You also don't have to exhaustively test this, but I'd love to see at
>>> least a sanity check with a microbenchmark (or something) that, yes,
>>> this does help *something*.  Maybe it makes the remote
>>> flush_tlb_func_common() run faster because it's pulling in fewer lines,
>>> or maybe you can even detect fewer misses in there.
>> 
>> I agree that with the whole Meltdown/Spectre entry-cost it might not even be
>> measurable, at least on small ( < 2 sockets) machines. But I do not think it
>> worth profiling. Basically, AFAIK, all the data structures that are used for
>> inter-processor communication by the kernel are aligned, and this is an
>> exception.
> 
> This is only going to be measurable at all on NUMA, I suspect.

Yes, I meant <= 2 ... 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeAaVPl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:15:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753145AbeAaVPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:15:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CB12178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x224Tvgh6Hjgu2vMqhBt434LkNYg915rW5qeSY82GU0U15USlSFmx7uDOKxaOKPfyPj4Z6680pLZ1BqGLoOISa14=
MIME-Version: 1.0
In-Reply-To: <0E65629C-0D7D-4602-A43D-B18E62F330A6@gmail.com>
References: <20180131201118.1694-1-namit@vmware.com> <8bb352bc-4e1f-4e87-80e3-a8e65d618d2a@linux.intel.com>
 <0E65629C-0D7D-4602-A43D-B18E62F330A6@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 31 Jan 2018 13:15:19 -0800
X-Gmail-Original-Message-ID: <CALCETrX-zmhoLgZzL_VJZqZF+XTS26o+HHA7=vA+E7T88yO_uA@mail.gmail.com>
Message-ID: <CALCETrX-zmhoLgZzL_VJZqZF+XTS26o+HHA7=vA+E7T88yO_uA@mail.gmail.com>
Subject: Re: [PATCH] x86: Align TLB invalidation info
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 1:09 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>> On 01/31/2018 12:11 PM, Nadav Amit wrote:
>>> The TLB invalidation info is allocated on the stack, which might cause
>>> it to be unaligned. Since this information may be transferred to
>>> different cores for TLB shootdown, this might result in an additional
>>> cache-line bouncing between the cores.
>>>
>>> GCC provides a way to deal with it by using
>>> __builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.
>>
>> It doesn't really *bounce*, though, does it?  I don't see any writes on
>> the remote side.  The remote use seems entirely read-only.
>>
>> You also don't have to exhaustively test this, but I'd love to see at
>> least a sanity check with a microbenchmark (or something) that, yes,
>> this does help *something*.  Maybe it makes the remote
>> flush_tlb_func_common() run faster because it's pulling in fewer lines,
>> or maybe you can even detect fewer misses in there.
>
> I agree that with the whole Meltdown/Spectre entry-cost it might not even be
> measurable, at least on small ( < 2 sockets) machines. But I do not think it
> worth profiling. Basically, AFAIK, all the data structures that are used for
> inter-processor communication by the kernel are aligned, and this is an
> exception.
>

This is only going to be measurable at all on NUMA, I suspect.

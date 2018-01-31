Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeAaVB0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:01:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:17672 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752757AbeAaVBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:01:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,441,1511856000";
   d="scan'208";a="170690603"
Subject: Re: [PATCH] x86: Align TLB invalidation info
To: Nadav Amit <namit@vmware.com>, x86@kernel.org
References: <20180131201118.1694-1-namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>, Andy Lutomirski <luto@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <8bb352bc-4e1f-4e87-80e3-a8e65d618d2a@linux.intel.com>
Date: Wed, 31 Jan 2018 13:01:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180131201118.1694-1-namit@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 12:11 PM, Nadav Amit wrote:
> The TLB invalidation info is allocated on the stack, which might cause
> it to be unaligned. Since this information may be transferred to
> different cores for TLB shootdown, this might result in an additional
> cache-line bouncing between the cores.
> 
> GCC provides a way to deal with it by using
> __builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.

It doesn't really *bounce*, though, does it?  I don't see any writes on
the remote side.  The remote use seems entirely read-only.

You also don't have to exhaustively test this, but I'd love to see at
least a sanity check with a microbenchmark (or something) that, yes,
this does help *something*.  Maybe it makes the remote
flush_tlb_func_common() run faster because it's pulling in fewer lines,
or maybe you can even detect fewer misses in there.

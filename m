Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964814AbeE2QDl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:03:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934933AbeE2QDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:03:39 -0400
Date: Tue, 29 May 2018 18:03:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: changbin.du@intel.com
Cc: akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
        neilb@suse.com, linux-kernel@vger.kernel.org, jpoimboe@redhat.com
Subject: Re: [PATCH] scripts/faddr2line: show the code context
Message-ID: <20180529160332.GD12258@hirez.programming.kicks-ass.net>
References: <1521444205-2259-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521444205-2259-1-git-send-email-changbin.du@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 03:23:25PM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> Inspired by gdb command 'list', show the code context of target lines.
> Here is a example:
> 
> $ scripts/faddr2line vmlinux native_write_msr+0x6
> native_write_msr+0x6/0x20:
> arch_static_branch at arch/x86/include/asm/msr.h:105
> 100             return EAX_EDX_VAL(val, low, high);
> 101     }
> 102
> 103     static inline void notrace __wrmsr(unsigned int msr, u32 low, u32 high)
> 104     {
> 105             asm volatile("1: wrmsr\n"
> 106                          "2:\n"
> 107                          _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wrmsr_unsafe)
> 108                          : : "c" (msr), "a"(low), "d" (high) : "memory");
> 109     }
> 110
> (inlined by) static_key_false at include/linux/jump_label.h:142
> 137     #define JUMP_TYPE_LINKED        2UL
> 138     #define JUMP_TYPE_MASK          3UL
> 139
> 140     static __always_inline bool static_key_false(struct static_key *key)
> 141     {
> 142             return arch_static_branch(key, false);
> 143     }
> 144
> 145     static __always_inline bool static_key_true(struct static_key *key)
> 146     {
> 147             return !arch_static_branch(key, true);
> (inlined by) native_write_msr at arch/x86/include/asm/msr.h:150
> 145     static inline void notrace
> 146     native_write_msr(unsigned int msr, u32 low, u32 high)
> 147     {
> 148             __wrmsr(msr, low, high);
> 149
> 150             if (msr_tracepoint_active(__tracepoint_write_msr))
> 151                     do_trace_write_msr(msr, ((u64)high << 32 | low), 0);
> 152     }
> 153
> 154     /* Can be uninlined because referenced by paravirt */
> 155     static inline int notrace

Not a fan of this :-/ And you didn't even make it optional. Nor did you
Cc the original author of the tool.

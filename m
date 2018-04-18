Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeDRT7U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 15:59:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeDRT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 15:59:18 -0400
Date: Wed, 18 Apr 2018 12:59:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Serge Hallyn <serge@hallyn.com>,
        James Morris <james.l.morris@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@01.org, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [do_execve] attempted to set unsupported pgprot
Message-Id: <20180418125916.a8be1fac1ac017f41a10f0fb@linux-foundation.org>
In-Reply-To: <20180418135933.t3dyszi2phhsvaah@wfg-t540p.sh.intel.com>
References: <20180418135933.t3dyszi2phhsvaah@wfg-t540p.sh.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 21:59:33 +0800 Fengguang Wu <fengguang.wu@intel.com> wrote:

> Hello,
> 
> FYI this happens in mainline kernel 4.17.0-rc1.
> It looks like a new regression.
> 
> It occurs in 4 out of 4 boots.
> 
> [   12.345562] Write protecting the kernel text: 14376k
> [   12.346649] Write protecting the kernel read-only data: 4740k
> [   12.347584] rodata_test: all tests were successful
> [   12.348499] ------------[ cut here ]------------
> [   12.349193] attempted to set unsupported pgprot: 8000000000000025 bits: 8000000000000000 supported: 7fffffffffffffff
> [   12.350792] WARNING: CPU: 0 PID: 1 at arch/x86/include/asm/pgtable.h:540 handle_mm_fault+0xfc1/0xfe0:
> 						check_pgprot at arch/x86/include/asm/pgtable.h:535
> 						 (inlined by) pfn_pte at arch/x86/include/asm/pgtable.h:549
> 						 (inlined by) do_anonymous_page at mm/memory.c:3169
> 						 (inlined by) handle_pte_fault at mm/memory.c:3961
> 						 (inlined by) __handle_mm_fault at mm/memory.c:4087
> 						 (inlined by) handle_mm_fault at mm/memory.c:4124
> [   12.352294] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1 #172
> [   12.353357] EIP: handle_mm_fault+0xfc1/0xfe0:
> 						check_pgprot at arch/x86/include/asm/pgtable.h:535
> 						 (inlined by) pfn_pte at arch/x86/include/asm/pgtable.h:549
> 						 (inlined by) do_anonymous_page at mm/memory.c:3169
> 						 (inlined by) handle_pte_fault at mm/memory.c:3961
> 						 (inlined by) __handle_mm_fault at mm/memory.c:4087
> 						 (inlined by) handle_mm_fault at mm/memory.c:4124

Dave, fb43d6cb91ef57 ("x86/mm: Do not auto-massage page protections")
looks like a culprit?

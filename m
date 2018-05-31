Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755759AbeEaQfN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:35:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755597AbeEaQfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:35:12 -0400
Date: Thu, 31 May 2018 11:35:09 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] objtool: Fix GCC 8 cold subfunction detection for
 aliased functions
Message-ID: <20180531163509.rkvalvwbwtockh3n@treble>
References: <6d4fc778da0c8702b0d19882443ea33233af6fc3.1527696986.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d4fc778da0c8702b0d19882443ea33233af6fc3.1527696986.git.jpoimboe@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:16:39AM -0500, Josh Poimboeuf wrote:
> The kbuild test robot reported the following issue:
> 
>   kernel/time/posix-stubs.o: warning: objtool: sys_ni_posix_timers.cold.1()+0x0: unreachable instruction
> 
> This file creates symbol aliases for the sys_ni_posix_timers() function.
> So there are multiple ELF function symbols for the same function:
> 
>   23: 0000000000000150     26 FUNC    GLOBAL DEFAULT        1 __x64_sys_timer_create
>   24: 0000000000000150     26 FUNC    GLOBAL DEFAULT        1 sys_ni_posix_timers
>   25: 0000000000000150     26 FUNC    GLOBAL DEFAULT        1 __ia32_sys_timer_create
>   26: 0000000000000150     26 FUNC    GLOBAL DEFAULT        1 __x64_sys_timer_gettime
> 
> Here's the corresponding cold subfunction:
> 
>   11: 0000000000000000     45 FUNC    LOCAL  DEFAULT        6 sys_ni_posix_timers.cold.1
> 
> When analyzing overlapping functions, objtool only looks at the first
> one in the symbol list.  The rest of the functions are basically ignored
> because they point to instructions which have already been analyzed.
> 
> So in this case it analyzes the __x64_sys_timer_create() function, but
> then it fails to recognize that its cold subfunction is
> sys_ni_posix_timers.cold.1(), because the names are different.
> 
> Make the subfunction detection a little smarter by associating each
> subfunction with the first function which jumps to it, since that's the
> one which will be analyzed.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

NACK.  This adds another warning:

arch/x86/xen/enlighten.o: warning: objtool: xen_pin_vcpu()+0x4b: can't find switch jump table

-- 
Josh

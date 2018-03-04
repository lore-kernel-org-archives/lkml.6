Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbeCDKye convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 05:54:34 -0500
Received: from ozlabs.org ([103.22.144.67]:40853 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932234AbeCDKyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 05:54:31 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 17/21] powerpc: Add missing prototype for sys_debug_setcontext
In-Reply-To: <20180225172236.29650-18-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-18-malat@debian.org>
Date: Sun, 04 Mar 2018 21:54:29 +1100
Message-ID: <87muzoglga.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:

> In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32.c")
> the function sys_debug_setcontext was added without a prototype.
>
> Fix compilation warning (treated as error in W=1):
>
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype for ‘sys_debug_setcontext’ [-Werror=missing-prototypes]
>  int sys_debug_setcontext(struct ucontext __user *ctx,
>      ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

This one should actually be using the SYSCALL_DEFINE syntax, so that it
can be used with CONFIG_FTRACE_SYSCALLS.

See eg. our mmap:

  SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
  		unsigned long, prot, unsigned long, flags,
  		unsigned long, fd, off_t, offset)
  {
  	return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
  }


We probably still need this patch, but I'm not entirely sure because the
SYSCALL_DEFINE macro does all sorts of shenanigans.

cheers

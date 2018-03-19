Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031012AbeCST6q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:58:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32963 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936041AbeCST5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:57:53 -0400
Date: Mon, 19 Mar 2018 20:57:48 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] x86: Force asm-goto
In-Reply-To: <20180319154717.652679334@infradead.org>
Message-ID: <alpine.DEB.2.21.1803192055410.1520@nanos.tec.linutronix.de>
References: <20180319154124.337947038@infradead.org> <20180319154717.652679334@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, Peter Zijlstra wrote:

> We want to start using asm-goto to guarantee the absence of dynamic
> branches (and thus speculation).
> 
> A primary prerequisite for this is of course that the compiler
> supports asm-goto. This effecively lifts the minimum GCC version to
> build an x86 kernel to gcc-4.5.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Makefile          |   13 +++++++------
>  arch/x86/Makefile |    4 ++++
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> --- a/Makefile
> +++ b/Makefile
> @@ -494,6 +494,13 @@ RETPOLINE_CFLAGS_CLANG := -mretpoline-ex
>  RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
>  export RETPOLINE_CFLAGS
>  
> +# check for 'asm goto'
> +ifeq ($(shell $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)

Why are you not using the shell-cached version which you remove further
down?

Thanks,

	tglx

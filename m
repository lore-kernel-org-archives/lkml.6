Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935912AbeCHQ0e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:26:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933513AbeCHQ0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:26:18 -0500
Date: Thu, 8 Mar 2018 10:26:16 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20180308162616.yhbymodggnfzpskx@treble>
References: <20180305164928.GA17953@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180305164928.GA17953@lst.de>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 05:49:28PM +0100, Torsten Duwe wrote:
> The "Power Architecture 64-Bit ELF V2 ABI" says in section 2.3.2.3:
> 
> [...] There are several rules that must be adhered to in order to ensure
> reliable and consistent call chain backtracing:
> 
> * Before a function calls any other function, it shall establish its
>   own stack frame, whose size shall be a multiple of 16 bytes.
> 
>  – In instances where a function’s prologue creates a stack frame, the
>    back-chain word of the stack frame shall be updated atomically with
>    the value of the stack pointer (r1) when a back chain is implemented.
>    (This must be supported as default by all ELF V2 ABI-compliant
>    environments.)
> [...]
>  – The function shall save the link register that contains its return
>    address in the LR save doubleword of its caller’s stack frame before
>    calling another function.
> 
> To me this sounds like the equivalent of HAVE_RELIABLE_STACKTRACE.
> This patch may be unneccessarily limited to ppc64le, but OTOH the only
> user of this flag so far is livepatching, which is only implemented on
> PPCs with 64-LE, a.k.a. ELF ABI v2.
> 
> This change also implements save_stack_trace_tsk_reliable() for ppc64
> that checks for the above conditions, where possible.
> 
> Signed-off-by:   Torsten Duwe <duwe@suse.de>

This doesn't seem to address some of my previous concerns:

- Bailing on interrupt/exception frames

- Function graph tracing return address conversion

- kretprobes return address conversion

-- 
Josh

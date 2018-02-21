Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeBUAQh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:16:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbeBUAQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:16:36 -0500
Date: Tue, 20 Feb 2018 16:16:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/4] kernel/fork: switch vmapped stack callation to
 __vmalloc_area()
Message-Id: <20180220161634.517598ec63ec4a785c4c81cc@linux-foundation.org>
In-Reply-To: <5c19630f-7466-676d-dbbc-a5668c91cbcd@yandex-team.ru>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
        <151670492913.658225.2758351129158778856.stgit@buzz>
        <5c19630f-7466-676d-dbbc-a5668c91cbcd@yandex-team.ru>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2018 16:57:21 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> # stress-ng --clone 100 -t 10s --metrics-brief
> at 32-core machine shows boost 35000 -> 36000 bogo ops
> 
> Patch 4/4 is a kind of RFC.
> Actually per-cpu cache of preallocated stacks works faster than buddy allocator thus
> performance boots for it happens only at completely insane rate of clones.
> 

I'm not really sure what to make of this patchset.  Is it useful in any
known real-world use cases?

> +	  This option neutralize stack overflow protection but allows to
> +	  achieve best performance for syscalls fork() and clone().

That sounds problematic, but perhaps acceptable if the fallback only
happens rarely.

Can this code be folded into CONFIG_VMAP_STACk in some cleaner fashion?
We now have options for non-vmapped stacks, vmapped stacks and a mix
of both.

And what about this comment in arch/Kconfig:VMAP_STACK:

          This is presently incompatible with KASAN because KASAN expects
          the stack to map directly to the KASAN shadow map using a formula
          that is incorrect if the stack is in vmalloc space.


So VMAP_STACK_AS_FALLBACK will intermittently break KASAN?

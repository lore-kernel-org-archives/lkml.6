Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262F82083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="etVVFC2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262F82083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeHaIwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbeHaIwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:52:16 -0400
Received: from devnote (sp183-74-193-25.msb.spmode.ne.jp [183.74.193.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5774320661;
        Fri, 31 Aug 2018 04:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535690799;
        bh=ZfeKrBr9HK+Hl7fDyU2Nt92tdI3Bm9PqCwoNs6O1/+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=etVVFC2Qs+qu/7hE7Uc1yVwKwQUtLnXmy1Gd6jftJYpxIw9rIqRjNZIpA4Ed0TqKa
         rYXWXKGXdAU4Q2ZvKiIoITmJ/3fiQGzlW6vMhB7rrrHEugWrcppHqL5HPnj4VubjVO
         Lei1rizDtdTDWod8NQ962YitH+6fFGaIkk+qdkdA=
Date:   Fri, 31 Aug 2018 13:46:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] x86/alternatives: text_poke() fixes
Message-Id: <20180831134635.35b6c2a919449adf4b63a133@kernel.org>
In-Reply-To: <20180830173218.238900-1-namit@vmware.com>
References: <20180830173218.238900-1-namit@vmware.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 10:32:12 -0700
Nadav Amit <namit@vmware.com> wrote:

> This patch-set addresses some issues that were raised in a recent
> correspondence and might affect the security and the correctness of code
> patching. (Note that patching performance is not addressed by this
> patch-set).
> 
> The main issue that the patches deal with is the fact that the fixmap
> PTEs that are used for patching are available for access from other
> cores and might be exploited. They are not even flushed from the TLB in
> remote cores, so the risk is even higher. Address this issue by
> introducing a temporary mm that is only used during patching.
> Unfortunately, due to init ordering, fixmap is still used during
> boot-time patching. Future patches can eliminate the need for it.
> 
> The second issue is the missing lockdep assertion to ensure text_mutex
> is taken. It is actually not always taken, so fix the instances that
> were found not to take the lock (although they should be safe even
> without taking the lock).
> 
> Finally, try to be more conservative and to map a single page, instead
> of two, when possible. This helps both security and performance.
> 
> In addition, there is some cleanup of the patching code to make it more
> readable.

OK, this series looks good to me, and tested with ftracetest, kprobe testsets.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!


> 
> RFC->v1:
> - Added handling of error in get_locked_pte()
> - Remove lockdep assertion, clarify text_mutex use instead [masami]
> - Comment fix [peterz]
> - Removed remainders of text_poke return value [masami]
> - Use __weak for poking_init instead of macros [masami]
> - Simplify error handling in poking_init [masami]  
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lkml.org/lkml/2018/8/24/586
> 
> Andy Lutomirski (1):
>   x86/mm: temporary mm struct
> 
> Nadav Amit (5):
>   x86/alternatives: clarify text_mutex use in text_poke
>   fork: provide a function for copying init_mm
>   x86/alternatives: initializing temporary mm for patching
>   x86/alternatives: use temporary mm for text poking
>   x86/alternatives: remove text_poke() return value
> 
>  arch/x86/include/asm/mmu_context.h   |  20 ++++
>  arch/x86/include/asm/pgtable.h       |   3 +
>  arch/x86/include/asm/text-patching.h |   4 +-
>  arch/x86/kernel/alternative.c        | 173 +++++++++++++++++++++++----
>  arch/x86/mm/init_64.c                |  29 +++++
>  include/linux/sched/task.h           |   1 +
>  init/main.c                          |   3 +
>  kernel/fork.c                        |  24 +++-
>  8 files changed, 226 insertions(+), 31 deletions(-)
> 
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

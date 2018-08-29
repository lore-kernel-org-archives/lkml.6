Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE2FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773002086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih/1C6/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773002086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeH2Mze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbeH2Mze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:55:34 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6062084D;
        Wed, 29 Aug 2018 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535533180;
        bh=/Ujqb5UvMI55/uQfFPKN1VNykja+euGwwFkie+76qag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ih/1C6/UlOmuR8CY7SF4J7078K2Cy8LyOTVmbWSuQ2z8DlCJbq1BvBN7wm6P3gKqc
         /wskV2sahT7xMtyrZtB/mRSbMdO0bThogf00j0HMv9lVKB+XLjlGJ6661FZ54X/7ci
         glL563Vb1N2dwxxNvujTob9YaNpzAE/uRZzGjzaw=
Date:   Wed, 29 Aug 2018 17:59:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Message-Id: <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
In-Reply-To: <20180829081147.184610-2-namit@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-2-namit@vmware.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 01:11:42 -0700
Nadav Amit <namit@vmware.com> wrote:

> Use lockdep to ensure that text_mutex is taken when text_poke() is
> called.
> 
> Actually it is not always taken, specifically when it is called by kgdb,
> so take the lock in these cases.

Can we really take a mutex in kgdb context?

kgdb_arch_remove_breakpoint
  <- dbg_deactivate_sw_breakpoints
    <- kgdb_reenter_check
       <- kgdb_handle_exception
          <- __kgdb_notify
            <- kgdb_ll_trap
              <- do_int3
            <- kgdb_notify
              <- die notifier

kgdb_arch_set_breakpoint
  <- dbg_activate_sw_breakpoints
    <- kgdb_reenter_check
       <- kgdb_handle_exception
           ...

Both seems called in exception context, so we can not take a mutex lock.
I think kgdb needs a special path.

Thanks,

> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/kernel/alternative.c | 1 +
>  arch/x86/kernel/kgdb.c        | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 014f214da581..916c11b410c4 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -699,6 +699,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>  	 * pages as they are not yet initialized.
>  	 */
>  	BUG_ON(!after_bootmem);
> +	lockdep_assert_held(&text_mutex);
>  
>  	if (!core_kernel_text((unsigned long)addr)) {
>  		pages[0] = vmalloc_to_page(addr);
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 8e36f249646e..60b99c76086c 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -768,8 +768,12 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
>  	 */
>  	if (mutex_is_locked(&text_mutex))
>  		return -EBUSY;
> +
> +	/* Take the mutex to avoid lockdep assertion failures. */
> +	mutex_lock(&text_mutex);
>  	text_poke((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
>  		  BREAK_INSTR_SIZE);
> +	mutex_unlock(&text_mutex);
>  	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
>  	if (err)
>  		return err;
> @@ -793,7 +797,12 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  	 */
>  	if (mutex_is_locked(&text_mutex))
>  		goto knl_write;
> +
> +	/* Take the mutex to avoid lockdep assertion failures. */
> +	mutex_lock(&text_mutex);
>  	text_poke((void *)bpt->bpt_addr, bpt->saved_instr, BREAK_INSTR_SIZE);
> +	mutex_unlock(&text_mutex);
> +
>  	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
>  	if (err || memcmp(opc, bpt->saved_instr, BREAK_INSTR_SIZE))
>  		goto knl_write;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

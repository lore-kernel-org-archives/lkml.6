Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A450206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A450206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeLDPlI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:41:08 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45384 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:41:07 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gUCoj-0000nD-Gx; Tue, 04 Dec 2018 16:40:57 +0100
Date:   Tue, 4 Dec 2018 16:40:57 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
Message-ID: <20181204154056.iyf333bcxqwk3obe@linutronix.de>
References: <20181130224736.GA38485@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181130224736.GA38485@beast>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-30 14:47:36 [-0800], Kees Cook wrote:
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index cfe87b465819..0f7d97917197 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -259,8 +259,7 @@ static int efi_pstore_write(struct pstore_record *record)
>  		efi_name[i] = name[i];
>  
>  	ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
> -			      !pstore_cannot_block_path(record->reason),
> -			      record->size, record->psi->buf);
> +			      preemptible(), record->size, record->psi->buf);

Well. Better I think.
might_sleep() / preempt_count_equals() checks for preemptible() + rcu_preempt_depth().
kmsg_dump() starts with rcu_read_lock() which means with this patch applied I
got:

| BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
| in_atomic(): 0, irqs_disabled(): 0, pid: 2286, name: sig-xstate-bum PC: 0 RCU: 1
| Preemption disabled at:
| [<ffffffff9b959085>] __queue_work+0x95/0x440
| CPU: 30 PID: 2286 Comm: sig-xstate-bum Tainted: G      D           4.20.0-rc3+ #90
| Call Trace:
|  dump_stack+0x4f/0x6a
|  ___might_sleep.cold.91+0xef/0x100
|  __might_sleep+0x50/0x90
|  wait_for_completion+0x32/0x130
|  virt_efi_query_variable_info+0x14e/0x160
|  efi_query_variable_store+0x51/0x1a0
|  efivar_entry_set_safe+0xa3/0x1b0
|  efi_pstore_write+0x110/0x140
|  pstore_dump+0x114/0x320
|  kmsg_dump+0xa4/0xd0
|  oops_exit+0x7f/0x90
|  oops_end+0x67/0xd0
|  die+0x41/0x4a
|  do_general_protection+0xc1/0x150
|  general_protection+0x1e/0x30
| RIP: 0010:__fpu__restore_sig+0x1c1/0x540

just in case you wonder why both counter are zero and it still creates
this backtrace.

>  	if (record->reason == KMSG_DUMP_OOPS)
>  		efivar_run_worker();
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 2387cb74f729..afdfd3687f94 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -400,23 +401,20 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>  	unsigned long	total = 0;
>  	const char	*why;
>  	unsigned int	part = 1;
> -	unsigned long	flags = 0;
> -	int		is_locked;
>  	int		ret;
>  
>  	why = get_reason_str(reason);
>  
> -	if (pstore_cannot_block_path(reason)) {
> -		is_locked = spin_trylock_irqsave(&psinfo->buf_lock, flags);
> -		if (!is_locked) {
> -			pr_err("pstore dump routine blocked in %s path, may corrupt error record\n"
> -				       , in_nmi() ? "NMI" : why);
> +	if (down_trylock(&psinfo->buf_lock)) {
> +		/* Failed to acquire lock: give up if we cannot wait. */
> +		if (pstore_cannot_wait(reason)) {
> +			pr_err("dump skipped in %s path: may corrupt error record\n",
> +				in_nmi() ? "NMI" : why);
>  			return;
>  		}
> -	} else {
> -		spin_lock_irqsave(&psinfo->buf_lock, flags);
> -		is_locked = 1;
> +		down_interruptible(&psinfo->buf_lock);

 In function ‘pstore_dump’:
fs/pstore/platform.c:393:3: warning: ignoring return value of ‘down_interruptible’, declared with attribute warn_unused_result [-Wunused-result]
   down_interruptible(&psinfo->buf_lock);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>  	}

Sebastian

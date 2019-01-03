Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C08CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E738620883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noQNsS3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfACFp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 00:45:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34575 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfACFp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 00:45:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so15542622pga.1;
        Wed, 02 Jan 2019 21:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g+vz4pPvmeQuaxVMah67xFgUjNCUPF9/TsQuGb3t6j0=;
        b=noQNsS3wDH9oXeRvqCnsKwgRj6+ooPS01tKCo06zlL8cvEKmE3mcH4pq2sevtG2CEL
         UFO0y171XRC8FP0N+FmjkX48I2bfwtRJyQpwTHWAsVRkQduYlP8UVFkam8VDt72eThN3
         76U5v6HCY755WJp0U4uzQeOx50zrc6KA5zT3b8uTfKNelitju9eq3NSF5t2s+meMReFw
         GNhxoha05HHGAMgu41hOBELVxY0C/anSlj+w8fBrYVdw5efhEKvbEBOTO97Y4AQp88J/
         6g9PqP9UwkGuxo3c3RNW3g5Cz7u8PHDA3m6qrQRL6cNUKt6TckTNvvf7K49REiWsc3HT
         YBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g+vz4pPvmeQuaxVMah67xFgUjNCUPF9/TsQuGb3t6j0=;
        b=U/1c0WS8Skbhcs4+5+qc+Zh6WK+0tbScYHUpdj1uKIvdX5dSsLiz6zg3iNDICEwKRS
         FsYVnIT2gAT2DSujMqKBThLRRGzENYaq7dWlioyxjmnA5C9oBKd3ku90VizX17xYrBED
         M9Y7q31xMCAuwtnoAk4/M0xIj/9DLpoLxeV++xwWMzqfsmEU1JqtiiEUTbK35tWHyRjl
         pX53+s17e9LVUnD5cErTmKHlSD3/LPYYJV9JUm0W5mZNoJuG7AOeIJUVFMWt+FMe/U1A
         dbHwIl4hC7UhsCbw0urbo1TTczqMytuk6X4H1u31yXkqdprS/iJofJpvqzpnNt/RbHal
         Wh1g==
X-Gm-Message-State: AJcUukdGidIRmFdAW+RQwuBATPNM7n18XF3UiVOwQNqZtFdBvBi3Cal4
        PNoEJW/NcSUzBS05ESFtxEjkh+6q
X-Google-Smtp-Source: ALg8bN5f8nI5PviGz1VxnK5EsmLniW1VrGXqWwjoB5iyycn4/Wr0iugrhCna1AR9MIbrHo3we2FpeQ==
X-Received: by 2002:a65:590b:: with SMTP id f11mr15955116pgu.60.1546494357036;
        Wed, 02 Jan 2019 21:45:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o8sm105518525pfa.42.2019.01.02.21.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 21:45:56 -0800 (PST)
Date:   Wed, 2 Jan 2019 21:45:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vincent Chen <vincentc@andestech.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linux-arch@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Add _TIF_NEED_RESCHED check for kernel thread
 when CONFIG_PREEMPT=y
Message-ID: <20190103054555.GA30904@roeck-us.net>
References: <1546486353-23115-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546486353-23115-1-git-send-email-vincentc@andestech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 11:32:33AM +0800, Vincent Chen wrote:
> The cond_resched() can be used to yield the CPU resource if
> CONFIG_PREEMPT is not defined. Otherwise, cond_resched() is a dummy
> function. In order to avoid kernel thread occupying entire CPU,
> when CONFIG_PREEMPT=y, the kernel thread needs to follow the
> rescheduling mechanism like a user thread.
> 
> Signed-off-by: Vincent Chen <vincentc@andestech.com>

This patch seems to do the trick. I no longer see a problem with
CONFIG_PREEMPT=y and the various lock torture tests enabled, as
previously reported.

Nice catch and fix.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  arch/riscv/kernel/asm-offsets.c |    1 +
>  arch/riscv/kernel/entry.S       |   18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 6a92a2f..dac9834 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -39,6 +39,7 @@ void asm_offsets(void)
>  	OFFSET(TASK_STACK, task_struct, stack);
>  	OFFSET(TASK_TI, task_struct, thread_info);
>  	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
> +	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>  	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 13d4826..728b72d 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -144,6 +144,10 @@ _save_context:
>  	REG_L x2,  PT_SP(sp)
>  	.endm
>  
> +#if !IS_ENABLED(CONFIG_PREEMPT)
> +#define resume_kernel restore_all
> +#endif
> +
>  ENTRY(handle_exception)
>  	SAVE_ALL
>  
> @@ -228,7 +232,7 @@ ret_from_exception:
>  	REG_L s0, PT_SSTATUS(sp)
>  	csrc sstatus, SR_SIE
>  	andi s0, s0, SR_SPP
> -	bnez s0, restore_all
> +	bnez s0, resume_kernel
>  
>  resume_userspace:
>  	/* Interrupts must be disabled here so flags are checked atomically */
> @@ -250,6 +254,18 @@ restore_all:
>  	RESTORE_ALL
>  	sret
>  
> +#if IS_ENABLED(CONFIG_PREEMPT)
> +resume_kernel:
> +	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
> +	bnez s0, restore_all
> +need_resched:
> +	REG_L s0, TASK_TI_FLAGS(tp)
> +	andi s0, s0, _TIF_NEED_RESCHED
> +	beqz s0, restore_all
> +	call preempt_schedule_irq
> +	j need_resched
> +#endif
> +
>  work_pending:
>  	/* Enter slow path for supplementary processing */
>  	la ra, ret_from_exception

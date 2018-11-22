Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183942075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183942075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbeKVMyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:54:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51302 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732695AbeKVMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:54:00 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 80A175B1;
        Thu, 22 Nov 2018 02:16:51 +0000 (UTC)
Date:   Wed, 21 Nov 2018 18:16:50 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] ptrace: take into account saved_sigmask in
 PTRACE_{GET,SET}SIGMASK
Message-Id: <20181121181650.8d2d6abcf83b9defb7195cd3@linux-foundation.org>
In-Reply-To: <20181120060616.6043-1-avagin@gmail.com>
References: <20181120060616.6043-1-avagin@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 22:06:16 -0800 Andrei Vagin <avagin@gmail.com> wrote:

> There are a few system calls (pselect, ppoll, etc) which replace a task
> sigmask while they are running in a kernel-space
> 
> When a task calls one of these syscalls, the kernel saves a current
> sigmask in task->saved_sigmask and sets a syscall sigmask.
> 
> On syscall-exit-stop, ptrace traps a task before restoring the
> saved_sigmask, so PTRACE_GETSIGMASK returns the syscall sigmask and
> PTRACE_SETSIGMASK does nothing, because its sigmask is replaced by
> saved_sigmask, when the task returns to user-space.
> 
> This patch fixes this problem. PTRACE_GET_SIGMASK returns saved_sigmask
> is it's set. PTRACE_SETSIGMASK drops the TIF_RESTORE_SIGMASK flag.

Looks good to me, but what would I know.  I'll await input from Eric
and/or Oleg (please).

> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -417,10 +417,20 @@ static inline void set_restore_sigmask(void)
>  	set_thread_flag(TIF_RESTORE_SIGMASK);
>  	WARN_ON(!test_thread_flag(TIF_SIGPENDING));
>  }
> +
> +static inline void clear_tsk_restore_sigmask(struct task_struct *tsk)
> +{
> +	clear_tsk_thread_flag(tsk, TIF_RESTORE_SIGMASK);
> +}

How irritating is it that this file uses "task" 85 times and "tsk" 19
times?  What did that gain us?  This patch worsens things.

Oh well.

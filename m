Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9086F20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfBEVLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:11:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfBEVLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:11:22 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8BDCCA6C1;
        Tue,  5 Feb 2019 21:11:20 +0000 (UTC)
Date:   Tue, 5 Feb 2019 13:11:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ivan Delalande <colona@arista.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] exec: don't force_sigsegv processes with a pending
 fatal signal
Message-Id: <20190205131119.3e388a0a1a69c0a041ed87ef@linux-foundation.org>
In-Reply-To: <20190205025308.GA24455@visor>
References: <20190205025308.GA24455@visor>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 18:53:08 -0800 Ivan Delalande <colona@arista.com> wrote:

> We were seeing unexplained segfaults in coreutils processes and other
> basic utilities on systems with print-fatal-signals enabled:
> 
> 	[  311.001986] potentially unexpected fatal signal 11.
> 	[  311.001993] CPU: 3 PID: 4565 Comm: tail Tainted: P           O    4.9.100.Ar-8497547.eostrunkkernel49 #1
> 	[  311.001995] task: ffff88021431b400 task.stack: ffffc90004cec000
> 	[  311.001997] RIP: 0023:[<00000000f7722c09>]  [<00000000f7722c09>] 0xf7722c09
> 	[  311.002003] RSP: 002b:00000000ffcc8aa4  EFLAGS: 00000296
> 	[  311.002004] RAX: fffffffffffffff2 RBX: 0000000057efc530 RCX: 0000000057efdb68
> 	[  311.002006] RDX: 0000000057effb60 RSI: 0000000057efdb68 RDI: 00000000f768f000
> 	[  311.002007] RBP: 0000000057efc530 R08: 0000000000000000 R09: 0000000000000000
> 	[  311.002008] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> 	[  311.002009] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 	[  311.002011] FS:  0000000000000000(0000) GS:ffff88021e980000(0000) knlGS:0000000000000000
> 	[  311.002013] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> 	[  311.002014] CR2: 00000000f77bf097 CR3: 0000000150f6f000 CR4: 00000000000406f0
> 
> We tracked these crashes down to binfmt_elf failing to load segments
> for ld.so inside the kernel. Digging further, the actual problem
> seems to occur when a process gets sigkilled while it is still being
> loaded by the kernel. In our case when _do_page_fault goes for a retry
> it will return early as it first checks for fatal_signal_pending(), so
> load_elf_interp also returns with error and as a result
> search_binary_handler will force_sigsegv() which is pretty confusing as
> nothing actually failed here.
> 
> 
> v2: add a message when load_binary fails, add a check for fatal signals
> in signal_delivered (avoiding a single check in force_sigsegv as other
> architectures use it directly and may have different expectations).
> 
> Thanks to Dmitry Safonov and Oleg Nesterov for their comments and
> suggestions.
> 
> ...
>
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1660,7 +1660,12 @@ int search_binary_handler(struct linux_binprm *bprm)
>  		if (retval < 0 && !bprm->mm) {
>  			/* we got to flush_old_exec() and failed after it */
>  			read_unlock(&binfmt_lock);
> -			force_sigsegv(SIGSEGV, current);
> +			if (!fatal_signal_pending(current)) {
> +				if (print_fatal_signals)
> +					pr_info("load_binary() failed: %d\n",
> +						retval);

Should we be using print_fatal_signal() here?

> +				force_sigsegv(SIGSEGV, current);
> +			}
>  			return retval;
>  		}
>  		if (retval != -ENOEXEC || !bprm->file) {
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e1d7ad8e6ab1..674076e63624 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2552,10 +2552,10 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
>  
>  void signal_setup_done(int failed, struct ksignal *ksig, int stepping)
>  {
> -	if (failed)
> -		force_sigsegv(ksig->sig, current);
> -	else
> +	if (!failed)
>  		signal_delivered(ksig, stepping);
> +	else if (!fatal_signal_pending(current))
> +		force_sigsegv(ksig->sig, current);
>  }


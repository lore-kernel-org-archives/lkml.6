Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D34C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD912184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfBKN0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:26:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39038 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfBKN0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:26:39 -0500
Received: from [5.158.153.55] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtBbV-0005o1-0u; Mon, 11 Feb 2019 14:26:33 +0100
Date:   Mon, 11 Feb 2019 14:26:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v8 2/3] proc: add AVX-512 usage elapsed time to
 /proc/pid/status
In-Reply-To: <20190117183822.31333-2-aubrey.li@intel.com>
Message-ID: <alpine.DEB.2.21.1902111420370.3197@nanos.tec.linutronix.de>
References: <20190117183822.31333-1-aubrey.li@intel.com> <20190117183822.31333-2-aubrey.li@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Aubrey Li wrote:

> Subject: proc: add AVX-512 usage elapsed time to /proc/pid/status

Well, no. This should be split into two patches:

 #1 proc/status: Add support for architecture specific output

 #2 x86/proc/status: Add AVX-512 usage time
 
> +/*
> + * Report the amount of time elapsed in millisecond since last AVX512
> + * use in the task.
> + */
> +void avx512_state(struct seq_file *m, struct task_struct *task)
> +{
> +	unsigned long timestamp = task->thread.fpu.avx512_timestamp;
> +	long delta;
> +
> +	if (!timestamp)
> +		delta = -1;
> +	else {

Still lacks curly brackets around the if () clause

> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 0ceb3b6b37e7..dd88c2219f08 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -392,6 +392,10 @@ static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
>  	seq_putc(m, '\n');
>  }

> +void __weak arch_task_state(struct seq_file *m, struct task_struct *task)

Still lacks a function prototype in the appropriate header file and please
rename it to something which makes it clear what this is
about. arch_proc_pid_status() or something like that.

Thanks,

	tglx

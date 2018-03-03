Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCCJ62 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 04:58:28 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36799 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCCJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 04:58:27 -0500
X-Google-Smtp-Source: AG47ELvKOITfMv5wmd9ZCbfwGl1D2BtqlouokADIPsivL5BLiM5sdt7LsZM6UvksgG90718UPHix9Q==
Date: Sat, 3 Mar 2018 10:58:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH -tip] x86: kprobes: Cleanup preempt disabling and enabling
Message-ID: <20180303095823.phaoeuvcjhoirwg3@gmail.com>
References: <152004878307.12012.17534094592580782444.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152004878307.12012.17534094592580782444.stgit@devbox>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +/*
> + * Interrupts are disabled on entry as trap3 is an interrupt gate and they
> + * remain disabled throughout this function.
> + */
> +int kprobe_int3_handler(struct pt_regs *regs)
> +{
> +	struct kprobe_ctlblk *kcb;
> +	int ret;
> +
> +	if (user_mode(regs))
> +		return 0;
> +
> +	/*
> +	 * We don't want to be preempted for the entire
> +	 * duration of kprobe processing.
> +	 */
> +	preempt_disable();
> +
> +	kcb = get_kprobe_ctlblk();
> +	ret = kprobe_int3_dispatcher(regs, kcb);
> +
> +	if (!kprobe_ready_for_singlestep(regs))
> +		preempt_enable_no_resched();
> +
> +	return ret;

What's the point of disabling preemption, if IRQs are disabled already?

There's no preemption when IRQs are off...

Thanks,

	Ingo

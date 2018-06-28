Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A3C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CB2276FB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CB2276FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935863AbeF1QxN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:53:13 -0400
Received: from foss.arm.com ([217.140.101.70]:50482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753501AbeF1QxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:53:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A17DC18A;
        Thu, 28 Jun 2018 09:53:10 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 718FF3F318;
        Thu, 28 Jun 2018 09:53:10 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 96D2A1AE540D; Thu, 28 Jun 2018 17:53:48 +0100 (BST)
Date:   Thu, 28 Jun 2018 17:53:48 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.18 2/2] rseq: check that rseq->rseq_cs padding
 is zero
Message-ID: <20180628165348.GE10751@arm.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <20180628162359.9054-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628162359.9054-2-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Thu, Jun 28, 2018 at 12:23:59PM -0400, Mathieu Desnoyers wrote:
> On 32-bit kernels, the rseq->rseq_cs_padding field is never read by the
> kernel. However, 64-bit kernels dealing with 32-bit compat tasks read the
> full 64-bit in its entirety, and terminates the offending process with
> a segmentation fault if the upper 32 bits are set due to failure of
> copy_from_user().
> 
> Ensure that both 32-bit and 64-bit kernels dealing with 32-bit tasks end
> up terminating offending tasks with a segmentation fault if the upper
> 32-bit padding bits (rseq->rseq_cs_padding) are set by adding an explicit
> check that padding is zero on 32-bit kernels.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Paul Turner <pjt@google.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Andi Kleen <andi@firstfloor.org>
> CC: Dave Watson <davejwatson@fb.com>
> CC: Chris Lameter <cl@linux.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: Ben Maurer <bmaurer@fb.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Josh Triplett <josh@joshtriplett.org>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Michael Kerrisk <mtk.manpages@gmail.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: linux-api@vger.kernel.org
> ---
>  kernel/rseq.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 4ba582046fcd..b038f35a60d6 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -112,6 +112,29 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
>  	return 0;
>  }
>  
> +#ifndef __LP64__
> +/*
> + * Ensure that padding is zero.
> + */
> +static int check_rseq_cs_padding(struct task_struct *t)
> +{
> +	unsigned long pad;
> +	int ret;
> +
> +	ret = __get_user(pad, &t->rseq->rseq_cs_padding);
> +	if (ret)
> +		return ret;
> +	if (pad)
> +		return -EFAULT;
> +	return 0;
> +}
> +#else
> +static int check_rseq_cs_padding(struct task_struct *t)
> +{
> +	return 0;
> +}
> +#endif

I'm still not sure how this works with a 64-bit kernel and a compat (32-bit)
task. The check_rseq_cs_padding() will return 0 regardless of the upper bits
of the rseq_cs field, whereas a native 32-bit kernel would actually go and
check them.

What am I missing here?

Will

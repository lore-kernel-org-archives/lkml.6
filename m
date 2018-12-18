Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48384C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FF7217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeLRJbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:31:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55229 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLRJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:31:09 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZBiV-00052d-FL; Tue, 18 Dec 2018 10:31:07 +0100
Date:   Tue, 18 Dec 2018 10:31:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefan Liebler <stli@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch] futex: Cure exit race
In-Reply-To: <20181212090418.GT5289@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1812172239090.1660@nanos.tec.linutronix.de>
References: <20181210152311.986181245@linutronix.de> <20181210160205.GQ5289@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1812101824070.1667@nanos.tec.linutronix.de> <20181212090418.GT5289@hirez.programming.kicks-ass.net>
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

On Wed, 12 Dec 2018, Peter Zijlstra wrote:
> On Mon, Dec 10, 2018 at 06:43:51PM +0100, Thomas Gleixner wrote:
> @@ -806,6 +806,8 @@ void __noreturn do_exit(long code)
>  		 * task into the wait for ever nirwana as well.
>  		 */
>  		tsk->flags |= PF_EXITPIDONE;
> +		smp_mb();
> +		wake_up_bit(&tsk->flags, 3 /* PF_EXITPIDONE */);

Using ilog2(PF_EXITPIDONE) spares that horrible inline comment and more
importantly selects the right bit. 0x04 is bit 2 ....

> @@ -1187,10 +1236,15 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
>  		 * set, we know that the task has finished the
>  		 * cleanup:
>  		 */
>  		int ret = handle_exit_race(uaddr, uval, p);
>  
>  		raw_spin_unlock_irq(&p->pi_lock);
> -		put_task_struct(p);
> +
> +		if (ret == -EAGAIN)
> +			*pe = p;

Hmm, no. We really want to split the return value for that. EAGAIN is also
returned for other reasons.

Plus requeue_pi() needs the same treatment. I'm staring into it, but all I
came up with so far is horribly ugly.

Thanks,

	tglx

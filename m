Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8gTJFqZRGlv3DwAAmS7hNA
	; Fri, 08 Jun 2018 09:52:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DF432607E4; Fri,  8 Jun 2018 09:52:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7679A60290;
	Fri,  8 Jun 2018 09:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7679A60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeFHJwY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:52:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751614AbeFHJwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:52:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABCE5401EF11;
        Fri,  8 Jun 2018 09:52:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 253901116702;
        Fri,  8 Jun 2018 09:52:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  8 Jun 2018 11:52:22 +0200 (CEST)
Date: Fri, 8 Jun 2018 11:52:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, gkohli@codeaurora.org, tglx@linutronix.de,
        mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 4/4] kthread: Simplify kthread_park() completion
Message-ID: <20180608095220.GA18941@redhat.com>
References: <20180607123310.866085998@infradead.org>
 <20180607124006.266038375@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607124006.266038375@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 08 Jun 2018 09:52:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 08 Jun 2018 09:52:22 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

I am travelling till the end of the next week, unlikely I will be able
to reply to emails or even read them.

But I want very much to comment this change,

On 06/07, Peter Zijlstra wrote:
>
> Now that smpboot_update_cpumask_percpu_thread() is gone, we no longer
> have anybody calling kthread_park() on already parked threads. So
> revert commit:
>
>   b1f5b378e126 ("kthread: Allow kthread_park() on a parked kthread")

Great, I obviously like this patch but the changelog should be fixed ;)

smpboot_update_cpumask_percpu_thread() was actually fine. And we can
(should) revert this commit in any case. Unless I am totally confused.

So how this code

	for_each_cpu_and(cpu, &tmp, cpu_online_mask)
		smpboot_park_thread(plug_thread, cpu);

in smpboot_update_cpumask_percpu_thread() can hit a KTHREAD_SHOULD_PARK
thread? Lets look into kernel test robot's .config:

	CONFIG_NR_CPUS=1

Now look at NR_CPUS==1 version of for_each_cpu* helpers:

	#define for_each_cpu(cpu, mask)			\
		for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
	#define for_each_cpu_not(cpu, mask)		\
		for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
	#define for_each_cpu_wrap(cpu, mask, start)	\
		for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
	#define for_each_cpu_and(cpu, mask, and)	\
		for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)

See? They all ignore the "mask" argument, and this is obviously wrong.

So even if the "tmp" cpumask is empty the code above always does

		smpboot_park_thread(plug_thread, 0);

and hits the already parked kthread.

Oleg.

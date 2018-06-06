Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I+2lOt7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 029CA601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeFFL7m (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:59:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58234 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeFFL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:59:40 -0400
Date: Wed, 6 Jun 2018 13:59:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 0.5/5] alpha: remove custom dec_and_lock() implementation
Message-ID: <20180606115918.GG12198@hirez.programming.kicks-ass.net>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
 <20180504154533.8833-2-bigeasy@linutronix.de>
 <20180604102559.2ynbassthjzva62l@linutronix.de>
 <20180604102757.h46feymcfdydl4nz@linutronix.de>
 <20180604114852.GQ12217@hirez.programming.kicks-ass.net>
 <20180606111849.4vr2ap2w4mlyqm23@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606111849.4vr2ap2w4mlyqm23@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 01:18:50PM +0200, Sebastian Andrzej Siewior wrote:

> - atomic_add_unless() adds more memory barriers compared to the custom
>   assembly

> I can't tell if the different memory barriers
> are an issue but having the same barriers is probably good.

refcount decrement needs to be a RELEASE operation, such that all the
load/stores to the object happen before we decrement the refcount.

Otherwise things like:

	obj-foo = 5;
	refcnt_dec(&obj->ref);

can be re-ordered, which then allows fun scenarios like:

	CPU0				CPU1

	refcnt_dec(&obj->ref);
					if (dec_and_test(&obj->ref))
						free(obj);
	obj->foo = 5; // oops UaF


This means (for alpha) that there should be a memory barrier _before_
the decrement, however the dec_and_lock asm thing only has one _after_,
which, per the above, is too late.

The generic version using add_unless will result in memory barrier
before and after (because that is the rule for atomic ops with a return
value) which is strictly too many barriers for the refcount story, but
who knows what other ordering requirements code has.

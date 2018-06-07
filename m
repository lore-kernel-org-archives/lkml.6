Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2vRKCHFEGVu/EwAAmS7hNA
	; Thu, 07 Jun 2018 14:43:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F1809607DC; Thu,  7 Jun 2018 14:43:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xvxsb9FF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7BEA6607E7;
	Thu,  7 Jun 2018 14:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BEA6607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934821AbeFGOnA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:43:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934797AbeFGOmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C01r5sDjeT1H1DayAoPkQfIMP1RpEnTLumlESsnD0Ew=; b=Xvxsb9FFPmWgSQuHaGvuDlWGS
        1QGR5hSSoFStx5VbaKFlehNHN6eYYthtcD3l56K1CzQAcwze5FVvi1blccW6ucMnof0T3ybukUpEi
        /gIVG5CE4WAtPux3bw7JpBvxdPrPPEr0+lH78NnsvjDjj9Uh0MYXS4oYWYJjRkRo/0jRp0UzWzq6e
        W9Hc9WqqQkl0CZQwT4u3oWkA/LIihzKarpprG+FshG/12Kzooz+0uRoD4ROIfdUhECxaanu1Yok1K
        dUTT5/JUAUIii2YB43AYhgVIMMrVp559OxNaf1Hp9Y08qSLZ23SP9eAWbn75acmO91hpYvHTn5MUU
        JzvsQ2vBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQw7j-0005Jv-BF; Thu, 07 Jun 2018 14:42:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69133201EA7AA; Thu,  7 Jun 2018 16:42:45 +0200 (CEST)
Date: Thu, 7 Jun 2018 16:42:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc: tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 2/4] watchdog/softlockup: Replace "watchdog/%u" threads
 with cpu_stop_work
Message-ID: <20180607144245.GG12235@hirez.programming.kicks-ass.net>
References: <20180607123310.866085998@infradead.org>
 <20180607124006.158330973@infradead.org>
 <20180607142405.GO12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607142405.GO12198@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 04:24:05PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 07, 2018 at 02:33:12PM +0200, Peter Zijlstra wrote:
> 
> > +static int softlockup_stop_fn(void *data)
> >  {
> > +	watchdog_disable(smp_processor_id());
> > +	return 0;
> >  }
> >  
> > +static void softlockup_stop_all(void)
> >  {
> > +	int cpu;
> > +
> > +	for_each_cpu(cpu, &watchdog_allowed_mask)
> > +		stop_one_cpu(cpu, softlockup_stop_fn, NULL);
> > +
> > +	cpumask_clear(&watchdog_allowed_mask);
> >  }
> 
> Bugger, that one doesn't quite work.. watchdog_disable() ends up calling
> a sleeping function. I forgot to enable all the debug cruft when
> testing..
> 
> Let me try and fix that..

The below seems to fix that, and now I can complete all the tests
without triggering debug nonsense ;-)


--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -512,7 +512,7 @@ static void softlockup_stop_all(void)
 	int cpu;
 
 	for_each_cpu(cpu, &watchdog_allowed_mask)
-		stop_one_cpu(cpu, softlockup_stop_fn, NULL);
+		smp_call_on_cpu(cpu, softlockup_stop_fn, NULL, false);
 
 	cpumask_clear(&watchdog_allowed_mask);
 }
@@ -529,7 +529,7 @@ static void softlockup_start_all(void)
 
 	cpumask_copy(&watchdog_allowed_mask, &watchdog_cpumask);
 	for_each_cpu(cpu, &watchdog_allowed_mask)
-		stop_one_cpu(cpu, softlockup_start_fn, NULL);
+		smp_call_on_cpu(cpu, softlockup_start_fn, NULL, false);
 }
 
 int lockup_detector_online_cpu(unsigned int cpu)

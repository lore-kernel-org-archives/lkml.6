Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KLZhJRNAGVuUXgAAmS7hNA
	; Thu, 07 Jun 2018 14:24:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7E327608BA; Thu,  7 Jun 2018 14:24:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7BBmhvM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 17DFE6063F;
	Thu,  7 Jun 2018 14:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17DFE6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933478AbeFGOYR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:24:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933352AbeFGOYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8jJMkkaj4IilLjOAr13jUR+hK7a4kIjSO5khSpvEFXA=; b=A7BBmhvMJHP8Y33LvZ36GhM1C
        31Cj3NMW02BE3TeFN76OR12Kd38L4TwszQCiP1oVh5iojmHpRbxDSthMrhAtYyL6QDYs/b3m7ovZ3
        WUG3iwua2lI2ZCKFINKhuhz/Nq7/cDNt95W01h459CGL9HWxBPDq71aWI1gsjBGRIaAnIISUfxDHm
        anj/uTqdTSF10nv/4Q2J2Hdqb7T67fzpJjPiED06LmWBEmc8bpMpKdNUjPj9D/xnnePYUvfzZlIdf
        g8d5D8yDhg/72b1MMQk54Bmx24oQpXJJmw5qtptn+f77M1NtzBKgGD0YOBqAhWpI/PFKbuBcnOCIj
        ObekQGuqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQvpf-0001pP-H0; Thu, 07 Jun 2018 14:24:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97438201EA7A8; Thu,  7 Jun 2018 16:24:05 +0200 (CEST)
Date: Thu, 7 Jun 2018 16:24:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc: tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 2/4] watchdog/softlockup: Replace "watchdog/%u" threads
 with cpu_stop_work
Message-ID: <20180607142405.GO12198@hirez.programming.kicks-ass.net>
References: <20180607123310.866085998@infradead.org>
 <20180607124006.158330973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607124006.158330973@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 02:33:12PM +0200, Peter Zijlstra wrote:

> +static int softlockup_stop_fn(void *data)
>  {
> +	watchdog_disable(smp_processor_id());
> +	return 0;
>  }
>  
> +static void softlockup_stop_all(void)
>  {
> +	int cpu;
> +
> +	for_each_cpu(cpu, &watchdog_allowed_mask)
> +		stop_one_cpu(cpu, softlockup_stop_fn, NULL);
> +
> +	cpumask_clear(&watchdog_allowed_mask);
>  }

Bugger, that one doesn't quite work.. watchdog_disable() ends up calling
a sleeping function. I forgot to enable all the debug cruft when
testing..

Let me try and fix that..

Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A47C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CD9213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AsD9+0bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CD9213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJDQ1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:27:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T1oW0KxqnIqdB92Wr2XBybWti6kBTlxvYiCz/u1YQqI=; b=AsD9+0bxC9raSTcnSBMY4P55y
        FY/2Z+/ksD6sWQvsnESwTisap6l+9Cq616YCrZWALrTwTlKKTBZ8I2482iC1ZNzggNa0hxSvk8H46
        oSQNJFFhjfip/h40S9qEzu45MEy9s3R+PHEad6feYC7anW95kxIJeYk8ImaeWoJUUQczlutiVp8Gl
        qg1aAo5ZWz2+/2tQTLeNk6mNEhv09IzYXAzHzByk90J6NCbZkrVjMJA3QlV+AAdsuDDPYl/wDgfAz
        yOP2KHRMuWdRfXJG7PxTAk1jegSTLXWcL+h0XcQlsysG6RxqYKBtgd5CHgQ1lZcPfc1UqNiyHw6wb
        /mAEtO5uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g802I-0000I8-9N; Thu, 04 Oct 2018 09:35:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D59E202695A2; Thu,  4 Oct 2018 11:35:06 +0200 (CEST)
Date:   Thu, 4 Oct 2018 11:35:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Message-ID: <20181004093506.GK19272@hirez.programming.kicks-ass.net>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
 <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
 <20181004075703.GG19272@hirez.programming.kicks-ass.net>
 <e4cf9124-2dbb-45cb-6b45-f0b92a6ac88e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4cf9124-2dbb-45cb-6b45-f0b92a6ac88e@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:12:44AM +0200, Daniel Lezcano wrote:
> 
> Hi Peter,
> 
> On 04/10/2018 09:57, Peter Zijlstra wrote:
> > On Thu, Oct 04, 2018 at 09:42:07AM +0200, Daniel Lezcano wrote:
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index b88a145..5605f03 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -2873,25 +2873,12 @@ unsigned long long nr_context_switches(void)
> >>  
> >>  	return sum;
> >>  }
> >> -/*
> >> - * Consumers of these two interfaces, like for example the cpufreq menu
> >> - * governor are using nonsensical data. Boosting frequency for a CPU that has
> >> - * IO-wait which might not even end up running the task when it does become
> >> - * runnable.
> >> - */
> >>  
> >>  unsigned long nr_iowait_cpu(int cpu)
> >  
> > +static
> 
> The function is exported in include/linux/sched/stat.h and used by
> drivers/cpuidle/governors/menu.c
> 
> Do you want to declare it static inline in the stat.h file ?

No, but if there's a user left, that comment needs to stay. The number
it returns is utter crap.

Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E606520671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsvOhsfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E606520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbeGWUT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:19:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45912 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388052AbeGWUT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dQBrz3nycixF7y4TKSgDJgKpWJFpq/ERRVkJusaDII4=; b=fsvOhsfukt0Fq8ukHBQDQeFeD
        lcqLwqCaZctq8FLvdAV//8CDzX0FSVszjV1V3yaDvfYu2/tQ54hzw1ClbdbFFjx020OUMjmw9Z6Vm
        5xjALVaYg2MIysqGjbQzjxbwk5VPD7WUqfMB/xeoZFSq2w1sVoBM7vnZpmnD+JVCpE7LwXZIilCV2
        IDHr8A0943hLX5qHon5j5VNfyxFMsdcoTOaTUFP+0j9OmXW/4ILt7xSw4p0+xH0UNVHnFFsnovhaG
        mRthPYFkLWAfw1gspdEU4x3Y1CDR3g4j4eGpkHrkk03u+40ipOkBgOyI6R9i2K/brKs/lVvtzVTFC
        XIodf0e/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhgJq-00015i-5y; Mon, 23 Jul 2018 19:16:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A126320268325; Mon, 23 Jul 2018 21:16:27 +0200 (CEST)
Date:   Mon, 23 Jul 2018 21:16:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] cpufreq: Fix a circular lock dependency problem
Message-ID: <20180723191627.GJ2494@hirez.programming.kicks-ass.net>
References: <1532368179-15263-1-git-send-email-longman@redhat.com>
 <1532368179-15263-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532368179-15263-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 01:49:39PM -0400, Waiman Long wrote:
>  drivers/cpufreq/cpufreq.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b0dfd32..9cf02d7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -922,8 +922,22 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  	struct cpufreq_policy *policy = to_policy(kobj);
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret = -EINVAL;
> +	int retries = 3;
>  
> -	cpus_read_lock();
> +	/*
> +	 * cpus_read_trylock() is used here to work around a circular lock
> +	 * dependency problem with respect to the cpufreq_register_driver().
> +	 * With a simple retry loop, the chance of not able to get the
> +	 * read lock is extremely small.
> +	 */
> +	while (!cpus_read_trylock()) {
> +		if (retries-- <= 0)
> +			return -EBUSY;
> +		/*
> +		 * Sleep for about 50ms and retry again.
> +		 */
> +		msleep(50);
> +	}

That's atrocious.



Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85DC2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="onJL/c0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85DC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJLP76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:59:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeJLP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZVkCFujIr5udvdQVB2emw/fqd6coQE//m6uQ2EQ7MXE=; b=onJL/c0i3VF3iJX4fG86hh8AM
        APr+2MnGbh74/VoRSEFaTs1fX1WQBmXvVYgKSXbG5KqgP9/DTWG7HQRS078pqJXcRssZ5paf2qYB7
        FwLYjcPqYb6VkWsCESemPjApkHGOE5gLKWgnNl4iC+AiDpbKeTYragMJTwiwpCLulCIC8ZNi5g5At
        09JmdG0/J3zCP6UcFTNSCWxppxzDiNOx6KHsEKLF19YLbPqISQdBCNLDAIo7oIHBVKDyT/R/ns5yV
        xc+MO00NMW3IQHH1FPwTWFxBxNOY85ohnXmpcoL13nSt3w3qDzjqLLhcO+Jh76okIlAx2Bzl4v8HA
        RgF9daQGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAso8-00039c-MQ; Fri, 12 Oct 2018 08:28:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86CE52027E186; Fri, 12 Oct 2018 10:28:26 +0200 (CEST)
Date:   Fri, 12 Oct 2018 10:28:26 +0200
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
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Message-ID: <20181012082826.GP9848@hirez.programming.kicks-ass.net>
References: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
 <1538654644-32705-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538654644-32705-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:04:03PM +0200, Daniel Lezcano wrote:
> The function get_loadavg() returns almost always zero. To be more
> precise, statistically speaking for a total of 1023379 times passing
> in the function, the load is equal to zero 1020728 times, greater than
> 100, 610 times, the remaining is between 0 and 5.
> 
> In 2011, the get_loadavg() was removed from the Android tree because
> of the above [1]. At this time, the load was:
> 
> unsigned long this_cpu_load(void)
> {
>         struct rq *this = this_rq();
>         return this->cpu_load[0];
> }
> 
> In 2014, the code was changed by commit 372ba8cb46b2 (cpuidle: menu: Lookup CPU
> runqueues less) and the load is:
> 
> void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> {
>         struct rq *rq = this_rq();
>         *nr_waiters = atomic_read(&rq->nr_iowait);
>         *load = rq->load.weight;
> }
> 
> with the same result.
> 
> Both measurements show using the load in this code path does no matter
> anymore. Removing it.
> 
> [1] https://android.googlesource.com/kernel/common/+/4dedd9f124703207895777ac6e91dacde0f7cc17
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Ramesh Thomas <ramesh.thomas@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

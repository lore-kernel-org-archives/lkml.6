Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A99C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC8E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LKzV+LRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC8E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395447AbeKWAo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:44:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbeKWAo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6WHemYpUuR4ajbpzEbJpDUTGQjiK5drKbbwRv91VITw=; b=LKzV+LRRU1sduEKWdA6c6sDns
        VhXeWe85hBq/c2tA3XDZwNtJXI+u1GSevJ6LT8vc+pRtrBtjZudiqpzzYRbPOAbbghM0dZSzefCrW
        HRXhJKcq9oepkfciOkUxCF4mTWnCVO0s335f1FluIVwHi3OtZs16PGEasXLzUB73zdULOB+1EVsRF
        8IG9mngugCKT3JDnlxzK+J7HqSLsNwYslP/wwsm5h5ex/261kB+cwBaXJee2UViTORq9+XKP49y2u
        W8pjlc3T66E+q1gl+OO7m6VcX2ivgBeb9bAwyE32EJZmXDbTVwwq6AlhULr9Aewtym0CJxqrzIuGz
        2ju2xh6Bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpax-0001vz-Jp; Thu, 22 Nov 2018 14:04:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBDA02029FD58; Thu, 22 Nov 2018 15:04:32 +0100 (CET)
Date:   Thu, 22 Nov 2018 15:04:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v9 08/15] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Message-ID: <20181122140432.GH2113@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-9-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119141857.8625-9-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:18:50PM +0000, Quentin Perret wrote:
> +			if (rd->pd)
> +				pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
> +						cpumask_pr_args(cpu_map));
> +			goto free;

I would have preferred just not allowing the governor to change at all,
but if you want to allow that, this is, I suppose, the best you can do.

Rafael, are you otherwise OK with the grubbing inside cpufreq?

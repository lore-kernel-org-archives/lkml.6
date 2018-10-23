Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC4BC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029DA207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sq/wyM4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029DA207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeJWSX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:23:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbeJWSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aowGkJCJmkF+rGz8nllz8ppIt/CMUE5RB6sGSpqj2oQ=; b=Sq/wyM4oE4GpWsyT8gkjAAt8t
        50jwiFwMOEPcl+Gmv6xa94nwRCU7VPKFE0ol39ufH1g0r5zel4bkqePdmUjDDwwgkbzBCbGj6TsvT
        wWDIuA7Sq0A26WKYk3LnXzHK22nELGHAyZJYpxyluCwCAUvLEn2xkknPl6sXrFSI5JCCgIBUYpyh9
        YQABjhdsrDRdRfhHBsv2dz6vlblHvwT9Oi6pMYmOyyJR4R2BbgR3WBhpi7axpm4gs9KfWbAFIsar2
        qa3lWApkduV1KCBeDopURNOtX/uuMVYqLuZu9NUQRCOYqZZ6yZHG40H0dg8dKWxzJ3rx0sYbVmtOn
        xc7lcsodw==;
Received: from [185.7.230.214] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEtUm-00017Q-HU; Tue, 23 Oct 2018 10:01:07 +0000
Received: by worktop (Postfix, from userid 1000)
        id 953046E08B3; Tue, 23 Oct 2018 12:00:57 +0200 (CEST)
Date:   Tue, 23 Oct 2018 12:00:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        patrick.bellasi@arm.com, pjt@google.com, bsegall@google.com,
        thara.gopinath@linaro.org
Subject: Re: [PATCH v4 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181023100057.GJ3109@worktop.c.hoisthospitality.com>
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
 <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 06:17:51PM +0200, Vincent Guittot wrote:
> In order to achieve this time scaling, a new clock_pelt is created per rq.


> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3990818..d987f50 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -848,6 +848,8 @@ struct rq {
>  	unsigned int		clock_update_flags;
>  	u64			clock;
>  	u64			clock_task;
> +	u64			clock_pelt;
> +	unsigned long		lost_idle_time;

Very clever that. Seems to work out nicely. We should maybe look at
ensuring all these clock fields are indeed on the same cacheline.

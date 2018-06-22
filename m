Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BFEC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3DB244C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3JhZ1po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3DB244C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933776AbeFVPYp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:24:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933291AbeFVPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VCNYDljz0anDY2Aaglf5ZM9d8HYNhQCg+WqBzzmjsHM=; b=N3JhZ1potcUW3ujaLibg/ssv8
        0H9nfFGGAi4d3s8XfDbMjI69K+/GEqzQ7fGqrkCtuf7exmce6pyLEZh32YGau5gW51eMrsc9HRflF
        kr0a5fv7lXfnQpU8Qbthbvw4OMu9nLNiIqgMmf4B2oE4OJ3BXH9AcREFVspLnLmvyYImGbzXq7joM
        QJZ7cfYOPM2AaJTYuikooA0p8CN7Y37DgW4P739VHOunKF6o0TNkc7CAslYEchY/5XmGveEB/Qc4Z
        h5JdnpClyLZBuE8ghMUb+YIwvxCH8X3WWP8wyJojAzmUp+dY2UMisuhRZAWcOKRHGPrf+QDXTGuI9
        z6P3OwIvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWNvK-0007iv-5H; Fri, 22 Jun 2018 15:24:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 859D62029F1D7; Fri, 22 Jun 2018 17:24:28 +0200 (CEST)
Date:   Fri, 22 Jun 2018 17:24:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 06/11] cpufreq/schedutil: use dl utilization tracking
Message-ID: <20180622152428.GS2476@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:09:49PM +0200, Vincent Guittot wrote:
> -	 * Ideally we would like to set util_dl as min/guaranteed freq and
> -	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> -	 * ready for such an interface. So, we only do the latter for now.

Please don't delete that comment. It is not less relevant.

> -static inline unsigned long cpu_util_dl(struct rq *rq)
> +static inline unsigned long cpu_bw_dl(struct rq *rq)

I think you forgot to fix-up ignore_dl_rate_limit().

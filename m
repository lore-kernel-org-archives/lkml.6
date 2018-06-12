Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A33AFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD872086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3KjcIYwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD872086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933884AbeFLOXN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:23:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51286 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932712AbeFLOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g/TBf/Okjt9R9ppfKEb6Jjn+jBO4bf+hpsn0DVHEwL8=; b=3KjcIYwt9LClYdlNgnJ+0P7ab
        I24NAS0MimxGodzEXoHJzYkALyspdlBtoCHMtiMDf+5rHQHXAjCQHZaGZ9pebWE7EkrMmCMy0Q5+5
        Fu12+mK7pDWokdhhBigJ+KRN6wASdZ/0X323kttQKJhcZcaoJqPlqg0ZjYNDvEfkLRzC1E4aaOCGw
        uM/498S0MOdQohxDOVzWk63u7kXnpkmIfz+9E6XOoqnwdyxYb2Qqf2KS7WuVPUb4YrJ3CJiliXH7r
        LuRdvAuMV2T+e0UQ0OWwNPUBMz/JzcpurXTAlshA8qzVDLegqIQhKz9AoyLnNs8Fvf1eVgHQTE1GN
        +bDNrWd+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSkCM-0003wF-G9; Tue, 12 Jun 2018 14:23:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2717F201EA7CC; Tue, 12 Jun 2018 16:23:01 +0200 (CEST)
Date:   Tue, 12 Jun 2018 16:23:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180612142301.GR12217@hirez.programming.kicks-ass.net>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
> +static void idle_injection_last_man(struct idle_injection_device *ii_dev)
> +{
> +	unsigned int run_duration_ms;
> +
> +	run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> +	if (run_duration_ms) {
> +		hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
> +			      HRTIMER_MODE_REL_PINNED);

What's the point of PINNED here? AFAICT this gets called from a
different CPU every time.

> +		return;
> +	}
> +
> +	complete(&ii_dev->stop_complete);
> +}

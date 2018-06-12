Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 63BF1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDB6208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tw/g7nBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDB6208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeFLO04 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:26:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51310 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932969AbeFLO0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eccfEkrKF47LiUIf0o/tALJh7+SMcQssXdT5dzy2UWU=; b=Tw/g7nBzqK7n0+lBMeMiDzy0O
        D0OfWfMyeIDvs255F+mmt9SU4/YC13RHjhBS0CTAm747AZI3kn5MoJvJMbp1pdHrZ8mDtKxew4YCf
        A00wAkOL8Ww/ifePbevBWN018cGhxgUA4EubOX7kLWpepRTye4gTdxvmTQvwyg9F8XHs16k+6M/QN
        Hv+Z3z6F3IUyr2NQ9rD2+t6nNpjOXJsSTsmkVbbV63Oky2YCQCkZqFhIzd1/R0aRhhbgLUTIf6qaL
        vIVA//8IjUQePqaw9TtaKSdgcOHdJ/vUjxNOJP/xHEQhQkpJ/ZrLHgA59ANJMs0wrcduZRvdITTku
        X+HAHQVlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSkG0-0003xJ-EZ; Tue, 12 Jun 2018 14:26:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 393FD201EA7CC; Tue, 12 Jun 2018 16:26:47 +0200 (CEST)
Date:   Tue, 12 Jun 2018 16:26:47 +0200
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
Message-ID: <20180612142647.GS12217@hirez.programming.kicks-ass.net>
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
> +void idle_injection_stop(struct idle_injection_device *ii_dev)
> +{
> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
> +		 cpumask_pr_args(ii_dev->cpumask));
> +
> +	idle_injection_set_duration(ii_dev, 0, 0);
> +
> +	wait_for_completion_interruptible(&ii_dev->stop_complete);
> +}

interruptible?

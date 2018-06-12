Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 005ABC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D87208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CfOCltaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D87208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933662AbeFLMap (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:30:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932811AbeFLMan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FgXlQTW1ZGbjnHhyBREFViq6EXTPSp5PgHfhh+11Os0=; b=CfOCltaRdSMmc5+5H2JZ0J3AB
        a/8MMjRlHkoiFloKoTWX3Bq2DY9fGXEN3ApXK/JV4DEFBpeMYZFYv+X1o1Cvu0w0QAqCy1cwa7qbZ
        hf9HIG7ILMQ4HXJXSynPuSWTIsSYA8h15/wagQOA1fp/CsyTsm8b7hzqq0EF9Xe2sK7jp00faDbun
        AFCym1RWzx8uv2iGHrwu+QjaHwyZQPbcOfwXMktlBcjMk2dwWHutugFsmp8tVqbECMrTzybaz21Tr
        +y2zCLOlYRbWI9DublSgbsVNDBmLMnFCNHdt6BsinDxol9Kxf8E6AEM1M+Q9ib58f2yMUd3yfEOar
        QwqkKsk3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSiRa-0000SF-IF; Tue, 12 Jun 2018 12:30:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E198201EA7C9; Tue, 12 Jun 2018 14:30:36 +0200 (CEST)
Date:   Tue, 12 Jun 2018 14:30:36 +0200
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
Message-ID: <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
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
> +static void __idle_injection_wakeup(struct idle_injection_device *ii_dev)
> +{
> +	struct idle_injection_thread *iit;
> +	struct cpumask tmp;
> +	unsigned int cpu;
> +
> +	cpumask_and(&tmp, ii_dev->cpumask, cpu_online_mask);

You should not be having a cpumask on the stack. Those things can be
ginormous.

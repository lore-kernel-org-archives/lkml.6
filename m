Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB38F20896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghCL63CG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB38F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934525AbeGFF70 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:59:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38432 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933852AbeGFF7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:59:21 -0400
Received: by mail-pl0-f68.google.com with SMTP id b1-v6so2358244pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 22:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=92pSQwWyYB+8ZcktHLy+izS7RDbkJGCS/fA1UrblsMM=;
        b=ghCL63CGq2Tuy6YriEI6M+NTTqWGvkYzV1cJPsStUgTu1gxrqqZCU8edHXafxfYEPV
         7uZ+uNajDGhFVsHAdkU3NWhLdyypzIQQtQUUy19gntVKn/wnuW/24EVmdOTzR9bPWymo
         zu74CAAe1FvdEEsWkWFb6xjl63wIMlUJBoTXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=92pSQwWyYB+8ZcktHLy+izS7RDbkJGCS/fA1UrblsMM=;
        b=PNHIDH9UHet59NZoTDYWAynsCYNgcRISpKXndIF6TtKM0zR4TDz/e6DqapV+cA+8RT
         smKpH2IJGI0Xj2iU4Fmod9YlJvVng0adgriCyTnNpOBF07oCa2O9lCnMz8D1ORWXWR9X
         ituNF24N3sb2hLU/HOjAup7rQ6Gp7uX5UpeJs1utfY4nsobAHsJddEHUeDXg53J/o8Er
         2A00T/8b1i3wZKy7SC/se5UdN5xX+NVY+Sw3sbKpEAFPG5o9mlJwpq/1sx1vRTi7qCv5
         EjCudnylrE0aUAH/cBjV1hF701WctSndIHx2XNRMhPY6GqBfzEDmUNjTJ3Bf1a/pc9sH
         TZTQ==
X-Gm-Message-State: APt69E28wAYVtRxbv/IXwUyO7FVGAJ9iCsVQn0853w3P6u7Uk37Xt7mJ
        FTOlTgvQvQGEsQG9wq6IsykMhw==
X-Google-Smtp-Source: AAOMgpfk4DE+7mQL8D0pYbAGSE/eqbXtSEzI80LK72dy1IkF8Ywd+WdxDo8JF7o0TpHsbq8dgdZP2g==
X-Received: by 2002:a17:902:6802:: with SMTP id h2-v6mr8890780plk.113.1530856761363;
        Thu, 05 Jul 2018 22:59:21 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id k10-v6sm20150852pfj.29.2018.07.05.22.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 22:59:20 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:29:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 05/11] cpufreq/schedutil: use dl utilization tracking
Message-ID: <20180706055918.ti4qewbo6atrt6oa@vireshk-i7>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-6-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530200714-4504-6-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-18, 17:45, Vincent Guittot wrote:
> Now that we have both the dl class bandwidth requirement and the dl class
> utilization, we can detect when CPU is fully used so we should run at max.
> Otherwise, we keep using the dl bandwidth requirement to define the
> utilization of the CPU
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 23 +++++++++++++++++------
>  kernel/sched/sched.h             |  7 ++++++-
>  2 files changed, 23 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

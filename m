Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3F3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EFE23F9F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2o69oLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EFE23F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934683AbeGFF4w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:56:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38840 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933799AbeGFF4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:56:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id j17-v6so7467226pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 22:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1iSN5kXvMvAc8ogMQWTpfnFLDg9X7bjCC4agR35JQPY=;
        b=J2o69oLPqiqA/KUWAlnnXeEv/DbkJGg3SDwLxtClq6ibM1s2+6jMp1ZqR5rnbQNxLx
         RIFVQd4OjZrGFUGF++7/kBO3O6fqAsbC0sWVk8lTnGMELp+k3gYe4UweUijRhanXGDs7
         3yl3ak5uywIFZ2JtsDIaTubq1sIkVVDx2rlQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1iSN5kXvMvAc8ogMQWTpfnFLDg9X7bjCC4agR35JQPY=;
        b=i8133VY3kCXdQReQeDaeCZTB1s3dDJ7XMtvOIe5cguNcJYax8dih7OKveCxJ03pLLl
         1QZjTU9k6zgkBn0BLsMvV94D/dnj7bncinVM6roCsOZdAwrxDafYvG+Unni7saVjXBKo
         6k1n1n7MvPQlc0x6j5sR2NptbtyI3ljYiFiwbV6ItZrNTbTB+JQhgTHCCGuDYybQOSrO
         q+8g/cEUXRHfYTi8qx1BleS/FqtO/OzHtTb3sRDM0x9HLoiidm7bx3oxH6gr4yNOn7fD
         KUHr5zWkX6jUiZ0iD/DutugPLld7ozkT3D6yeJRIBM5RmV4ricWfhV2E1F2Ou8auA8ES
         u0gQ==
X-Gm-Message-State: APt69E0FjUKMb8dTH46cDeFto2n5eA0hFUJO2aiQ0itSWTDqD6sQxg52
        6418+7a8Vba29LwmzYGyShHXmA==
X-Google-Smtp-Source: AAOMgpes36AIGiPS3tgyasPLDe4qetk535BqPI9kX5U4pCJkMHJmNcc7sETH/YlbByv6jh7l3bBBkg==
X-Received: by 2002:a62:b20c:: with SMTP id x12-v6mr9462189pfe.64.1530856609855;
        Thu, 05 Jul 2018 22:56:49 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id i89-v6sm22153049pfi.170.2018.07.05.22.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 22:56:48 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:26:46 +0530
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
Subject: Re: [PATCH 03/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180706055646.47iu4gktby4trjmq@vireshk-i7>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530200714-4504-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-18, 17:45, Vincent Guittot wrote:
> Add both cfs and rt utilization when selecting an OPP for cfs tasks as rt
> can preempt and steal cfs's running time.
> 
> rt util_avg is used to take into account the utilization of rt tasks
> on the CPU when selecting OPP. If a rt task migrate, the rt utilization
> will not migrate but will decay over time. On an overloaded CPU, cfs
> utilization reflects the remaining utilization avialable on CPU. When rt
> task migrates, the cfs utilization will increase when tasks will start to
> use the newly available capacity. At the same pace, rt utilization will
> decay and both variations will compensate each other  to keep unchanged
> overall utilization and will prevent any OPP drop.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

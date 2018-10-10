Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE437C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956D82087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ8mxG4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956D82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJJNid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:38:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40375 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJJNid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:38:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so4348418wmc.5;
        Tue, 09 Oct 2018 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BZT/hDLKrDHEFII2+wPhuw7KJJddC8rhp6VmSHEpHQw=;
        b=VQ8mxG4OODpqbyjO7RduAwfBnAe8Zy1rKbfPCJ7UtjyWYl2u5SlpY0qkvAcbMTjcPQ
         g4L5AOOVGY4qunrnH/8TEdPES7U2f9bPdI+20VXjh+BtVTTuQlx4KzP9GpihQLLx5OcM
         wz4Da4rJfZgrBtugwoHN6garZsP3nLAwnknMFQJ7qgNOPhstRT5DI6q9DKktmnGqvDpf
         j2kwA2sFiEfxIlRVLfAT6BYENS2GRskkMyIRhEGqnvM1TaH98otMUOOr24A7lUf9tqkC
         tUZqqrHVbIbvBY+dRcmNpfDYdJPlvYWD1lvpun4K5VK8AU8jvnqBVav1gA6xxWuUi9L5
         iuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BZT/hDLKrDHEFII2+wPhuw7KJJddC8rhp6VmSHEpHQw=;
        b=KRv1y4vUfVqH9g8t9YCZxKv9FBS924VsIFvLLBSE06GGjHIlA66qEfBwCQ9G9CPYxD
         tGQvzlRRiTeHYwJxiO10fGo7RPv2ura0wIG58ZKgvAxgW+018xjf3A8cVSiB6cB4P4tj
         EBp4V7lYBqmtsr1POSqqWizxzWsVl8PmYTC2eFbCPBNOQxWJFnwVXLfbXd4holw4SXVn
         XsIumcMYBODGUT6quPzzJ+7QodIAq+1Bm97FKmJRXaV2nfEeeVa1NLCJGaeLAOCLivtv
         ISSSMsVKdSD0xJ+g9yw0ObdkSWXdAmnW4o6niWohcgd00QwIYZu411eafd0ny74EopQP
         U3NA==
X-Gm-Message-State: ABuFfogSsSNl8pUYFWUYtFFqfzn4E8JRmGvWXYeSR6r1d75BSuhVHV9Y
        9wxjtsbGzPGOvCKxa2XzpDw=
X-Google-Smtp-Source: ACcGV61KKnMnMUx/TX1Wef0bXLdMlygfCN2Kcnm2rtOCiO53l06r1kpQ1IfBzQ8xHs6gbspbZL1QuQ==
X-Received: by 2002:a1c:7913:: with SMTP id l19-v6mr4083336wme.84.1539152274711;
        Tue, 09 Oct 2018 23:17:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 62-v6sm28391967wra.48.2018.10.09.23.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 23:17:53 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:17:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181010061751.GA37224@gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thara Gopinath <thara.gopinath@linaro.org> wrote:

> Thermal governors can respond to an overheat event for a cpu by
> capping the cpu's maximum possible frequency. This in turn
> means that the maximum available compute capacity of the
> cpu is restricted. But today in linux kernel, in event of maximum
> frequency capping of a cpu, the maximum available compute
> capacity of the cpu is not adjusted at all. In other words, scheduler
> is unware maximum cpu capacity restrictions placed due to thermal
> activity. This patch series attempts to address this issue.
> The benefits identified are better task placement among available
> cpus in event of overheating which in turn leads to better
> performance numbers.
> 
> The delta between the maximum possible capacity of a cpu and
> maximum available capacity of a cpu due to thermal event can
> be considered as thermal pressure. Instantaneous thermal pressure
> is hard to record and can sometime be erroneous as there can be mismatch
> between the actual capping of capacity and scheduler recording it.
> Thus solution is to have a weighted average per cpu value for thermal
> pressure over time. The weight reflects the amount of time the cpu has
> spent at a capped maximum frequency. To accumulate, average and
> appropriately decay thermal pressure, this patch series uses pelt
> signals and reuses the available framework that does a similar
> bookkeeping of rt/dl task utilization.
> 
> Regarding testing, basic build, boot and sanity testing have been
> performed on hikey960 mainline kernel with debian file system.
> Further aobench (An occlusion renderer for benchmarking realworld
> floating point performance) showed the following results on hikey960
> with debain.
> 
>                                         Result          Standard        Standard
>                                         (Time secs)     Error           Deviation
> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%

Wow, +13% speedup, impressive! We definitely want this outcome.

I'm wondering what happens if we do not track and decay the thermal load at all at the PELT 
level, but instantaneously decrease/increase effective CPU capacity in reaction to thermal 
events we receive from the CPU.

You describe the averaging as:

> Instantaneous thermal pressure is hard to record and can sometime be erroneous as there can 
> be mismatch between the actual capping of capacity and scheduler recording it.

Not sure I follow the argument here: are there bogus thermal throttling events? If so then
they are hopefully not frequent enough and should average out over time even if we follow
it instantly.

I.e. what is 'can sometimes be erroneous', exactly?

Thanks,

	Ingo

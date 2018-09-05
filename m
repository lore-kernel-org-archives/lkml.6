Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9209C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B692077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B692077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeIEPaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:30:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55349 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeIEPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:30:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so7497410wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXNlJCeF/EldLo3kgGYc96ZmK+t7BvsB++fKrFyH2ks=;
        b=ZX6CjlJMfrMwM1Eah12QzqTy9uGVHJKjVYbLmbObf9TQ80gMTToOY9h2kBnGwArZm1
         l5bGMWkYycbtoQBjYGW3JIxbPyRWKdTc+Armz1g3Ngep0Xs9S41c+U2wNMpU50tJ/NKv
         4g+0BmhAX8RtP469oHcUulO5tMUFGMTm56n5VVHf4ZvMHst4f/3H5XEW1Rhn4zlJRlgI
         KVWMC4CDLdMFjCQoT7N2YNPZIn7ZN9MuN2QXxI4/dkstUJjW6nqEhr3KDxRm82GzgMpM
         XMa6Mu/hJAP7isPhLTzSvhEgEo/mOxQgI1UNNtSo0m0JKlj+c2AuTmc6fmHvv877+jjn
         TZ9Q==
X-Gm-Message-State: APzg51DAFTqB8tfQtOS893JuuoRint7Y32AYrRTM5Xe2qaLMYHhe+wP0
        0jQcxcAzpX+nAYYaUEwAT55D1A==
X-Google-Smtp-Source: ANB0VdbTwi+lc/06GARRGkyHHYCraoNDvYmnmqDDBgI+t+R6VAfOvmYcyCk0yhMcJJXFn0lss3pFeA==
X-Received: by 2002:a1c:e289:: with SMTP id z131-v6mr5319453wmg.32.1536145271636;
        Wed, 05 Sep 2018 04:01:11 -0700 (PDT)
Received: from localhost.localdomain ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id 132-v6sm1838599wmd.13.2018.09.05.04.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 04:01:10 -0700 (PDT)
Date:   Wed, 5 Sep 2018 13:01:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 01/16] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180905110108.GC20267@localhost.localdomain>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/08/18 14:53, Patrick Bellasi wrote:

[...]

> Let's introduce a new API to set utilization clamping values for a
> specified task by extending sched_setattr, a syscall which already
> allows to define task specific properties for different scheduling
> classes.
> Specifically, a new pair of attributes allows to specify a minimum and
> maximum utilization which the scheduler should consider for a task.

AFAIK sched_setattr currently mandates that a policy is always specified
[1]. I was wondering if relaxing such requirement might be handy. Being
util clamp a cross-class feature it might be cumbersome to always have
to get current policy/params and use those with new umin/umax just to
change the latter.

sched_setparam already uses the in-kernel SETPARAM_POLICY thing, maybe
we could extend that to sched_setattr? Not sure exposing this to
userspace is a good idea though. :-/

Best,

- Juri

1 - https://elixir.bootlin.com/linux/v4.19-rc2/source/kernel/sched/core.c#L4564

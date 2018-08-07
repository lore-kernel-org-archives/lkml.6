Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D74C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E425821723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E425821723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeHGMMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:12:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40009 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbeHGMMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:12:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so17497832wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 02:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwF+xHIkAm9SFeKz/1GdpcxcnMrkIhh2EnDc3zL0aO0=;
        b=IZuNKAcJxYifojD5UGNFVW2YaFlSu4mj4rp2LA/VPut1flMuJvqCzhWgTXMFXCF6D3
         5kd4fyc2sKeIIEWdXttVVtKmNzMX9hSBDuOePMHC6OglFEH5OrqusOXqYlzXTYHaoE1N
         FHMwRpUO9UZonpV3bP+h7onFpcU9kO4D4Gr21fX6VRyqMLneiLjywvZkBxGeRYBoH6Fb
         87jz/g7BFG0bfIPDKfQ+Bcvs5dutNum1+QQmvqioDjqsva7yGgXSRbHmYCilZix1Vzqx
         vmO8mTAC8dptQEdnyaR3ld8Ntp+62wU73zD6Qq/zO/Nckd/piiRJY3p8VpwDlp5BREUJ
         jNzg==
X-Gm-Message-State: AOUpUlEbXFwTXZyiAGjXXQybjBU9aDsYUj6y7Mn4mYMbNw0F4vpxl8hS
        HoRZc+BbzgMXjX9XuK45W56L3A==
X-Google-Smtp-Source: AA+uWPxkftgHcYOZwdxQlfUDrx64yNPYRiS+u6iKb6zHooXwgSkkb5rpVoVQBZqbYqBcXFIjhO6iQg==
X-Received: by 2002:a1c:30c3:: with SMTP id w186-v6mr1125980wmw.153.1533635948642;
        Tue, 07 Aug 2018 02:59:08 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31703FE367972448AED7A.dip0.t-ipconnect.de. [2003:ef:2bd3:1703:fe36:7972:448a:ed7a])
        by smtp.gmail.com with ESMTPSA id n12-v6sm659244wrm.62.2018.08.07.02.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 02:59:07 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:59:05 +0200
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
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180807095905.GB2288@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Minor comments below.

On 06/08/18 17:39, Patrick Bellasi wrote:

[...]

> + *
> + * Task Utilization Attributes
> + * ===========================
> + *
> + * A subset of sched_attr attributes allows to specify the utilization which
> + * should be expected by a task. These attributes allows to inform the
                                                       ^
						     allow

> + * scheduler about the utilization boundaries within which is safe to schedule

Isn't all this more about providing hints than safety?

> + * the task. These utilization boundaries are valuable information to support
> + * scheduler decisions on both task placement and frequencies selection.
> + *
> + *  @sched_util_min	represents the minimum utilization
> + *  @sched_util_max	represents the maximum utilization
> + *
> + * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE] which
> + * represents the percentage of CPU time used by a task when running at the
> + * maximum frequency on the highest capacity CPU of the system. Thus, for
> + * example, a 20% utilization task is a task running for 2ms every 10ms.
> + *
> + * A task with a min utilization value bigger then 0 is more likely to be
> + * scheduled on a CPU which can provide that bandwidth.
> + * A task with a max utilization value smaller then 1024 is more likely to be
> + * scheduled on a CPU which do not provide more then the required bandwidth.

Isn't s/bandwidth/capacity/ here, above, and in general where you use
the term "bandwidth" more appropriate? I wonder if overloading this term
(w.r.t. how is used with DEADLINE) might create confusion. In this case
we are not providing any sort of guarantees, it's a hint.

Best,

- Juri

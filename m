Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E0EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F27C20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F27C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbeHGOuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:50:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42637 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732703AbeHGOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:50:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so15604911wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 05:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bw3qLRMbKJ6HZRAJ9WL0GBg9v0Vg4HYIc5ZCbt6hI0U=;
        b=oZLtQMv6t4obgsASOPnxLkZmE9tMmAOI1h56FCtMG8msFAxrCii54MqSj0ZMzWs4Fp
         qkAAV/o1gg6HfzUczn6PYmufoFDkmoMigfesuEYE83LJe6GG4/5KV8zV1c3gODf4IJsW
         7Rk0neZw1kuhHZP1lKapHhWA2hB19VSk7DuMWAOJM7j2yY4IOBj3MiAReoTJ2bCjbJf1
         CGeV9pu/z+QxlaXrRSp4/wU7bcWM8v2pdDU2odmCvusOTj/X7u8MhSE0ZxeTo99BO5su
         e2LjbEedAAozdGwIVpBiLGvS6yp0123vLmyDxs8yj0NKEJpkRkXBNjQ9p9YWJ6rpsmrW
         HGzg==
X-Gm-Message-State: AOUpUlFag4K1UfCi0+Xs8lVTJ9zgQZMyXqKQIhPkc4CPsir6CkXph3JC
        wHTxiXQPnpJuWNC5TfjShMCUhw==
X-Google-Smtp-Source: AAOMgpe2NKtCYU3vaOZ8Y83UK+yPBVPEVjtZYF6FsvN+vcROZ3zQf6nvYH76m92VHME2MnobeCR0BA==
X-Received: by 2002:adf:eb4c:: with SMTP id u12-v6mr13215609wrn.174.1533645354613;
        Tue, 07 Aug 2018 05:35:54 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31703FE367972448AED7A.dip0.t-ipconnect.de. [2003:ef:2bd3:1703:fe36:7972:448a:ed7a])
        by smtp.gmail.com with ESMTPSA id b2-v6sm2001085wmh.3.2018.08.07.05.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 05:35:53 -0700 (PDT)
Date:   Tue, 7 Aug 2018 14:35:50 +0200
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
Message-ID: <20180807123550.GA3062@localhost.localdomain>
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

On 06/08/18 17:39, Patrick Bellasi wrote:

[...]

> @@ -4218,6 +4245,13 @@ static int __sched_setscheduler(struct task_struct *p,
>  			return retval;
>  	}
>  
> +	/* Configure utilization clamps for the task */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> +		retval = __setscheduler_uclamp(p, attr);
> +		if (retval)
> +			return retval;
> +	}
> +

IIUC, this is available to root and non-root users. In the latter case,
how do we cope with the fact that some user might occupy all the
available clamping groups configured for the system?

Best,

- Juri

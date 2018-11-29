Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B202DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2F120834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2F120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeK2VCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:02:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38161 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeK2VCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:02:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so1217237wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 01:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wVbQqGOEZGIqh5tnJCI0R/630vIv6JcoxcsOFv3IZng=;
        b=Z+lo30BXVHApujXrkBhf/VdYV3JoMczCuXVSsm1fOEqiutzM9JRqn4LW917mKHN5PK
         al+83L4RJ2BQno+G2AIU1quuhYIQGWyL2PSSE9hTfvZivSfmT/TgBdyL5fx/zBZijqGe
         bJEoyAx9DVXucQNfdH4DGkwvPfk/6DX9nGwsYcxBQKKmUBBCUcp5jXC2alZ61r7h+loJ
         oSRItmKU/WQEomg4NYNxvBa+nJ9SfZwiMX1ubZ4ocv4qU1gkFUnLWnlt1sarGFgs2ej1
         YvZ+t30VGYSahsS+r3n5+GLAa309HqOTBSiLmLPk4sCAEslXsJZbYdB7uRQlp7l5fGdv
         hlhg==
X-Gm-Message-State: AA+aEWbYVdzBjQ8kj1tOtQIDDV2R4YvUQZe07dZm/1DjJP+PU/XdM7Zz
        yBPLqmwD6Ju3xtwoSf0nXAG+rw==
X-Google-Smtp-Source: AFSGD/UW/sY4Ma4EUXKAuQrmoh9/ZwxCf5J8M45gZBWKGWZ2Ein+aUJ/sHbd2BzKc5JWtCpkL+P/RQ==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr752691wre.244.1543485486748;
        Thu, 29 Nov 2018 01:58:06 -0800 (PST)
Received: from localhost.localdomain ([151.15.226.84])
        by smtp.gmail.com with ESMTPSA id o81sm2224951wmd.10.2018.11.29.01.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 01:58:05 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:58:03 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH V5 1/2] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
Message-ID: <20181129095803.GF4271@localhost.localdomain>
References: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
 <20181128114454.GC4271@localhost.localdomain>
 <17ecb59a-7647-ce56-0715-bfe8d520dd18@linaro.org>
 <20181129070437.GD4271@localhost.localdomain>
 <749fdda3-7af5-2899-5c91-c9a1c57025d3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749fdda3-7af5-2899-5c91-c9a1c57025d3@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/18 10:18, Daniel Lezcano wrote:
> On 29/11/2018 08:04, Juri Lelli wrote:
> 
> [ ... ]
> 
> >> With or without this patch, it is the case:
> >>
> >>                 task1                      task2
> >>                   |                          |
> >>   read("/sys/.../cpu1/cpu_capacity)          |
> >>                   |                  write("/sys/.../cpu1/cpu_capacity")
> >>   read("/sys/.../cpu2/cpu_capacity)          |
> >>
> >>
> >> There is no guarantee userspace can have a consistent view of the
> >> capacity. As soon as it reads a capacity, it can be changed in its back.
> > 
> > True, but w/o the mutex task1 could read different cpu_capacity values
> > for a cluster (it actually can also with current implementation, we
> > should grab the mutex in the read path as well if we want to avoid
> > this). 
> 
> Even if the mutex is on the read path, the userspace can see different
> capacities because it will read the cpu_capacity per cpu directory.
> 
> The mutex will be take when reading cpu0/cpu_capacity, not for
> cpu[0-9]/cpu_capacity. Between two reads, a write can happen because the
> lock is released in between.
> 
> Do you agree with the patch ? Or do you want me to drop it ?

I don't actually have cases at hand that are showing regression with it,
I was just trying to understand if we might potentially hit problems in
the future. So, I'm not against this patch. :-)

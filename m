Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEE1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D820206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D820206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437844AbeKWC3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:29:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33259 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391763AbeKWC3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:29:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so8441029otl.0;
        Thu, 22 Nov 2018 07:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPiXjaMvWT6hSfJG40umWuN/SCk3uLLZ1OnKEp2w92I=;
        b=lMhokUpQREQdpmeBIRbEbi9F+swgS94v/qXXnAOwNf4OdqGgZGC5aEcR3rynxOUll4
         oYKFAFoJBCV/sQNCq/P1kV2rAufKxBtC/ss6RBkxHMI9e/qEKB58S138JIgX31lyQBe5
         WyzMo6VSB9Skr+8R7IDOWFZIknfBQNf7Fhh+oe3B11t1RLehZIvGwfFwYHzMTvUUbZh+
         i0wQRTLkjX2XzEPq8O/d1+xVXaeasnCAKq37G8wWiU+o9IIl3f/pzR0Q+MUCJUEKwPDd
         E75+lSgzI769J4xmkb5vXsin+iRN2bkkQeq06HE4kzmMgdaOO10EOZugLAgUu7TPcqZ9
         X1sQ==
X-Gm-Message-State: AA+aEWboGw1ik3Z3NOlM5Q37RiAvITTq9Nsj6ELUucUtVfJJ9YgafFoV
        RsZ7/7HyTUq7W1pP5p1NpMGIYLd0IbvN8409OFI=
X-Google-Smtp-Source: AFSGD/UYldQTocsV5ElpvranFvnL0a6lmhbfliZ+ZvoUfKSQ1eOUc4o118/pK/veKSEagQC108eSRKDJUTooSbk55FM=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr6322444ota.244.1542901752370;
 Thu, 22 Nov 2018 07:49:12 -0800 (PST)
MIME-Version: 1.0
References: <20181119141857.8625-1-quentin.perret@arm.com> <20181119141857.8625-9-quentin.perret@arm.com>
 <20181122140432.GH2113@hirez.programming.kicks-ass.net>
In-Reply-To: <20181122140432.GH2113@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Nov 2018 16:49:04 +0100
Message-ID: <CAJZ5v0g0cca+wuZocwwt5y+a7FS6Y8qDDf27KftRQ_1Dy6-7XQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/15] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
To:     Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 3:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 19, 2018 at 02:18:50PM +0000, Quentin Perret wrote:
> > +                     if (rd->pd)
> > +                             pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
> > +                                             cpumask_pr_args(cpu_map));
> > +                     goto free;
>
> I would have preferred just not allowing the governor to change at all,
> but if you want to allow that, this is, I suppose, the best you can do.
>
> Rafael, are you otherwise OK with the grubbing inside cpufreq?

Sort of. :-)

I would put the sched_cpufreq_governor_change() header (and the static
inline stub of it) into linux/cpufreq.h (instead of
linux/sched/cpufreq.h) so that cpufreq.c doesn't have to include
linux/sched/cpufreq.h which is kind of confusing.

Apart from that the changes are fine by me.

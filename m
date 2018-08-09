Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1CFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A62521AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3FZ8tFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A62521AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbeHILzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:55:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41061 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeHILzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:55:09 -0400
Received: by mail-io0-f195.google.com with SMTP id q4-v6so4219221iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtuPyPk64r09cO3EtqFJAP42zGzxwKzl724zbBNMBPc=;
        b=D3FZ8tFunAx13zmr9bDIlI66bSUG7V4Uh1CaoEzmHr5ZT8OPCjCTovNg5CjDjeIaE3
         GRY+HU9TRx2YPC4dqOcuidNFRL+AI1LyD7UK92PEQaY1vOpsn2+azqZqhGu5ZxfN18CI
         FPHKQk93oSfB1YehdExkOvrbPEYE10ojVSmPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtuPyPk64r09cO3EtqFJAP42zGzxwKzl724zbBNMBPc=;
        b=KlQQ84iUScRyo/TOoCkhJW9eegqvR/dMP+b1+ks8mYx8IiXQ0MRukXkRJQsF+GlFyN
         gQKKRfRrRpTqBp9Xn88zC2Mx1/8qsK9H2f6N0EKm4LC6SWZspGPl3kD3Ju5/2qc/lHt6
         MbmrHrF23NgF+ZTw/Vzr1iPMt8Aouosb8lZ+wpcGmEB9ciFc4is558+toi1XVBms8CC8
         l5ficum0wrKQs+3Myhuh77N+ln5k/HUwJ0K/4rUN84B6tFun8HBsZpmKHqRhs8oOBCe9
         SCZ+KhhMZEeg8eEGlEZk5nSO9YAZZlZZlqQQldt7VwBd0PjYzsBZbez5ZQgsACsihIbK
         dBoQ==
X-Gm-Message-State: AOUpUlGtNwpDTncvJEwyRVEPjRprKFiukOOcumabTFIXBJWFn/XjLKBH
        e9QW2DBXVGQ4Htfv/eXYw4WUbYdrFl0Gv6lPQhFOIQ==
X-Google-Smtp-Source: AA+uWPzCGO85HRf6awiInb+ox/jXiAk0G4sqK6qw5FVF0R0qrUXg1f8DUkQ7ZE5UzeINM3HMybnnkHAzn4uj2OZepYQ=
X-Received: by 2002:a6b:ec0f:: with SMTP id c15-v6mr1075360ioh.18.1533807068698;
 Thu, 09 Aug 2018 02:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180724122521.22109-1-quentin.perret@arm.com> <20180724122521.22109-10-quentin.perret@arm.com>
In-Reply-To: <20180724122521.22109-10-quentin.perret@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Aug 2018 11:30:57 +0200
Message-ID: <CAKfTPtBxWheWa4igKtwUmQR3x=7Zojnb65uFpeFUqxHmSkOh5w@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point indicator
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 at 14:26, Quentin Perret <quentin.perret@arm.com> wrote:
>
> From: Morten Rasmussen <morten.rasmussen@arm.com>
>
> Energy-aware scheduling is only meant to be active while the system is
> _not_ over-utilized. That is, there are spare cycles available to shift
> tasks around based on their actual utilization to get a more
> energy-efficient task distribution without depriving any tasks. When
> above the tipping point task placement is done the traditional way based
> on load_avg, spreading the tasks across as many cpus as possible based
> on priority scaled load to preserve smp_nice. Below the tipping point we
> want to use util_avg instead. We need to define a criteria for when we
> make the switch.
>
> The util_avg for each cpu converges towards 100% (1024) regardless of

remove the "(1024)" because util_avg converges to max cpu capacity
which can be different from 1024

> how many task additional task we may put on it. If we define
> over-utilized as:
>
> sum_{cpus}(rq.cfs.avg.util_avg) + margin > sum_{cpus}(rq.capacity)
>
> some individual cpus may be over-utilized running multiple tasks even
> when the above condition is false. That should be okay as long as we try
> to spread the tasks out to avoid per-cpu over-utilization as much as
> possible and if all tasks have the _same_ priority. If the latter isn't
> true, we have to consider priority to preserve smp_nice.
>

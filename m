Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7178C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9961B21A0E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9961B21A0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeHFNKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:10:50 -0400
Received: from foss.arm.com ([217.140.101.70]:36332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbeHFNKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:10:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBBAF18A;
        Mon,  6 Aug 2018 04:02:18 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6A163F5D4;
        Mon,  6 Aug 2018 04:02:14 -0700 (PDT)
Date:   Mon, 6 Aug 2018 12:02:13 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180806110211.kvibet576unwaowl@queper01-lin>
References: <20180802161027.v2ctgscuc4uxbb7u@queper01-lin>
 <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin>
 <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin>
 <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
 <20180803155547.sxlhxpmhwcoappit@queper01-lin>
 <CAKfTPtBT-p-Z0EneirfOTwUw=5jEeDGa+4_EE4ogi2Ht7GU9Bg@mail.gmail.com>
 <20180806094342.lonjz4g3lspcatcy@queper01-lin>
 <CAKfTPtBh2Z8Lc28avBOzOtz72eN-6vyuQZ1=5Wgbj4kJ=yn8FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBh2Z8Lc28avBOzOtz72eN-6vyuQZ1=5Wgbj4kJ=yn8FA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 Aug 2018 at 12:45:44 (+0200), Vincent Guittot wrote:
> On Mon, 6 Aug 2018 at 11:43, Quentin Perret <quentin.perret@arm.com> wrote:
> I would have preferred to have a full power policy for all task when
> EAS is in used by default and then see if there is any performance
> problem instead of letting some UC unclear but that's a personal
> opinion.

Understood. I'd say let's keep things simple for now unless there is a
consensus that this is must-have form the start.

> so IMO, the minimum is to add a comment in the code that describes
> this behavior for fork tasks so people will understand why EAS puts
> newly created task on not "EAS friendly" cpus when they will look at
> the code trying to understand the behavior

Agreed, that really needs to be documented. I'll add a comment somewhere
in v6.

Thanks,
Quentin

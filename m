Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86135FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BA520894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BA520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbeG3R4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:56:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41814 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730802AbeG3R4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:56:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C253680D;
        Mon, 30 Jul 2018 09:20:40 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB69C3F5D0;
        Mon, 30 Jul 2018 09:20:36 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:20:32 +0100
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
Subject: Re: [RFC PATCH v4 12/12] OPTIONAL: cpufreq: dt: Register an Energy
 Model
Message-ID: <20180730162029.2bu3vqipajgelbyz@queper01-lin>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-13-quentin.perret@arm.com>
 <CAKfTPtAANKzw7QTzKiU_ntiGYMxZD3etd8wMzXtngwUWHXj+Hg@mail.gmail.com>
 <20180706101858.GC11862@e108498-lin.cambridge.arm.com>
 <CAKfTPtASCvv1sbzp-7N=dsFBjATaGdeorxiyZ9urDgsMO8+XGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtASCvv1sbzp-7N=dsFBjATaGdeorxiyZ9urDgsMO8+XGA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Monday 30 Jul 2018 at 17:53:23 (+0200), Vincent Guittot wrote:
[...]
> ok, so you copy/paste what is done in cpu cooling device ?
> 
> Nevertheless I still have some concerns with the formula used here and
> in cpu cooling device:
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/arm/cpus.txt#L273
> The documentation says
> Pdyn = dynamic-power-coefficient * V^2 * f where voltage is in uV,
> frequency is in MHz.
>  and  dynamic power coefficient in units of mW/MHz/uV^2.
> 
> This implies that the results is in mW and we can summarize the formula with :
> 
> mW = C * (uV)^2 * Mhz with C = dynamic-power-coefficient
> then uV = 1000*mV
> mW = C * (1000*mV)^2 * Mhz
> mW = C * 1000000 * mV * mV * Mhz
> 
> Which is different from what is used here and in cpu cooling device.
> I may have done something wrong with the formula but i can't catch
> it... My brain is not yet fully back from vacations

I think your brain works fine ;) The doc does seem to be incorrect ...
I also believe that this issue has been discussed recently in another
thread:

http://archive.armlinux.org.uk/lurker/message/20180720.141530.2bf75d5c.en.html

> Which gives with the formula in the documentation:
> mW = 550 * (1100000)^2 * 2362 = 1,571911×10^18 which is quite huge
> even for a big core running at max freq
> and with the formula in cpu_cooling.c:
> mW = 550 * 1100 * 1100 * 2362 / 1000000000 = 1571 which seems to be a
> bit more reasonable

Indeed, 1.5W for a big CPU at max OPP is in the right ballpark I
believe.

FYI, this is the power values I have in the EM for all OPPs on H960:

        +--------+-------+--------+--------+
        |      A53s      |       A73s      |
        +--------+-------+--------+--------+
        |  MHz   |  mW   |  MHz   |  mW    |
        +--------+-------+--------+--------+
        |  533   |  28   |  903   |  243   |
        |  999   |  70   |  1421  |  500   |
        |  1402  |  124  |  1805  |  804   |
        |  1709  |  187  |  2112  |  1161  |
        |  1844  |  245  |  2362  |  1571  |
        +--------+-------+--------+--------+

[...]

> It's just that the tests results that you provided in the cover letter
> has used this patch and running tests with wrong formula (it seems
> that's the documentation is wrong) doesn't give much confidence on the
> results

I can understand that the mismatch between the code and the
documentation can be slightly confusing. However, as you said yourself
the code _is_ correct, so the test results are valid.

Moreover, the actual unit for the power costs doesn't make any
difference with EAS as long as that doesn't cause precision issues. EAS
works in relative terms, so even if the unit was in, say, uW instead of
mW, the test results would still be valid. And again, that's not the
case, the code does the right thing here.

Thanks,
Quentin

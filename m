Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1DBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C501206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C501206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390655AbeKVKUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:20:40 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47787 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387923AbeKVKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:20:40 -0500
Received: from 79.184.254.110.ipv4.supernova.orange.pl (79.184.254.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 434de29f7b835983; Thu, 22 Nov 2018 00:44:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor for tickless systems
Date:   Thu, 22 Nov 2018 00:44:06 +0100
Message-ID: <2788286.KFAUdKNhO2@aspire.rjw.lan>
In-Reply-To: <3270197.PFh8UsvZCP@aspire.rjw.lan>
References: <102783770.7hZjAahU8c@aspire.rjw.lan> <20181111154017.GD3021@worktop> <3270197.PFh8UsvZCP@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 15, 2018 4:15:59 AM CET Rafael J. Wysocki wrote:
> On Sunday, November 11, 2018 4:40:17 PM CET Peter Zijlstra wrote:

[cut]

> 
> > Anyway; a fair while ago I proposed a different estimator. I've not had
> > time to dig through the 4 prior versions so I cannot tell if you've
> > already tried this, but the idea was simple:
> > 
> >   - track the last @n wakeup distances in the @idle-states buckets;
> >   - sum the buckets in increasing idle state and pick the state before
> >     you reach 50% of @n.
> > 
> > That is computationally cheaper than what you have; and should allow you
> > to increase @n without making the computation more expensive.
> 
> I can do something similar (actually, I have a prototype ready already),
> but do it after walking the idle states once (which will give us a preliminary
> idle state choice based on the time to the closest timer and the "history")
> and then sum the buckets below the idle state selected so far in the decreasing
> order (that will tend to select a shallower state in "tie" situations).

I did that, but the result was not encouraging as it caused state 0 (polling)
to be selected way too often (and the total time spent in it was significantly
greater too).

I have gone back to averaging over the most recent observed idle duration
values, but now I'm doing that after selecting a candidate idle state
(based on the time to the closest timer and the "history") and only taking
values below the target residency of that state into account.  Seems to work
reasonably well.

I'll send a v6 tomorrow if all goes well.


Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27191C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22B1206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391916AbfAPMEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:04:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54313 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbfAPMEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:04:01 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 721b0c8b447b5a03; Wed, 16 Jan 2019 13:03:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Chen, Hu" <hu1.chen@intel.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v11] cpuidle: New timer events oriented governor for tickless systems
Date:   Wed, 16 Jan 2019 13:03:06 +0100
Message-ID: <2138748.C3tVedyW9D@aspire.rjw.lan>
In-Reply-To: <3625809.WY5lk7ujeb@aspire.rjw.lan>
References: <3625809.WY5lk7ujeb@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 4, 2019 12:30:47 PM CET Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The venerable menu governor does some things that are quite
> questionable in my view.
> 
> First, it includes timer wakeups in the pattern detection data and
> mixes them up with wakeups from other sources which in some cases
> causes it to expect what essentially would be a timer wakeup in a
> time frame in which no timer wakeups are possible (because it knows
> the time until the next timer event and that is later than the
> expected wakeup time).
> 
> Second, it uses the extra exit latency limit based on the predicted
> idle duration and depending on the number of tasks waiting on I/O,
> even though those tasks may run on a different CPU when they are
> woken up.  Moreover, the time ranges used by it for the sleep length
> correction factors depend on whether or not there are tasks waiting
> on I/O, which again doesn't imply anything in particular, and they
> are not correlated to the list of available idle states in any way
> whatever.
> 
> Also, the pattern detection code in menu may end up considering
> values that are too large to matter at all, in which cases running
> it is a waste of time.
> 
> A major rework of the menu governor would be required to address
> these issues and the performance of at least some workloads (tuned
> specifically to the current behavior of the menu governor) is likely
> to suffer from that.  It is thus better to introduce an entirely new
> governor without them and let everybody use the governor that works
> better with their actual workloads.
> 
> The new governor introduced here, the timer events oriented (TEO)
> governor, uses the same basic strategy as menu: it always tries to
> find the deepest idle state that can be used in the given conditions.
> However, it applies a different approach to that problem.
> 
> First, it doesn't use "correction factors" for the time till the
> closest timer, but instead it tries to correlate the measured idle
> duration values with the available idle states and use that
> information to pick up the idle state that is most likely to "match"
> the upcoming CPU idle interval.
> 
> Second, it doesn't take the number of "I/O waiters" into account at
> all and the pattern detection code in it avoids taking timer wakeups
> into account.  It also only uses idle duration values less than the
> current time till the closest timer (with the tick excluded) for that
> purpose.

Given the lack of negative feedback and my confidence in this, I'm
queuing it up for 5.1.

Cheers,
Rafael


Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D0BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5520220C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfB0LSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:18:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfB0LSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:18:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53B3230A01E3;
        Wed, 27 Feb 2019 11:18:04 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id E80CE5D707;
        Wed, 27 Feb 2019 11:18:02 +0000 (UTC)
Date:   Wed, 27 Feb 2019 12:18:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: Support sample context in perf report
Message-ID: <20190227111801.GA18893@krava>
References: <20190226030412.23485-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226030412.23485-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 27 Feb 2019 11:18:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 07:04:01PM -0800, Andi Kleen wrote:
> [Changes: 
> Removed already merged patches.
> Address review feedback, see individual patches.
> Now compiles with gcc 8.
> Some minor bug fixes and improvements.]
> 
> We currently have two ways to look at sample data in perf:
> either use perf report to aggregate everything, or use
> perf script to look at all individual samples.
> 
> Both ways are useful. Of course aggregation is useful
> to quickly find the most expensive part of the code.
> 
> But sometimes a single sample is not good enough to
> determine the problem and we need to look at context, either
> through branch contexts, or other previous samples (e.g. for
> correlating different micro architecture events or computing
> metrics)
> 
> This can be done through perf script today, but it can
> be rather cumbersome to find the right samples to look
> at.
> 
> Another problem with perf report is that it aggregates
> the whole measurement period. But many real workloads
> have phases where they behave quite differently, and it is
> often not useful to combine them into a single histogram.
> 
> While this can be worked around with the --time option
> to report, it can be quite cumbersome.
> 
> This patch kit attempts to address some of these
> problems in perf report by making it time aware.
> 
> - It adds a new time sort key that allows perf report
> to separate samples from different regions. The time
> regions can be defined with a new --time-quantum option.
> 
> - Then it extends the perf script support in the
> tui record browser to allow browsing samples for 
> different time regions from within a perf report
> session.
> 
> - Extends the report browser script display
> to automatically select sensible defaults
> based on what was recorded. For example it will
> automatically show branch contexts with -b.
> 
> - Support browsing the context of individual samples.
> perf report can save a limited number of random samples
> per histogram entry with the new --samples option.
> Then the browser allows directly jumping to any
> of the saved samples and browsing the context on the current
> thread or CPU.
> 
> There could be probably be done more to make
> perf report even better for such use cases (e.g. a real
> time line display), but this basic support is good
> enough for many useful usages.
> 
> Also available in
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2

your post is missing this patch, it's only in the branch:
  perf tools: Add utility function to fetch executable

jirka

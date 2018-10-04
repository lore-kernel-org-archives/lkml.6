Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB56C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DCB20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DCB20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJDTVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:21:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:55950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbeJDTVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:21:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1D8BAC6F;
        Thu,  4 Oct 2018 12:28:47 +0000 (UTC)
Date:   Thu, 4 Oct 2018 13:28:44 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Message-ID: <20181004122844.GA6931@suse.de>
References: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
 <1538654644-32705-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1538654644-32705-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:04:03PM +0200, Daniel Lezcano wrote:
> The function get_loadavg() returns almost always zero. To be more
> precise, statistically speaking for a total of 1023379 times passing
> in the function, the load is equal to zero 1020728 times, greater than
> 100, 610 times, the remaining is between 0 and 5.
> 
> In 2011, the get_loadavg() was removed from the Android tree because
> of the above [1]. At this time, the load was:
> 
> unsigned long this_cpu_load(void)
> {
>         struct rq *this = this_rq();
>         return this->cpu_load[0];
> }
> 
> In 2014, the code was changed by commit 372ba8cb46b2 (cpuidle: menu: Lookup CPU
> runqueues less) and the load is:
> 
> void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> {
>         struct rq *rq = this_rq();
>         *nr_waiters = atomic_read(&rq->nr_iowait);
>         *load = rq->load.weight;
> }
> 
> with the same result.
> 
> Both measurements show using the load in this code path does no matter
> anymore. Removing it.
> 
> [1] https://android.googlesource.com/kernel/common/+/4dedd9f124703207895777ac6e91dacde0f7cc17
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Ramesh Thomas <ramesh.thomas@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I agree that removing this is the most sensible option so;

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs

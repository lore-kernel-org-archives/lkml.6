Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DF2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B07D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eoU7DyD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B07D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeGaQpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:45:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeGaQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+cMdTyIUVDzKVmgmL9p6STfx6PrfnxOtk/KHQV6RXrs=; b=eoU7DyD/HVjH82aESm5LIahaw
        krIFJkBf5X1zx4X91YAjtNJMj78MvElQIaiXv9YSqZanrP6ZL0zX2VgkWw7kLuwSv3ykg9hkXJVuF
        fnVc5MvIxfk31X6giXH84MVIwOgUHF5bulmOjMt75Y8XcE0ZSzr0FvjwIi7gPCVSUB+eJ01ipzADL
        XsnLQgI7UxckE/8CXg6Dk5cQGCXYXaw1LMRu2OB9ks5RixfKrKRd0HiQmNnpOxDCC6k2UTvwYZsyX
        bBWZb0F7CRMDf10hTWz1kPjEIUu4dsnayWL+KDQofberpMNUX0D40CCpvKQ/KUfydLzyy/d2aU9iM
        yngi3zK6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkWCW-0001o0-Iy; Tue, 31 Jul 2018 15:04:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA41720532353; Tue, 31 Jul 2018 17:04:38 +0200 (CEST)
Date:   Tue, 31 Jul 2018 17:04:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Eero Tamminen <eero.t.tamminen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Francisco Jerez <currojerez@riseup.net>, lenb@kernel.org,
        rjw@rjwysocki.net, ggherdovich@suse.cz, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
Message-ID: <20180731150438.GE2458@hirez.programming.kicks-ass.net>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
 <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
 <87bmarhqk4.fsf@riseup.net>
 <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
 <e7388bf4-deb1-34b6-97d7-89ced8e78ef1@intel.com>
 <605cfcb3f315917c5970f452fab988ae1dc946ff.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <605cfcb3f315917c5970f452fab988ae1dc946ff.camel@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 07:06:21AM -0700, Srinivas Pandruvada wrote:
> On Mon, 2018-07-30 at 14:16 +0300, Eero Tamminen wrote:
> > Questions:
> > 
> > * Does currently kernel CPU freq management have any idea which IO
> >    devices share TDP with the CPU cores?

> No. The requests we do to hardware is just indication only (HW can
> ignore it). The HW has a bias register to adjust and distribute power
> among users.
> We can have several other active device on servers beside CPU which
> when runs need extra power. So the HW arbitrates power.

That's not entirely accurate AFAIK. "No" is accurate for Intel, but the
ARM people have their IPA thing (not a beer):

  https://developer.arm.com/open-source/intelligent-power-allocation

  drivers/thermal/power_allocator.c

which IIUC interacts with their cpufreq driver to disallow certain OPP
states.

And note that I discourage intel_pstate active mode.

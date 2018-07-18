Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4641DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED97020693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="otOZiMEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED97020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeGRJAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:00:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60962 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeGRJAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ERHY8RK/YpcSpvaKoM0yOyvjKjHHeeTtaHmhqiVJzYc=; b=otOZiMEmhuYuug5F3vE+ZDxqK
        vm16p/WnCJPtOri4CcNxDkesVKhNCC8lEy5kApIki6WaURmH+IaCiDiHUBIpjeOR89Iku6Lg5sDD5
        g3CIzOIJVWLemBQjAuhlZp+iRYegfMLlEVxoD+Pr+GyGewbVF251gV+cFRUR/1HeRL8O1ECKU27gB
        tk31aqW9C/LGOzymxmHL3eCLyW+qGjsX5UYXsbMErDbDw6FM1vk8xH+L7ppq3u8psj5RDc3d9EAgo
        tD++nf7HcIWeQgGLA8QDzplnpzftfA8MSmiJUR973tD7yEzvYG0SNu2EqSy8LzDinw+CSRzuWNd4Z
        j/bU4Cd3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffhkZ-00012k-5n; Wed, 18 Jul 2018 08:23:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58CB920289330; Wed, 18 Jul 2018 10:23:52 +0200 (CEST)
Date:   Wed, 18 Jul 2018 10:23:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: pcc-cpufreq: Disable dynamic scaling on
 many-CPU systems
Message-ID: <20180718082352.GQ2494@hirez.programming.kicks-ass.net>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <306375154.NhdH6AhdAd@aspire.rjw.lan>
 <5423012.ZZnfdYddaT@aspire.rjw.lan>
 <20180717201323.6rwb4yklq46cmtom@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717201323.6rwb4yklq46cmtom@suselix>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:13:23PM +0200, Andreas Herrmann wrote:
> On Tue, Jul 17, 2018 at 06:14:58PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The firmware interface used by the pcc-cpufreq driver is
> > fundamentally not scalable and using it for dynamic CPU performance
> > scaling on systems with many CPUs leads to degraded performance.
> > 
> > For this reason, disable dynamic CPU performance scaling on systems
> > with pcc-cpufreq where the number of CPUs present at the driver init
> > time is greater than 4.  Also make the driver print corresponding
> > complaints to the kernel log.
> > 
> > Reported-by: Andreas Herrmann <aherrmann@suse.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > -> v2: Rework the messages printed in the problematic case.
> 
> I've tested this patch. Effect is as expected: driver loads but use of
> ondemand governor is not allowed. Sample output:
> 
> [   40.757519] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1200 MHz, 2800 MHz
> [   40.831705] pcc_cpufreq_init: Too many CPUs, dynamic performance scaling disabled
> [   40.898353] pcc_cpufreq_init: Try to enable a different scaling driver through BIOS settings

BTW, Andreas, is that BIOS option available through the normal BIOS
settings, or it is in the "secret" BIOS menu that HP has? If it is in
the "secret" one (^A IIRC) then we might want to explicitly mention
that.

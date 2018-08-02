Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB19C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210F021566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d23OvFxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210F021566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeHBT2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:28:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33248 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbeHBT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MzUMTE/sLtyJKiKBmEwkMjOKSBsqw6Qh+nt3s0dfXwg=; b=d23OvFxJv1/fNookaRveChjw0
        W0xd/8tLAD2zkniksi7E/lCVGn+/i5sKVb2+luBVpLOABneJcHMG2sDZD183pA6xOeXqBOLXm9mek
        BbrRXaWQZWZEHjC/PcQ22E0RZGWx+g7Uvsb6zsrV/Gl/1tkrQ2aL5q55KQzw3JfyVxRaHo7QbPKVZ
        YhvU5hXPOHByNjv7v8KsADjBHpir5GkcqlFFQ4hmNQIa166dq+R00yrZ3/np1TwTiADAJhQ2d8nGo
        pQatE28yX2LRb9lh2Cjy2lSH5s3Wjc9blg8roOIOq2ZzyWyxuaqhpWZcpnIb+uCChg9vTJ5MsitiJ
        qHNs3jCIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flHW7-0007fD-5b; Thu, 02 Aug 2018 17:36:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7534F20267E4D; Thu,  2 Aug 2018 19:36:01 +0200 (CEST)
Date:   Thu, 2 Aug 2018 19:36:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     skannan@codeaurora.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Message-ID: <20180802173601.GO2494@hirez.programming.kicks-ass.net>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180802123315.GV2476@hirez.programming.kicks-ass.net>
 <20180802124511.GN2512@hirez.programming.kicks-ass.net>
 <20180802152109.2k45jqbfquef6u62@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802152109.2k45jqbfquef6u62@queper01-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 04:21:11PM +0100, Quentin Perret wrote:
> On Thursday 02 Aug 2018 at 14:45:11 (+0200), Peter Zijlstra wrote:

> > To clarify, it makes absolutely no sense what so ever to attempt EAS
> > when the DVFS control is not coordinated.
> 
> I tend to agree with that, but at the same time even if we create a very
> strong dependency on schedutil, we will have no guarantee that the actual
> frequencies used on the platform are the ones we predicted in EAS.

Sure; on x86 for example our micro-code does whatever. But using
schedutil we at least 'guide' it in the general direction we'd expect
with the control that is available.

Using a !schedutil governor doesn't even get us that and we're basically
running on random input without any feedback to close the loop. Not
something I feel we should support or care for.

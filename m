Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF5C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1B22082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TUNeBo5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1B22082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJDRs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:48:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52902 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeJDRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uk9/+Rux2h0eMgBe1OnQ6iheLXgx5sSN9B1amX2CG1E=; b=TUNeBo5W25cSVrq/7ZvDZmA1v
        pIwbacZSzQzPvPaY9QGWca8qWuhzKGwLvV4mtocu3uxbkVoP46Vh43Ql5Tccnj/Nkce4OqIn4EjoN
        hXxiALAl//LMCNxit9rwbp8PWTxzF9KJhQkv5TOPKDykdabXgDssh2kFsTzV2+xtyJhei60O0goTj
        psCNF1sOwuUIC0k0l9bWHkBQIn+CCMu0GbGu1SGCedY7KQmnDVYdISo5dhC2wUGj2XJIaKCj9dRNr
        1YLcAOlzJL0r+wpvNsTD4tPEF4Dw324lcQUCO71zcHHjCeBlBEUYETxz0EuUCpcw+5py6UWQMYGKr
        XsC4HKJyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g81IY-00009j-Dx; Thu, 04 Oct 2018 10:56:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE97B202C1A0F; Thu,  4 Oct 2018 12:50:23 +0200 (CEST)
Date:   Thu, 4 Oct 2018 12:50:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Message-ID: <20181004105023.GE19252@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-14-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-14-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:13:08AM +0100, Quentin Perret wrote:
> Energy Aware Scheduling (EAS) is designed with the assumption that
> frequencies of CPUs follow their utilization value. When using a CPUFreq
> governor other than schedutil, the chances of this assumption being true
> are small, if any. When schedutil is being used, EAS' predictions are at
> least consistent with the frequency requests. Although those requests
> have no guarantees to be honored by the hardware, they should at least
> guide DVFS in the right direction and provide some hope in regards to the
> EAS model being accurate.
> 
> To make sure EAS is only used in a sane configuration, create a strong
> dependency on schedutil being used. Since having sugov compiled-in does
> not provide that guarantee, make CPUFreq call a scheduler function on
> on governor changes hence letting it rebuild the scheduling domains,
> check the governors of the online CPUs, and enable/disable EAS
> accordingly.

So this patch disables EAS when we change cpufreq gov. How about we
force select schedutil and disallow changing it when EAS is enabled?

Instead of silently disabling EAS when we frob the governor?

Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F35FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF4F240C6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rBJ5w4be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF4F240C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeGERdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:33:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbeGERdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ChqyhaL6LOSr5My60bb2JbsGirb12I9ASzGHlJKgN0M=; b=rBJ5w4beCEV/65C0hxbHaHyxq
        EvH/PruD7JK8WTdIJf/h9mAhN/Jfx/nj2BWVQOw866iMmL14y4XPINcOCPfuJpkg7JQ02EciXbCxC
        klmtrDyh5pTex2tc8MiFtsq26ovOEVgPdysxKuDmM37zY+S++20yfpFeRCVlAmBGPrywE5lpqhfy+
        E++lemocbN8YbDoIs/gd1u7CJUmfQq3qS5pXvL2MwP6q64TfLKRUj925cihXCm3Z1/iL/zcxH+Ve9
        COeBvATDT0CJ1T7NaAFkg5LrWfOPcTGzBYL6Up0DWF3eOyNV7u3LvZutPHVjfhcd11dsK0ZQbC1uV
        /W7l4GXVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb88B-0002jW-5Y; Thu, 05 Jul 2018 17:33:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9EB620298BAE; Thu,  5 Jul 2018 19:33:21 +0200 (CEST)
Date:   Thu, 5 Jul 2018 19:33:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 05/12] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180705173321.GR2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-6-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-6-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:36PM +0100, Quentin Perret wrote:
> +			if (cpumask_equal(doms_new[i], doms_cur[j])
> +			    && cpu_rq(cpumask_first(doms_cur[j]))->rd->fd)

Please put the operator at the end of the previous line, not the begin
of the next line when splitting.

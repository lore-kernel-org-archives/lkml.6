Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB998C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3AF23FBA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xefy2DA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3AF23FBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeGFNNI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:13:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932916AbeGFNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FKlSBG8j2zmf9LCtYKH6XHO83cQ0K2I0P8X38p4FZyI=; b=Xefy2DA1FDr7+R8+hFtipVOgZ
        aBpk2kre2+33Ufsc5vpUX7zH8/mjh6HqgeVmpCHT+jItCfFUQyJGHB+yZ7imfMUV8oo3ozs8opvJG
        QqfiXKIrB20GMAzgKfFnVOwlLHqtKatB6F5h8ViHI+APMqFWD5xTQedW1sDADhzgw2GhhTT40EXfx
        6pOhwo6KynFTUOpwTzAuJmRba6cwSEANZ8cmZnc5u2i0lD1uALI7qEwvRfXoq9EhfBUdMoXHXVaiZ
        yZCtjyASfH/uTF/Oc4eBSnGyO7PGpSipPkVbhLUpMj2PKQ+JAasgpP7JyEbb3QRCxOSafW2j9n6LV
        tS2ZR5/kA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbQXW-00018U-Nw; Fri, 06 Jul 2018 13:12:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAA8F20297EAB; Fri,  6 Jul 2018 15:12:43 +0200 (CEST)
Date:   Fri, 6 Jul 2018 15:12:43 +0200
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
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180706131243.GV2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-10-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:40PM +0100, Quentin Perret wrote:
> +static long 
   compute_energy(struct task_struct *p, int dst_cpu, struct freq_domain *fd)
> +{
> +	long util, max_util, sum_util, energy = 0;
> +	int cpu;
> +
> +	while (fd) {
> +		max_util = sum_util = 0;
> +		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {

I had a wee little wtf moment when I realized this crosses root_domain
boundaries but that that is actually desired. A comment might be in
order.

> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util += cpu_util_dl(cpu_rq(cpu));
> +			/* XXX: add RT util_avg when available. */
> +
> +			max_util = max(util, max_util);
> +			sum_util += util;

Did you want to use sugov_get_util() here? There is no way we're going
to duplicate all that.

ISTR we already established the whole EAS was going to require using
schedutil anyway.

> +		}
> +
> +		energy += em_fd_energy(fd->obj, max_util, sum_util);
> +		fd = fd->next;
> +	}
> +
> +	return energy;
> +}

Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA29C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FAD2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S5tj3Bwa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pMhSTd1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FAD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965664AbeFSJvx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:51:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755270AbeFSJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:51:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B733560B1A; Tue, 19 Jun 2018 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529401910;
        bh=KMPtYJ1oyhWweIy+Eqz+kmopH5bbpNwl04WuxXPDbJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5tj3BwalSyozE2ZpoCMugfaKfI38RBdYbN8llu/HpbjbaH4bXXFxLTus1puX8jd8
         2AHhiF9DnvPdz5gypiU/ybJ1PHPhSxBr9jskzYMfz+AUj4uWt8ulVMMxu/B6fIuRgx
         yESEfIm5L2QyVisc2lBkHVonTOgVfIsN8vvyhE04=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54F30604A6;
        Tue, 19 Jun 2018 09:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529401909;
        bh=KMPtYJ1oyhWweIy+Eqz+kmopH5bbpNwl04WuxXPDbJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMhSTd1mMpdET6cVZhZ1bIHlH35xRFKjBuFqK2fhKJC8AOH6yk29BSJ2Q8f5gXs86
         cGnKHrsAxLyKCl8oGajGbsnErPvJaZSb95HDQlY099FdZP2HYNxCMQ3iKTXJKED4Z+
         ZEnZW1iY07rwp+3waj0Ku4CoXbhDT2DWz6YeOzkk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54F30604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 19 Jun 2018 15:21:40 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 07/10] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180619095140.GE9208@codeaurora.org>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-8-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-8-quentin.perret@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:25:02PM +0100, Quentin Perret wrote:

<snip>

>  
> +/*
> + * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
> + */
> +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> +{
> +	unsigned long util, util_est;
> +	struct cfs_rq *cfs_rq;
> +
> +	/* Task is where it should be, or has no impact on cpu */
> +	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
> +		return cpu_util(cpu);
> +
> +	cfs_rq = &cpu_rq(cpu)->cfs;
> +	util = READ_ONCE(cfs_rq->avg.util_avg);
> +
> +	if (dst_cpu == cpu)
> +		util += task_util(p);
> +	else
> +		util = max_t(long, util - task_util(p), 0);
> +
> +	if (sched_feat(UTIL_EST)) {
> +		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +		if (dst_cpu == cpu)
> +			util_est += _task_util_est(p);
> +		else
> +			util_est = max_t(long, util_est - _task_util_est(p), 0);

For UTIL_EST case, the waking task will not have any contribution in the
previous CPU's util_est. So we can just use the previous CPU util_est as is.

> +		util = max(util, util_est);
> +	}
> +
> +	return min_t(unsigned long, util, capacity_orig_of(cpu));
> +}
> +

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


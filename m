Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0AFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E8820824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GmcTJva4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E8820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeJ3EXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:23:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3EXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ohrRml1DVL3QOAHeC2fJX5vmlo5wnZeHUHLRlPhYEWU=; b=GmcTJva4PiKwfCDklaq2/tmhH
        CfV9owyT0dM609geEf1398SWvHnocZO0k1SuLkOBHCt53JEl+5DOe5w5oqBu3VPEqPw3uVEPqKgfR
        Vdn2jYzI0Dy+qOrtwdPo73fB0FupZoTTAiMpiYEn9lQB5TtpxOuZLR0lqPRuL3C4xWmzfM6sOLMVl
        RnfFNaYwQkTrihD37W35aq/SoTs+NBkm5ClKsAbZ5ssM+4jL395FvlRrffqj1UktGoqNqFkRpUxvZ
        nabZGlbLtxZod2nA7CKVe/as6ZeXu7yuh+2AF2MiIL58vjGiro4WI/acYk5PLV+gxULbj3rDcKd7x
        ZmgyArD4w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHDID-00076I-4e; Mon, 29 Oct 2018 19:33:41 +0000
Subject: Re: [PATCH v5 01/15] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-api@vger.kernel.org
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-2-patrick.bellasi@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5d17113b-d0c8-dafe-f4f9-527722749bb8@infradead.org>
Date:   Mon, 29 Oct 2018 12:33:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029183311.29175-2-patrick.bellasi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 11:32 AM, Patrick Bellasi wrote:

> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
> index 10fbb8031930..fde7301ed28c 100644
> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h

> @@ -53,6 +73,30 @@ struct sched_param {
>   * As of now, the SCHED_DEADLINE policy (sched_dl scheduling class) is the
>   * only user of this new interface. More information about the algorithm
>   * available in the scheduling class file or in Documentation/.
> + *
> + * Task Utilization Attributes
> + * ===========================
> + *
> + * A subset of sched_attr attributes allows to specify the utilization which
> + * should be expected by a task. These attributes allow to inform the
> + * scheduler about the utilization boundaries within which it is expected to
> + * schedule the task. These boundaries are valuable hints to support scheduler
> + * decisions on both task placement and frequencies selection.
> + *
> + *  @sched_util_min	represents the minimum utilization
> + *  @sched_util_max	represents the maximum utilization
> + *
> + * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE] which
> + * represents the percentage of CPU time used by a task when running at the
> + * maximum frequency on the highest capacity CPU of the system. Thus, for
> + * example, a 20% utilization task is a task running for 2ms every 10ms.
> + *
> + * A task with a min utilization value bigger then 0 is more likely to be

                                                 than

> + * scheduled on a CPU which has a capacity big enough to fit the specified
> + * minimum utilization value.
> + * A task with a max utilization value smaller then 1024 is more likely to be
> + * scheduled on a CPU which do not necessarily have more capacity then the

                               does                                  than

> + * specified max utilization value.
>   */
>  struct sched_attr {
>  	__u32 size;


cheers.
-- 
~Randy

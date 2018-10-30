Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB8CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0B420831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PJXLDyyc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PJXLDyyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0B420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJ3SMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:12:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3SMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:12:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E8FD06029D; Tue, 30 Oct 2018 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540891185;
        bh=cj/p5kDACa6KrPMRniicO1jU0bzMdStbl0C0ao6vqEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJXLDyyc0DeBrLr8oAsmvmQKVXP1RUVoGepshh/BgUbvhTFtR7Ui/am8bFTyhatjM
         uLVwM5m8nlg7mTiiErUdAxe7LGy1TpWx6B542Q5oCH/asnUkg3DMYUd49xoRXbeVLP
         yRi3OjOl8wvMzQqHyexWoZVKyaUkbBZs1YZH07EI=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19C19601B4;
        Tue, 30 Oct 2018 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540891185;
        bh=cj/p5kDACa6KrPMRniicO1jU0bzMdStbl0C0ao6vqEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJXLDyyc0DeBrLr8oAsmvmQKVXP1RUVoGepshh/BgUbvhTFtR7Ui/am8bFTyhatjM
         uLVwM5m8nlg7mTiiErUdAxe7LGy1TpWx6B542Q5oCH/asnUkg3DMYUd49xoRXbeVLP
         yRi3OjOl8wvMzQqHyexWoZVKyaUkbBZs1YZH07EI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19C19601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 30 Oct 2018 14:49:38 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        patrick.bellasi@arm.com, pjt@google.com, bsegall@google.com,
        thara.gopinath@linaro.org
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181030091938.GE27587@codeaurora.org>
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Fri, Oct 26, 2018 at 06:11:43PM +0200, Vincent Guittot wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6806c27..7a69673 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -674,9 +674,8 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	return calc_delta_fair(sched_slice(cfs_rq, se), se);
>  }
>  
> -#ifdef CONFIG_SMP
>  #include "pelt.h"
> -#include "sched-pelt.h"
> +#ifdef CONFIG_SMP
>  
>  static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
>  static unsigned long task_h_load(struct task_struct *p);
> @@ -764,7 +763,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
>  			 * such that the next switched_to_fair() has the
>  			 * expected state.
>  			 */
> -			se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
> +			se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
>  			return;
>  		}
>  	}
> @@ -3466,7 +3465,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  /* Update task and its cfs_rq load average */
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> -	u64 now = cfs_rq_clock_task(cfs_rq);
> +	u64 now = cfs_rq_clock_pelt(cfs_rq);
>  	struct rq *rq = rq_of(cfs_rq);
>  	int cpu = cpu_of(rq);
>  	int decayed;
> @@ -6694,6 +6693,12 @@ done: __maybe_unused;
>  	if (new_tasks > 0)
>  		goto again;
>  
> +	/*
> +	 * rq is about to be idle, check if we need to update the
> +	 * lost_idle_time of clock_pelt
> +	 */
> +	update_idle_rq_clock_pelt(rq);
> +
>  	return NULL;
>  }

Do you think it is better to call this from pick_next_task_idle()? I don't see
any functional difference, but it may be easier to follow.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


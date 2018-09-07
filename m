Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF3BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9DF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cywUXhom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9DF2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeIGRQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:16:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35533 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeIGRQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:16:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so14551370wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VpB1vYCQbP4r/2bEcPqiF8o2uY9ubTvP/ZfDVhYapSc=;
        b=cywUXhom7eifWOjT72m6SIqGXtJ3Rd3d9+dFPjNQLXj0zSZDRuspK3ySTgbn1g4hWQ
         zJMyAXTi2sWyP9lHQr+wun7C6o8KoMIEbCfjFYoUWRvku+Qd54o9nM7wTPfqfNI4OxmG
         if1uKBOGu+Po+7D5z7JKTMSbrg7XsQOBRA178=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VpB1vYCQbP4r/2bEcPqiF8o2uY9ubTvP/ZfDVhYapSc=;
        b=H+yymHM1vrbkPBRKrBtbWvPacHXQmQLC/V3jExDaptRdPzus+yKP6TC3ft96SOs3z+
         IhmzuZlkiaJBzwBX1iJysHaeghsNMRFeaSXu5bUue+NycGMhpUUzeZGPfqCpo/5zD106
         FcGGRc4PQ+hsFPP8vDVgP+B1syVWRY6wTDZAhQUbMEzcrI3y0Ej+cVG0lTw0b5Q9CAVK
         zsebk/HVo/RUPGvsnA+kfclJ8TF31eVEUtqJideMLuUaq0x2dO5+oOr0w+YxBWcxO8KH
         L34mHa1m00IVo971xFu2nyOdR8d+Mt0FG/WGJzgSmLpYSiQGx6l0fAvGaqn9DXnHONJ9
         tTFw==
X-Gm-Message-State: APzg51BVlYXqcF6LXseCrp3DvgIIv3Oc74Bo3DyJPItqfd2sy5zSBzBq
        4zEOeFDSDEB2YzAC7v2o7mPdZg==
X-Google-Smtp-Source: ANB0VdaRXUb8vmygXq4cXP+uhcSAWj3fcVzKvIrPx/2jSTwG0Gb+QzBA4loORzrDp+o5rIBoMvaRrQ==
X-Received: by 2002:a1c:cecf:: with SMTP id e198-v6mr4878145wmg.83.1536323754192;
        Fri, 07 Sep 2018 05:35:54 -0700 (PDT)
Received: from linaro.org ([2a01:e0a:f:6020:5981:ec43:6d36:934e])
        by smtp.gmail.com with ESMTPSA id d1-v6sm18658770wrc.52.2018.09.07.05.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 05:35:53 -0700 (PDT)
Date:   Fri, 7 Sep 2018 14:35:51 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, jhugo@codeaurora.org
Subject: Re: [PATCH] sched/fair: fix load_balance redo for null imbalance
Message-ID: <20180907123551.GA9955@linaro.org>
References: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
 <20180907113748.GV24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907113748.GV24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Friday 07 Sep 2018 à 13:37:49 (+0200), Peter Zijlstra a écrit :
> On Fri, Sep 07, 2018 at 09:51:04AM +0200, Vincent Guittot wrote:
> > It can happen that load_balance finds a busiest group and then a busiest rq
> > but the calculated imbalance is in fact null.
> 
> Cute. Does that happen often?

I have a use case with RT tasks that reproduces the problem regularly.
It happens at least when we have CPUs with different capacity either because
of heterogeous CPU or because of RT/DL reducing available capacity for cfs
I have put the call path that trigs the problem below and accroding to the
comment it seems that we can reach similar state when playing with priority.

> 
> > If the calculated imbalance is null, it's useless to try to find a busiest
> > rq as no task will be migrated and we can return immediately.
> > 
> > This situation can happen with heterogeneous system or smp system when RT
> > tasks are decreasing the capacity of some CPUs.
> 
> Is it the result of one of those "force_balance" conditions in
> find_busiest_group() ? Should we not fix that to then return NULL
> instead?

The UC is:
We have a newly_idle load balance that is triggered when RT task becomes idle
( but I think that I have seen that with idle load balance too)

we trigs:
	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
	    busiest->group_no_capacity)
		goto force_balance;

In calculate_imbalance we use the path
	/*
	 * Avg load of busiest sg can be less and avg load of local sg can
	 * be greater than avg load across all sgs of sd because avg load
	 * factors in sg capacity and sgs with smaller group_type are
	 * skipped when updating the busiest sg:
	 */
	if (busiest->avg_load <= sds->avg_load ||
	    local->avg_load >= sds->avg_load) {
		env->imbalance = 0;
		return fix_small_imbalance(env, sds);
	}

but fix_small_imbalance finally decides to return without modifying imbalance
like here
	if (busiest->avg_load + scaled_busy_load_per_task >=
	    local->avg_load + (scaled_busy_load_per_task * imbn)) {
		env->imbalance = busiest->load_per_task;
		return;
	}

Beside this patch, I'm preparing another patch in fix small imbalance to
ensure 1 task per CPU in similar situation but according to the comment above,
we can reach this situation because of tasks priority


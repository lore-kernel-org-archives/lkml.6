Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30420C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE5920850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6Si5uWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE5920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeH2SDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:03:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43109 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2SDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:03:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so4955314wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8bHBgu1w8gp4sRX9HM2TpUSo8dJNbUTejKR10AiYyZQ=;
        b=a6Si5uWUfHXOrh6Y0EcLfA/0NsjiH1hzKVTMJLvTGPG7K5XS2wzPMkLT1JaLApjxN9
         dUlcNJHuXUCeDEwGTFFBLQcl0oDZ2lNeVJk+FZlYijqKjPgeigvpFgbIgGOFVFEusSbv
         BrNgB4ww1lygU/trlqdU65CfqRzr97PKZjMtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8bHBgu1w8gp4sRX9HM2TpUSo8dJNbUTejKR10AiYyZQ=;
        b=VKTzSMhC4PXJ4bTYOJs7vy/RlQwGZNrpEEF5iedur1qCwb0JrJZUAvBcO/frxdMOZI
         jsvfjmFVqaJ98FGo6mVIOeKFc/2CLXB0RNzexHc9IVSgay4dvXPUu7JA6vKZWlSlKIpS
         G5e4e8piGKIaq4w5W+RhpZWRDUEhKKnqIcaf0V5cHeYl4cTdU6CXu/dbl38U9QXZVSm5
         GORKAGoADAz6rOmoGjzVrtpu089kvtjY9Dzz7wiq5LccFy0A/yP8NPlTxNkVpccswj+q
         OPuJ2UUrhP8nElcIIN8odL+lA+oE7WOP3/r+yvDkys52jr2dryCw85XOPDJGi92Hwr1O
         vO8g==
X-Gm-Message-State: APzg51DEwbOmgfJ5hC6UNvRVN6mOgfuIY0xE5e4+p3YcS6bSM2JHx8sE
        DWcrZwyuSjpJIOQpcL9zgKNBom9q4NU=
X-Google-Smtp-Source: ANB0VdapE4K5IbSw58Jz5A067CfgRoq9hOyC8jIScAXXuk4Gm9A8QRC4rggen43WBDP4UolMEyqwVA==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr4591145wra.120.1535551601335;
        Wed, 29 Aug 2018 07:06:41 -0700 (PDT)
Received: from linaro.org ([2a01:e0a:f:6020:4c23:4749:7ea6:c5af])
        by smtp.gmail.com with ESMTPSA id r30-v6sm8852054wrc.90.2018.08.29.07.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 07:06:40 -0700 (PDT)
Date:   Wed, 29 Aug 2018 16:06:38 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, kernellwp@gmail.com
Subject: Re: [PATCH] sched/schedutil : optimize utilization scaling for guest
 kernel
Message-ID: <20180829140638.GA7483@linaro.org>
References: <1535532702-3508-1-git-send-email-vincent.guittot@linaro.org>
 <20180829124503.GU24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180829124503.GU24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wednesday 29 Aug 2018 à 14:45:03 (+0200), Peter Zijlstra a écrit :
> On Wed, Aug 29, 2018 at 10:51:42AM +0200, Vincent Guittot wrote:
> > Scaling the utilization of CPUs with irq util_avg in schedutil doesn't give
> > any benefit and just waste CPU cycles when irq time is not accounted but
> > only steal time.
> > Add an internal _scale_irq_capacity() for scale_rt_capacity but scale
> > cpu utilization in schedutil only if we are accounting irq time.
> 
> This makes a mess of things; also it doesn't really do what it says.

you're right. I forgot to not add irq util_avg in this case.
What about the below instead ?

sched/schedutil : optimize computation of utilization in schedutil
    
Scaling the utilization of CPUs with irq util_avg in schedutil doesn't give
any benefit and just waste CPU cycles when irq time is not accounted but
only steal time.
Skip the irq scaling when irq time is not accounted

Suggested-by: Wanpeng Li <kernellwp@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

---
 kernel/sched/cpufreq_schedutil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3fffad3..edbc4d2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -238,6 +238,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	if ((util + cpu_util_dl(rq)) >= max)
 		return max;
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	/*
 	 * There is still idle time; further improve the number by using the
 	 * irq metric. Because IRQ/steal time is hidden from the task clock we
@@ -249,6 +250,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 */
 	util = scale_irq_capacity(util, irq, max);
 	util += irq;
+#endif
 
 	/*
 	 * Bandwidth required by DEADLINE must always be granted while, for
-- 
2.7.4

> 
> Even if we have CONFIG_IRQ_TIME_ACCOUNTING, that doesn't mean we do it,
> just that it is capable.
> 
> 

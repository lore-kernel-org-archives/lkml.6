Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08278C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9066020867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3Z2yWzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9066020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeIDOAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:00:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32903 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeIDOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:00:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id r1-v6so8675495wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fWvFRk2DF9cr4qOBjjQdzHJqXKr8I/4NJe4vlXpbS3Y=;
        b=J3Z2yWzmXm80Xv27khGarIuBOUgimiIcFvQbTq2F49Bzbj0hzgcWSS3MdIBEiJy9L0
         8Zi8he9kGw/pnaetqj25odiBG8bXcBqvity2qamLfw40f3kCUj2U074CJ+Jg0crgTOzC
         Qzn03QGHNbdp0wDuwFBGf0Gf4k2GCYN3JncsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fWvFRk2DF9cr4qOBjjQdzHJqXKr8I/4NJe4vlXpbS3Y=;
        b=Xpw73UOu5rQH/yr4H7NL5sq6oXvhreVh5bjJsFBcXXLfSvDKNUz55pwb7H281rUkCg
         OPkfUP1urbmJ9WL2AtI9GohP3V/J3tWmYMBcM2uZV5bkoHVRE8A2xrH4b4g899vUhjB8
         Hn8RiClWdTPKFyzH5lu9kUwG1a58hXr/fu7nienD1f1xZ9UGHYFn1/+ZWBCGTn2oZKM7
         oxtOgTkaCvt6I16GwlPI6vuSyaXH22ysODyTsmTZgsD9j6XJeUZGw9un4K7RzGeNzdba
         DKi8jYIcUyk4qTuFLpv2UmzYeOn99LSUU6LaZKbWDIfjbC8VejTd02xeUv8/loPsD3FX
         aFzA==
X-Gm-Message-State: APzg51AyVC6b6X7/ZotkiPIBxNUo9Hu4T8Tp1QvpGftQbuBh9FVUZQCr
        CXPj0yjb10lvQEPQiosIVNDmIQ==
X-Google-Smtp-Source: ANB0VdYiTGAuCUZM6tYoWPAHKAiEJe/bToAL5d6R3QwG5phh9IuEFb0vrkZypd/FObPeRkWrszrtBw==
X-Received: by 2002:a1c:d946:: with SMTP id q67-v6mr7329817wmg.156.1536053789058;
        Tue, 04 Sep 2018 02:36:29 -0700 (PDT)
Received: from linaro.org ([2a01:e0a:f:6020:7c65:f99f:5f34:3c07])
        by smtp.gmail.com with ESMTPSA id q135-v6sm28751946wmd.4.2018.09.04.02.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 02:36:28 -0700 (PDT)
Date:   Tue, 4 Sep 2018 11:36:26 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
Message-ID: <20180904093626.GA23936@linaro.org>
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
 <20180904082424.GA2090@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180904082424.GA2090@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

Le Tuesday 04 Sep 2018 à 01:24:24 (-0700), Srikar Dronamraju a écrit :
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: linux-kernel@vger.kernel.org (open list)
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 4a2e8ca..b1715b8 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1758,9 +1758,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
> >  static __always_inline
> >  unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
> >  {
> > -	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
> > -		return sd->smt_gain / sd->span_weight;
> > -
> >  	return SCHED_CAPACITY_SCALE;
> 
> Without this change, the capacity_orig of an SMT would have been based
> on the number of threads.
> For example on SMT2, capacity_orig would have been 589 and
> for SMT 8, capacity_orig would have been 148.
> 
> However after this change, capacity_orig of each SMT thread would be
> 1024. For example SMT 8 core capacity_orig would now be 8192.
> 
> smt_gain was suppose to make a multi threaded core was slightly more
> powerful than a single threaded core. I suspect if that sometimes hurt

Is there system with both single threaded and multi threaded core ?
That was the main open point for me (and for Qais too)


> us when doing load balance between 2 cores i.e at MC or DIE sched
> domain. Even with 2 threads running on a core, the core might look
> lightly loaded 2048/8192. Hence might dissuade movement to a idle core.

Then, there is the sibling flag at SMT level that normally ensures 1 task per
core for such UC

> 
> I always wonder why arch_scale_cpu_capacity() is called with NULL
> sched_domain, in scale_rt_capacity(). This way capacity might actually

Probably because until this v4.19-rcxx version, the rt scaling was done
relatively to local cpu capacity:
  capacity  = arch_scale_cpu() * scale_rt_capacity / SCHED_CAPACITY_SCALE

Whereas now, it directly returns the remaining capacity

> be more than the capacity_orig. I am always under an impression that
> capacity_orig > capacity.  Or am I misunderstanding that?

You are right, there is a bug for SMT and the patch below should fix it.
Nevertheless, we still have the problem in some other places in the code.

Subject: [PATCH] sched/fair: fix scale_rt_capacity() for SMT

Since commit:
  commit 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
scale_rt_capacity() returns the remaining capacity and not a scale factor
to apply on cpu_capacity_orig. arch_scale_cpu() is directly called by
scale_rt_capacity() so we must take the sched_domain argument

Fixes: 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..c73e1fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7481,10 +7481,10 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 	return load_idx;
 }
 
-static unsigned long scale_rt_capacity(int cpu)
+static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long max = arch_scale_cpu_capacity(sd, cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -7506,7 +7506,7 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity = scale_rt_capacity(cpu);
+	unsigned long capacity = scale_rt_capacity(sd, cpu);
 	struct sched_group *sdg = sd->groups;
 
 	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(sd, cpu);
-- 
2.7.4

> 
> -- 
> Thanks and Regards
> Srikar Dronamraju
> 

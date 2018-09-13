Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DA2C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BAC20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VOdsvY8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BAC20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeINAbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:31:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbeINAbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SU/gQ9iepIa3fr6MAHl89j7sRUzM9LC+Sd8puxLGIr8=; b=VOdsvY8EZ78mGVSo+j9Xev5Gx
        3dOJw01aklC5Z6hasQk3r4CAEqNLzkxdc0KcN3Oyh4P4zX03emMywm0n5lzhIgHVKNIIpGtICkKN1
        IrzG2jm2VsTrjnWQ//+EFEEqLvkOtSe1MwSGhYB2WVlBMe0sKPOy1YXHUu0lQx3dI5oZsfM4G7ZnA
        Gg4Ai8GaZCcWtyXbQAk3yhUUGW2A3J3O9E4YRzer1v2rAGCkIfaaA2/T/Z+hI7CCBCqm7RBm+aWPS
        IHt9v4BmR2LTABWhyj72KUkN2ZQN8u4OvE25aeo3aSBsG7WRFKi751lTBbSDtkWZXQycWapTR6bmU
        ElXY93ITg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0XAK-0003Zv-9z; Thu, 13 Sep 2018 19:20:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6D21202C1A34; Thu, 13 Sep 2018 21:20:34 +0200 (CEST)
Date:   Thu, 13 Sep 2018 21:20:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180913192034.GA24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912162427.GA24106@hirez.programming.kicks-ass.net>
 <20180912174209.GI1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912174209.GI1413@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 06:42:09PM +0100, Patrick Bellasi wrote:
> On 12-Sep 18:24, Peter Zijlstra wrote:
> > On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:

> > >  {
> > > +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > > +	int lower_bound, upper_bound;
> > > +	struct uclamp_se *uc_se;
> > > +	int result = 0;
> > 
> > I think the thing would become much more readable if you set
> > lower/upper_bound right here.

> Actually it could also make sense to have them before the mutex ;)

Indeed.

+               upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
+                       ? attr->sched_util_max
+                       : p->uclamp[UCLAMP_MAX].value;
+               
+               if (upper_bound == UCLAMP_NOT_VALID)
+                       upper_bound = SCHED_CAPACITY_SCALE;
+               if (attr->sched_util_min > upper_bound) {
+                       result = -EINVAL;
+                       goto done;
+               }
+             
+               result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
+               if (result == -ENOSPC) {
+                       pr_err(UCLAMP_ENOSPC_FMT, "MIN");
+                       goto done;
+               }
+               group_id[UCLAMP_MIN] = result;
+       }
+       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+               lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
+                       ? attr->sched_util_min
+                       : p->uclamp[UCLAMP_MIN].value;
+ 
+               if (lower_bound == UCLAMP_NOT_VALID)
+                       lower_bound = 0;
+               if (attr->sched_util_max < lower_bound ||
+                   attr->sched_util_max > SCHED_CAPACITY_SCALE) {
+                       result = -EINVAL;
+                       goto done;
+               }

That would end up soething like:

	unsigned int lower_bound = p->uclamp[UCLAMP_MIN].value;
	unsigned int upper_bound = p->uclamp[UCLAMP_MAX].value;

	if (sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
		lower_bound = attr->sched_util_min;

	if (sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
		upper_bound = attr->sched_util_max;

	if (lower_bound > upper_bound ||
	    upper_bound > SCHED_CAPACITY_MAX)
		return -EINVAL;

	mutex_lock(...);



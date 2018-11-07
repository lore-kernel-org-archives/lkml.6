Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1892085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DKjg8WYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1892085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbeKHA0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:26:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKHA0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Km3eX6cyK6wqmqeZh5Hm99t8d322ZtdYDXbuVhfuzdE=; b=DKjg8WYHfR2uZ5JAOjwxui4WE
        4rGg5ZUuveYRqHB5TTzLpwQjpBNzTHu3LYythBiDv2q8NC1N226vjMKB+EI9ZIUAjJg66pCv0TyhE
        0yE28Xc/BA3fw1ziM7QP4iuR2xcXc7Eyv1T6d9mp/slWqZU5LRFha6SAWxGLdMtldeLIHAEt/czFM
        AEyFOz3Xc68ha6DaxYdtrpTLym+uoN9l/I7plKEQgJSdx8sisPVUQ5ImNYkF+kzBUcSxIyE17WUnS
        QVJHjksyfZQx2WfnVAsbndxfK50jVge1BtiIUw5liNj7lGoFpZv6LWNH4E0+P+stZ91xQq/YklQlT
        ++tH9H7HA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKPEw-0008JB-Eg; Wed, 07 Nov 2018 14:55:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7DDA20298C0C; Wed,  7 Nov 2018 15:55:27 +0100 (CET)
Date:   Wed, 7 Nov 2018 15:55:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
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
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20181107145527.GI9761@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107133504.GQ9781@hirez.programming.kicks-ass.net>
 <20181107144809.GH14309@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107144809.GH14309@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 02:48:09PM +0000, Patrick Bellasi wrote:
> On 07-Nov 14:35, Peter Zijlstra wrote:
> You mean se_count overflow ?

Yah..

> > And I'm not really a fan of hiding that error in a define like you keep
> > doing.
> 
> The #define is not there to mask an overflow, it's there to catch the

+#define UCLAMP_MAPERR "clamp value [%u] mapping to clamp group failed\n"

Is what I was talking about.

> > What's wrong with something like:
> > 
> > 	if (SCHED_WARN(free_group_id == UCLAMP_GROUPS))
> > 		return;
> 
> Right, the flow should be:
> 
>   1. try to find a valid clamp group
>   2. if you don't find one, the data structures are corrupted
>      warn once for data corruption
>      do not map this scheduling entity and return
>   3. map the scheduling entity
> 
> Is that ok ?

That's what the proposed does.

> > and
> > 
> > > +	uc_map_new.se_count = uc_map_old.se_count + 1;
> > 
> > 	if (SCHED_WARN(!new.se_count))
> > 		new.se_count = -1;
> 
> Mmm... not sure we can recover from a corrupted refcount or an
> overflow.
> 
> What should we do on these cases, disable uclamp completely ?

You can teach put to never decrement -1 (aka. all 1s).

But its all SCHED_DEBUG stuff anyway, so who really cares.

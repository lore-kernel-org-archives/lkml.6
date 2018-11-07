Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E83CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361EC204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eq/9Z3dD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361EC204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeKGVtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:49:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeKGVtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v23055yEHBFvJw7hZgkV2moVDYtXEwtvERZbDc7AyEM=; b=Eq/9Z3dDAdDZiaU62/V+5KScA
        C6uuj5dgY2nt+cQv0t2fvuNImlFl+0x62Rp/oRCMxSYrgwIOz6NWksxDyRe0relN0O1wHHbxzJW+d
        /Xe5xQ+FuZM9UFtPidbaNQHJkWQPh04Qr3prPvhzXsg90IC0lHXZENPZUuBuMX1adxtskOQKaxMNc
        xBfocgjXi9Nt1zOypopCQb/W3HST8Y4xxKWcn7nIPQH1h+njGqomKfp6zv9y8Yq3nn/O6T0nuz5aO
        yYTtfjRUuUCqETkx+t5BhWQyTumOsdtUNS4yMJg9dGeO6/wdxfmKywKwlYk9HBNBzjBK65blB8XEx
        MhNnXZxjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKMne-0004Cb-UO; Wed, 07 Nov 2018 12:19:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCB3A20284F94; Wed,  7 Nov 2018 13:19:08 +0100 (CET)
Date:   Wed, 7 Nov 2018 13:19:08 +0100
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
Message-ID: <20181107121908.GO9781@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> +struct uclamp_se {
> +	unsigned int value		: SCHED_CAPACITY_SHIFT + 1;
> +	unsigned int group_id		: order_base_2(UCLAMP_GROUPS);

Are you sure about ob2() ? seems weird we'll end up with 0 for
UCLAMP_GROUPS==1.

> +	unsigned int mapped		: 1;
> +};

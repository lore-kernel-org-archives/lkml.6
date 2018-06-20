Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A912CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570F120872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sCEIb4dZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570F120872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeFTORu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:17:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbeFTORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YZmOzkQx23KS2w8ksxyoFyEFxXJUEXkTrldxqXASDdM=; b=sCEIb4dZo2wwINHNDKtF1ru2m
        dnr/geXd+7fDCKoe6wTqyB/xuEgV4el/YjrhyMK7lgRefdqn1OKJxP/UDLjPaPP9fvYV9RRd8I7VI
        Pxp9bOckr0dvCum33zPajjDTg0uLh+1A9iXDSmaguTNYME/bEm6YDEkh2aB8Ib2zQ5U8gq25c58jh
        tqRMQ7vk37YWDPmUuXwt6ki/nuwJV4SZumjY7rbRs+Rfayezw1nMZI7HvxQTxkP2rlnbX0bzaLwwH
        jQX6ju/4kwK1Q77JXXur0/x5TvI3puSP+UgH0BaGnppvcLKATRiyB01cXuh0fF5H63LoIzP25YcgR
        vBMMSeu3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVdvP-0003Rr-QN; Wed, 20 Jun 2018 14:17:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 474CA2029F1D5; Wed, 20 Jun 2018 16:17:30 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:17:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v10 6/9] cpuset: Make generate_sched_domains() recognize
 reserved_cpus
Message-ID: <20180620141730.GK2494@hirez.programming.kicks-ass.net>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-8-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529295249-5207-8-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:14:06PM +0800, Waiman Long wrote:
> The generate_sched_domains() function is modified to make it work
> correctly with the newly introduced reserved_cpus mask for schedule
> domains generation.

Why isn't this (and the previous) patch part of the patch that
introduces reserved_cpus? It seems weird to have this broken
intermediate state.

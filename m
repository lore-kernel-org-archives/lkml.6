Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA79AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3562086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u0IAF1St"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3562086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbeKFVBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:01:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57110 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFVBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QM4hvYp9M8WCw+TKG7IEIs4GRbuBxcFezGbs72Qu0ME=; b=u0IAF1St1Wpe7TnAmPmm8OeEr
        F+Zqs6iTZufRWi83teDoGp96/aImqTTaRTSqECKAd5Tjn9V9lKrFl4ftSFcTTD20ouR0wMBT5ClNj
        eXMhQd4JXUdndPqUCgg2I6QJTNQ0oxtv6UrZWo3C94/H7HzREFyJcJ2yhVWgflV6u5GRIInODRgK6
        0lgFiDxwBUJN6HrwZJQNyR72J7m+tX2Q9silfTl8Ga3yzHOEGcKX3Hro5atHtMum+WQmeaXnD2tzJ
        3+dXG2s19xJQ6HPZQlpAD/2bCqweNhxbpyq93SOriHpLXyYO552/uI7n1V090ddjjBGZ7Ck4L4q0l
        jYXskh5yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJze5-0005h3-OF; Tue, 06 Nov 2018 11:35:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 541532029F9FF; Tue,  6 Nov 2018 12:35:38 +0100 (CET)
Date:   Tue, 6 Nov 2018 12:35:38 +0100
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
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 04/12] cpuset: Add new v2 cpuset.sched.partition flag
Message-ID: <20181106113538.GK22431@hirez.programming.kicks-ass.net>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <1539635377-22335-5-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539635377-22335-5-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:29:29PM -0400, Waiman Long wrote:
> + * Called with cpuset_mutex held.
> + */
> +static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
> +					  struct cpumask *newmask,
> +					  struct tmpmasks *tmp)
> +{
> +	struct cpuset *parent = parent_cs(cpuset);
> +	int adding;	/* Moving cpus from effective_cpus to subparts_cpus */
> +	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
> +

I much prefer doing away with that "called with * held" comment crud and
add:

	lockdep_assert_held(&cpuset_mutex);



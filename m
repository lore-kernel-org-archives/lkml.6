Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B88BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7BF20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OAHa/VOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7BF20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeFTOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:46:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbeFTOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZKf96prADD2Hvs7n4fXf2KFm7vCLkqBMyh1u+rx+U8I=; b=OAHa/VOJ8rCQdHOeWUY+u/fPV
        TCmV0pmkhNh0Vbc/ftKRHmPuRRAfvnD0bt09Ehk01gz77jYjbtplIj4LF/vakZ9dxj2jbUTpjGe8d
        Q8wXvCU/KoDWCrjkPxEUnrr7MR5FPDrPkqNkQXE6TqQ9oAmW0UAWK2S3d6Lu5UW/yRR3MNGcBempy
        cmJuhd1lRcTbleYxXMzekk1VWVr8E6zlIaB3lEyB/97MXUVju8MCQQCHeXbRptjR9FfPv2JnGIdIX
        yB496lON0JcYlD/m3DS5+Ie+N8rs/zhG1ka+WYRslUv9LKfE2IhX2W+JwNWW2QkVGUC7xiG8VWGFN
        raC8POH+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVeND-0007HY-Jj; Wed, 20 Jun 2018 14:46:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CACAA2029F1D5; Wed, 20 Jun 2018 16:46:13 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:46:13 +0200
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
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v9 3/7] cpuset: Add cpuset.sched.load_balance flag to v2
Message-ID: <20180620144613.GP2476@hirez.programming.kicks-ass.net>
References: <1527601294-3444-1-git-send-email-longman@redhat.com>
 <1527601294-3444-4-git-send-email-longman@redhat.com>
 <20180531122638.GJ12180@hirez.programming.kicks-ass.net>
 <42cc1f44-2355-1c0c-b575-49c863303c42@redhat.com>
 <20180531152050.GK12180@hirez.programming.kicks-ass.net>
 <ebe7f0c1-b2dc-57ad-e5cb-7edf0fee4626@redhat.com>
 <20180531160857.GM12180@hirez.programming.kicks-ass.net>
 <54c607c3-e742-4da9-c89a-4ed54146e3bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c607c3-e742-4da9-c89a-4ed54146e3bd@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 12:42:20PM -0400, Waiman Long wrote:
> Thinking about isolcpus emulation, I now realize that it is more than
> just disabling load balancing. it also disables some kernel threads like
> kworker from running so that an userspace application can monopolize as
> much of a cpu as possible. Disabling kernel threads from running isn't
> that hard if it is only done once at boot time. it is trickier if we
> have to do it at run time.

Don't think it is all that difficult, we just need a notifier for when
that housekeeping thing changes and ensure that everybody who uses it
re-evaluates crap.

> Without good isolcpus emulation, disabling load balance kind of loses
> its usefulness. So I am going to take out the load_balance flag for now
> unless I hear objection otherwise.

I'm not seeing the direct link between the load_balance flag and
isolcpus emulation in the proposed stuff.

We can tie the housekeeping mask to whatever CPUs remain in the root
cgroup, couple that to that notifier and it should all just work I
think.

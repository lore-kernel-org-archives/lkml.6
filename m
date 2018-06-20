Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC5320872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U1VcqErj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC5320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbeFTOQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:16:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeFTOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FxjwbLB5V2s0tONoFTCK0nUFgqrtYJ0tDIalXSPoimU=; b=U1VcqErjcRcruXYokbrgi68/b
        1ufxFjeNhBcrK6Cq8f3gBFpcSzQHkhDmYPod1hYZRqj4oQx3qsgyxqkoQaE6h+9ghrKcAtcLXHMXw
        KpCfp6y0SpMWWPAoLT+FoX7uo04UojbhBBvydaTdW8s62U/gdyV3nYqApG4eGEaOQPZ6ja1XLPzrH
        bUZqq1uAA8LlkY2vwMkF9ZGixgqLrMXjIBuR6Nb3BsmFpBa3LkQYq+EYy3qJ/2o3iqkc8NkUDskAr
        iGf9krJdwYcRccC/1qxkTofZByl4wv4Q6LxFKydyfOkfpxENdz2bkmAeobYaTgoSfy3jTq+WnwaLM
        XxLQh6AEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVdtd-0005wm-Is; Wed, 20 Jun 2018 14:15:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C054F2029F1D5; Wed, 20 Jun 2018 16:15:38 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:15:38 +0200
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
Subject: Re: [PATCH v10 5/9] cpuset: Make sure that domain roots work
 properly with CPU hotplug
Message-ID: <20180620141538.GJ2494@hirez.programming.kicks-ass.net>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-6-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529295249-5207-6-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:14:04PM +0800, Waiman Long wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5ee5e77..6ef3516 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1626,6 +1626,13 @@ Cpuset Interface Files
>  	2) No CPU that has been distributed to child scheduling domain
>  	   roots is deleted.
>  
> +	When all the CPUs allocated to a scheduling domain are offlined,
> +	that scheduling domain will be temporaily gone and all the
> +	tasks in that scheduling domain will migrate to another one that
> +	belongs to the parent of the scheduling domain root.  When any
> +	of those offlined CPUs is onlined again, a new scheduling domain
> +	will be re-created and the tasks will be migrated back.
> +

You should mention that this is a destructive operation. If any of the
tasks had an affinity smaller than the original cgroup, that will be
gone.

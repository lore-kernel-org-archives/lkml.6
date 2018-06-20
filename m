Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8466DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367F720846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTy23Fns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367F720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFTO17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:27:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeFTO16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eMGX/vsz54Q4caqt50tNX8W2/XJte3L4ED1D2DYi3DM=; b=NTy23Fnsf7WLUGXDCU7Zw7jvu
        1M4RHZa6VjWMn91F72ExcFloyGANed3g6cq6XvBzm8yPXCl4S4CBQykPADUjAeyX2odDPvAm0QQz6
        yfxE7hqrJIbMtIDuYQO4oLeMDbDLHv/vUfqq93ZG9Y8df2nE8U2Ldw4mIGoJc+QAbYPVrMdKgmRiu
        51JP9eVTIm7Ivyx2WSRrpLyubjbWfUhd1cvrBMQXeSXBz+U1yasuhs80zQY94T1MBG5MgkAtKVHq4
        R0WtHHtz+UBNsed6zSZFwR2aYtFXi6CnktqZKGvIlj1FPjQNCs2k2jWcRWjE6tt7KUyS37zVp/8ue
        y3MAHvLCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVe5B-00065C-9M; Wed, 20 Jun 2018 14:27:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F322E2029F1D5; Wed, 20 Jun 2018 16:27:35 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:27:35 +0200
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
Subject: Re: [PATCH v10 2/9] cpuset: Add new v2 cpuset.sched.domain_root flag
Message-ID: <20180620142735.GM2494@hirez.programming.kicks-ass.net>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529295249-5207-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:14:01PM +0800, Waiman Long wrote:
> +  cpuset.sched.domain_root

Why are we calling this a domain_root and not a partition?

> +	A read-write single value file which exists on non-root
> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
> +	either "0" (off) or "1" (on).  This flag is set by the parent
> +	and is not delegatable.

You still haven't answered:

  https://lkml.kernel.org/r/20180531094943.GG12180@hirez.programming.kicks-ass.net

the question stands.

> +	If set, it indicates that the current cgroup is the root of a
> +	new scheduling domain or partition that comprises itself and
> +	all its descendants except those that are scheduling domain
> +	roots themselves and their descendants.  The root cgroup is
> +	always a scheduling domain root.
> +
> +	There are constraints on where this flag can be set.  It can
> +	only be set in a cgroup if all the following conditions are true.
> +
> +	1) The "cpuset.cpus" is not empty and the list of CPUs are
> +	   exclusive, i.e. they are not shared by any of its siblings.
> +	2) The "cpuset.cpus" is also a proper subset of the parent's
> +	   "cpuset.cpus.effective".
> +	3) The parent cgroup is a scheduling domain root.
> +	4) There is no child cgroups with cpuset enabled.  This is
> +	   for eliminating corner cases that have to be handled if such
> +	   a condition is allowed.
> +
> +	Setting this flag will take the CPUs away from the effective
> +	CPUs of the parent cgroup.  Once it is set, this flag cannot be
> +	cleared if there are any child cgroups with cpuset enabled.
> +
> +	A parent scheduling domain root cgroup cannot distribute
> +	all its CPUs to its child scheduling domain root cgroups.
> +	There must be at least one cpu left in the parent scheduling
> +	domain root cgroup.

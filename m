Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DDAC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F42A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F42A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeKFJv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:51:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeKFJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:51:57 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 55E1A86E;
        Tue,  6 Nov 2018 00:29:33 +0000 (UTC)
Date:   Mon, 5 Nov 2018 16:29:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] psi: simplify cgroup_move_task
Message-Id: <20181105162930.c381c0c8550f0334817ca419@linux-foundation.org>
In-Reply-To: <20181103183339.8669-1-olof@lixom.net>
References: <20181103183339.8669-1-olof@lixom.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Nov 2018 11:33:39 -0700 Olof Johansson <olof@lixom.net> wrote:

> The existing code triggered an invalid warning about 'rq' possibly being
> used uninitialized. Instead of doing the silly warning suppression by
> initializa it to NULL, refactor the code to bail out early instead.
> 
> Warning was:
> 
> kernel/sched/psi.c: In function ‘cgroup_move_task’:
> kernel/sched/psi.c:639:13: warning: ‘rq’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -633,38 +633,39 @@ void psi_cgroup_free(struct cgroup *cgroup)
>   */
>  void cgroup_move_task(struct task_struct *task, struct css_set *to)
>  {
> -	bool move_psi = !psi_disabled;
>  	unsigned int task_flags = 0;
>  	struct rq_flags rf;
>  	struct rq *rq;
>  
> -	if (move_psi) {
> -		rq = task_rq_lock(task, &rf);
> +	if (psi_disabled) {
> +		/*
> +		 * Lame to do this here, but the scheduler cannot be locked
> +		 * from the outside, so we move cgroups from inside sched/.
> +		 */
> +		rcu_assign_pointer(task->cgroups, to);
> +		return;
> +	}

Fair enough.

Surprisingly this doesn't increase psi.o text size.


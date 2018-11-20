Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08FC520D3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18E82148E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD71rVdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18E82148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeKUJLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeKUJLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:11:54 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFA321479;
        Tue, 20 Nov 2018 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542753625;
        bh=vpj/+/rSAmjzlSpbJTV4fppoXe5kFmh4a9nXdhunc4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YD71rVdqU3fr1lyw7LrpMwan44g8SsHsq6dzYwL2bKy2uhfJKdml7wqkvi1frhKLU
         vhWyZEpawN4iLmXSDvKT3TCyQFnZJQf9WqUAKPVyM8M6QE4md5crIgLg7wm/uqpv0z
         cyttrIK3Mkmqi+4K61Vl5WPJkUsqIN78Y/ExzF6g=
Date:   Tue, 20 Nov 2018 23:40:22 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 20/25] sched/kcpustat: Introduce vtime-aware kcpustat
 accessor
Message-ID: <20181120224021.GB22332@lerouge>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-21-git-send-email-frederic@kernel.org>
 <20181120142306.GX2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120142306.GX2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:23:06PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 14, 2018 at 03:46:04AM +0100, Frederic Weisbecker wrote:
> 
> > +void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
> > +		      u64 *user, u64 *nice, u64 *system,
> > +		      u64 *guest, u64 *guest_nice)
> > +{
> > +	struct task_struct *curr;
> > +	struct vtime *vtime;
> > +	int err;
> > +
> > +	if (!vtime_accounting_enabled()) {
> > +		kcpustat_cputime_raw(kcpustat, user, nice,
> > +				     system, guest, guest_nice);
> > +		return;
> > +	}
> > +
> > +	rcu_read_lock();
> > +
> > +	do {
> > +		curr = rcu_dereference(kcpustat->curr);
> 
> Like I explained earlier; I don't think the above is correct.
> task_struct is itself not RCU protected.

But there is at least one put_task_struct() that is enqueued as an RCU callback
on release_task(). That patchset (try to) make sure that kcpustat->curr can't
be assigned beyond that point.

Or did I misunderstand something?

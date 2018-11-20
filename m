Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CAC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F351D2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="haMfl2hT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F351D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeKTXtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:49:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKTXtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=18u5XVCo3kS5SAfQ6whsyf323fgrt7v369ex6SxcB/U=; b=haMfl2hTqIJkxcXhNukzMQuhn
        H0+ahfJIRfvCre/fFlZcjPmGoE+HrXgEv6YFE+6Ai8IeK1Ama2eQ+tR47F5EU3O+0N/8NokcA3fkb
        RLmHdHLL2kjsF6afSKVXWKaS+SfrH4Pw85OXi8gmQ55bPME0Cs+619cgdqfgTSZ2/e/bKYbldnup1
        Q+gkY/4Vgp1vlEG6hO2CoEDGUGZUcvVnaBsisdTUMS4ueW54Pb6t1BsjHKtbi0MR4kMIOUKV3qyB9
        +ZVl/viXTor3L5N2v4Gwp++uK2bIQnSk7JVwN4Cg+jVmpsqz9qWupoSBL0ljRRQzJuTdWcwdf9OmT
        xzMxGkucw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP5wL-0007vO-PZ; Tue, 20 Nov 2018 13:19:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB9262029F87F; Tue, 20 Nov 2018 14:19:39 +0100 (CET)
Date:   Tue, 20 Nov 2018 14:19:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 02/25] sched/vtime: Protect idle accounting under vtime
 seqcount
Message-ID: <20181120131939.GP2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-3-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-3-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:45:46AM +0100, Frederic Weisbecker wrote:
> Locking the seqcount on idle vtime accounting wasn't thought to be
> necessary because the readers of idle cputime don't use vtime (yet).
> 
> Now updating vtime expect the related seqcount to be locked so do it
> for locking coherency purposes.
> 
> Also idle cputime updates use vtime, but idle cputime readers use the
> traditional ad-hoc nohz time delta. We may want to consider moving
> readers to use vtime to consolidate the overall accounting scheme. The
> seqcount will be a functional requirement for it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/cputime.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 54eb945..6e74ec2 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -800,7 +800,11 @@ EXPORT_SYMBOL_GPL(vtime_guest_exit);
>  
>  void vtime_account_idle(struct task_struct *tsk)
>  {
> +	struct vtime *vtime = &tsk->vtime;
> +
> +	write_seqcount_begin(&vtime->seqcount);
>  	account_idle_time(get_vtime_delta(&tsk->vtime));
> +	write_seqcount_end(&vtime->seqcount);
>  }

So this makes switching away from idle more expensive ? Also,
vtime_account_system() has this fast-path check in there before taking
that lock, should we not do the same? Or should it be removed from
vtime_account_system() ?

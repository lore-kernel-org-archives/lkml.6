Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2D7C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2913D20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qfGv+k4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2913D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeKUAwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:52:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbeKUAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VhPpR1N+F+KoJID0WBZDbRBWt1UDCzoSktkWynVFxDw=; b=qfGv+k4LZaUwz4eas+SGpwEX0
        NVwUN+7joG9i2lwOeIM9gfr1rNgDuuAlCoYPDeq9AGMq+VzbBkb26MqrY1dIY0g6pnPXX8H+9baTg
        kQEZr10IGWKrXVB3wE6eo3OO1SKuyHVWPlA5osmMzx4lKo5PixybLrkWiTBPuHsXmvhoMSoKf9gib
        uY9xvS4GD6fILGRahsqm82MB4BXujc7CcUPQKnfJtIbOZ+H1pdUjj8gGvRYr34iqEXuAiIuphdOoZ
        uHQb+i8OG2S1qtFAbR+ht8pH4Uomuqk26J6vJC3UcOZ1JHlWSWb6jG+7KHfmOGh+XjKrS2iR9N97e
        zgT2Agowg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP6vk-0006sJ-HQ; Tue, 20 Nov 2018 14:23:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DBF42029F87F; Tue, 20 Nov 2018 15:23:06 +0100 (CET)
Date:   Tue, 20 Nov 2018 15:23:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 20/25] sched/kcpustat: Introduce vtime-aware kcpustat
 accessor
Message-ID: <20181120142306.GX2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-21-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-21-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:46:04AM +0100, Frederic Weisbecker wrote:

> +void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
> +		      u64 *user, u64 *nice, u64 *system,
> +		      u64 *guest, u64 *guest_nice)
> +{
> +	struct task_struct *curr;
> +	struct vtime *vtime;
> +	int err;
> +
> +	if (!vtime_accounting_enabled()) {
> +		kcpustat_cputime_raw(kcpustat, user, nice,
> +				     system, guest, guest_nice);
> +		return;
> +	}
> +
> +	rcu_read_lock();
> +
> +	do {
> +		curr = rcu_dereference(kcpustat->curr);

Like I explained earlier; I don't think the above is correct.
task_struct is itself not RCU protected.

> +		if (!curr) {
> +			kcpustat_cputime_raw(kcpustat, user, nice,
> +					     system, guest, guest_nice);
> +			break;
> +		}
> +
> +		vtime = &curr->vtime;
> +		err = kcpustat_vtime(kcpustat, vtime, cpu, user,
> +				     nice, system, guest, guest_nice);
> +	} while (err == -EAGAIN);
> +
> +	rcu_read_unlock();
> +}
> +
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
> -- 
> 2.7.4
> 

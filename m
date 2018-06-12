Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 73178C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219C5208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dsJU/uIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219C5208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933549AbeFLMRi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:17:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47874 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932412AbeFLMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qn6oyl5Pn0+DYt1Gyjw2+36Syq+jbVPh/f51otOu1dI=; b=dsJU/uIlqRINg0ffM+cBAXRqS
        9haBjxXhBZSrMvFIAPqDUtnLDOew6aCbKBcNCj+LrduZtEala1ldrsf22o1rXlY4mlTdW9ycQVqEs
        bvG1qF2i4Kymthbn+Ec91IsTblGlmDhRfR9ywcIzrryj2TCXwi4mtI1sQiFbXcAzvVQA8RrZ6rL2T
        jZXC3y3IKGiwcDVGV9twlJuDjQhMP8TKMVIZiHEWDwPGPxVe9sJZu2QNOW3jieaCESZzi/RvfiSqR
        iODfSPD1j115fsWj22x2xbNAvmfKd05R3YkFDBUpdCfucOaDQA+WGT9rR9rE2loJDCRw6IeTFjZbC
        UOtXphuMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSiEj-00023I-JG; Tue, 12 Jun 2018 12:17:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51697201EA7CD; Tue, 12 Jun 2018 14:17:18 +0200 (CEST)
Date:   Tue, 12 Jun 2018 14:17:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     mingo@kernel.org, gkohli@codeaurora.org, tglx@linutronix.de,
        mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 2/4] watchdog/softlockup: Replace "watchdog/%u" threads
 with cpu_stop_work
Message-ID: <20180612121718.GR12198@hirez.programming.kicks-ass.net>
References: <20180607123310.866085998@infradead.org>
 <20180607124006.158330973@infradead.org>
 <20180607142405.GO12198@hirez.programming.kicks-ass.net>
 <20180608135703.GD18941@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608135703.GD18941@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jun 08, 2018 at 03:57:04PM +0200, Oleg Nesterov wrote:

> And probably there is another problem. Both watchdog_disable(cpu) and
> watchdog_nmi_disable(cpu) assume that cpu == smp_processor_id(), this arg
> is simply ignored.
> 
> but lockup_detector_offline_cpu(cpu) is called by cpuhp_invoke_callback(),
> so in this case watchdog_disable(dying_cpu) is simply wrong.

But at this point, the cpuhp_invoke_callback() is ran from the dying CPU
still, so dying_cpu == this_cpu. I actually have a WARN in both
watchdog_{dis,en}able() to verify this assumption.

> May be we can do something like below? Then softlockup_stop_all() can simply do
> 
> 	for_each_cpu(cpu, &watchdog_allowed_mask)
> 		watchdog_disable(cpu);
> 
> watchdog_nmi_disable() is __weak, but at first glance arch/sparc/kernel/nmi.c
> does everything correctly.

I prefer to not do that and keep the current assumption. While it would
work for the disable, it the above form will not work for enable (we
really must start hrtimers on the right CPU) and that would bring some
asymmetry.


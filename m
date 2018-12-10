Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252A8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD362082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DiR5MEZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD362082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeLJOsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:48:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeLJOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I46PdXLQPzcr9rLDYSmTtJ9NEqenJEAYhW/gbZ1FkUU=; b=DiR5MEZWaI3unjmg6O+L22dHe
        DEW0TxK/+VsuUYAyfQwlks33ahMQjHcTY340O6wfHx7Sf5bzPCAFb53o9ssXhd0e9T6LWGkU5lyvP
        s6M1YFN0qfQxsEe4rCQpOFMjijWSmQVtRDsAZa36MZymECxSwCC51ila9zYJ8EsaQ7c1CbidifBiL
        DBkVozmLZFJ2UyEzz3OcADDbcwscFAjV4ADQNHoqEOk7O5bv18ko1ca5NiyflBAQQJaj3x3TkBrOC
        wMTMmhR6jRtmKabbtGOn+mKGNUJCAfB5FctvYHpv9TgqWCI5l+3OMl39e/zJ8SLC/7kQlCNNmnv22
        YUXZL/Vfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWMqh-0007dV-T1; Mon, 10 Dec 2018 14:47:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D2592075BE7B; Mon, 10 Dec 2018 15:47:54 +0100 (CET)
Date:   Mon, 10 Dec 2018 15:47:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        mark.rutland@arm.com, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de, mingo@kernel.org,
        longman@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
Message-ID: <20181210144754.GO5289@hirez.programming.kicks-ass.net>
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
 <20181210140703.GM5289@hirez.programming.kicks-ass.net>
 <9303a6cf-24af-2f31-9fbd-8c1ecdd5e4f4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9303a6cf-24af-2f31-9fbd-8c1ecdd5e4f4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 02:19:53PM +0000, Valentin Schneider wrote:
> Hi,
> 
> On 10/12/2018 14:07, Peter Zijlstra wrote:
> [...]
> > ---
> >  kernel/cpu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 91d5c38eb7e5..e1ee8caf28b5 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -313,6 +313,8 @@ void cpus_write_unlock(void)
> >  
> >  void lockdep_assert_cpus_held(void)
> >  {
> > +	if (system_state < SYSTEM_RUNNING)
> > +		return;
> >  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
> >  }
> >  
> 
> Kinda hijacking the thread here - is that something we'd want to replace 
> 
>     40fa3780bac2 ("sched/core: Take the hotplug lock in sched_init_smp()")
> 
> with?
>  

Possibly; and I have vague memories of other people running into this
same thing too.

Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389F613F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC41D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kVQccG/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC41D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeG3OLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:11:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbeG3OLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4ystWmHe7vNSfKbzUzfcHrDeBsx2W8bP/adi721Qdtg=; b=kVQccG/kG5dHjNy9yF21cWdyE
        yqXmc6Cn+t/TrkkJozb9EAQtERxgzeDfns0P7/JwZGwcya+GxEddXthLFnF21x2+oGATCHaMMf9tg
        dymMlrjtTem9wCfahEZtHBI7mtavo207AgUOkuO5RTdJPIc0dniIioyhq0sCYq5dbUnaTBawnWhoR
        QRLEiqoP+kAbgiZ4wTQ9iSKstIxQJIK66HrP1TCHOakWVN/Gxs9v7hcV+PTWfjND6FkmYUaEVij6G
        RU4LPh0gVizViRF55m4HDD7KVdi+rfEK4YylkoXXqLsXh/jcWmanJrpi1l+XvAsHrQpNbyHZ2rwtA
        JzivsMKTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk7Pe-00042v-8N; Mon, 30 Jul 2018 12:36:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EABD52026831C; Mon, 30 Jul 2018 14:36:31 +0200 (CEST)
Date:   Mon, 30 Jul 2018 14:36:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/timers] sched/clock: Enable sched clock early
Message-ID: <20180730123631.GO2476@hirez.programming.kicks-ass.net>
References: <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <tip-857baa87b6422bcfb84ed3631d6839920cb5b09d@git.kernel.org>
 <20180724195215.GA22496@roeck-us.net>
 <CAGM2reayvBs8rs6yHZYV9SvPz-tsNG_Ux8ypHguLLagiS2SkuA@mail.gmail.com>
 <CAGM2rebX7dq_ejNuSotV_0gJZY6pqro-KteXz9zzhDkjtSxaOw@mail.gmail.com>
 <ddb6bc3d-b764-3115-ebc7-54c70c967f24@roeck-us.net>
 <CAGM2reaUEOMbbtfbLY2n66jJV=ZH0Wy7GtX-tfCG62U7Uhn14g@mail.gmail.com>
 <CAGM2reYevKGh7pqvK5O7oLB5FYkuU31v7t_AMDYt0=Q+jsVEqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reYevKGh7pqvK5O7oLB5FYkuU31v7t_AMDYt0=Q+jsVEqw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:41:19PM -0400, Pavel Tatashin wrote:

> If we need it, we can surround the sched_clock_register() with
> local_irq_disable/local_irq_enable:
> 
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index cbc72c2c1fca..5015b165b55b 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -243,8 +243,11 @@ void __init generic_sched_clock_init(void)
>          * If no sched_clock() function has been provided at that point,
>          * make it the final one one.
>          */
> -       if (cd.actual_read_sched_clock == jiffy_sched_clock_read)
> +       if (cd.actual_read_sched_clock == jiffy_sched_clock_read) {
> +               local_irq_disable();
>                 sched_clock_register(jiffy_sched_clock_read, BITS_PER_LONG, HZ);
> +               local_irq_enable();
> +       }
> 
>         update_sched_clock();

I'm thinking maybe disable IRQs for that entire function, instead of
just the register call.

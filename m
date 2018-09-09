Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B78C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 09:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E27F2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 09:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E27F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeIIOZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 10:25:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34224 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeIIOZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 10:25:25 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jhtsMu0bqj22; Sun,  9 Sep 2018 11:36:18 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDD0A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdd:a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9D811EC01F6;
        Sun,  9 Sep 2018 11:36:18 +0200 (CEST)
Date:   Sun, 9 Sep 2018 11:36:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched/core.c: Avoid unused variable on non-SMP
 configs
Message-ID: <20180909093611.GA4614@zn.tnic>
References: <20180908190553.GA4573@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180908190553.GA4573@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 09:05:53PM +0200, Miguel Ojeda wrote:
> On non-SMP configs, when only one of CONFIG_{PARAVIRT,IRQ_TIME}_ACCOUNTING
> is defined, we are declaring a variable (irq_delta or steal) which
> is not used:
> 
>     kernel/sched/core.c: In function ‘update_rq_clock_task’:
>     kernel/sched/core.c:139:17: warning: unused variable ‘irq_delta’ [-Wunused-variable]
>       s64 steal = 0, irq_delta = 0;
> 
> The reason is that CONFIG_SMP guards HAVE_SCHED_AVG_IRQ, which in turn
> disables the code guarded by HAVE_SCHED_AVG_IRQ.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  kernel/sched/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 625bc9897f62..d662d1e11843 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -135,8 +135,11 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>   * In theory, the compile should just see 0 here, and optimize out the call
>   * to sched_rt_avg_update. But I don't trust it...
>   */
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> -	s64 steal = 0, irq_delta = 0;
> +#if defined(HAVE_SCHED_AVG_IRQ) || defined(CONFIG_IRQ_TIME_ACCOUNTING)
> +	s64 irq_delta = 0;
> +#endif
> +#if defined(HAVE_SCHED_AVG_IRQ) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +	s64 steal = 0;
>  #endif
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>  	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
> -- 

Alternatively, if you don't want to let the crazy ifdeffery in that
function grow even more, you can simply do:

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc9897f62..1728743360d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -136,7 +136,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
  * to sched_rt_avg_update. But I don't trust it...
  */
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-	s64 steal = 0, irq_delta = 0;
+	s64 steal __maybe_unused = 0, irq_delta = 0;
 #endif
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

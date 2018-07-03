Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E165C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AF220BED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AF220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeGCPHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:07:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51053 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933556AbeGCPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:07:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so2744043wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HwHVRiepXNmNXr/CGDFt5BbpDjLq9QSd75KFRMPax28=;
        b=tuS3UoJiuUGSXBA7OY5tdt6rDZRRBEIrXED//4GSw20J8mZmNjn13C15u2nuiQHhvo
         Gfmd1tgbQ/gtyEVWQ1KNimsRm5HtkLAGBvG2XGMg4tzO7W5+5zWvQ2ES6b7zxe3GHIRK
         62iOC9YhBxY+qgAfVjfwf501WTZIyzbFNlc2uPN+Nb366Qdex61lx4u+3XHJx9iv6ana
         ivr95LaUpVPoAsoEACSC+3YqE6EP7oaMjFkmb7zoh4lzCs4iPLRt4e+5s7EYi8P4oUMX
         VpGl2l2icRCqYGe2xnj24AqwrzIMg9E3o84n7HCzv3II4lJSXP/Ic4oPL3zplRX2+F+3
         rcMw==
X-Gm-Message-State: APt69E3enPb2EUFdN9k6JjUuvbonhOM49UJaEn+aMAh0NX7k+MmYIqE0
        6l9TqjNVFaVaIUqmKinD6h087A==
X-Google-Smtp-Source: AAOMgpc55tpzp2QkRt0IvK9MyQ+uYxGlKsxUna0s/hK4X2SnvaaZGO/yr/dcKn2wqz6kAkxeeyoJcQ==
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr6717559wmm.117.1530630434711;
        Tue, 03 Jul 2018 08:07:14 -0700 (PDT)
Received: from localhost.localdomain ([151.15.255.159])
        by smtp.gmail.com with ESMTPSA id i68-v6sm2457856wmd.30.2018.07.03.08.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:07:14 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:07:11 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [BUG] Caused by: sched/deadline: Move CPU frequency selection
 triggering points
Message-ID: <20180703150711.GA23426@localhost.localdomain>
References: <20180703105449.2a211fb2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703105449.2a211fb2@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 03/07/18 10:54, Steven Rostedt wrote:
> When looking to test SCHED_DEADLINE, I triggered a lockup. The lockup
> appears to be caused by  WARN_ON() done inside the scheduling path, and
> I'm guessing it tried to grab the rq lock and caused a deadlock (all I
> would get would be the "--- cut here ---" line, and then nothing after
> that. But a bit of playing with the printks() I figured out it was
> happening at:
> 
> assert_clock_updated() {
> 	SCHED_WARN_ON(rq->clock_update_flags < RQCF_ACT_SKIP);
> }
> 
> I bisected it down to commit e0367b126 ("sched/deadline: Move CPU
> frequency selection triggering points"). Reverting it indeed makes the
> deadlock go away.
> 
> I commented out the WARN_ON that was being triggered, and that let the
> system continue to run. I did the following change:
> 
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -914,7 +914,12 @@ static inline void assert_clock_updated(struct rq *rq)
>          * The only reason for not seeing a clock update since the
>          * last rq_pin_lock() is if we're currently skipping updates.
>          */
> -       SCHED_WARN_ON(rq->clock_update_flags < RQCF_ACT_SKIP);
> +       if (rq->clock_update_flags < RQCF_ACT_SKIP)
> +               trace_printk("WARN_ON: [%d] rq->clock_update_flags (%d) < %d)\n",
> +                       rq->cpu, rq->clock_update_flags, RQCF_ACT_SKIP);
> +       else
> +               trace_printk("GOOD: [%d] rq->clock_update_flags (%d) >= %d)\n",
> +                       rq->cpu, rq->clock_update_flags, RQCF_ACT_SKIP);
>  }
> 
> To see what was happening. I also, added trace_printk()s to all the
> updates to clock_update_flags, and ran my test again.
> 
> Here's what I got:
> 
>    deadline_test-1393  [002]   162.127132: bprint:               push_dl_task.part.40: WARN_ON: [1] rq->clock_update_flags (0) < 2)
>    deadline_test-1393  [002]   162.127133: bprint:               update_rq_clock: [1] clock was 0 now 4
>    deadline_test-1393  [002]   162.127134: bprint:               rq_clock: GOOD: [1] rq->clock_update_flags (4) >= 2)
> 
> It appears that we hit this in this path:
> 
> push_dl_task {
> 	add_running_bw() {
> 		__add_running_bw() {
> 			cpufreq_update_util() {
> 				data->func(data, rq_clock(rq), flags);
> 				rq_clock() {
> 					assert_clock_updated()
> 
> And here the clock isn't updated and we get the splat.
> 
> Reverting the stated patch works because it added the call to
> cpufreq_update_util() that does the rq_clock() at an inappropriate
> time, which causes the splat.
> 
> I'm not sure what the right answer to this is. Reverting obviously
> works, but I'm also guessing a proper placement of update_rq_clock()
> may also work. I just don't know where that placement is, as I don't
> understand the rq_clock() updates enough.
> 
> Help?

This got into tip quite recently

ecda2b66e263 ("sched/deadline: Fix missing clock update")

could you please double check that you have that in your stack?

Thanks,

- Juri

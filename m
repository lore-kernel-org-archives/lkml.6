Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B54C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8AF208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8AF208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeHBIY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:24:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35619 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHBIY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:24:26 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fl7C7-0008Hn-AY; Thu, 02 Aug 2018 08:34:43 +0200
Date:   Thu, 2 Aug 2018 08:34:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Gaurav Kohli <gkohli@codeaurora.org>
cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] timers: Clear must_forward_clk inside base lock
In-Reply-To: <1533186903-28419-1-git-send-email-gkohli@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1808020826580.1835@nanos.tec.linutronix.de>
References: <1533186903-28419-1-git-send-email-gkohli@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, Gaurav Kohli wrote:
> Timer wheel base->must_forward_clock is indicating that
> the base clock might be stale due to a long idle sleep.
> The forwarding of base clock takes place in softirq of timer

of the base clock takes place in the timer softirq ...

> or when a timer is enqueued to base which is idle. While migrate

to a base ..

> timer from remote CPU to the new base which is idle, then

See below.

> following race can happen:
> 
>   CPU0                                  CPU1
>   run_timer_softirq                     timers_dead_cpu
> 
> 					base = lock_timer_base(timer);
>   base->must_forward_clk = false
> 					if (base->must_forward_clk)
> 				         forward(base); >>skip
> 
> 					migrate_timer_list

I don't know why you insist on migrate_timer_list() being part of the
picture here.

It's only _ONE_ particular way to observe that issue. But it's not the only
way. ANY remote enqueue which hits the situation on the other CPU (CPU0 in
the example) has this problem. Tying it to migrate_timer_list() just
because you observed it that way is actively misleading. Surely you can add
a sentence that you observed it in that case, but that's supplemental
information.

Thanks,

	tglx

Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202D220851
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfB0LOf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:14:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48552 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfB0LOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:14:35 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gyxAT-000283-P4; Wed, 27 Feb 2019 12:14:29 +0100
Date:   Wed, 27 Feb 2019 12:14:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 24/32] softirq: Uninline !CONFIG_TRACE_IRQFLAGS
 __local_bh_disable_ip()
Message-ID: <20190227111429.6gt7vfvewmpt6xkf@linutronix.de>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-25-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190212171423.8308-25-frederic@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-12 18:14:15 [+0100], Frederic Weisbecker wrote:
> diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> index 240419382978..ef9e4c752f56 100644
> --- a/include/linux/bottom_half.h
> +++ b/include/linux/bottom_half.h
> @@ -28,17 +28,7 @@ enum
>  
>  #define SOFTIRQ_DATA_INIT (SOFTIRQ_ALL_MASK << SOFTIRQ_ENABLED_SHIFT)
>  
> -
> -
> -#ifdef CONFIG_TRACE_IRQFLAGS
>  extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
> -#else
> -static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> -{
> -	preempt_count_add(cnt);
> -	barrier();
> -}
> -#endif

you are aware that a simple local_bh_disable() / spin_lock_bh() gains a
function call. Let me look further how much code you are going to add
here…

Sebastian

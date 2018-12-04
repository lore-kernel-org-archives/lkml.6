Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5896C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734E52146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734E52146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLDL4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:56:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44642 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:56:49 -0500
Received: from conf.hotelmediterraneo.com ([2.228.78.71] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gU9Jm-0004wc-VF; Tue, 04 Dec 2018 12:56:47 +0100
Date:   Tue, 4 Dec 2018 12:56:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Roland Dreier <roland@purestorage.com>
cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Add heuristics to avoid switching away from
 TSC due to timer delay
In-Reply-To: <20181130211750.5571-1-roland@purestorage.com>
Message-ID: <alpine.DEB.2.21.1812041237460.8181@nanos.tec.linutronix.de>
References: <20181130211750.5571-1-roland@purestorage.com>
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

Roland,

On Fri, 30 Nov 2018, Roland Dreier wrote:
>  		delta = clocksource_delta(csnow, cs->cs_last, cs->mask);
> +
> +		/* If the cycle delta is beyond what we can safely
> +		 * convert to nsecs, and the watchdog clocksource
> +		 * suggests that we've overslept, skip checking this
> +		 * iteration to avoid marking a clocksource as
> +		 * unstable because of a severely delayed timer. */

  		 /*
		  * Proper multiline comments look like this not like
		  * the above.
		  */

That aside. Why are you trying to do heuristics on the delta?

We have way better information than that. The watchdog timer expiry time is
known and we can determine the exact delay of the timer.

The watchdog clocksource provides the maximum 'idle' time, i.e. the time
between two reads, in clocksource::max_idle_ns. That value is filled in
when the clocksource is configured.

So without doing speculation we can make an informed decision:

    elapsed = jiffies_to_nsec(jiffies - watchdog_timer->expires) +
    	      WATCHDOG_INTERVAL_NS;

    if (elapsed > wdcs->max_idle_ns) {
       	    Skip ......
    }

Hmm?

Thanks,

	tglx

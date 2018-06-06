Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SkXAaW6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02292607E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeFFMaC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:30:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeFFMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:30:00 -0400
Date: Wed, 6 Jun 2018 14:29:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180606122957.GO12258@hirez.programming.kicks-ass.net>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
 <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
 <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
 <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
 <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
 <20180606120539.GA13130@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606120539.GA13130@andrea>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 02:05:39PM +0200, Andrea Parri wrote:
> Hi Daniel, Viresh,
> 
> On Wed, Jun 06, 2018 at 04:15:28PM +0530, Viresh Kumar wrote:
> > On 06-06-18, 12:22, Daniel Lezcano wrote:
> > > (mb() are done in the atomic operations AFAICT).
> 
> To do my bit, not all atomic ops do/imply memory barriers; e.g.,
> 
>   [from Documentation/atomic_t.txt]
> 
>   - non-RMW operations [e.g., atomic_set()] are unordered
> 
>   - RMW operations that have no return value [e.g., atomic_inc()] are unordered

Quite so indeed.

> > AFAIU, it is required to make sure the operations are seen in a particular order
> > on another CPU and the compiler doesn't reorganize code to optimize it.
> > 
> > For example, in our case what if the compiler reorganizes the atomic-set
> > operation after wakeup-process ? But maybe that wouldn't happen across function
> > calls and we should be safe then.
> 
> IIUC, wake_up_process() implies a full memory barrier and a compiler barrier,
> due to:

Yes, the wakeup being a RELEASE (at least) is a fairly fundamental
property for causality. You expect the woken task to observe the
condition it got woken up on.

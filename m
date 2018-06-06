Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A8jtXw/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B147D60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeFFMFu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:05:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50625 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeFFMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:05:48 -0400
X-Google-Smtp-Source: ADUXVKLqIC6jQzZK3nbXjCGyteB46glDGh+QhjMKbOD+fpEEp6EOeCg8rIjXiQr3GnD1hmaosP/DiA==
Date: Wed, 6 Jun 2018 14:05:39 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180606120539.GA13130@andrea>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
 <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
 <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
 <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
 <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Viresh,

On Wed, Jun 06, 2018 at 04:15:28PM +0530, Viresh Kumar wrote:
> On 06-06-18, 12:22, Daniel Lezcano wrote:
> > (mb() are done in the atomic operations AFAICT).

To do my bit, not all atomic ops do/imply memory barriers; e.g.,

  [from Documentation/atomic_t.txt]

  - non-RMW operations [e.g., atomic_set()] are unordered

  - RMW operations that have no return value [e.g., atomic_inc()] are unordered


> 
> AFAIU, it is required to make sure the operations are seen in a particular order
> on another CPU and the compiler doesn't reorganize code to optimize it.
> 
> For example, in our case what if the compiler reorganizes the atomic-set
> operation after wakeup-process ? But maybe that wouldn't happen across function
> calls and we should be safe then.

IIUC, wake_up_process() implies a full memory barrier and a compiler barrier,
due to:

  raw_spin_lock_irqsave(&p->pi_lock, flags);
  smp_mb__after_spinlock();

The pattern under discussion isn't clear to me, but if you'll end up relying
on this "implicit" barrier I'd suggest documenting it with a comment.

  Andrea

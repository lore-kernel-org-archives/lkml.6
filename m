Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeEKGYw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 02:24:52 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:40949 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750805AbeEKGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 02:24:50 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: hoeun.ryu@lge.com
X-Original-SENDERIP: 10.159.138.109
X-Original-MAILFROM: hoeun.ryu@lge.com
From: "Hoeun Ryu" <hoeun.ryu@lge.com>
To: "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Hoeun Ryu'" <hoeun.ryu@lge.com.com>
Cc: <mingo@kernel.org>, <aaron.lu@intel.com>, <adobriyan@gmail.com>,
        <frederic@kernel.org>, <ying.huang@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <00fb01d3e81b$89b9c2d0$9d2d4870$@lge.com> <20180510101653.GB12217@hirez.programming.kicks-ass.net>
In-Reply-To: <20180510101653.GB12217@hirez.programming.kicks-ass.net>
Subject: RE: smp_call_function() friends and irq/bottom_half context
Date: Fri, 11 May 2018 15:24:46 +0900
Message-ID: <013801d3e8f0$c1f21820$45d64860$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGgz48akdOms0mM0V3gM5Qi+2oKGwIuF5+hpH6/3tA=
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Thursday, May 10, 2018 7:17 PM
> To: ��ȣ�� <hoeun.ryu@lge.com>
> Cc: mingo@kernel.org; aaron.lu@intel.com; adobriyan@gmail.com;
> frederic@kernel.org; ying.huang@intel.com; linux-kernel@vger.kernel.org
> Subject: Re: smp_call_function() friends and irq/bottom_half context
> 
> On Thu, May 10, 2018 at 01:58:29PM +0900, ��ȣ�� wrote:
> > Hi, all.
> >
> > I'm reading kernel/smp.c code and I found comments on smp_call_function()
> > and smp_call_function_[single/many]
> > saying that these functions are cannot be called in interrupt disabled
> > context or irq/bottom half handlers.
> >
> > I understand that there is a potential deadlock issue when caller CPU of
> > the functions is waiting for the completion of the callback of other
> CPUs.
> > But I was wondering if this is the case even when the caller CPU doesn't
> > wait for the completion (wait == 0).
> 
> IIRC yes, because csd_lock(). You can however use
> smp_call_function_single_async() with your own csd. Be very careful
> though, it is very easy to construct deadlocks.

Thank you for the explanation and the suggestion.

Would you please explain more on csd lock and irq disabled or irq/bh context ?
How can deadlocks happen when calling smp_call_function(wait=0) with irq disabled ?
How can deadlocks happen when calling smp_call_function(wait=0) from irq or bottom half context ?

I think it as 2d array like call_single_data[caller cpu][target cpu].flags.
csd_lock(csd[caller][target]) spins on the flag only when LOCKED is already set
which means that the caller CPU already called smp_call_function(wait=0)
and at the second calling of the function, the caller CPU spins on
csd_lock(csd[caller][target]) but the target CPU is still processing its callback list
(maybe processing other csd[other cpu][target]) and it does not yet process
csd[caller][target]. But the callback list will be finally flushed and LOCKED flags
is cleared of csd[caller][target] eventually ?

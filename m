Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934991AbeEJKRG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:17:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41396 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934593AbeEJKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:17:05 -0400
Date: Thu, 10 May 2018 12:16:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?utf-8?B?77+977+9yKPvv73vv70=?= <hoeun.ryu@lge.com>
Cc: mingo@kernel.org, aaron.lu@intel.com, adobriyan@gmail.com,
        frederic@kernel.org, ying.huang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: smp_call_function() friends and irq/bottom_half context
Message-ID: <20180510101653.GB12217@hirez.programming.kicks-ass.net>
References: <00fb01d3e81b$89b9c2d0$9d2d4870$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00fb01d3e81b$89b9c2d0$9d2d4870$@lge.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:58:29PM +0900, ��ȣ�� wrote:
> Hi, all.
> 
> I'm reading kernel/smp.c code and I found comments on smp_call_function()
> and smp_call_function_[single/many]
> saying that these functions are cannot be called in interrupt disabled
> context or irq/bottom half handlers.
> 
> I understand that there is a potential deadlock issue when caller CPU of
> the functions is waiting for the completion of the callback of other CPUs.
> But I was wondering if this is the case even when the caller CPU doesn't
> wait for the completion (wait == 0).

IIRC yes, because csd_lock(). You can however use
smp_call_function_single_async() with your own csd. Be very careful
though, it is very easy to construct deadlocks.

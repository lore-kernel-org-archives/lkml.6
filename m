Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCUKOH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:14:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36680 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeCUKOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:14:06 -0400
Date: Wed, 21 Mar 2018 11:14:01 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Qixuan Wu <qixuan.wu@linux.alibaba.com>
cc: John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: About dmesg time and uptime
In-Reply-To: <5AB13ECE.2090005@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1803211107560.3754@nanos.tec.linutronix.de>
References: <5AB13ECE.2090005@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018, Qixuan Wu wrote:
>    I have a doubt in kernel 4.9 about dmesg time and uptime. Would you
> please to help to clarify whether it's bug or not.
>    Below is our log. The dmesg time second is large than uptime second.
> 
> [25049978.919097] bond0.700: port 9(veth4e77160) entered forwarding state
> [25049978.926455] bond0.700: port 9(veth4e77160) entered forwarding state
> [chenggang.qcg@e80g10383 ~]$ cat /proc/uptime
> 25023128.55 1416627078.34
> 
>    I found dmesg second is just directly get from tsc (x86 64 platform).
> While the uptime is get by a complicated computation.

Well it's not a complicated computation. It simply uses the timekeeping
infrastructure.

The dmesg timestamp comes from sched_clock() which is TSC based and it is
using a coarse calibration value obtained at boot time.

The timekeeping infrastructure is using a fine grained calibration which
can be further adjusted by NTP/PTP.

So yes, this can drift apart. The error from your numbers above is about
0.1% which is not an unusual value.

There is a patch is mainline which feed the fine grained calibration value
into sched_clock to make this slighty better, but it wont be perfect. See:

     aa7b630ea023 ("x86/tsc: Feed refined TSC calibration into sched_clock()")

There is also an effort to base dmesg time stamps on monotonic time, which
will fix this problem completely, but that's still work in progress.

Thanks,

	tglx

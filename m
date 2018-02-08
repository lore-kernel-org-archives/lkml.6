Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeBHA53 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 19:57:29 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:42599 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeBHA51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 19:57:27 -0500
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Thu, 8 Feb 2018 09:57:24 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: jolsa@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: A problem about 'perf sched latency'
Message-ID: <20180208005724.GB24686@sejong>
References: <20180206135002.sn32vfqgfz326rcb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180206135002.sn32vfqgfz326rcb@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Feb 06, 2018 at 09:50:02PM +0800, Du, Changbin wrote:
> Hello all,
> I am using perf sched tool to analyzer sched data on my machine. But it seems that 
> 'perf sched latency' report incorrect 'Switches'. What I did is as below.
> 
> First, record...
> $ sudo perf sched record time pi 2000000 > /dev/null
> 
> Then check statistics. It says 'pi' only sched-in 1 time.
> $ sudo ./perf sched latency | grep pi
>   compiz:4054           |      6.389 ms |       30 | avg:    0.023 ms | max:    0.122 ms | max at:  94546.021080 s
>   pi:4059               |   2083.241 ms |        1 | avg:    0.007 ms | max:    0.007 ms | max at:  94545.201435 s
> 
> But the sched event show 'pi' has been sched-in 7 times.
> $ sudo ./perf sched script | grep pi:
>               pi  4059 [001] 94545.820858:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1:32237 [120]
>      kworker/1:1 32237 [001] 94545.820868:       sched:sched_switch: kworker/1:1:32237 [120] R ==> pi:4059 [120]
>               pi  4059 [001] 94545.885412:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1H:320 [100]
>     kworker/1:1H   320 [001] 94545.885419:       sched:sched_switch: kworker/1:1H:320 [100] R ==> pi:4059 [120]
>               pi  4059 [001] 94545.907869:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1H:320 [100]
>     kworker/1:1H   320 [001] 94545.907875:       sched:sched_switch: kworker/1:1H:320 [100] R ==> pi:4059 [120]
>               pi  4059 [001] 94545.908104:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1H:320 [100]
>     kworker/1:1H   320 [001] 94545.908108:       sched:sched_switch: kworker/1:1H:320 [100] R ==> pi:4059 [120]
>               pi  4059 [001] 94545.916135:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1H:320 [100]
>     kworker/1:1H   320 [001] 94545.916154:       sched:sched_switch: kworker/1:1H:320 [100] R ==> pi:4059 [120]
>               pi  4059 [001] 94546.812856:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1:32237 [120]
>      kworker/1:1 32237 [001] 94546.813148:       sched:sched_switch: kworker/1:1:32237 [120] R ==> pi:4059 [120]
>               pi  4059 [001] 94546.885227:       sched:sched_switch: pi:4059 [120] S ==> i915/signal:1:207 [98]
>    i915/signal:1   207 [001] 94546.885232:       sched:sched_switch: i915/signal:1:207 [98] D ==> pi:4059 [120]
>               pi  4059 [001] 94547.285049:       sched:sched_switch: pi:4059 [120] x ==> swapper/1:0 [120]
> 
> Does anyone know why? Thank you! :)

It seems your data doesn't have wakeup event which is required by the
'perf sched latency'.

Thanks,
Namhyung


> 
> -- 
> Thanks,
> Changbin Du
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B0C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FE620651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bOR13m+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FE620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeJXG6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:58:55 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:33498 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeJXG6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:58:55 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C75A910C1B91;
        Tue, 23 Oct 2018 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540334013; bh=Sj3KgEgGoHRblkr7AOvfshDGF3MZN1p3tiCcb6WJZks=;
        h=From:To:CC:Subject:Date:References:From;
        b=bOR13m+dNWzQx+LYx0UR+8FQEDElkNxxkKh9MFvx+tMOyzfJRyIBoWK7PHWeXJOxp
         Ry1XvNhHt06nlhtyyZx2NRmLx5EPhC8/TCNaJnxADIOwl3LFWfSKsYD+o3v9+sA8XL
         1lj+f0Zl+hlJqxSg+sKWVAl9hypPlDkLPQsn4ez8u+jDBT3OjDLwK3ijM6uoNSPYag
         nbu/Xo/4MlHxX1DAo7xMdMy140GBNk33+frHldvf6R2SE+MlIftlFPtgwfd4epI8Vz
         xbcvJFOhfgJqlYqaJ3hJoa5QI3ZjacUeahn5ksUs/tSMmCvzb/35oeRj2c9ZdR7F8H
         dBS/2lqxOlH+w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3ECCE3E08;
        Tue, 23 Oct 2018 15:33:31 -0700 (PDT)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 23 Oct 2018 15:33:31 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Topic: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Index: AQHUZgzPejIboRhY8EuB047asCCktg==
Date:   Tue, 23 Oct 2018 22:33:30 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B0B1A07@US01WEMBX2.internal.synopsys.com>
References: <20181017113020.7551-1-abrodkin@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 04:30 AM, Alexey Brodkin wrote:=0A=
> It turned out we used to use default implementation of sched_clock()=0A=
> from kernel/sched/clock.c which was as precise as 1/HZ, i.e.=0A=
> by default we had 10 msec granularity of time measurement.=0A=
>=0A=
> Now given ARC built-in timers are clocked with the same frequency as=0A=
> CPU cores we may get much higher precision of time tracking.=0A=
>=0A=
> Thus we switch to generic sched_clock which really reads ARC hardware=0A=
> counters.=0A=
>=0A=
> This is especially helpful for measuring short events.=0A=
> That's what we used to have:=0A=
> ------------------------------>8------------------------=0A=
> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null=0A=
>=0A=
>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/h=
ello':=0A=
>=0A=
>          10.000000      task-clock (msec)         #    2.832 CPUs utilize=
d=0A=
>                  1      context-switches          #    0.100 K/sec=0A=
>                  1      cpu-migrations            #    0.100 K/sec=0A=
>                 63      page-faults               #    0.006 M/sec=0A=
>            3049480      cycles                    #    0.305 GHz=0A=
>            1091259      instructions              #    0.36  insn per cyc=
le=0A=
>             256828      branches                  #   25.683 M/sec=0A=
>              27026      branch-misses             #   10.52% of all branc=
hes=0A=
>=0A=
>        0.003530687 seconds time elapsed=0A=
>=0A=
>        0.000000000 seconds user=0A=
>        0.010000000 seconds sys=0A=
> ------------------------------>8------------------------=0A=
>=0A=
> And now we'll see:=0A=
> ------------------------------>8------------------------=0A=
> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null=0A=
>=0A=
>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/h=
ello':=0A=
>=0A=
>           3.004322      task-clock (msec)         #    0.865 CPUs utilize=
d=0A=
>                  1      context-switches          #    0.333 K/sec=0A=
>                  1      cpu-migrations            #    0.333 K/sec=0A=
>                 63      page-faults               #    0.021 M/sec=0A=
>            2986734      cycles                    #    0.994 GHz=0A=
>            1087466      instructions              #    0.36  insn per cyc=
le=0A=
>             255209      branches                  #   84.947 M/sec=0A=
>              26002      branch-misses             #   10.19% of all branc=
hes=0A=
>=0A=
>        0.003474829 seconds time elapsed=0A=
>=0A=
>        0.003519000 seconds user=0A=
>        0.000000000 seconds sys=0A=
> ------------------------------>8------------------------=0A=
>=0A=
> Note how much more meaningful is the second output - time spent for=0A=
> execution pretty much matches number of cycles spent (we're running=0A=
> @ 1GHz here).=0A=
>=0A=
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>=0A=
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>=0A=
> Cc: Vineet Gupta <vgupta@synopsys.com>=0A=
> Cc: Thomas Gleixner <tglx@linutronix.de>=0A=
> ---=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
@Daniel is this going via timer tree or you want me to pick it up.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=

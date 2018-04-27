Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeD0FOZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:14:25 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45824 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeD0FOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:14:23 -0400
X-Google-Smtp-Source: AB8JxZprJpeI4ycI0zlIVN48ljVIkLsVrPrP1It8BJK/r/aq3l+keIDcIHkcDlTm7ZHj5eEDQHeJdg==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: testing io.low limit for blk-throttle
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <b8c4c2b1-dafa-703b-f322-0ea3bbc768f1@gmail.com>
Date: Fri, 27 Apr 2018 07:14:16 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>
Message-Id: <6D0FF312-8A23-425F-B2D7-9F220887FB31@linaro.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
 <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
 <18accc1e-c7b3-86a7-091b-1d4b631fcd4a@gmail.com>
 <536A1B1D-575F-4193-ADA6-BA832AEC7179@linaro.org>
 <871b8d16-a172-af68-1aae-92ae55c0cce7@gmail.com>
 <5FEFF82B-4160-4F00-A60A-D3A6D9DDE66C@linaro.org>
 <b8c4c2b1-dafa-703b-f322-0ea3bbc768f1@gmail.com>
To: Joseph Qi <jiangqi903@gmail.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3R5EWJP013451



> Il giorno 27 apr 2018, alle ore 05:27, Joseph Qi <jiangqi903@gmail.com> ha scritto:
> 
> Hi Paolo,
> 
> On 18/4/27 01:27, Paolo Valente wrote:
>> 
>> 
>>> Il giorno 25 apr 2018, alle ore 14:13, Joseph Qi <jiangqi903@gmail.com> ha scritto:
>>> 
>>> Hi Paolo,
>>> 
>> 
>> Hi Joseph
>> 
>>> ...
>>> Could you run blktrace as well when testing your case? There are several
>>> throtl traces to help analyze whether it is caused by frequently
>>> upgrade/downgrade.
>> 
>> Certainly.  You can find a trace attached.  Unfortunately, I'm not
>> familiar with the internals of blk-throttle and low limit, so, if you
>> want me to analyze the trace, give me some hints on what I have to
>> look for.  Otherwise, I'll be happy to learn from your analysis.
>> 
> 
> I've taken a glance at your blktrace attached. It is only upgrade at first and
> then downgrade (just adjust limit, not to LIMIT_LOW) frequently.
> But I don't know why it always thinks throttle group is not idle.
> 
> For example:
> fio-2336  [004] d...   428.458249:   8,16   m   N throtl avg_idle=90, idle_threshold=1000, bad_bio=10, total_bio=84, is_idle=0, scale=9
> fio-2336  [004] d...   428.458251:   8,16   m   N throtl downgrade, scale 4
> 
> In throtl_tg_is_idle():
> is_idle = ... ||
> 	(tg->latency_target && tg->bio_cnt &&
> 	 tg->bad_bio_cnt * 5 < tg->bio_cnt);
> 
> It should be idle and allow run more bandwidth. But here the result shows not
> idle (is_idle=0). I have to do more investigation to figure it out why. 
> 

Hi Joseph,
actually this doesn't surprise me much, for this scenario I expected
exactly that blk-throttle would have considered the random-I/O group,
for most of the time,
1) non idle,
2) above the 100usec target latency, and
3) below low limit,

In fact,
1) The group can evidently issue I/O at a much higher rate than that
received, so, immediately after its last pending I/O has been served,
the group issues new I/O; in the end, it is is non idle most of the
time
2) To try to enforce the 10MB/s limit, blk-throttle necessarily makes
the group oscillate around 10MB/s, which means that the group is
frequently below limit (this would not have held only if the group had
actually received much more than 10MB/s, but it is not so)
3) For each of the 4k random I/Os of the group, the time needed by the
drive to serve that I/O is already around 40-50usec.  So, since the
group is of course not constantly in service, it is very easy that,
because of throttling, the latency of most I/Os of the group goes
beyond 100usec.

But, as it is often the case for me, I might have simply misunderstood
blk-throttle parameters, and I might be just wrong here.

Thanks,
Paolo

> You can also filter these logs using:
> grep throtl trace | grep -E 'upgrade|downgrade|is_idle'
> 
> Thanks,
> Joseph

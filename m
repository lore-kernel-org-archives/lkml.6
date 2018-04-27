Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757251AbeD0D14 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 23:27:56 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:45115 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeD0D1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 23:27:54 -0400
X-Google-Smtp-Source: AB8JxZohGOTvU0comF5G+YRVMQiuY3SKVmBwv0Y9XWoUJUJ0NLjN81uqGu+Pc6Gha+f36FkReD5QJA==
Subject: Re: testing io.low limit for blk-throttle
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
 <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
 <18accc1e-c7b3-86a7-091b-1d4b631fcd4a@gmail.com>
 <536A1B1D-575F-4193-ADA6-BA832AEC7179@linaro.org>
 <871b8d16-a172-af68-1aae-92ae55c0cce7@gmail.com>
 <5FEFF82B-4160-4F00-A60A-D3A6D9DDE66C@linaro.org>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <b8c4c2b1-dafa-703b-f322-0ea3bbc768f1@gmail.com>
Date: Fri, 27 Apr 2018 11:27:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5FEFF82B-4160-4F00-A60A-D3A6D9DDE66C@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On 18/4/27 01:27, Paolo Valente wrote:
> 
> 
>> Il giorno 25 apr 2018, alle ore 14:13, Joseph Qi <jiangqi903@gmail.com> ha scritto:
>>
>> Hi Paolo,
>>
> 
> Hi Joseph
> 
>> ...
>> Could you run blktrace as well when testing your case? There are several
>> throtl traces to help analyze whether it is caused by frequently
>> upgrade/downgrade.
> 
> Certainly.  You can find a trace attached.  Unfortunately, I'm not
> familiar with the internals of blk-throttle and low limit, so, if you
> want me to analyze the trace, give me some hints on what I have to
> look for.  Otherwise, I'll be happy to learn from your analysis.
> 

I've taken a glance at your blktrace attached. It is only upgrade at first and
then downgrade (just adjust limit, not to LIMIT_LOW) frequently.
But I don't know why it always thinks throttle group is not idle.

For example:
fio-2336  [004] d...   428.458249:   8,16   m   N throtl avg_idle=90, idle_threshold=1000, bad_bio=10, total_bio=84, is_idle=0, scale=9
fio-2336  [004] d...   428.458251:   8,16   m   N throtl downgrade, scale 4

In throtl_tg_is_idle():
is_idle = ... ||
	(tg->latency_target && tg->bio_cnt &&
	 tg->bad_bio_cnt * 5 < tg->bio_cnt);

It should be idle and allow run more bandwidth. But here the result shows not
idle (is_idle=0). I have to do more investigation to figure it out why. 

You can also filter these logs using:
grep throtl trace | grep -E 'upgrade|downgrade|is_idle'

Thanks,
Joseph

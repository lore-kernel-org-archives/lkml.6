Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757268AbeD0CKZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:10:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54910 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757142AbeD0CKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:10:23 -0400
Subject: Re: testing io.low limit for blk-throttle
To: Tejun Heo <tj@kernel.org>, Joseph Qi <jiangqi903@gmail.com>
Cc: Paolo Valente <paolo.valente@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
 <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
 <18accc1e-c7b3-86a7-091b-1d4b631fcd4a@gmail.com>
 <536A1B1D-575F-4193-ADA6-BA832AEC7179@linaro.org>
 <20180426183200.GK1911913@devbig577.frc2.facebook.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <9aee3b22-2600-b16b-d944-f3a09089664f@oracle.com>
Date: Fri, 27 Apr 2018 10:09:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426183200.GK1911913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804270019
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun and Joseph

On 04/27/2018 02:32 AM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 24, 2018 at 02:12:51PM +0200, Paolo Valente wrote:
>> +Tejun (I guess he might be interested in the results below)
> 
> Our experiments didn't work out too well either.  At this point, it
> isn't clear whether io.low will ever leave experimental state.  We're
> trying to find a working solution.

Would you please take a look at the following two patches.

https://marc.info/?l=linux-block&m=152325456307423&w=2
https://marc.info/?l=linux-block&m=152325457607425&w=2

In addition, when I tested blk-throtl io.low on NVMe card, I always got
even if the iops has been lower than io.low limit for a while, but the
due to group is not idle, the downgrade always fails.

       tg->latency_target && tg->bio_cnt &&
		tg->bad_bio_cnt * 5 < tg->bio_cn

the latency always looks well even the sum of two groups's iops has reached the top.
so I disable this check on my test, plus the 2 patches above, the io.low
could basically works.

My NVMe card's max bps is ~600M, and max iops is ~160k.
Here is my config
io.low riops=50000 wiops=50000 rbps=209715200 wbps=209715200 idle=200 latency=10
io.max riops=150000
There are two cgroups in my test, both of them have same config.

In addition, saying "basically work" is due to the iops of the two cgroup will jump up and down.
such as, I launched one fio test per cgroup, the iops will wave as following:

group0   30k  50k   70k   60k  40k
group1   120k 100k  80k   90k  110k

however, if I launched two fio tests only in one cgroup, the iops of two test could stay 
about 70k~80k.

Could help to explain this scenario ?

Thanks in advance
Jianchao

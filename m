Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753749AbeEWB7S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 21:59:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55434 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbeEWB7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 21:59:16 -0400
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <163c5760-cf0e-faea-ee4e-ac5d688310fe@applied-asynchrony.com>
 <00e5dfd4-d3a2-b008-3d8b-390a788f61c9@kernel.dk>
 <7c93b85f-6a02-bdcf-5e92-a9533500df20@kernel.dk>
 <fc26ef08-2e2a-3b2d-2190-8419307b243e@applied-asynchrony.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d5c15cb9-cef9-3d05-8895-b826fa1c7f01@oracle.com>
Date: Wed, 23 May 2018 09:59:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fc26ef08-2e2a-3b2d-2190-8419307b243e@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8901 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805230015
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens and Holger

Thank for your kindly response.
That's really appreciated.

I will post next version based on Jens' patch.

Thanks
Jianchao

On 05/23/2018 02:32 AM, Holger Hoffstätte wrote:
>>>> This looks great but prevents kyber from being built as module,
>>>> which is AFAIK supposed to work (and works now):
>>>>
>>>> ..
>>>>   CC [M]  block/kyber-iosched.o
>>>>   Building modules, stage 2.
>>>>   MODPOST 313 modules
>>>> ERROR: "bio_attempt_back_merge" [block/kyber-iosched.ko] undefined!
>>>> ERROR: "bio_attempt_front_merge" [block/kyber-iosched.ko] undefined!
>>>> ERROR: "bio_attempt_discard_merge" [block/kyber-iosched.ko] undefined!
>>>> ERROR: "blk_try_merge" [block/kyber-iosched.ko] undefined!
>>>> ERROR: "blk_rq_merge_ok" [block/kyber-iosched.ko] undefined!
>>>> ..
>>>>
>>>> It does build fine when compiled in, obviously. :)
>>> It's basically duplicating the contents of blk_attempt_plug_merge().
>>> I would suggest abstracting out the list loop and merge check
>>> into a helper, that could then both be called from kyber and the
>>> plug merge function.
>> See attached, prep patch and yours rebased on top of it.
> That was quick. :)
> 
> Applies smoothly on top of my 4.16++ tree, now builds correctly as
> module and is reproducibly (slightly) faster even on my pedestrian
> SATA SSDs, now on par or occasionally even faster than mq-deadline.
> What's not to like? So:
> 
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

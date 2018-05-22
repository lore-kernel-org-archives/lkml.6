Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeEVQbl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:31:41 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:37954 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbeEVQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:31:35 -0400
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <163c5760-cf0e-faea-ee4e-ac5d688310fe@applied-asynchrony.com>
Date: Tue, 22 May 2018 18:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/18 16:48, Jianchao Wang wrote:
> Currently, kyber is very unfriendly with merging. kyber depends
> on ctx rq_list to do merging, however, most of time, it will not
> leave any requests in ctx rq_list. This is because even if tokens
> of one domain is used up, kyber will try to dispatch requests
> from other domain and flush the rq_list there.
> 
> To improve this, we setup kyber_ctx_queue (kcq) which is similar
> with ctx, but it has rq_lists for different domain and build same
> mapping between kcq and khd as the ctx & hctx. Then we could merge,
> insert and dispatch for different domains separately. If one domain
> token is used up, the requests could be left in the rq_list of
> that domain and maybe merged with following io.
> 
> Following is my test result on machine with 8 cores and NVMe card
> INTEL SSDPEKKR128G7
> 
> fio size=256m ioengine=libaio iodepth=64 direct=1 numjobs=8
> seq/random
> +------+---------------------------------------------------------------+
> |patch?| bw(MB/s) |   iops    | slat(usec) |    clat(usec)   |  merge  |
> +----------------------------------------------------------------------+
> | w/o  |  606/612 | 151k/153k |  6.89/7.03 | 3349.21/3305.40 |   0/0   |
> +----------------------------------------------------------------------+
> | w/   | 1083/616 | 277k/154k |  4.93/6.95 | 1830.62/3279.95 | 223k/3k |
> +----------------------------------------------------------------------+
> When set numjobs to 16, the bw and iops could reach 1662MB/s and 425k
> on my platform.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>

<snip>

This looks great but prevents kyber from being built as module,
which is AFAIK supposed to work (and works now):

..
  CC [M]  block/kyber-iosched.o
  Building modules, stage 2.
  MODPOST 313 modules
ERROR: "bio_attempt_back_merge" [block/kyber-iosched.ko] undefined!
ERROR: "bio_attempt_front_merge" [block/kyber-iosched.ko] undefined!
ERROR: "bio_attempt_discard_merge" [block/kyber-iosched.ko] undefined!
ERROR: "blk_try_merge" [block/kyber-iosched.ko] undefined!
ERROR: "blk_rq_merge_ok" [block/kyber-iosched.ko] undefined!
..

It does build fine when compiled in, obviously. :)

cheers,
Holger

Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8505FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541BF214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeLZNZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:25:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:37390 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeLZNZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:25:49 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gc9Bz-0004vm-4R; Wed, 26 Dec 2018 16:25:47 +0300
Subject: Re: [PATCH v2 0/5] fuse: Interrupt-related optimizations and
 improvements
To:     miklos@szeredi.hu
References: <154166765576.10655.15178401490817622677.stgit@localhost.localdomain>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <b0ff11bd-49ea-6073-3c06-80a57275936a@virtuozzo.com>
Date:   Wed, 26 Dec 2018 16:25:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154166765576.10655.15178401490817622677.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 08.11.2018 12:05, Kirill Tkhai wrote:
> v2: Changes in [1-2,5] patches. The biggest change is in [5],
>     where repeater FR_INTERRUPTED assignment is removed.
> 
> This patchset consists of several parts. Patches [1-2] optimize
> likely case of request_end(), and make this function to take
> fiq->waitq.lock only, when it is really needed. This improves
> performance of this function completes.
> 
> Patch 3 makes request_end() to call wake_up() only for not
> background requests (background requests never wait answer),
> and this optimizes this function a bit more
> 
> Patches [4-5] makes code to check userspace requests correct
> interrupt id to requeue (whether we've sent this interrupt).
> 
> ---
> 
> Kirill Tkhai (5):
>       fuse: Kill fasync only if interrupt is queued in queue_interrupt()
>       fuse: Optimize request_end() by not taking fiq->waitq.lock
>       fuse: Wake up req->waitq of only not background requests in request_end()
>       fuse: Do some refactoring in fuse_dev_do_write()
>       fuse: Verify userspace asks to requeue interrupt that we really sent
> 
> 
>  fs/fuse/dev.c |   57 ++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 19 deletions(-)
> 
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 

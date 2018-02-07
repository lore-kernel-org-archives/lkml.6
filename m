Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeBGWSW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:18:22 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:34778 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeBGWSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:18:20 -0500
X-Google-Smtp-Source: AH8x226KS9xRXJFNN73gXwpEHPFHl9ZdWbPWt5KSxIcsMBE+2k4wUxg8buG84L02s8aw4KPuBTcLFA==
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        alban.browaeys@gmail.com, ming.lei@redhat.com, ivan@ludios.org,
        169364@studenti.unimore.it, holger@applied-asynchrony.com,
        efault@gmx.de, Serena Ziviani <ziviani.serena@gmail.com>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <17c57205-7cc0-5577-0322-dc35914e50e5@kernel.dk>
Date: Wed, 7 Feb 2018 15:18:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <20180207211920.6343-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/18 2:19 PM, Paolo Valente wrote:
> Commit 'a6a252e64914 ("blk-mq-sched: decide how to handle flush rq via
> RQF_FLUSH_SEQ")' makes all non-flush re-prepared requests for a device
> be re-inserted into the active I/O scheduler for that device. As a
> consequence, I/O schedulers may get the same request inserted again,
> even several times, without a finish_request invoked on that request
> before each re-insertion.
> 
> This fact is the cause of the failure reported in [1]. For an I/O
> scheduler, every re-insertion of the same re-prepared request is
> equivalent to the insertion of a new request. For schedulers like
> mq-deadline or kyber, this fact causes no harm. In contrast, it
> confuses a stateful scheduler like BFQ, which keeps state for an I/O
> request, until the finish_request hook is invoked on the request. In
> particular, BFQ may get stuck, waiting forever for the number of
> request dispatches, of the same request, to be balanced by an equal
> number of request completions (while there will be one completion for
> that request). In this state, BFQ may refuse to serve I/O requests
> from other bfq_queues. The hang reported in [1] then follows.
> 
> However, the above re-prepared requests undergo a requeue, thus the
> requeue_request hook of the active elevator is invoked for these
> requests, if set. This commit then addresses the above issue by
> properly implementing the hook requeue_request in BFQ.

Thanks, applied.

-- 
Jens Axboe

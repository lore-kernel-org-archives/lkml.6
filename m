Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBIRRl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:17:41 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:46098 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeBIRRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:17:38 -0500
X-Google-Smtp-Source: AH8x22434ctwbWW7v0IpWPRoeZsjhQvD12MhoH/qWM6a7Wi3VJASRlWdESAQMpLeH1cfmFZJv7u/vw==
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>,
        169364@studenti.unimore.it, holger@applied-asynchrony.com,
        efault@gmx.de, Serena Ziviani <ziviani.serena@gmail.com>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
 <17c57205-7cc0-5577-0322-dc35914e50e5@kernel.dk>
 <34041F0A-F460-4736-9A6C-76D861EA0070@linaro.org>
 <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <760ae85e-be4c-cf13-53f2-579ab4646b09@kernel.dk>
Date: Fri, 9 Feb 2018 10:17:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/18 6:21 AM, Oleksandr Natalenko wrote:
> Hi.
> 
> 08.02.2018 08:16, Paolo Valente wrote:
>>> Il giorno 07 feb 2018, alle ore 23:18, Jens Axboe <axboe@kernel.dk> ha 
>>> scritto:
>>>
>>> On 2/7/18 2:19 PM, Paolo Valente wrote:
>>>> Commit 'a6a252e64914 ("blk-mq-sched: decide how to handle flush rq 
>>>> via
>>>> RQF_FLUSH_SEQ")' makes all non-flush re-prepared requests for a 
>>>> device
>>>> be re-inserted into the active I/O scheduler for that device. As a
>>>> consequence, I/O schedulers may get the same request inserted again,
>>>> even several times, without a finish_request invoked on that request
>>>> before each re-insertion.
>>>>
>>>> This fact is the cause of the failure reported in [1]. For an I/O
>>>> scheduler, every re-insertion of the same re-prepared request is
>>>> equivalent to the insertion of a new request. For schedulers like
>>>> mq-deadline or kyber, this fact causes no harm. In contrast, it
>>>> confuses a stateful scheduler like BFQ, which keeps state for an I/O
>>>> request, until the finish_request hook is invoked on the request. In
>>>> particular, BFQ may get stuck, waiting forever for the number of
>>>> request dispatches, of the same request, to be balanced by an equal
>>>> number of request completions (while there will be one completion for
>>>> that request). In this state, BFQ may refuse to serve I/O requests
>>>> from other bfq_queues. The hang reported in [1] then follows.
>>>>
>>>> However, the above re-prepared requests undergo a requeue, thus the
>>>> requeue_request hook of the active elevator is invoked for these
>>>> requests, if set. This commit then addresses the above issue by
>>>> properly implementing the hook requeue_request in BFQ.
>>>
>>> Thanks, applied.
>>>
>>
>> I Jens,
>> I forgot to add
>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>> in the patch.
>>
>> Is it still possible to add it?
>>
> 
> In addition to this I think it should be worth considering CC'ing Greg 
> to pull this fix into 4.15 stable tree.

I can't add the tested-by anymore, but it's easy enough to target for
stable after-the-fact.


-- 
Jens Axboe

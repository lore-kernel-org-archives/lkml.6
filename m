Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeBHHRB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:17:01 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36232 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHHQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:16:58 -0500
X-Google-Smtp-Source: AH8x225+lzntr7N/tCRKX5tvuf9mSnuzXhcdNZMMoeTJlG2i9KT/3OgmeoBmsTlixAd5EbCtASs9Gg==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <17c57205-7cc0-5577-0322-dc35914e50e5@kernel.dk>
Date: Thu, 8 Feb 2018 08:16:51 +0100
Cc: linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>,
        169364@studenti.unimore.it, holger@applied-asynchrony.com,
        efault@gmx.de, Serena Ziviani <ziviani.serena@gmail.com>
Message-Id: <34041F0A-F460-4736-9A6C-76D861EA0070@linaro.org>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
 <17c57205-7cc0-5577-0322-dc35914e50e5@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w187H7iB019783



> Il giorno 07 feb 2018, alle ore 23:18, Jens Axboe <axboe@kernel.dk> ha scritto:
> 
> On 2/7/18 2:19 PM, Paolo Valente wrote:
>> Commit 'a6a252e64914 ("blk-mq-sched: decide how to handle flush rq via
>> RQF_FLUSH_SEQ")' makes all non-flush re-prepared requests for a device
>> be re-inserted into the active I/O scheduler for that device. As a
>> consequence, I/O schedulers may get the same request inserted again,
>> even several times, without a finish_request invoked on that request
>> before each re-insertion.
>> 
>> This fact is the cause of the failure reported in [1]. For an I/O
>> scheduler, every re-insertion of the same re-prepared request is
>> equivalent to the insertion of a new request. For schedulers like
>> mq-deadline or kyber, this fact causes no harm. In contrast, it
>> confuses a stateful scheduler like BFQ, which keeps state for an I/O
>> request, until the finish_request hook is invoked on the request. In
>> particular, BFQ may get stuck, waiting forever for the number of
>> request dispatches, of the same request, to be balanced by an equal
>> number of request completions (while there will be one completion for
>> that request). In this state, BFQ may refuse to serve I/O requests
>> from other bfq_queues. The hang reported in [1] then follows.
>> 
>> However, the above re-prepared requests undergo a requeue, thus the
>> requeue_request hook of the active elevator is invoked for these
>> requests, if set. This commit then addresses the above issue by
>> properly implementing the hook requeue_request in BFQ.
> 
> Thanks, applied.
> 

I Jens,
I forgot to add
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
in the patch.

Is it still possible to add it?

Thanks,
Paolo

> -- 
> Jens Axboe

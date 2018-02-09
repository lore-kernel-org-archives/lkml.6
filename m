Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBINWB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:22:01 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:44396 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeBINV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:21:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 89D222F0198
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Feb 2018 14:21:57 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>,
        169364@studenti.unimore.it, holger@applied-asynchrony.com,
        efault@gmx.de, Serena Ziviani <ziviani.serena@gmail.com>
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
In-Reply-To: <34041F0A-F460-4736-9A6C-76D861EA0070@linaro.org>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
 <17c57205-7cc0-5577-0322-dc35914e50e5@kernel.dk>
 <34041F0A-F460-4736-9A6C-76D861EA0070@linaro.org>
Message-ID: <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name>
User-Agent: Roundcube Webmail/1.3.3
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1518182517;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=os5E+yhKocluj0TaYk1d0SPzPIXQBOsQjJs5BwY9NJg=;
        b=Jhxz4IWFrJ8xq/fFtuXZuPo8FOSogoYYcF0sbB3nzTplEA8EgmnNFl67tBkdd3ABoeGh/Y
        ulNbzHGBzwrA+w0Fxu3pe8VuuNW+9EJTKytMM5v8M7bT7/UF5N53jEAXxJI8CcaMO3NiRw
        4vgFu/CgHBoCvsePXseFwN7ylYWER9s=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1518182517; a=rsa-sha256;
        cv=none;
        b=voQjf1ceHnkohSTQtslujnF4H7naRBMy6sZwbKYdkvo+FLdeGx8QCQXMwvzPdVAhK4iPOgVPdFcqj9mlAh3JoYVMPqjtEoxBGPScg5GL9/COdgKZxlBI6iDDvd8OfMjpLfge6h+0RiuMkvtUcLmrnHZDO3BiPpqOSYOWSRg6xyA=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

08.02.2018 08:16, Paolo Valente wrote:
>> Il giorno 07 feb 2018, alle ore 23:18, Jens Axboe <axboe@kernel.dk> ha 
>> scritto:
>> 
>> On 2/7/18 2:19 PM, Paolo Valente wrote:
>>> Commit 'a6a252e64914 ("blk-mq-sched: decide how to handle flush rq 
>>> via
>>> RQF_FLUSH_SEQ")' makes all non-flush re-prepared requests for a 
>>> device
>>> be re-inserted into the active I/O scheduler for that device. As a
>>> consequence, I/O schedulers may get the same request inserted again,
>>> even several times, without a finish_request invoked on that request
>>> before each re-insertion.
>>> 
>>> This fact is the cause of the failure reported in [1]. For an I/O
>>> scheduler, every re-insertion of the same re-prepared request is
>>> equivalent to the insertion of a new request. For schedulers like
>>> mq-deadline or kyber, this fact causes no harm. In contrast, it
>>> confuses a stateful scheduler like BFQ, which keeps state for an I/O
>>> request, until the finish_request hook is invoked on the request. In
>>> particular, BFQ may get stuck, waiting forever for the number of
>>> request dispatches, of the same request, to be balanced by an equal
>>> number of request completions (while there will be one completion for
>>> that request). In this state, BFQ may refuse to serve I/O requests
>>> from other bfq_queues. The hang reported in [1] then follows.
>>> 
>>> However, the above re-prepared requests undergo a requeue, thus the
>>> requeue_request hook of the active elevator is invoked for these
>>> requests, if set. This commit then addresses the above issue by
>>> properly implementing the hook requeue_request in BFQ.
>> 
>> Thanks, applied.
>> 
> 
> I Jens,
> I forgot to add
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> in the patch.
> 
> Is it still possible to add it?
> 

In addition to this I think it should be worth considering CC'ing Greg 
to pull this fix into 4.15 stable tree.

Oleksandr

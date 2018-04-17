Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDQW5E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 18:57:04 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:44036 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeDQW5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 18:57:02 -0400
X-Google-Smtp-Source: AIpwx4+SAqtGVWU+rpM1M3qrSmQJ373T4PTDVhzt76sqD9KmMMzLIt7opdNzJ3yG3T9hdOhwE3R65RwanGP8DGTiric=
MIME-Version: 1.0
In-Reply-To: <7d192394-568c-53e0-4359-723769c3ed7d@kernel.dk>
References: <20180417214218.GA44753@beast> <7d192394-568c-53e0-4359-723769c3ed7d@kernel.dk>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 17 Apr 2018 15:57:00 -0700
X-Google-Sender-Auth: baNj9grqFpHw0TKSKLZamAJR4hA
Message-ID: <CAGXu5jLLn9HxkR0G6=-Qqjr__=ya_NM3zCLsZwa1V5m7fisQ5A@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Clear out elevator private data
To: Jens Axboe <axboe@kernel.dk>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 2:45 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 4/17/18 3:42 PM, Kees Cook wrote:
>> Some elevators may not correctly check rq->rq_flags & RQF_ELVPRIV, and
>> may attempt to read rq->elv fields. When requests got reused, this
>> caused BFQ to think it already had a bfqq (rq->elv.priv[1]) allocated.
>> This could lead to odd behaviors like having the sense buffer address
>> slowly start incrementing. This eventually tripped HARDENED_USERCOPY
>> and KASAN.
>>
>> This patch wipes all of rq->elv instead of just rq->elv.icq. While
>> it shouldn't technically be needed, this ends up being a robustness
>> improvement that should lead to at least finding bugs in elevators faster.
>
> Comments from the other email still apply, we should not need to do this
> full memset() for every request. From a quick look, BFQ needs to straighten
> out its usage of prepare request and interactions with insert_request.

Sure, understood. I would point out, FWIW, that memset() gets unrolled
by the compiler and this is just two more XORs in the same cacheline
(the two words following icq). (And there is SO much more being
cleared during alloc, it didn't seem like hardly any extra cost vs the
robustness it provided.)

-Kees

-- 
Kees Cook
Pixel Security

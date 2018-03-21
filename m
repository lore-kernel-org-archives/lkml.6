Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeCURCP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:02:15 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35943 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeCURCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:02:10 -0400
X-Google-Smtp-Source: AG47ELulIB03NWg4SUXM19UDfJ72X9fZHV0EVEIZicDkshY4oqcpLppt/h/tq3HI3aFFDkXI7KtRTQ==
Subject: Re: [PATCH] block: use 32-bit blk_status_t on Alpha
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Mike Snitzer <msnitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.LRH.2.02.1803211239490.23314@file01.intranet.prod.int.rdu2.redhat.com>
 <502b7c1e-a95c-ff8d-64cd-9cbdd275fa1d@kernel.dk>
 <alpine.LRH.2.02.1803211253410.26409@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9cd0ef78-68e0-2c08-ca37-775c931fa159@kernel.dk>
Date: Wed, 21 Mar 2018 11:02:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1803211253410.26409@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/18 11:00 AM, Mikulas Patocka wrote:
> 
> 
> On Wed, 21 Mar 2018, Jens Axboe wrote:
> 
>> On 3/21/18 10:42 AM, Mikulas Patocka wrote:
>>> Early alpha processors cannot write a single byte or word; they read 8
>>> bytes, modify the value in registers and write back 8 bytes.
>>>
>>> The type blk_status_t is defined as one byte, it is often written
>>> asynchronously by I/O completion routines, this asynchronous modification
>>> can corrupt content of nearby bytes if these nearby bytes can be written
>>> simultaneously by another CPU.
>>>
>>> - one example of such corruption is the structure dm_io where
>>>   "blk_status_t status" is written by an asynchronous completion routine
>>>   and "atomic_t io_count" is modified synchronously
>>> - another example is the structure dm_buffer where "unsigned hold_count"
>>>   is modified synchronously from process context and "blk_status_t
>>>   write_error" is modified asynchronously from bio completion routine
>>>
>>> This patch fixes the bug by changing the type blk_status_t to 32 bits if
>>> we are on Alpha and if we are compiling for a processor that doesn't have
>>> the byte-word-extension.
>>
>> That's nasty. Is alpha the only problematic arch here?
> 
> Yes. All the other architectures supported by Linux have byte writes.
> 
>> As to the patch in question, normally I'd just say we should make it
>> unconditionally u32. But we pack so nicely in the bio, and I don't think
>> the bio itself has this issue as the rest of the members that share this
>> word are all set before the bio is submitted. But callers embedding
>> the status var in other structures don't necessarily have that
>> guarantee, as your dm examples show.
>>
>> -- 
>> Jens Axboe
> 
> Keeping blk_status_t 8-bit for most architectures will save a few bytes in 
> some of device mapper structures.

And more importantly, it won't screw up the bio layout, I'm somewhat more
concerned about that than random driver structures.

If alpha is the odd one out here, then I think your patch is fine as-is.

-- 
Jens Axboe

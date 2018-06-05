Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeFEOss (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:48:48 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33073 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeFEOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:48:46 -0400
X-Google-Smtp-Source: ADUXVKLYPQ8yIdXaanmpbDf58TiIUcHmm5WnVPsMnpNOUOeBGeMx5lertN0mD81loRoRJGMy5IXFRQ==
Subject: Re: dm: Use kzalloc for all structs with embedded biosets/mempools
To: Mike Snitzer <snitzer@redhat.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20180605092633.29583-1-kent.overstreet@gmail.com>
 <e78b0f9f-d4f9-d865-0727-5e1ed074928d@kernel.dk>
 <20180605144506.GA13100@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7373e0e8-c3b9-2fed-b0a1-88fb4934d82d@kernel.dk>
Date: Tue, 5 Jun 2018 08:48:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180605144506.GA13100@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/18 8:45 AM, Mike Snitzer wrote:
> On Tue, Jun 05 2018 at 10:22P -0400,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 6/5/18 3:26 AM, Kent Overstreet wrote:
>>> mempool_init()/bioset_init() require that the mempools/biosets be zeroed
>>> first; they probably should not _require_ this, but not allocating those
>>> structs with kzalloc is a fairly nonsensical thing to do (calling
>>> mempool_exit()/bioset_exit() on an uninitialized mempool/bioset is legal
>>> and safe, but only works if said memory was zeroed.)
>>>
>>> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
>>> ---
>>>
>>> Linus,
>>>
>>> I fucked up majorly on the bioset/mempool conversion - I forgot to check that
>>> everything biosets/mempools were being embedded in was actually being zeroed on
>>> allocation. Device mapper currently explodes, you'll probably want to apply this
>>> patch post haste.
>>>
>>> I have now done that auditing, for every single conversion - this patch fixes
>>> everything I found. There do not seem to be any incorrect ones outside of device
>>> mapper...
>>>
>>> We'll probably want a second patch that either a) changes
>>> bioset_init()/mempool_init() to zero the passed in bioset/mempool first, or b)
>>> my preference, WARN() or BUG() if they're passed memory that isn't zeroed.
>>
>> Odd, haven't seen a crash, but probably requires kasan or poisoning to
>> trigger anything? Mike's tree also had the changes, since they were based
>> on the block tree.
>>
>> I can queue this up and ship it later today. Mike, you want to review
>> this one?
> 
> Yes, looks good.
> 
> From the start of revisiting these changes last week, Kent and I
> discussed whether it was safe to call mempool_exit() even if
> mempool_init() failed or was never called.  He advised that it was so
> long as the containing structure was zeroed.  But I forgot to audit that 
> aspect.  So this was an oversight by both of us.
> 
> DM core uses kvzalloc_node for struct mapped_device and cache, crypt,
> integrity, verity-fec and zoned targets are already using kzalloc as
> needed.
> 
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Thanks Mike, I'll push this out this morning.

-- 
Jens Axboe

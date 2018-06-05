Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeFEOmI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:42:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44337 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeFEOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:42:07 -0400
X-Google-Smtp-Source: ADUXVKKalP2I5osRhW0+O1XlEijL3Y5DfRYlleRSUFB1l3Z4woZeWI7sFRf/nfAT+sP32GLl2v1F0w==
Subject: Re: [PATCH] dm: Use kzalloc for all structs with embedded
 biosets/mempools
To: dsterba@suse.cz, Kent Overstreet <kent.overstreet@gmail.com>,
        torvalds@linux-foundation.org, snitzer@redhat.com,
        linux-kernel@vger.kernel.org
References: <20180605092633.29583-1-kent.overstreet@gmail.com>
 <e78b0f9f-d4f9-d865-0727-5e1ed074928d@kernel.dk>
 <20180605143507.2o3qm4r6euvyhe5g@twin.jikos.cz>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8a4b20a3-899d-3317-407e-a6a2029d31b0@kernel.dk>
Date: Tue, 5 Jun 2018 08:42:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180605143507.2o3qm4r6euvyhe5g@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/18 8:35 AM, David Sterba wrote:
> On Tue, Jun 05, 2018 at 08:22:22AM -0600, Jens Axboe wrote:
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
> 
> eg. fstests/generic/081 crashes (trace below), no KASAN, PAGE_POISONING=y,
> PAGE_POISONING_NO_SANITY=y.
> 
>> I can queue this up and ship it later today. Mike, you want to review
>> this one?
> 
> Would be great to push that soon. The fstests build on several DM targets, the
> crashes lead to many test failures. I'm going to test the kzalloc fix now.

For sure, it should go asap.

-- 
Jens Axboe

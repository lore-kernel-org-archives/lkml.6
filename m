Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935260AbeCHH7i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 02:59:38 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44864 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754877AbeCHH7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 02:59:35 -0500
X-Google-Smtp-Source: AG47ELtMrVD1DnL9rHlymGRAPKUgcax0BNSUklzsDhF3XEZbarPRDgJqTfMsm/2/n6nXgKpxBCY3tQ==
Subject: Re: [PATCH 6/6] lib/scatterlist: Drop order argument from
 sgl_free_n_order
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
 <20180307124712.14963-7-tvrtko.ursulin@linux.intel.com>
 <1520447415.5558.12.camel@HansenPartnership.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <faa56419-bdce-c539-5eee-5e180c62b0a5@ursulin.net>
Date: Thu, 8 Mar 2018 07:59:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520447415.5558.12.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/03/18 18:30, James Bottomley wrote:
> On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> Firstly, I don't see any justifiable benefit to churning this API, so
> why bother? but secondly this:

Primarily because I wanted to extend sgl_alloc_order slightly in order 
to be able to use it from i915. And then in the process noticed a couple 
of bugs in the implementation, type inconsistencies and unused exported 
symbols. That gave me a feeling API could actually use a bit of work.

>> We can derive the order from sg->length and so do not need to pass it
>> in explicitly.
> 
> Is wrong.  I can have a length 2 scatterlist that crosses a page
> boundary, but I can also have one within a single page, so the order
> cannot be deduced from the length.

sgl_alloc_order never does this.

However there is a different bug in my patch relating to the last entry 
which can have shorter length from the rest. So get_order on the last 
entry is incorrect - I have to store the deduced order and carry it over.

In which case it may even make sense to refactor sgl_alloc_order a bit 
more to avoid wastage on the last entry with high order allocations.

Regards,

Tvrtko

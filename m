Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeFEOW1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:22:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40167 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeFEOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:22:26 -0400
X-Google-Smtp-Source: ADUXVKLHFrKqqYDvahf9w8NCMFtFSmDedWMAZ9YnGGvCHmucsUfmLnnrU6JqZTnggQZQ6TtK+3kaoQ==
Subject: Re: [PATCH] dm: Use kzalloc for all structs with embedded
 biosets/mempools
To: Kent Overstreet <kent.overstreet@gmail.com>,
        torvalds@linux-foundation.org
Cc: snitzer@redhat.com, linux-kernel@vger.kernel.org
References: <20180605092633.29583-1-kent.overstreet@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e78b0f9f-d4f9-d865-0727-5e1ed074928d@kernel.dk>
Date: Tue, 5 Jun 2018 08:22:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180605092633.29583-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/18 3:26 AM, Kent Overstreet wrote:
> mempool_init()/bioset_init() require that the mempools/biosets be zeroed
> first; they probably should not _require_ this, but not allocating those
> structs with kzalloc is a fairly nonsensical thing to do (calling
> mempool_exit()/bioset_exit() on an uninitialized mempool/bioset is legal
> and safe, but only works if said memory was zeroed.)
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
> 
> Linus,
> 
> I fucked up majorly on the bioset/mempool conversion - I forgot to check that
> everything biosets/mempools were being embedded in was actually being zeroed on
> allocation. Device mapper currently explodes, you'll probably want to apply this
> patch post haste.
> 
> I have now done that auditing, for every single conversion - this patch fixes
> everything I found. There do not seem to be any incorrect ones outside of device
> mapper...
> 
> We'll probably want a second patch that either a) changes
> bioset_init()/mempool_init() to zero the passed in bioset/mempool first, or b)
> my preference, WARN() or BUG() if they're passed memory that isn't zeroed.

Odd, haven't seen a crash, but probably requires kasan or poisoning to
trigger anything? Mike's tree also had the changes, since they were based
on the block tree.

I can queue this up and ship it later today. Mike, you want to review
this one?

-- 
Jens Axboe

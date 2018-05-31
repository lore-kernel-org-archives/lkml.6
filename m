Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755348AbeEaOWe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:22:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54787 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755264AbeEaOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:22:31 -0400
X-Google-Smtp-Source: ADUXVKLjJwOXZt+QgIhj3U8HTsHuf7x9qMxdL+tN2rBHXI29usjmclC0QGP5388PwvFWavGPRtWbtQ==
Subject: Re: linux-next: build failure after merge of the device-mapper tree
From: Jens Axboe <axboe@kernel.dk>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Alasdair G Kergon <agk@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20180531142302.5f7b4302@canb.auug.org.au>
 <A669939D-1AC5-48AA-AAE2-92694FB25B11@kernel.dk>
 <20180531121041.GB8456@redhat.com>
 <6ad38822-0bb4-3099-69b0-7a8a36d79403@kernel.dk>
Message-ID: <9ed288cd-0e85-1cb6-7be0-d9d76c7af66d@kernel.dk>
Date: Thu, 31 May 2018 08:22:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6ad38822-0bb4-3099-69b0-7a8a36d79403@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/18 8:20 AM, Jens Axboe wrote:
> On 5/31/18 6:10 AM, Mike Snitzer wrote:
>> On Thu, May 31 2018 at 12:35am -0400,
>> Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> On May 30, 2018, at 10:23 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> After merging the device-mapper tree, today's linux-next build (x86_64
>>>> allmodconfig) failed like this:
>>>>
>>>> drivers/md/dm-writecache.c: In function 'writecache_dtr':
>>>> drivers/md/dm-writecache.c:1799:3: error: implicit declaration of function 'bioset_free'; did you mean 'bvec_free'? [-Werror=implicit-function-declaration]
>>>>   bioset_free(wc->bio_set);
>>>>   ^~~~~~~~~~~
>>>>   bvec_free
>>>> drivers/md/dm-writecache.c: In function 'writecache_ctr':
>>>> drivers/md/dm-writecache.c:1929:17: error: implicit declaration of function 'bioset_create'; did you mean 'bioset_exit'? [-Werror=implicit-function-declaration]
>>>>   wc->bio_set = bioset_create(BIO_POOL_SIZE,
>>>>                 ^~~~~~~~~~~~~
>>>>                 bioset_exit
>>>> drivers/md/dm-writecache.c:1929:15: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>>>>   wc->bio_set = bioset_create(BIO_POOL_SIZE,
>>>>               ^
>>>>
>>>> Caused by commit
>>>>
>>>>  2105231db61b ("dm: add writecache target")
>>>>
>>>> interacting with commit
>>>>
>>>>  dad08527525f ("block: Drop bioset_create()")
>>>>
>>>> from the block tree.
>>>>
>>>> Can we please consider not immediately dropping APIs if at all
>>>> possible. :-(
>>>
>>> I’ll drop the last patch, we can do that at the end of the merge window instead. 
>>>
>>
>> FYI, I've since updated dm-writecache to use the new APIs
> 
> Thanks Mike. I've rebased for-4.18/block to fold a bug fix for the
> bounce code, and drop the patch that gets rid of the old API. When
> we get to the end of the merge window, I'll push that last patch.
> That's much more sensible, how it should have been done from the
> get-go.

Actually, maybe I should roll them back, since you both fixed that
up AND based on my tree - which is of course totally fine, but
now I'm thinking the rebase will do more harm than good in this
case.

-- 
Jens Axboe

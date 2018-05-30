Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968779AbeE3IyH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:54:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33787 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968744AbeE3Ixh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:53:37 -0400
X-Google-Smtp-Source: ADUXVKJ/HuG8/U2VMPhXaTmcvQTP3nGwSmmIaYEnKcXjanf5UsvZtVDvfQ0eCGwbHJS/aMIT9gjgvHzBjcF6G3KesXA=
MIME-Version: 1.0
In-Reply-To: <CAEemH2c=EWHb1Ua6Fe4g_kF2JC8LKoiySPabZ7xXF43ovrNFmg@mail.gmail.com>
References: <20180524095752.17770-1-liwang@redhat.com> <CALZtONA4y+7vzUr2xPa8ZbwCczjJV9EMCOXaCsE94DdfGbrmtA@mail.gmail.com>
 <CAEemH2c=EWHb1Ua6Fe4g_kF2JC8LKoiySPabZ7xXF43ovrNFmg@mail.gmail.com>
From: Dan Streetman <ddstreet@ieee.org>
Date: Wed, 30 May 2018 04:52:56 -0400
X-Google-Sender-Auth: wchKGP2JgBx6oDpeJyQKlf9itSY
Message-ID: <CALZtONC69mq9Sh+pi_1Snntj-31ej5vW+UH-d77oUdvrEAS-Bw@mail.gmail.com>
Subject: Re: [PATCH RFC] zswap: reject to compress/store page if
 zswap_max_pool_percent is 0
To: Li Wang <liwang@redhat.com>
Cc: Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Huang Ying <huang.ying.caritas@gmail.com>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:57 PM, Li Wang <liwang@redhat.com> wrote:
> Hi Dan,
>
> On Wed, May 30, 2018 at 5:14 AM, Dan Streetman <ddstreet@ieee.org> wrote:
>>
>> On Thu, May 24, 2018 at 5:57 AM, Li Wang <liwang@redhat.com> wrote:
>> > The '/sys/../zswap/stored_pages:' keep raising in zswap test with
>> > "zswap.max_pool_percent=0" parameter. But theoretically, it should
>> > not compress or store pages any more since there is no space for
>> > compressed pool.
>> >
>> > Reproduce steps:
>> >
>> >   1. Boot kernel with "zswap.enabled=1 zswap.max_pool_percent=17"
>> >   2. Set the max_pool_percent to 0
>> >       # echo 0 > /sys/module/zswap/parameters/max_pool_percent
>> >      Confirm this parameter works fine
>> >       # cat /sys/kernel/debug/zswap/pool_total_size
>> >       0
>> >   3. Do memory stress test to see if some pages have been compressed
>> >       # stress --vm 1 --vm-bytes $mem_available"M" --timeout 60s
>> >      Watching the 'stored_pages' numbers increasing or not
>> >
>> > The root cause is:
>> >
>> >   When the zswap_max_pool_percent is set to 0 via kernel parameter, the
>> > zswap_is_full()
>> >   will always return true to shrink the pool size by zswap_shrink(). If
>> > the pool size
>> >   has been shrinked a little success, zswap will do compress/store pages
>> > again. Then we
>> >   get fails on that as above.
>>
>> special casing 0% doesn't make a lot of sense to me, and I'm not
>> entirely sure what exactly you are trying to fix here.
>
>
> Sorry for that confusing, I am a pretty new to zswap.
>
> To specify 0 to max_pool_percent is purpose to verify if zswap stopping work
> when there is no space in compressed pool.
>
> Another consideration from me is:
>
> [Method A]
>
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1021,7 +1021,7 @@ static int zswap_frontswap_store(unsigned type,
> pgoff_t offset,
>         /* reclaim space if needed */
>         if (zswap_is_full()) {
>                 zswap_pool_limit_hit++;
> -               if (zswap_shrink()) {
> +               if (!zswap_max_pool_percent || zswap_shrink()) {
>                         zswap_reject_reclaim_fail++;
>                         ret = -ENOMEM;
>                         goto reject;
>
> This make sure the compressed pool is enough to do zswap_shrink().
>
>
>>
>>
>> however, zswap does currently do a zswap_is_full() check, and then if
>> it's able to reclaim a page happily proceeds to store another page,
>> without re-checking zswap_is_full().  If you're trying to fix that,
>> then I would ack a patch that adds a second zswap_is_full() check
>> after zswap_shrink() to make sure it's now under the max_pool_percent
>> (or somehow otherwise fixes that behavior).
>>
>
> Ok, it sounds like can also fix the issue. The changes maybe like:
>
> [Method B]
>
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1026,6 +1026,15 @@ static int zswap_frontswap_store(unsigned type,
> pgoff_t offset,
>                         ret = -ENOMEM;
>                         goto reject;
>                 }
> +
> +               /* A second zswap_is_full() check after
> +                * zswap_shrink() to make sure it's now
> +                * under the max_pool_percent
> +                */
> +               if (zswap_is_full()) {
> +                       ret = -ENOMEM;
> +                       goto reject;
> +               }
>         }
>
>
> So, which one do you think is better, A or B?

this is better.

>
> --
> Regards,
> Li Wang

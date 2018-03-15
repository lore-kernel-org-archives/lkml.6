Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeCOQ6J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:58:09 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:39178 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeCOQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:58:07 -0400
X-Google-Smtp-Source: AG47ELs8Aaj0L7Odz6VlBZVPp0qHHYKQGV5DYL/xfyIiF4bIIREB7zU1s2Ssgla8RPvq4DmhWZsk9UglS/7LII+elMM=
MIME-Version: 1.0
In-Reply-To: <0175e460-3424-9838-1064-9f63dab3304f@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org> <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
 <2a4f4dec64b7462ae64152f6c2df9754@codeaurora.org> <CAKgT0UcriMiyV0q6y_x9r3-HJRAWp5_CpsK2jTqh3qvOV=Kkzw@mail.gmail.com>
 <d565406d-1bc7-6fb0-3f36-87a28ac69070@codeaurora.org> <CAKgT0UeBHGDmr0uXfuPQJKOomiH9uvXRVYpyDwMOzjkxAZMSYg@mail.gmail.com>
 <53bf7dfe-32ee-1861-e6ea-81f667590a43@codeaurora.org> <CAKgT0UcBQRoSPPZ73bdu1oEBGqBA8_c3ZAjti20=+9UwEqpXbw@mail.gmail.com>
 <eee8269d-b711-828c-ab84-5933bf86d024@codeaurora.org> <0175e460-3424-9838-1064-9f63dab3304f@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Mar 2018 09:58:05 -0700
Message-ID: <CAKgT0UfqueJNq3cL3P=uWZ3xsJ1PXTMHSKTMgZO9uKmTUUCGPg@mail.gmail.com>
Subject: Re: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>, Netdev <netdev@vger.kernel.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 9:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/15/2018 12:21 PM, Sinan Kaya wrote:
>> On 3/15/2018 10:32 AM, Alexander Duyck wrote:
>>> We tend to do something like:
>>>   update tx_buffer_info
>>>   update tx_desc
>>>   wmb()
>>>   point first tx_buffer_info next_to_watch value at last tx_desc
>>>   update next_to_use
>>>   notify device via writel
>>>
>>> We do it this way because we have to synchronize between the Tx
>>> cleanup path and the hardware so we basically lump the two barriers
>>> together. instead of invoking both a smp_wmb and a wmb. Now that I
>>> look at the pseudocode though I wonder if we shouldn't move the
>>> next_to_use update before the wmb, but that might be material for
>>> another patch. Anyway, in the Tx cleanup path we should have an
>>> smp_rmb() after we read the next_to_watch values so that we avoid
>>> reading any of the other fields in the buffer_info if either the field
>>> is NULL or the descriptor pointed to has not been written back.
>>
>> How do you feel about keeping wmb() very close to writel_relaxed() like this?
>>
>>    update tx_buffer_info
>>    update tx_desc
>>    point first tx_buffer_info next_to_watch value at last tx_desc
>>    update next_to_use
>>    wmb()
>>    notify device via writel_relaxed()
>>
>> I'm afraid that if the order of wmb() and writel() is not very
>> obvious or hidden in multiple functions, somebody can introduce a very nasty
>> bug in the future.
>>
>> We also have to think about code maintenance.
>>
>
> Now that I read your email again, I think this is the reason if I understood you
> correctly.
>
> "instead of invoking both a smp_wmb and a wmb"
>
> You'd need something like
>
>     update tx_buffer_info
>     update tx_desc
>     smp_wmb()
>     point first tx_buffer_info next_to_watch value at last tx_desc
>     update next_to_use
>     wmb()
>     notify device via writel_relaxed()
>
> Let me work on your comments.

Yes, we would be doing something like that, but we are using just a
single wmb() to cover both cases since hardware will never look at the
tx_buffer_info and software will never read that descriptor ring as
long as the next_to_watch is NULL. By doing it this way we should have
both cases covered and not need to worry

The only other bit still remaining is the "maybe_stop_tx" logic which
lives between the wmb and writel_relaxed. That logic has a smp_mb
living in it that is triggered if we have to stop the queue. Once
again though that is only viewed by software so it existing between
the wmb and the writel_relaxed should not be an issue.

Starting to understand why I was a bit hesitant to have us start
taking on these changes now? :-)

- Alex

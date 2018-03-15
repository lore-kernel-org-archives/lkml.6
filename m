Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeCOQ1x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:27:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeCOQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:27:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AE4360FEC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Timur Tabi <timur@codeaurora.org>, Netdev <netdev@vger.kernel.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
 <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
 <2a4f4dec64b7462ae64152f6c2df9754@codeaurora.org>
 <CAKgT0UcriMiyV0q6y_x9r3-HJRAWp5_CpsK2jTqh3qvOV=Kkzw@mail.gmail.com>
 <d565406d-1bc7-6fb0-3f36-87a28ac69070@codeaurora.org>
 <CAKgT0UeBHGDmr0uXfuPQJKOomiH9uvXRVYpyDwMOzjkxAZMSYg@mail.gmail.com>
 <53bf7dfe-32ee-1861-e6ea-81f667590a43@codeaurora.org>
 <CAKgT0UcBQRoSPPZ73bdu1oEBGqBA8_c3ZAjti20=+9UwEqpXbw@mail.gmail.com>
 <eee8269d-b711-828c-ab84-5933bf86d024@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0175e460-3424-9838-1064-9f63dab3304f@codeaurora.org>
Date: Thu, 15 Mar 2018 12:27:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <eee8269d-b711-828c-ab84-5933bf86d024@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/2018 12:21 PM, Sinan Kaya wrote:
> On 3/15/2018 10:32 AM, Alexander Duyck wrote:
>> We tend to do something like:
>>   update tx_buffer_info
>>   update tx_desc
>>   wmb()
>>   point first tx_buffer_info next_to_watch value at last tx_desc
>>   update next_to_use
>>   notify device via writel
>>
>> We do it this way because we have to synchronize between the Tx
>> cleanup path and the hardware so we basically lump the two barriers
>> together. instead of invoking both a smp_wmb and a wmb. Now that I
>> look at the pseudocode though I wonder if we shouldn't move the
>> next_to_use update before the wmb, but that might be material for
>> another patch. Anyway, in the Tx cleanup path we should have an
>> smp_rmb() after we read the next_to_watch values so that we avoid
>> reading any of the other fields in the buffer_info if either the field
>> is NULL or the descriptor pointed to has not been written back.
> 
> How do you feel about keeping wmb() very close to writel_relaxed() like this?
> 
>    update tx_buffer_info
>    update tx_desc
>    point first tx_buffer_info next_to_watch value at last tx_desc
>    update next_to_use
>    wmb()
>    notify device via writel_relaxed()
> 
> I'm afraid that if the order of wmb() and writel() is not very
> obvious or hidden in multiple functions, somebody can introduce a very nasty
> bug in the future.
> 
> We also have to think about code maintenance.
> 

Now that I read your email again, I think this is the reason if I understood you
correctly. 

"instead of invoking both a smp_wmb and a wmb"

You'd need something like

    update tx_buffer_info
    update tx_desc
    smp_wmb()
    point first tx_buffer_info next_to_watch value at last tx_desc
    update next_to_use
    wmb()
    notify device via writel_relaxed()

Let me work on your comments.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

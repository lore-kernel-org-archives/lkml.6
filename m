Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeCWSbj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:31:39 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55012 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeCWSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:31:36 -0400
X-Google-Smtp-Source: AG47ELsMXzaQB1km3TPEpp1FfWLhfXHwPbtp9ptxC+3MtFR8wg9YvwbvfpN3M01EB9wrugaeMk33MDOqEkJySiWCUpY=
MIME-Version: 1.0
In-Reply-To: <cf6191c0-07cc-226b-d780-f488a0d7c779@codeaurora.org>
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
 <1521829277-9398-8-git-send-email-okaya@codeaurora.org> <CAKgT0UfCm4SJAhwyHKrHZnoJWKpp6-DWWVUb-YKgA2NTQhx=RA@mail.gmail.com>
 <cf6191c0-07cc-226b-d780-f488a0d7c779@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 23 Mar 2018 11:31:34 -0700
Message-ID: <CAKgT0UeAJOdvqXfRw1xF+LnpGo3K7NQt_3DcJGUkiPMF+O8PTg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v6 7/7] ixgbevf: eliminate duplicate
 barriers on weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, sulrich@codeaurora.org,
        Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 11:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/23/2018 2:25 PM, Alexander Duyck wrote:
>>> +               /* We need this if more than one processor can write to our tail
>>> +                * at a time, it synchronizes IO on IA64/Altix systems
>>> +                */
>>> +               mmiowb();
>>>         }
>> The mmiowb shouldn't be needed for Rx. Only one CPU will be running
>> NAPI for the queue and we will synchronize this with a full writel
>> anyway when we re-enable the interrupts.
>>
>
> OK. I can fix this on the next version. I did a blanket search and replace for
> my writel_relaxed() changes as I don't know the code well enough.
>
> Please point me to the redundant ones.

So from what I can tell only this file and i40e needed any additional
mmiowb calls added. The rest are not needed.

- Alex

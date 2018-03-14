Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeCNVtE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:49:04 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37866 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNVtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:49:01 -0400
X-Google-Smtp-Source: AG47ELsPY3Zh20VBmBf1p9Itc861UmD2LLW2XoqhXDz6f3e/rkNh3P07g2Tl7nwttbqcevyGCwl878cHRXi2efiBdE4=
MIME-Version: 1.0
In-Reply-To: <2a4f4dec64b7462ae64152f6c2df9754@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org> <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
 <2a4f4dec64b7462ae64152f6c2df9754@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Mar 2018 14:49:00 -0700
Message-ID: <CAKgT0UcriMiyV0q6y_x9r3-HJRAWp5_CpsK2jTqh3qvOV=Kkzw@mail.gmail.com>
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

On Wed, Mar 14, 2018 at 5:13 AM,  <okaya@codeaurora.org> wrote:
> On 2018-03-14 01:08, Timur Tabi wrote:
>>
>> On 3/13/18 10:20 PM, Sinan Kaya wrote:
>>>
>>> +/* Assumes caller has executed a write barrier to order memory and
>>> device
>>> + * requests.
>>> + */
>>>   static inline void ixgbevf_write_tail(struct ixgbevf_ring *ring, u32
>>> value)
>>>   {
>>> -       writel(value, ring->tail);
>>> +       writel_relaxed(value, ring->tail);
>>>   }
>>
>>
>> Why not put the wmb() in this function, or just get rid of the wmb()
>> in the rest of the file and keep this as writel?  That way, you can
>> avoid the comment and the risk that comes with it.
>
>
>
> Sure, both solutions will work. I want to see what the maintainer prefers. I
> can repost accordingly.

Actually I would argue this whole patch set is pointless. For starters
why is it we are only updating the Intel Ethernet drivers here? This
seems like something that is going to impact the whole kernel tree
since many of us have been writing drivers for some time assuming x86
style behavior.

It doesn't make sense to be optimizing the drivers for one subset of
architectures. The scope of the work needed to update the drivers for
this would be ridiculous. Also I don't see how this could be expected
to work on any other architecture when we pretty much need to have a
wmb() before calling the writel on x86 to deal with accesses between
coherent and non-coherent memory. It seems to me more like somebody
added what they considered to be an optimization somewhere that is a
workaround for a poorly written driver. Either that or the barrier is
serving a different purpose then the one we were using.

It would make more sense to put in the effort making writel and
writel_relaxed consistent between architectures before we go through
and start modifying driver code to support different architectures.

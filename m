Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCNW5q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:57:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCNW5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:57:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D650660314
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d565406d-1bc7-6fb0-3f36-87a28ac69070@codeaurora.org>
Date: Wed, 14 Mar 2018 18:57:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcriMiyV0q6y_x9r3-HJRAWp5_CpsK2jTqh3qvOV=Kkzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 3/14/2018 5:49 PM, Alexander Duyck wrote:
> On Wed, Mar 14, 2018 at 5:13 AM,  <okaya@codeaurora.org> wrote:
>> On 2018-03-14 01:08, Timur Tabi wrote:
>>>
>>> On 3/13/18 10:20 PM, Sinan Kaya wrote:

> Actually I would argue this whole patch set is pointless. For starters
> why is it we are only updating the Intel Ethernet drivers here? 

I did a regex search for wmb() followed by writel() in each drivers directory.
I scrubbed the ones I care about and posted this series. Note also that
I have one Infiniband patch in the series. 

I considered "ease of change", "popular usage" and "performance critical
path" as the determining criteria for my filtering. 


> This
> seems like something that is going to impact the whole kernel tree
> since many of us have been writing drivers for some time assuming x86
> style behavior.

That's true. We used relaxed API heavily on ARM for a long time but
it did not exist on other architectures. For this reason, relaxed
architectures have been paying double penalty in order to use the common
drivers. 

Now that relaxed API is present on all architectures, we can go and scrub
all drivers to see what needs to change and what can remain.

> 
> It doesn't make sense to be optimizing the drivers for one subset of
> architectures. The scope of the work needed to update the drivers for
> this would be ridiculous. Also I don't see how this could be expected
> to work on any other architecture when we pretty much need to have a
> wmb() before calling the writel on x86 to deal with accesses between
> coherent and non-coherent memory. It seems to me more like somebody
> added what they considered to be an optimization somewhere that is a
> workaround for a poorly written driver. Either that or the barrier is
> serving a different purpose then the one we were using.

Is there a semantic problem with the definition of wmb() vs. writel() vs.
writel_relaxed()? I thought everything is well described in barriers
document about what to expect from these APIs.

AFAIK, writel() is equal to writel_relaxed() on x86 architecture.
It doesn't really change anything for x86 but it saves barriers on
other architectures.

> 
> It would make more sense to put in the effort making writel and
> writel_relaxed consistent between architectures before we go through
> and start modifying driver code to support different architectures.
> 

Is there an arch problem that I'm not seeing?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

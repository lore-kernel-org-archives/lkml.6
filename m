Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeCQDk5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 23:40:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57024 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCQDkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 23:40:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0717C60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 18/18] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
To: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
        timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "'Steve Wise'" <swise@chelsio.com>,
        "'Doug Ledford'" <dledford@redhat.com>,
        "'Jason Gunthorpe'" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, "'Michael Werner'" <werner@chelsio.com>,
        "'Casey Leedom'" <leedom@chelsio.com>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-19-git-send-email-okaya@codeaurora.org>
 <003601d3bd6a$783d6970$68b83c50$@opengridcomputing.com>
 <83387f6e-adcb-14e9-2c22-96abf9493cc6@codeaurora.org>
 <004501d3bd7b$505e70f0$f11b52d0$@opengridcomputing.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <740c7d45-450e-c9b3-ceed-7bc7fcefbc5a@codeaurora.org>
Date: Fri, 16 Mar 2018 23:40:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <004501d3bd7b$505e70f0$f11b52d0$@opengridcomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/2018 7:05 PM, Steve Wise wrote:
>>
>> On 3/16/2018 5:05 PM, Steve Wise wrote:
>>>> Code includes wmb() followed by writel(). writel() already has a barrier
>>> on
>>>> some architectures like arm64.
>>>>
>>>> This ends up CPU observing two barriers back to back before executing
>> the
>>>> register write.
>>>>
>>>> Since code already has an explicit barrier call, changing writel() to
>>>> writel_relaxed().
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>
>>> NAK - This isn't correct for PowerPC.  For PowerPC, writeX_relaxed() is just
>>> writeX().
>>>
>>> I was just looking at this with Chelsio developers, and they said the
>>> writeX() should be replaced with __raw_writeX(), not writeX_relaxed(), to
>>> get rid of the extra barrier for all architectures.
>>
>> OK. I can do that but isn't the problem at PowerPC adaptation?
>>
>> /*
>>  * We don't do relaxed operations yet, at least not with this semantic
>>  */
>> #define readb_relaxed(addr)	readb(addr)
>> #define readw_relaxed(addr)	readw(addr)
>> #define readl_relaxed(addr)	readl(addr)
>> #define readq_relaxed(addr)	readq(addr)
>> #define writeb_relaxed(v, addr)	writeb(v, addr)
>> #define writew_relaxed(v, addr)	writew(v, addr)
>> #define writel_relaxed(v, addr)	writel(v, addr)
>> #define writeq_relaxed(v, addr)	writeq(v, addr)
>>
>> Why don't we fix the PowerPC's relaxed operators? Is that a bigger task?
> 
> I don't know the answer, but perhaps the proper fix is to correctly implement these for PPC?
> 

I found this article: https://lwn.net/Articles/698014/#PowerPC%20Implementation

Apparently, this issue was discussed at a conference in 2015.

Based on how I read this article, writel() and writel_relaxed() behave exactly
the same on PowerPC because the barrier is enforced by the time code is leaving
a critical section not during MMIO execution.

I also see that __raw_writel() is being heavily used in drivers directory.

https://elixir.bootlin.com/linux/latest/ident/__raw_writel

I'll change writel_relaxed() with __raw_writel() in the series like you suggested
and also look at your other comments.

This seems to be the current norm.

> 
>>
>> >From API perspective both __raw_writeX() and writeX_relaxed() are
>> correct.
>> It is just PowerPC doesn't seem the follow the definition yet.
> 
> 
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

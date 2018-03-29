Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeC2Npn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:45:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeC2Npl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:45:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23DE560AFB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v7 3/7] bnx2x: Replace doorbell barrier() with wmb()
To: "Elior, Ariel" <Ariel.Elior@cavium.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
 <1521988761-30344-4-git-send-email-okaya@codeaurora.org>
 <CY1PR0701MB133742146E2848330CA89FB290A20@CY1PR0701MB1337.namprd07.prod.outlook.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d3ef68c2-bf18-9bc8-76ce-8077f3987189@codeaurora.org>
Date: Thu, 29 Mar 2018 09:45:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CY1PR0701MB133742146E2848330CA89FB290A20@CY1PR0701MB1337.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ariel,

On 3/29/2018 5:17 AM, Elior, Ariel wrote:
>> Subject: [PATCH v7 3/7] bnx2x: Replace doorbell barrier() with wmb()
>>
>> barrier() doesn't guarantee memory writes to be observed by the hardware on
>> all architectures. barrier() only tells compiler not to move this code
>> with respect to other read/writes.
>>
>> If memory write needs to be observed by the HW, wmb() is the right choice.
> The wmb() is there (a couple of lines above). Your modification adds an
> unnecessary fence which would hurt high pps scenarios. The memory
> writes which the HW needs to observe are the buffer descriptors, not the
> producer update message. The producer is written to the HW, and exists
> on the stack. The barrier() is there to prevent the compiler from mixing the
> order of the prod update message preparation and writing it to the host.
> A possible alternative would be to move the existing wmb() to where
> the barrier() is, achieving both goals, although in the existing design each
> barrier has a distinct purpose. The comment location is misleading, though.

I was told that barrier() is there to guarantee that HW is observing the memory
write before writel(). 

I reacted to this and changed barrier() to wmb() following the old directions. 
You are saying that this not true. 

Since then, Linus gave us direction not to have wmb() in front of writel() as
writel() already has memory-IO guarantee.

https://www.mail-archive.com/netdev@vger.kernel.org/msg225806.html

I'll be doing one more pass to remove wmb() before writel() soon. Please review
that carefully. 

Intel drivers use wmb() as a substitute for smp_wmb(). So, we can't always assume
that you can remove all wmb() in front of writel() as the write barrier seems to
serve dual purpose.

Please help me getting this right on the next version.

Sinan


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeCXO5o (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 10:57:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCXO5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 10:57:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9547560271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
To: "Chopra, Manish" <Manish.Chopra@cavium.com>,
        David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
 <20180323.124326.2170503491903886041.davem@davemloft.net>
 <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
 <20180323.130418.2223623186761161723.davem@davemloft.net>
 <b4553d26-b326-15be-dcac-12594ea7c5b5@codeaurora.org>
 <DM2PR07MB685FD0A0877865A41EE723889AF0@DM2PR07MB685.namprd07.prod.outlook.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <02335376-ca3c-e026-8649-8cb855f96216@codeaurora.org>
Date: Sat, 24 Mar 2018 10:57:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <DM2PR07MB685FD0A0877865A41EE723889AF0@DM2PR07MB685.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/2018 10:30 AM, Chopra, Manish wrote:
>> -----Original Message-----
>> From: Sinan Kaya [mailto:okaya@codeaurora.org]
>> Sent: Friday, March 23, 2018 10:44 PM
>> To: David Miller <davem@davemloft.net>
>> Cc: netdev@vger.kernel.org; timur@codeaurora.org; sulrich@codeaurora.org;
>> linux-arm-msm@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Elior,
>> Ariel <Ariel.Elior@cavium.com>; Dept-Eng Everest Linux L2 <Dept-
>> EngEverestLinuxL2@cavium.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on weakly-
>> ordered archs
>>
>> On 3/23/2018 1:04 PM, David Miller wrote:
>>> From: Sinan Kaya <okaya@codeaurora.org>
>>> Date: Fri, 23 Mar 2018 12:51:47 -0400
>>>
>>>> It could if txdata->tx_db was not a union. There is a data dependency
>>>> between txdata->tx_db.data.prod and txdata->tx_db.raw.
>>>>
>>>> So, no reordering.
>>>
>>> I don't see it that way, the code requires that:
>>>
>>>  	txdata->tx_db.data.prod += nbd;
>>>
>>> is visible before the doorbell update.>
>>> barrier() doesn't provide that.
>>>
>>> Neither does writel_relaxed().  However plain writel() does.
>>
>> Correct for some architectures including ARM but not correct universally.
>>
>> writel() just guarantees register read/writes before and after to be ordered
>> when HW observes it.
>>
>> writel() doesn't guarantee that the memory update is visible to the HW on all
>> architectures.
>>
>> If you need memory update visibility, that barrier() should have been a
>> wmb()
>>
>> A correct multi-arch pattern is
>>
>> wmb()
>> writel_relaxed()
>> mmiowb()
>>
> 
> Sinan,  Since you have mentioned the use of mmiowb() here after writel_relaxed().
> I believe this is not always correct for all types of IO mapped memory [Specially if IO memory is mapped using write combined (for ex. Ioremap_wc())].
> We have a current issue on our NIC (qede) driver on x86 for which the patch is already been sent more than a week ago [Still awaiting to hear from David on that].
> where mmiowb() seems to be useless since we use write combined mapped doorbell and mmiowb() just seems to be a compiler barrier() there.
> So in order to flush write combined buffer we really need writel_relaxed() followed by a wmb() to synchronize writes among CPU cores.
> I think  the correct pattern in such cases (for write combined IO) would have been like below - 
> 
> wmb();
> writel_relaxed();
> wmb(); -> To flush the writes actually.

You actually have good points. It is the same problem with barrier() description above.

The answer really depends on what you are doing/expecting after mmiowb(). If you expect
that some memory content to be observed by HW, you definitely need a wmb() like
you mentioned. 

If you just want writes to be flushed but you don't expect any memory content to be
updated, you need a mmiowb(). 

https://lwn.net/Articles/198988/
"There is mmiowb(), but its real purpose is to enforce ordering between MMIO operations only."

> 
> Thanks.
> 
> 
> 
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

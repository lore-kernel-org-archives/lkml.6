Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbeCUKrw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:47:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12750 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751411AbeCUKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:47:49 -0400
Subject: Re: [RESEND PATCH v1 2/6] i2c: i2c-stm32f7: Add slave support
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
 <20180317205109.gocf5wemtjkyomct@ninjato>
 <5a3c5b21-bc66-ce73-a997-f686ecc275f3@st.com>
 <20180320095242.tedafu5wphsx55qx@katana>
 <c7fa1cc2-a298-967c-6006-942fd631b4f0@st.com>
Message-ID: <f5389af1-257d-2887-531c-d3bd67b20524@st.com>
Date: Wed, 21 Mar 2018 11:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c7fa1cc2-a298-967c-6006-942fd631b4f0@st.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram

STM32 I2C F7 can be both Master and Slave mode.
Whenever a master command (I2C or SMBus) a START condition is generated and the
master flag (master_mode) is set and managed accordingly : sw and ITs/
Now if a slave is registered it's managed accordingly as long as there is no
master command on going.
IRqs are not separated neither Regs bits. The routing is done though out START
condition.
This driver is not slave-only driver and can act as master if a master command
is issued and slave if registered as such.

Hope it clarifies
Regards

On 03/20/2018 11:17 AM, Pierre Yves MORDRET wrote:
> 
> 
> On 03/20/2018 10:52 AM, Wolfram Sang wrote:
>>
>>> I do believe the hw can support it, even it looks odd to me having the same I2C
>>> in slave and master mode at the same time.
>>
>> I2C is multi-master, so it is perfectly valid for a device to be master
>> and slave. I do have seen designs making use of that more than once.
>>
>>> Nevertheless the driver is devised to support either master or slave more but
>>> not at the same time.
>>
>> Why should we limit ourselves here? Also, why should we have an
>> unnecessary configuration option?
>>
>> Unless the HW is broken and does not support it, I usually don't accept
>> slave-only solutions. If the needs for master and slave arises later,
>> this is hard to refactor and better done properly right away.
>>
>> Is it so hard? Usually you have irqs for master and for slave seperated,
>> so you can code things quite orthogonal. Check de20d1857dd6 ("i2c: rcar:
>> add slave support") as an example.
>>
> 
> I need to check at my end but status bits are shared between master and slave in
> my IP: i.e. Tx Empty, Rx Empty, NAxk, Stop.
> Both bits have a meaning in either master and slave mode. In your case status
> bits are separated between master and slave.
> BTW I need to think about it.
> 

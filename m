Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeDRP50 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:57:26 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39764 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750872AbeDRP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:57:24 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Subject: Re: [REGRESSION][BISECTED] i.MX6 pinctrl hogs stopped working
To: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        <linus.walleij@linaro.org>
References: <8b07e30a-7dd1-7923-dc50-b84f0e43e9e9@nextfour.com>
 <1d3c6099-3b33-d5dd-e12b-903586dc79f3@opensource.cirrus.com>
 <950ec4db-4121-2faf-b6fd-5fcabef91e90@nextfour.com>
CC: LKML <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <patches@opensource.cirrus.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <88a3855d-db5f-9086-2901-2360d0cd26ec@opensource.cirrus.com>
Date: Tue, 17 Apr 2018 09:50:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <950ec4db-4121-2faf-b6fd-5fcabef91e90@nextfour.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804180143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/18 19:33, Mika Penttilä wrote:
> 
> 
> On 10.04.2018 13:21, Richard Fitzgerald wrote:
>> On 04/04/18 06:33, Mika Penttilä wrote:
>>> Hi!
>>>
>>> Reverting this made the hogs on a i.MX6 board work again. :
>>>
>>>
>>> commit b89405b6102fcc3746f43697b826028caa94c823
>>> Author: Richard Fitzgerald <rf@opensource.cirrus.com>
>>> Date:   Wed Feb 28 15:53:06 2018 +0000
>>>
>>>       pinctrl: devicetree: Fix dt_to_map_one_config handling of hogs
>>>
>>>
>>>
>>> --Mika
>>>
>>
>> I think you should check whether the bug is with the i.MX6 driver
>> relying on the previous buggy behaviour of pinctrl. I haven't got
>> i.MX6 hardware to test myself.
>>
>> The bug I fixed in that patch was that when pinctrl is probing a
>> pinctrl driver it would try to apply all the pinctrl settings
>> listed in a dt node to the pinctrl driver it is probing instead
>> of the pinctrl drivers they actually refer to. This was a bug
>> introduced by an earlier patch (which unfortunately I forgot to
>> include a fixes line reference to)
>>
>>    pinctrl: core: Use delayed work for hogs
>>
>> So if a pinctrl driver "A" had a dependency on another pinctrl
>> driver "B" those dependencies wouldn't be properly created because
>> all the "B" pinctrl DT entries would be attempted against "A"
>> instead of "B". This caused failures if a pinctrl driver had a
>> dependency on another pinctrl driver, of if creating a pinctrl
>> driver that is a child of an MFD and that MFD has dependencies
>> on another pinctrl driver.
>>
> 
> Hard to say, but the kernel/dts has worked ok for 3+ years, from 3.17 until 4.17-rc. Nothing fancy, just normal hogs, in two groups.
> Can send you relevant pieces of DT if interested.
> 
> --Mika
> 

Tell me where in the kernel tree the the dts files and the source for
the pinctrl driver that uses them and which dts node, and I will look
at what the driver is doing.

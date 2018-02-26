Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeBZRTl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:19:41 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42810 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751570AbeBZRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:19:39 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Subject: Re: [PATCH v8 9/9] gpio: madera: Support Cirrus Logic Madera class
 codecs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <patches@opensource.cirrus.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180226130558.7634-1-rf@opensource.cirrus.com>
 <20180226130558.7634-10-rf@opensource.cirrus.com>
 <CAHp75VebWArW6p4HbvnBYEsBqg5WJkn3Afh+cBNKCDS_W71LBg@mail.gmail.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <8e61dc88-e66a-f853-0ae0-b293a6e3bfc9@opensource.cirrus.com>
Date: Mon, 26 Feb 2018 17:19:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VebWArW6p4HbvnBYEsBqg5WJkn3Afh+cBNKCDS_W71LBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802260226
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/18 14:16, Andy Shevchenko wrote:
> On Mon, Feb 26, 2018 at 3:05 PM, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>> This adds support for the GPIOs on Cirrus Logic Madera class codecs.
>> Any pins not used for special functions (see the pinctrl driver) can be
>> used as general single-bit input or output lines. The number of available
>> GPIOs varies between codecs.
>>
>> Note that this is part of a composite MFD for these codecs and can only
>> be used with the corresponding MFD and other child drivers on those
>> silicon. The GPIO block on these codecs does not exist indepedently of
>> the rest of the MFD.
> 
>> +struct madera_gpio {
>> +       struct madera *madera;
>> +       struct gpio_chip gpio_chip;
>> +};
> 
> Why do you need this? I suppose one embeds or refers to the other.
> 

The gpio_chip is storage for the struct gpio_chip that we're using.
It allow us to create dynamically constructed struct gpio_chip based
on the template in madera_gpio_chip. See the code in madera_gpio_probe.

There are slight differences between the codecs (currently what we
care about is that they have different numbers of gpios.) and as we
still want to support pdata we also might have to change .base at
runtime.

It's possible to have multiple codecs of different type in one system
so patching the static madera_gpio_chip is not viable, we would need
different content for each codec.

As almost all members are the same, what we do is use madera_gpio_chip
as a template and copy it into the gpio_chip member of
struct madera_gpio for this codec. That becomes the struct gpio_chip
that we're actually using for this instance of this codec.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCNTBm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:01:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751467AbeCNTBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:01:41 -0400
Subject: Re: [PATCH v2 1/2] hwmon: (ucd9000) Add gpio chip interface
To: Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
References: <1520974749-5372-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1520974749-5372-2-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75VdOzzmN=6K4H3rVGGaqMJ+q+nXnoY=qksNT6uvHnG6CAQ@mail.gmail.com>
 <20180314185542.GA23989@roeck-us.net>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 14:01:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314185542.GA23989@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031419-8235-0000-0000-00000D29593C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003037; UDB=6.00510431; IPR=6.00782367;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 19:01:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031419-8236-0000-0000-0000400FB6FA
Message-Id: <2e301c07-8880-0821-0549-9c52f5fb35f5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140207
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/14/2018 01:55 PM, Guenter Roeck wrote:
> On Tue, Mar 13, 2018 at 11:13:04PM +0200, Andy Shevchenko wrote:
>> On Tue, Mar 13, 2018 at 10:59 PM, Eddie James
>> <eajames@linux.vnet.ibm.com> wrote:
>>> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>>>
>>> Add a struct gpio_chip and define some methods so that this device's
>>> I/O can be accessed via /sys/class/gpio.
>>> +       /*
>>> +        * Note:
>>> +        *
>>> +        * Pinmux support has not been added to the new gpio_chip.
>>> +        * This support should be added when possible given the mux
>>> +        * behavior of these IO devices.
>>> +        */
>>> +       data->gpio.label = (const char *)&client->name;
>> Hmm... Why do you need this casting?
>>
>>> +       data->gpio.get_direction = ucd9000_gpio_get_direction;
>>> +       data->gpio.direction_input = ucd9000_gpio_direction_input;
>>> +       data->gpio.direction_output = ucd9000_gpio_direction_output;
>>> +       data->gpio.get = ucd9000_gpio_get;
>>> +       data->gpio.set = ucd9000_gpio_set;
>>> +       data->gpio.can_sleep = 1;
>> Isn't it type of boolean?
>>
> You are right.
>
>>> +       data->gpio.base = -1;
>>> +       data->gpio.parent = &client->dev;
>>> +       data->gpio.owner = THIS_MODULE;
>>> +       data->gpio.of_node = client->dev.of_node;
>> I think GPIO core does this for you.
>>
> Same here. I checked and found that it also sets the owner, so maybe this can be
> dropped as well.

Ah true. Especially since there is a TODO: remove chip->owner in the core.

>
>>> +       if (data->gpio.ngpio) {
>> Hmm...
>>
>> I would rather reorganize the above part to a separate helper, like
>>
>> static int ..._probe_gpio()
>> {
>> ...
>>    switch () {
>>     default:
>>       return 0; /* GPIO part is optional */
>>    }
>>    return 0;
>> }
>>
>> ret = _probe_gpio();
>> if (ret)
>>   dev_warn();
>>
> I am neutral to positiva on that.
> Might as well add the call to devm_gpiochip_add_data()
> into that function as well.

Sure. I can do a v4.

Thanks,
Eddie

>
>>> +               ret = devm_gpiochip_add_data(&client->dev, &data->gpio,
>>> +                                            client);
>>> +               if (ret)
>>> +                       dev_warn(&client->dev, "Could not add gpiochip: %d\n",
>>> +                                ret);
>>> +       }
>>> +
>>>          return pmbus_do_probe(client, mid, info);
>>>   }
>>>
>>> --
>>> 1.8.3.1
>>>
>>
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko

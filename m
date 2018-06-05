Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeFENdP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:33:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752069AbeFENdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:33:11 -0400
Subject: Re: [PATCH v9 2/7] i2c: Add FSI-attached I2C master algorithm
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528138850-18259-3-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75Vd7NvDFmWSzNDz-tgGvMVyXU7Z16LgGCWnHkY-3kE7fwg@mail.gmail.com>
 <7daf29f643bb0445fceef85b1a7fff71048f2aa6.camel@kernel.crashing.org>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Tue, 5 Jun 2018 08:31:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7daf29f643bb0445fceef85b1a7fff71048f2aa6.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060513-0036-0000-0000-000009E817D3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009133; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042672; UDB=6.00533929; IPR=6.00821802;
 MB=3.00021476; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-05 13:31:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060513-0037-0000-0000-0000478D50E8
Message-Id: <adbc4f16-326c-1cc8-a293-cfd5e2d8a070@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050156
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/2018 06:38 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2018-06-04 at 22:21 +0300, Andy Shevchenko wrote:
>>> +#define I2C_INT_ENABLE         0x0000ff80
>>> +#define I2C_INT_ERR            0x0000fcc0
>> Now it looks like a flags combinations.
>> For me as for reader would be better to see quickly a decoded line.
>>
>> My proposal is to introduce something like following
>>
>> _INT_ALL  GENMASK()
>> _INT_ENABLE (_INT_ALL & ~(_FOO | _BAR))
>> _INT_ERR ... similar way as above ...
>>
>> What do you think?
> I don't think this absolutely needs to change but yes, open coding is
> error prone. However I would think it more readable to use positive
> logic and just list all the bits that are *set* even if it's a bit more
> text:
>
> #define I2C_INT_ERR	(I2C_INT_INV_CMD	|\                			
>   I2C_INT_PARITY         |\
> 			 I2C_INT_BE_OVERRUN	|\
> 			.../...)
>
> #define I2C_INT_ENABLE	(I2C_INT_ERR		|\
> 			 I2C_INT_DAT_REQ	|\
> 			 I2C_INT_CMD_COMP)
>
> Note: Eddie, I notice I2C_INT_BUSY is in "ERR" but not in "ENABLE", any
> reason for that ?

Yes, we don't want to enable an interrupt if I2C gets into the busy 
state, as that happens during every transfer.  However it would likely 
be an error condition if we get that when the transfer is supposed to be 
complete. These were from the legacy driver... I just realized that 
neither are actually being used in this driver, so I will drop them.

Thanks,
Eddie

>
> Cheers,
> Ben.
>

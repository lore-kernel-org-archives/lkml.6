Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A96A23F3E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A96A23F3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeGFJGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:06:19 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:56828 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753056AbeGFJGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:06:14 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6693nmk006622;
        Fri, 6 Jul 2018 04:03:58 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2k0dnv3ecj-1;
        Fri, 06 Jul 2018 04:03:58 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 91D3C611C8AC;
        Fri,  6 Jul 2018 04:04:57 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.301.0; Fri, 6 Jul 2018
 10:03:57 +0100
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w6693raW028179;        Fri, 6 Jul 2018 10:03:54 +0100
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>, <patches@opensource.cirrus.com>,
        <linux-i2c@vger.kernel.org>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
 <7058252.SGNltMTCCa@z50> <20180705055037.GI496@dell> <1579112.qQSMXVQn9s@z50>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <4ecc2072-3ec3-6e9b-576f-fd05559e7634@opensource.cirrus.com>
Date:   Fri, 6 Jul 2018 10:03:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1579112.qQSMXVQn9s@z50>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1806210000
 definitions=main-1807060101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/18 21:56, Janusz Krzysztofik wrote:
> On Thursday, July 5, 2018 7:50:37 AM CEST Lee Jones wrote:
>> On Wed, 04 Jul 2018, Janusz Krzysztofik wrote:
>>> On Tuesday, July 3, 2018 7:31:41 PM CEST Boris Brezillon wrote:
>>>> Hi Janusz,
>>>>
>>>> On Tue,  3 Jul 2018 19:26:35 +0200
>>>>
>>>> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
>>>>> Avoid replication of error code conversion in non-DT GPIO consumers'
>>>>> code by returning -EPROBE_DEFER from gpiod_find() in case a chip
>>>>> identified by its label in a registered lookup table is not ready.
>>>>>
>>>>> See https://lkml.org/lkml/2018/5/30/176 for example case.
>>>>>
>>>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>>>> ---
>>>>> If accepted, please add
>>>>>
>>>>> 	Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>>>>
>>>>> if Boris doesn't mind.
>>>>>
>>>>> Thanks,
>>>>> Janusz
>>>>>
>>>>>   drivers/gpio/gpiolib.c | 13 ++++++++++---
>>>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>>>>> index e11a3bb03820..15dc77c80328 100644
>>>>> --- a/drivers/gpio/gpiolib.c
>>>>> +++ b/drivers/gpio/gpiolib.c
>>>>> @@ -3639,9 +3639,16 @@ static struct gpio_desc *gpiod_find(struct
>>>>> device
>>>>> *dev, const char *con_id,>
>>>>>
>>>>>   		chip = find_chip_by_name(p->chip_label);
>>>>>   		
>>>>>   		if (!chip) {
>>>>>
>>>>> -			dev_err(dev, "cannot find GPIO chip %s\n",
>>>>> -				p->chip_label);
>>>>> -			return ERR_PTR(-ENODEV);
>>>>> +			/*
>>>>> +			 * As the lookup table indicates a chip with
>>>>> +			 * p->chip_label should exist, assume it may
>>>>> +			 * still appear latar and let the interested
>>>>>
>>>> 					^ later
>>>>>
>>>>> +			 * consumer be probed again or let the Deferred
>>>>> +			 * Probe infrastructure handle the error.
>>>>> +			 */
>>>>> +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
>>>>> +				 p->chip_label);
>>>>> +			return ERR_PTR(-EPROBE_DEFER);
>>>>>
>>>>>   		}
>>>>>   		
>>>>>   		if (chip->ngpio <= p->chip_hwnum) {
>>>>
>>>> Looks good otherwise. Let's hope we're not breaking implementations
>>>> testing for -ENODEV...
>>>
>>> I've reviewed them all and found two which I think may be affected:
>>> - drivers/mfd/arizona-core.c,
>>> - drivers/i2c/busses/i2c-imx.c.
>>> As far as I can understand the code, both depend on error != -EPROBE_DEFER
>>> in order to continue in degraded mode. I'm adding their maintainers to
>>> the loop.
>>  From a quick glance, the -EPROBE_DEFER handing in Arizona Core appears
>> to be correct.  Would you mind explaining what your concerns are in
>> more detail please?
> 
> Hi
> 
> That's more about handling -ENODEV rather than -EPROBE_DEFER.
> 
> Before the change, if GPIO chip supposed to provide "reset" pin was not ready
> during  arizona_dev_init(), devm_gpiod_get() returned -ENODEV and device was
> initialized in degraded mode, i.e., with no control over the "reset" pin.
> After the change, gpiod_get() will return -EPROBE_DEFER in such case and
> arizona_dev_init() won't succeed in case the GPIO chip doesn't appear later
> for some reason.
> 
> Thanks,
> Januszz
> 
> 

The intention is that if the DT node is missing, the Arizona driver can run
using only soft reset, though there are limitations in that mode.
This should return -ENOENT so that the Arizona driver will continue without
a GPIO.

If the DT defines a GPIO it is effectively saying that this GPIO is required so
it is valid for the Arizona driver never to come up if the GPIO it is defined to
depend on doesn't come up.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966095AbeEJObt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:31:49 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:63012 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965266AbeEJObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:31:47 -0400
Subject: Re: [PATCH v4 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Dan Murphy <dmurphy@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180510122718.8413-1-dmurphy@ti.com>
 <20180510122718.8413-2-dmurphy@ti.com>
 <87eaf628-3cf6-6855-5732-b0e5291f3b34@ti.com>
 <08526618-7463-1e6e-a4ac-c4da4627c1b2@ti.com>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <7832225b-115c-2316-025e-29929cd4f208@ti.com>
Date: Thu, 10 May 2018 09:31:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <08526618-7463-1e6e-a4ac-c4da4627c1b2@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 09:04 AM, Dan Murphy wrote:

>>> +static int lm3601x_remove(struct i2c_client *client)
>>> +{
>>> +	struct lm3601x_led *led = i2c_get_clientdata(client);
>>> +
>>> +	regmap_write(led->regmap, LM3601X_ENABLE_REG, 0);
>>> +
>>
>>
>> If probe doesn't enable this, remove shouldn't disable it. It can lead
>> to odd cases if the driver is removed and added again.
> 
> I want to make sure the LED is off and in standby mode.  Maybe I will just set it to
> the default value instead.
> 


Why? If you want to do this then implement PM controls and put it in
standby mode there.


>>
>> Plus, removing the driver is not a command to disable the LED anyway.
> 
> True but you don't want to leave any LEDs in the on state without a driver to support it.
> This could burn out the LED or the board if left on on max brightness
> 


I disagree, we should not try to decide what the user wants here. We
should only do what we are instructed to do, which for remove() is to
cleanup what probe has done so the driver can be removed w/o leaking
memory or device state.


> 
> Dan
> 

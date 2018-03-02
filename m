Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946510AbeCBRT0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:19:26 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:20239 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1945949AbeCBRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:19:24 -0500
Subject: Re: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
To: Russell King - ARM Linux <linux@armlinux.org.uk>
CC: Pavel Machek <pavel@ucw.cz>, Linus Walleij <linus.walleij@linaro.org>,
        Martijn Braam <martijn@brixit.nl>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Ivajlo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        ext Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        =?UTF-8?B?TWlja3Vsw6HFoSBRd2VydHo=?= <abcloriens@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>, <clayton@craftyguy.net>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Patrik Bachan <patrikbachan@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <serge@hallyn.com>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd>
 <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
 <20180302111040.GA6344@amd> <0f090cc7-2b72-a038-26ee-d43077cb9663@ti.com>
 <20180302170841.GP28231@n2100.armlinux.org.uk>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <8cf3f026-4d65-71ac-60ed-3e9427139843@ti.com>
Date: Fri, 2 Mar 2018 11:18:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302170841.GP28231@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 11:08 AM, Russell King - ARM Linux wrote:
> On Fri, Mar 02, 2018 at 08:22:52AM -0600, Andrew F. Davis wrote:
>>> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
>>> index 84e5a9d..f0fab26 100644
>>> --- a/drivers/gpio/gpiolib-of.c
>>> +++ b/drivers/gpio/gpiolib-of.c
>>> @@ -241,29 +241,17 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
>>>  
>>>  		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
>>>  						&of_flags);
>>> -		/*
>>> -		 * -EPROBE_DEFER in our case means that we found a
>>> -		 * valid GPIO property, but no controller has been
>>> -		 * registered so far.
>>> -		 *
>>> -		 * This means we don't need to look any further for
>>> -		 * alternate name conventions, and we should really
>>> -		 * preserve the return code for our user to be able to
>>> -		 * retry probing later.
>>> -		 */
>>> -		if (IS_ERR(desc) && PTR_ERR(desc) == -EPROBE_DEFER)
>>> -			return desc;
>>>  
>>> -		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
>>> +		if (!IS_ERR(desc) || PTR_ERR(desc) != -ENOENT)
>>
>>
>> I rather like the () so one doesn't always have to look up C operator
>> precedence to verify..
> 
> Too many make it impossible to see which close paren ties up with
> which open paren.  I've spent way too long in the past reformatting
> code, where people think that () are a good thing, to work out what
> the comparison is actually doing before then rewriting the damn
> thing with less () and in a much clearer way.  I'm now convinced
> that unnecessary () are a very bad thing as they severely harm
> readability as test complexity increases.
> 


Fair enough, I personally prefer always having a new line per condition
when doing chained conditionals:

if (something &&
    this == that &&
    !not_this)


>>
>>
>>>  			break;
>>>  	}
>>>  
>>>  	/* Special handling for SPI GPIOs if used */
>>> -	if (IS_ERR(desc))
>>> +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
> 
> These can be simplified to:
> 
> 	if (desc == ERR_PTR(-ENOENT))
> 
> since error pointers are unique - ERR_PTR(-ENOENT) is what was
> returned as an error-pointer, and if IS_ERR(ERR_PTR(-ENOMENT)) etc
> were false, we'd have big problems as it'd mean we couldn't detect
> error pointers!
> 
> As an added bonus, they don't involve any operator precedence
> questions either.
> 

Looks like your suggestion clears up this one anyway.

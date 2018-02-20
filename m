Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeBTQkF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:40:05 -0500
Received: from vern.gendns.com ([206.190.152.46]:48463 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753233AbeBTQkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:40:02 -0500
Subject: Re: [PATCH v4] reset: add support for non-DT systems
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>
References: <20180219165837.28913-1-brgl@bgdev.pl>
 <72cd2af4-ed6b-8c1b-2488-b999976b894a@lechnology.com>
 <1519123185.3470.5.camel@pengutronix.de>
From: David Lechner <david@lechnology.com>
Message-ID: <8ef4b901-f38d-d885-e7bc-657202a2e248@lechnology.com>
Date: Tue, 20 Feb 2018 10:40:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1519123185.3470.5.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 04:39 AM, Philipp Zabel wrote:
> Hi Bartosz, David,
> 
> On Mon, 2018-02-19 at 18:21 -0600, David Lechner wrote:
>> On 02/19/2018 10:58 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> The reset framework only supports device-tree. There are some platforms
>>> however, which need to use it even in legacy, board-file based mode.
>>>
>>> An example of such architecture is the DaVinci family of SoCs which
>>> supports both device tree and legacy boot modes and we don't want to
>>> introduce any regressions.
>>>
>>> We're currently working on converting the platform from its hand-crafted
>>> clock API to using the common clock framework. Part of the overhaul will
>>> be representing the chip's power sleep controller's reset lines using
>>> the reset framework.
>>>
>>> This changeset extends the core reset code with new reset lookup
>>> structures. Each lookup table contains a set of lookup entries which
>>> allow the reset core to associate reset lines with devices (by
>>> comparing the dev_id and con_id strings).
>>>
>>> Machine code can register a set of reset lines using this lookup table
>>> and concerned devices can access them using the regular reset_control
>>> API.
>>>
>>> The new lookup function is only called as a fallback in case the
>>> of_node field is NULL and doesn't change anything for current users.
>>>
>>> Tested with a dummy reset driver with several lookup entries.
>>>
>>> An example lookup table can be found below:
>>>
>>> static struct platform_device foobar_reset_dev = {
>>>           .name = "foobar-reset",
>>> };
>>>
>>> static struct reset_lookup_entry foobar_reset_lookup_entries[] = {
>>>           { .con_id = "foo",    id = 15 },
>>>           { .con_id = "bar",    id = 5  },
>>> };
>>>
>>> static struct reset_lookup_table foobar_reset_lookup_table = {
>>>           .dev_id = "foobar-device",
>>>           .entries = foobar_reset_lookup_entries,
>>>           .num_entries = ARRAY_SIZE(foobar_reset_lookup_entries),
>>>           .dev = &foobar_reset_dev.dev,
>>> };
>>>
>>
>> This seems like a lot of boilerplate to register a lookup.
> 
> This could be shortened a bit by following the gpiod lookup model,
> adding a RESET_LOOKUP macro and making the array NULL terminated:
> 
> #define RESET_LOOKUP(reset_dev_id, idx, con_id) /*...*/
> 
> static struct reset_lookup_table foobar_reset_lookup_table = {
> 	.dev_id = "foobar-device",
> 	.entries = {
> 		RESET_LOOKUP("foobar-reset.0", 15, "foo"),
> 		RESET_LOOKUP("foobar-reset.0", 5, "bar"),
> 		{ },
> 	},
> };
> 
> 	/*...*/
> 	reset_add_lookup_table(&foobar_reset_lookup_table);
> 
>>   Can we have
>> something like phy_create_lookup() instead where there is just a single
>> function call to register a single lookup? This will be much easier to
>> use in the davinci PSC driver.
>>
>> void reset_add_lookup(struct reset_controller_dev *rdev, int index,
>> 		      const char *dev_id, const char *con_id);
> 
> In your case the platform code that adds the lookup may be identical to
> the code that registers the struct reset_controller_dev, but that
> doesn't have to be the case. I'm not sure how that is supposed to work
> for the phy framework (I see no platform code adding phy lookups, only
> drivers).
> 
> My point was that if the reset controller is registered by a separate
> driver, the platform code may not have access to the struct
> reset_controller_dev, or even the struct platform_device. I like that
> the gpiod lookups can match by dev_id of the gpio chip.
> 
> regards
> Philipp
> 

In our use case, we would be adding the lookup in the driver rather than
in the platform code, which is why I am suggesting doing it like the phy
framework.

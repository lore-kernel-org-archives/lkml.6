Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBHM5h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:57:37 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:38844 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbeBHM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:57:35 -0500
Subject: Re: [PATCH 2/7] soc: davinci: new genpd driver
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <20180207134553.13510-3-brgl@bgdev.pl>
 <65f2690c-c605-3c66-9d8a-9a882aaf446d@ti.com>
 <CAMRc=Mf+S3k_wfhUWEx2-39AZx1szkgy-u-bsZQUMiaY06UKww@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <34d3980b-2c94-1540-94f0-dc0c86743475@ti.com>
Date: Thu, 8 Feb 2018 18:26:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mf+S3k_wfhUWEx2-39AZx1szkgy-u-bsZQUMiaY06UKww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 February 2018 03:24 PM, Bartosz Golaszewski wrote:
> 2018-02-08 10:30 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>> On Wednesday 07 February 2018 07:15 PM, Bartosz Golaszewski wrote:
>>> +     /*
>>> +      * DaVinci always uses a single clock for power-management. We assume
>>> +      * it's the first one in the clocks property.
>>> +      */
>>> +     clk = of_clk_get(dev->of_node, 0);
>>> +     if (IS_ERR(clk))
>>> +             return PTR_ERR(clk);
>>
>> We already get this today with drivers/base/power/clock_ops.c once
>> .con_ids list is dropped from pm_clk_notifier_block (which I think it
>> should).
>>
>> If there is no reason to introduce thus functionality at this stage,
>> perhaps we should wait till such a time when its clearly needed?
>>
>> Thanks,
>> Sekhar
> 
> If I understand correctly: once we drop the con_ids list, we end up
> calling clk_get(dev, NULL) from pm_clk_acquire(), which matches
> against the clock with NULL con_id, which may not necessarily be the
> first clock in the list.

Hmm, not sure of this. In __of_clk_get_by_name() called by clk_get():

int index = 0;

/*
 * For named clocks, first look up the name in the
 * "clock-names" property.  If it cannot be found, then
 * index will be an error code, and of_clk_get() will fail.
 */
if (name)
	index = of_property_match_string(np, "clock-names", name);

So, if no con_id is provided (name == NULL), then index is set to 0
which will always get the first clock in clocks = list.

Thanks,
Sekhar

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEBPJg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:09:36 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:10401 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeEBPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:09:23 -0400
Subject: Re: [PATCH v9 03/27] clk: davinci: psc: allow for dev == NULL
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-4-david@lechnology.com>
 <8940259b-5811-ce9f-8262-17d39ca0a46f@ti.com>
 <94d4cfc5-0ea7-e642-c7e3-8d549bdef8ce@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <3cec9c1f-48fd-1c16-b642-eb93e41446fc@ti.com>
Date: Wed, 2 May 2018 20:38:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <94d4cfc5-0ea7-e642-c7e3-8d549bdef8ce@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 May 2018 07:19 AM, David Lechner wrote:
> On 05/01/2018 09:02 AM, Sekhar Nori wrote:
>> On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>>> +static inline void *_devm_kzalloc(struct device *dev, size_t size,
>>> gfp_t flags)
>>> +{
>>> +    if (dev)
>>> +        return devm_kzalloc(dev, size, flags);
>>> +
>>> +    return kzalloc(size, flags);
>>> +}
>>
>> I have the same question on the utility of this. A memory allocation
>> error so early on is not going to result in a bootable system anyway.
>> So, I wonder if its better to just BUG() in such cases. That will
>> actually help faster debug than returning an error back. I know the push
>> back on using BUG(), but clock drivers are special, and I think thats
>> why its seems to be used quite a bit already.
>>
> 
> Same reply here as well. On DA850/DA830, you might not get a console,
> but you will "boot" even if one of the PSC devices fails though.

Was not thinking of failure to boot due to clocks being disabled, but
the fact that you are not able to allocate a small amount of memory so
early in boot process. The chances of successful boot after memory
allocation failures like that are close to zero.

> WARN() is probably just as good as BUG() in this case too.

Okay, but with WARN() you would continue to proceed to try to boot which
is not going to be much fruitful (and might actually muddle the first
failure). But up to you on this.

Thanks,
Sekhar

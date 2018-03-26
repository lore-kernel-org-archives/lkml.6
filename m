Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeCZSVy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:21:54 -0400
Received: from smtp02.mail.online.nl ([194.134.25.72]:46935 "EHLO
        smtp02.mail.online.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeCZSVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:21:52 -0400
Subject: Re: [PATCH v2] of_net: Implement of_get_nvmem_mac_address helper
To: Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andrew@lunn.ch, robh+dt@kernel.org,
        frowand.list@gmail.com
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
 <20180323151101.GB24361@lunn.ch>
 <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
 <20180326.125816.1498152294570222508.davem@davemloft.net>
 <40e5302c-0c00-dba0-58d3-77407aa6bde8@gmail.com>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <8a2911a7-0511-9122-26ba-f100cd724bea@topic.nl>
Date: Mon, 26 Mar 2018 20:21:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <40e5302c-0c00-dba0-58d3-77407aa6bde8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-03-18 19:05, Florian Fainelli wrote:
> On 03/26/2018 09:58 AM, David Miller wrote:
>> From: Mike Looijmans <mike.looijmans@topic.nl>
>> Date: Mon, 26 Mar 2018 08:41:29 +0200
>>
>>> It's common practice to store MAC addresses for network interfaces into
>>> nvmem devices. However the code to actually do this in the kernel lacks,
>>> so this patch adds of_get_nvmem_mac_address() for drivers to obtain the
>>> address from an nvmem cell provider.
>>>
>>> This is particulary useful on devices where the ethernet interface cannot
>>> be configured by the bootloader, for example because it's in an FPGA.
>>>
>>> Tested by adapting the cadence macb driver to call this instead of
>>> of_get_mac_address().
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> ---
>>> v2: Use of_nvmem_cell_get to avoid needing the assiciated device
>>>      Use void* instead of char*
>>>      Add devicetree binding doc
>>
>> Like Andrew, I think you should add a new interface for getting the MAC
>> address from nvmem.
>>
>> And drivers can call both of them if they want OF device tree and
>> NVMEM probing for MAC addresses.
>>
>> Later you can add a consolidated interface, if necessary, which does
>> both and also take a reference to the MAC address buffer of the driver
>> in order to deal with the resource allocation issues.
> 
> Agreed, also, how does this fit with Alban's patch series here:

Ok, makes sense. I'll cook up a v3.

> 
> https://lkml.org/lkml/2018/3/24/312
> 
> do you depend on those changes at all?
> 

As far as I can tell, there's no dependency, I'm adding an nvmem 
"consumer" while Alban's patch adds a "provider". I'm mainly interested 
in storing the MAC address into an I2C EEPROM, which you can also buy 
with a pre-programmed MAC address in the first 6 bytes, so there's no 
production cost for managing that.


Alban's patch might some day collide with my idea of making hardware 
that has some unique ID into nvmem providers, like 1-wire chips, some 
NOR flash chips (there's the conflict) and various other devices. That 
would allow a board to obtain a random yet constant MAC address without 
any additional hardware. I'll cross that bridge when I find it.


-- 
Mike Looijmans

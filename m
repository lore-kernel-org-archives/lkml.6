Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeCHT6F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:58:05 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43447 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932269AbeCHT6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:58:01 -0500
X-Google-Smtp-Source: AG47ELuyW01T+O7y7S4UBUxIylqVnnUzZhigXkmSkRN0qo7rcagM/Uz0pdsvxBJHEgoujeYOH42NXQ==
Subject: Re: [PATCH] net: phy: Move interrupt check from phy_check to
 phy_interrupt
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: Brad Mouring <brad.mouring@ni.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180307225042.2205-1-brad.mouring@ni.com>
 <704e7f37-2b94-7e1f-c42f-374254bc791c@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <c9b61b5e-6cd6-dcf3-c7d9-c7fe9b163e80@cogentembedded.com>
Date: Thu, 8 Mar 2018 22:57:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <704e7f37-2b94-7e1f-c42f-374254bc791c@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 10:41 PM, Sergei Shtylyov wrote:

>> If multiple phys share the same interrupt (e.g. a multi-phy chip),
>> the first device registered is the only one checked as phy_interrupt
>> will always return IRQ_HANDLED if the first phydev is not halted.
>> Move the interrupt check into phy_interrupt and, if it was not this
>> phydev, return IRQ_NONE to allow other devices on this irq a chance
>> to check if it was their interrupt.
> 
>    Hm, looking at kernel/irq/handle.c, all registered IRQ handlers are always
> called regardless of their results. Care to explain?
> 
>> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
>> ---
>>  drivers/net/phy/phy.c | 16 ++++++----------
>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>> index e3e29c2b028b..ff1aa815568f 100644
>> --- a/drivers/net/phy/phy.c
>> +++ b/drivers/net/phy/phy.c
>> @@ -632,6 +632,12 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
>>  	if (PHY_HALTED == phydev->state)
>>  		return IRQ_NONE;		/* It can't be ours.  */
>>  
>> +	if (phy_interrupt_is_valid(phydev)) {
> 
>   Always true in this context, no?
> 
>> +		if (phydev->drv->did_interrupt &&
>> +			!phydev->drv->did_interrupt(phydev))
> 
>    I don't think we can do this in the interrupt context as this function *will*
> read from MDIO... I think that was the reason why IRQ handling is done in the
> thread context...

   Ah, we're already in a thread context here! Forgot about it...
 
> [...]

MBR, Sergei

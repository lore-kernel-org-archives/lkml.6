Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeBJAGx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:06:53 -0500
Received: from regular1.263xmail.com ([211.150.99.137]:48632 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbeBJAGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:06:51 -0500
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: briannorris@chromium.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <646148455871b15348c0565b729917d1>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A7E378F.4060100@rock-chips.com>
Date: Sat, 10 Feb 2018 08:06:39 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Brian Norris <briannorris@chromium.org>
CC: linux-kernel@vger.kernel.org, briannorris@google.com, dtor@google.com,
        dianders@google.com, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] Input: gpio-keys - allow setting wakeup interrupt
 trigger type in DT
References: <20180209115510.11868-1-jeffy.chen@rock-chips.com> <20180209115510.11868-3-jeffy.chen@rock-chips.com> <20180209234246.GA252335@ban.mtv.corp.google.com>
In-Reply-To: <20180209234246.GA252335@ban.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

Thanks for your reply.

On 02/10/2018 07:42 AM, Brian Norris wrote:
> Hi Jeffy,
>
> On Fri, Feb 09, 2018 at 07:55:09PM +0800, Jeffy Chen wrote:
>> Allow specifying a different interrupt trigger type for wakeup when
>> using the gpio-keys input device as a wakeup source.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>>   Documentation/devicetree/bindings/input/gpio-keys.txt | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> index a94940481e55..61926cef708f 100644
>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> @@ -26,6 +26,15 @@ Optional subnode-properties:
>>   	  If not specified defaults to 5.
>>   	- wakeup-source: Boolean, button can wake-up the system.
>>   			 (Legacy property supported: "gpio-key,wakeup")
>> +	- wakeup-trigger-type: Specifies the interrupt trigger type for wakeup.
>> +		 The value is defined in <dt-bindings/interrupt-controller/irq.h>
>
> Do you really want to codify interrupt triggers here? It seems like most
> of the information about edge vs. level is already codified elsewhere,
> so this becomes a little redundant. And in fact, some bindings may be
> specifying a "gpio", not technically an interrupt (at least not
> directly), so it feels weird to apply IRQ_* flags to them right here.
> Anyway, I think he only piece you really want to describe here is, do we
> wake on "event asserted", "event deasserted", or both. (The "none" case
> would just mean you shouldn't have the "wakeup-source" property.)
>
> So maybe:
>
> 	wakeup-trigger-type: Specifies whether the key should wake the
> 	system when asserted, when deasserted, or both. This property is
> 	only valid for keys that wake up the system (e.g., when the
> 	"wakeup-source" property is also provided). Supported values
> 	are:
> 	  1: asserted
> 	  2: deasserted
> 	  3: both asserted and deasserted
>
> ? We could still make macros out of those, if we want
> (input/linux-event-codes.h?). And then leave it up to the driver to
> determine how to translate that into the appropriate edge or level
> triggers.
make sense, will do it in the next version.
>
> Brian
>
>> +		 Only the following flags are supported:
>> +			IRQ_TYPE_NONE
>> +			IRQ_TYPE_EDGE_RISING
>> +			IRQ_TYPE_EDGE_FALLING
>> +			IRQ_TYPE_EDGE_BOTH
>> +			IRQ_TYPE_LEVEL_HIGH
>> +			IRQ_TYPE_LEVEL_LOW
>>   	- linux,can-disable: Boolean, indicates that button is connected
>>   	  to dedicated (not shared) interrupt which can be disabled to
>>   	  suppress events from the button.
>> --
>> 2.11.0
>>
>>
>
>
>

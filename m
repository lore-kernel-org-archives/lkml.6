Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbeEXNZl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:25:41 -0400
Received: from foss.arm.com ([217.140.101.70]:44788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbeEXNZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:25:38 -0400
Subject: Re: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
 <af81ea74-fb80-11e2-7bdc-d3607bdbd46b@arm.com>
 <20180523181058.GC27570@roeck-us.net>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <91d27df4-29d0-de7f-6805-c3e5f329caf3@arm.com>
Date: Thu, 24 May 2018 14:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523181058.GC27570@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/18 19:10, Guenter Roeck wrote:
> On Wed, May 23, 2018 at 11:57:25AM +0100, Robin Murphy wrote:
>> On 22/05/18 19:47, Ray Jui wrote:
>>> Update the SP805 binding document to add optional 'timeout-sec'
>>> devicetree property
>>>
>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>   Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>> index edc4f0e..f898a86 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>> +++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>> @@ -19,6 +19,8 @@ Required properties:
>>>   Optional properties:
>>>   - interrupts : Should specify WDT interrupt number.
>>> +- timeout-sec : Should specify default WDT timeout in seconds. If unset, the
>>> +                default timeout is 30 seconds
>>
>> According to the SP805 TRM, the default interval is dependent on the rate of
>> WDOGCLK, but would typically be a lot longer than that :/
>>
> Depends on the definition of "default". In the context of watchdog drivers,
> it is (or should be) a driver default, not a chip default.

DT describes hardware, not driver behaviour.

I appreciate that where a timeout *is* specified, that is effectively a 
hardware aspect even if it's something an OS consuming the binding still 
has to voluntarily program into the device. The notion of "this is the 
longest period of time for which you can reasonably expect to see no 
activity under normal operation" is indeed a property of the platform as 
a whole - a system with user-accessible PCIe slots may need to reflect 
the worst case of one CPU waiting for an ATS invalidation timeout with 
interrupts disabled, whereas a much shorter period might be appropriate 
for the same SoC in some closed-down embedded device.

The absence of the property, though, doesn't convey anything other than 
"I don't know" and/or "it doesn't really matter", and in that situation 
the default is always going to be "whatever the OS thinks is 
appropriate". The binding itself can't possibly know, whereas an OS 
might be configured for some pseudo-real-time application which it knows 
warrants a maximum of 100ms regardless of what the DT does or doesn't 
say. In the case of SP805, if the OS doesn't reconfigure it at all, 
there happens to be an actual hardware default of (2^32 / WDOGCLK), but 
since that's already implicit in the compatible it doesn't really need 
saying either.

Optional properties don't need to explicitly state what their absence 
might infer, especially when it's not directly meaningful (just imagine 
trying to do that for bindings/regulator/regulator.txt...), so I would 
suggest following the 93% of existing bindings which simply don't try to 
claim some default value for this property.

I also think the fact that, within the context of this patch series, the 
Linux driver doesn't even do what the binding claims only goes to help 
make my point ;)

Robin.

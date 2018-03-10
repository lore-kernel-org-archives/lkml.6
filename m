Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932832AbeCJECz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 23:02:55 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37405 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbeCJECy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 23:02:54 -0500
X-Google-Smtp-Source: AG47ELsZ0fCIsBYH7I7c6gouG/iD+rFL2QgNJMJ9O7z3bE3HDJhexPvMIe4lUuCj973D/sK2BiH/rg==
Subject: Re: [PATCH 1/2] watchdog: dw: RMW the control register
To: Brian Norris <briannorris@chromium.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20180310024431.160195-1-briannorris@chromium.org>
 <03a9d600-af54-ee43-1141-082278ebf672@roeck-us.net>
 <20180310032846.GA180802@rodete-desktop-imager.corp.google.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e5e1ce47-bf53-70ef-35d3-bab0996fb66d@roeck-us.net>
Date: Fri, 9 Mar 2018 20:02:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310032846.GA180802@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 03/09/2018 07:28 PM, Brian Norris wrote:
> Hi,
> 
> On Fri, Mar 09, 2018 at 07:20:38PM -0800, Guenter Roeck wrote:
>> On 03/09/2018 06:44 PM, Brian Norris wrote:
>>> RK3399 has rst_pulse_length in CONTROL_REG[4:2], determining the length
>>> of pulse to issue for system reset. We shouldn't clobber this value,
>>> because that might make the system reset ineffective. On RK3399, we're
>>> seeing that a value of 000b (meaning 2 cycles) yields an unreliable
>>> (partial?) reset, and so we only fully reset after the watchdog fires a
>>> second time. If we retain the system default (010b, or 8 clock cycles),
>>> then the watchdog reset is much more reliable.
>>>
>>> Read-modify-write retains the system value and improves reset
>>> reliability.
>>>
>>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>>> ---
>>>    drivers/watchdog/dw_wdt.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
>>> index c2f4ff516230..6925d3e6c6b3 100644
>>> --- a/drivers/watchdog/dw_wdt.c
>>> +++ b/drivers/watchdog/dw_wdt.c
>>> @@ -34,6 +34,7 @@
>>>    #define WDOG_CONTROL_REG_OFFSET		    0x00
>>>    #define WDOG_CONTROL_REG_WDT_EN_MASK	    0x01
>>> +#define WDOG_CONTROL_REG_RESP_MODE_MASK	    0x02
>>>    #define WDOG_TIMEOUT_RANGE_REG_OFFSET	    0x04
>>>    #define WDOG_TIMEOUT_RANGE_TOPINIT_SHIFT    4
>>>    #define WDOG_CURRENT_COUNT_REG_OFFSET	    0x08
>>> @@ -124,11 +125,16 @@ static int dw_wdt_set_timeout(struct watchdog_device *wdd, unsigned int top_s)
>>>    static int dw_wdt_start(struct watchdog_device *wdd)
>>>    {
>>>    	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
>>> +	u32 val;
>>>    	dw_wdt_set_timeout(wdd, wdd->timeout);
>>> -	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
>>> -	       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
>>> +	val = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
>>> +	/* Disable interrupt mode; always perform system reset. */
>>> +	val &= ~WDOG_CONTROL_REG_RESP_MODE_MASK;
>>
>> You don't talk about this change in the description.
> 
> I guess I could mention it. I was assuming that was an intended behavior
> of the existing driver: that we set resp_mode=0 (via clobber), so we
> always get a system reset (we don't try to handle any interrupt in this
> driver).
>
I don't think it was intended behavior. We don't even know for sure (or at least
I don't know) if all implementations of this IP have the same configuration bit
layout. All we can do is hope for the best.

Still, clobbering just 1 bit is better than clobbering 30 bit.

Thanks,
Guenter

> I'll include something along those lines in the commit message.
> 
>>> +	/* Enable watchdog. */
>>> +	val |= WDOG_CONTROL_REG_WDT_EN_MASK;
>>> +	writel(val, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
>>>    	return 0;
>>>    }
>>>
>>
>> Similar code is in dw_wdt_restart(), where it may be equally or even
>> more important. Granted, only if the watchdog isn't running, but still...
> 
> Oh, I misread that code. It looked like an read/modify/write already,
> but it was actually just a read/check/write. I should fix that, since
> otherwise the restart will clobber the very thing I'm trying to fix
> here, which might actually make the intended machine restart quite
> ineffective.
> 
> Thanks,
> Brian
> 

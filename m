Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3224020878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CLmQ3RpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3224020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeGJIBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:01:34 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39704 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeGJIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:01:33 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so40898371oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xBshCbIP9kcPO4YjFvZg6AWSXEnyw/dh8APn7DxB+Cs=;
        b=CLmQ3RpW/zMhnPo/Lhh2nDyCNCIY0d+yyrCJNYFbOyO2q+Q8h04i2/Q4ntgLyvJTpX
         PKWxf6SF+suFROdhIZnxDttPbjeXiIwOaIutEpcs/8+WWWyxLHErxY2cdtM8xWEuEKEZ
         2r5rhf6fdCQHdD4vbq3mVeqrONZ4HaGu9tsCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xBshCbIP9kcPO4YjFvZg6AWSXEnyw/dh8APn7DxB+Cs=;
        b=hECEUCsWoEC99vKG33ls+oidScsIhtIJiC7cIAXE7RqbNElUNpG6tK40zJGjOmfqvJ
         cW5R0xKrZSVu5xR5HvZTZr6/aYecUhuWSVk7icGSBCGa2Ce89s3bXV8gqbFKCZCaA/G4
         Joow61Hh4X5bA2U0PD6A5sY+1Bhf+2Kis42kdbRoQyPlXu5JPPz3SZCkZXOXPO0skkMg
         RkoUITzK3GfsC1VjjBwzkx6xu+/j7B0X7fq7j4WkmMwKVAGVZ6z/JhWBgwzX61UkuYYc
         YZVvkvlZDjnOgB4LE9ikND6H+k5f1uEz4x4COmEnLFFalwFmJW0PV5+0LjqUfADB5UEE
         EeAw==
X-Gm-Message-State: AOUpUlHw3/QiGNAZtawc9wuehaaDxx27be9GCYQ9QnAQqhALzp76LlfX
        ApPD/tjY63PhacKr55xRFYJdBT6riqIf+hlO3K6YCQ==
X-Google-Smtp-Source: AAOMgpcjI8E8BTYwd+a1L2HoiV0aLTsFDCnLxAl8kmgTJ74tdGE9RglcvfWPnNH99dbWCKOmhBcBEgHTfFYxqTyR24k=
X-Received: by 2002:aca:44c5:: with SMTP id r188-v6mr6948731oia.280.1531209692282;
 Tue, 10 Jul 2018 01:01:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 01:01:31
 -0700 (PDT)
In-Reply-To: <CABe79T4qj6SaZJzTn_ZY7XfGkj_z6JJ57+WfMm3zGE7XLbT4Lg@mail.gmail.com>
References: <1531131569-13727-1-git-send-email-srinath.mannam@broadcom.com>
 <055f7c8a-c3c9-af3a-d762-a26329270e4d@roeck-us.net> <CABe79T4qj6SaZJzTn_ZY7XfGkj_z6JJ57+WfMm3zGE7XLbT4Lg@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 10 Jul 2018 13:31:31 +0530
Message-ID: <CABe79T4DumpWbtXj_g-zGdE59JmsdJNtHVnQpbvXKM92t1FJhg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] watchdog: sp805: Add clock-frequency property
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

I missed your comment about "Clearing wdt->clk is useless." I will
remove that line.

Regards,
Srinath.

On Tue, Jul 10, 2018 at 1:27 PM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> Hi Guenter,
>
> Thank you for your feedback. Please find my answers in lined.
>
> On Mon, Jul 9, 2018 at 7:15 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 07/09/2018 03:19 AM, Srinath Mannam wrote:
>>>
>>> When using ACPI node, binding clock devices are
>>> not available as device tree, So clock-frequency
>>> property given in _DSD object of ACPI device is
>>> used to calculate Watchdog rate.
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> ---
>>>   drivers/watchdog/sp805_wdt.c | 34 ++++++++++++++++++++++++++--------
>>>   1 file changed, 26 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>>> index 9849db0..ad5ed64 100644
>>> --- a/drivers/watchdog/sp805_wdt.c
>>> +++ b/drivers/watchdog/sp805_wdt.c
>>> @@ -11,6 +11,7 @@
>>>    * warranty of any kind, whether express or implied.
>>>    */
>>>   +#include <linux/acpi.h>
>>>   #include <linux/device.h>
>>>   #include <linux/resource.h>
>>>   #include <linux/amba/bus.h>
>>> @@ -22,6 +23,7 @@
>>>   #include <linux/math64.h>
>>>   #include <linux/module.h>
>>>   #include <linux/moduleparam.h>
>>> +#include <linux/of.h>
>>>   #include <linux/pm.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/spinlock.h>
>>> @@ -65,6 +67,7 @@ struct sp805_wdt {
>>>         spinlock_t                      lock;
>>>         void __iomem                    *base;
>>>         struct clk                      *clk;
>>> +       u64                             rate;
>>>         struct amba_device              *adev;
>>>         unsigned int                    load_val;
>>>   };
>>> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>> unsigned int timeout)
>>>         struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>         u64 load, rate;
>>>   -     rate = clk_get_rate(wdt->clk);
>>> +       rate = wdt->rate;
>>>         /*
>>>          * sp805 runs counter with given value twice, after the end of
>>> first
>>> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>> unsigned int timeout)
>>>   static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>>   {
>>>         struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>> -       u64 load, rate;
>>> -
>>> -       rate = clk_get_rate(wdt->clk);
>>> +       u64 load;
>>>         spin_lock(&wdt->lock);
>>>         load = readl_relaxed(wdt->base + WDTVALUE);
>>> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct
>>> watchdog_device *wdd)
>>>                 load += wdt->load_val + 1;
>>>         spin_unlock(&wdt->lock);
>>>   -     return div_u64(load, rate);
>>> +       return div_u64(load, wdt->rate);
>>>   }
>>>     static int
>>> @@ -228,10 +229,27 @@ sp805_wdt_probe(struct amba_device *adev, const
>>> struct amba_id *id)
>>>         if (IS_ERR(wdt->base))
>>>                 return PTR_ERR(wdt->base);
>>>   -     wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> -       if (IS_ERR(wdt->clk)) {
>>> +       if (adev->dev.of_node) {
>>> +               wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> +               if (IS_ERR(wdt->clk)) {
>>> +                       ret = PTR_ERR(wdt->clk);
>>> +                       wdt->clk = NULL;
>>
>>
>> Clearing wdt->clk is useless.
>
> If not, clk_prepare_enable and clk_disable_unprepare functions calls
> made in this driver will crash.
Sorry I missed your point. I will remove that.
>
>>
>>> +               } else
>>> +                       wdt->rate = clk_get_rate(wdt->clk);
>>
>>
>> The else branch should be in { } as well per coding style.
> I will add the change.
>>
>>> +       } else if (has_acpi_companion(&adev->dev)) {
>>> +               /*
>>> +                * When Driver probe with ACPI device, clock devices
>>> +                * are not available, so watchdog rate get from
>>> +                * clock-frequency property given in _DSD object.
>>> +                */
>>> +               device_property_read_u64(&adev->dev, "clock-frequency",
>>> +                               &wdt->rate);
>>
>>
>> Continuation line alignment is off.
> I missed it, Thank you, I will make the change.
>>
>> Still not documented. Maybe that is common for ACPI devices nowadays.
>> If so, I'll need at least a pointer to a document or something declaring
>> that ACPI devices do not use well documented properties, and a confirmation
>> that using such properties is acceptable in the Linux kernel.
>>
> patches listed below has same approach to add ACPI support.
> ex:
> 1. commit 515da746983bc6382e380ba8b1ce9345a9550ffe
> Author: Naveen Kaje <nkaje@codeaurora.org>
> Date:   Tue Oct 11 10:27:56 2016 -0600
>
>     i2c: qup: add ACPI support
>
> 2. commit 82a19035d000c8b4fd7d6f61b614f63dec75d389
> Author: Lendacky, Thomas <Thomas.Lendacky@amd.com>
> Date:   Fri Jan 16 12:47:16 2015 -0600
>
>     amd-xgbe: Add ACPI support
>
>>> +               if (!wdt->rate)
>>> +                       ret = -ENODEV;
>>> +       }
>>> +
>>> +       if (ret) {
>>>                 dev_warn(&adev->dev, "Clock not found\n");
>>> -               ret = PTR_ERR(wdt->clk);
>>>                 goto err;
>>>         }
>>
>>
>> Please move the error handling to where the error occurs. While doing that,
>> please change the message to dev_err() - this is an error, not a warning -
>> and change the second error message to match the error (it did not find
>> the property).
>>
>> Also, return directly - the goto just generates another error message
>> which is ridiculous.
> Thank you, I will add the changes.
>>
>> Thanks,
>> Guenter
>
> Regards,
> Srinath.

Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476CDC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6A920661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2z98mdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6A920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeLCSdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:33:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37757 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeLCSdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:33:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so6756920wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cAOpKnHAD5ns1Ky+3IfAiM0nKtdg1D+Gm77eaVPxPaI=;
        b=Z2z98mdmJ3bsIHZ/nLo6i1c8QG6Gvagej87O0eV/eU7TNH+qQ3w96FJb9TuRpQGNoS
         CJSJ2HbT5QDZ6mXdXmvo6jE78X8o6NRhBnYlbPaiqERGX3lStrBi8w8c/LTmQuQ2aJwi
         Uy9b88jK3TlQzYXjcznFq8k4hJL9ZJs6zPWcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cAOpKnHAD5ns1Ky+3IfAiM0nKtdg1D+Gm77eaVPxPaI=;
        b=bdi74wJa+tgMeDP70nbTXfJbZbAbDztsN+ZBxeo/qqjSFQ1rKQqex79Ibgg4UwxtMd
         9LXlkPM/xnNdsQvNmPh0MQ/zCEDC7+g5Q6Ck/LESyAjSTtM49FTXDLiwhCBYng2aEe98
         E+XVQDtY/56wCZY5ypmao6BniEVlmosp1uydBYZ1q2BzJ9vlQ27i8VVXeIQIkjBW6HnU
         8zETp4kvWc7ViH2ZpoQtdT5lb58cRu4GH6RAGOHg7Ezj2lOTW/wtTyF0Zsg03xAE+94B
         rkK72Jaruw1FoI0lz0XfuymUglcJlqQi45MPA6m0A9sa7GPXOpMNAPqGrpRbddB/X4YL
         Bu9A==
X-Gm-Message-State: AA+aEWbqHo6CWrc4DbxFC7nwQgqs/jnOJCv+sT3ijZW3CHD0MSysfxbX
        LSH6j7j62FIOwdvh7Mct0WwqwA==
X-Google-Smtp-Source: AFSGD/Xni4YIOl7Xbj2epoxFnVWcf0++9wO3312dDrL3hhy7IZ8J4h8PwUboAqxyg92OjltTo4i0NA==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr9335620wmc.50.1543862015879;
        Mon, 03 Dec 2018 10:33:35 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id v133sm8106150wmd.4.2018.12.03.10.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:33:35 -0800 (PST)
Subject: Re: v4.14 fix for Hikey 960 unbalanced IRQ enablement
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
 <20181203141442.GA19335@kroah.com>
 <dc468512-7a73-3d69-fe9e-d660db85ee5b@linaro.org>
 <20181203151946.GG235790@sasha-vm> <20181203180521.GA15996@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6be6e40e-ce45-59ed-85e6-53b338b21dda@linaro.org>
Date:   Mon, 3 Dec 2018 19:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203180521.GA15996@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 19:05, Greg KH wrote:
> On Mon, Dec 03, 2018 at 10:19:46AM -0500, Sasha Levin wrote:
>> On Mon, Dec 03, 2018 at 03:42:41PM +0100, Daniel Lezcano wrote:
>>> On 03/12/2018 15:14, Greg KH wrote:
>>>> On Mon, Dec 03, 2018 at 11:31:02AM -0200, Rafael David Tinoco wrote:
>>>>> Sasha, could you consider including this cherry-picked patchset in v4.14.
>>>>>
>>>>> Kernel v4.14 might suffer from the following unbalanced enablement for the board Hikey 960:
>>>>>
>>>>> Nov  5 12:02:54 hikey kernel: [   22.148194] Unbalanced enable for IRQ 44
>>>>> Nov  5 12:02:54 hikey kernel: [   22.152193] ------------[ cut here ]------------
>>>>> Nov  5 12:02:54 hikey kernel: [   22.156872] WARNING: CPU: 2 PID: 509 at /home/inaddy/work/sources/linux/stable/stable-linux-4.14.y/kernel/irq/manage.c:525 __enable_irq+0x78/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.249606] CPU: 2 PID: 509 Comm: kworker/2:2 Not tainted 4.14.79 #1
>>>>> Nov  5 12:02:54 hikey kernel: [   22.255975] Hardware name: HiKey Development Board (DT)
>>>>> Nov  5 12:02:54 hikey kernel: [   22.261248] Workqueue: events_freezable thermal_zone_device_check
>>>>> Nov  5 12:02:54 hikey kernel: [   22.267368] task: ffff8000616e0e00 task.stack: ffff00000b5f0000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.273312] PC is at __enable_irq+0x78/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.277516] LR is at __enable_irq+0x78/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.281718] pc : [<ffff00000813e010>] lr : [<ffff00000813e010>] pstate: 000001c5
>>>>> Nov  5 12:02:54 hikey kernel: [   22.289129] sp : ffff00000b5f3c80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.292457] x29: ffff00000b5f3c80 x28: 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.297804] x27: ffff80005c139e38 x26: ffff000008a71870
>>>>> Nov  5 12:02:54 hikey kernel: [   22.303148] x25: 0000000000000000 x24: 0000000000000002
>>>>> Nov  5 12:02:54 hikey kernel: [   22.308492] x23: ffff00000b5f3d9c x22: ffff80005d565e88
>>>>> Nov  5 12:02:54 hikey kernel: [   22.313836] x21: 000000000000f980 x20: 000000000000002c
>>>>> Nov  5 12:02:54 hikey kernel: [   22.319181] x19: ffff800061726000 x18: 0000000000000010
>>>>> Nov  5 12:02:54 hikey kernel: [   22.324524] x17: 0000000000000000 x16: 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.329868] x15: ffffffffffffffff x14: ffff000009269c08
>>>>> Nov  5 12:02:54 hikey kernel: [   22.335213] x13: ffff00008940678f x12: ffff000009406797
>>>>> Nov  5 12:02:54 hikey kernel: [   22.340558] x11: ffff000009290000 x10: ffff00000b5f3980
>>>>> Nov  5 12:02:54 hikey kernel: [   22.345902] x9 : 00000000ffffffd0 x8 : ffff00000862c298
>>>>> Nov  5 12:02:54 hikey kernel: [   22.351246] x7 : 6c62616e65206465 x6 : 00000000000001b2
>>>>> Nov  5 12:02:54 hikey kernel: [   22.356589] x5 : 0000000000000000 x4 : 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.361931] x3 : 0000000000000000 x2 : ffff800063e824c8
>>>>> Nov  5 12:02:54 hikey kernel: [   22.367275] x1 : 000080005af95000 x0 : 000000000000001c
>>>>> Nov  5 12:02:54 hikey kernel: [   22.372618] Call trace:
>>>>> Nov  5 12:02:54 hikey kernel: [   22.375088] Exception stack(0xffff00000b5f3b40 to 0xffff00000b5f3c80)
>>>>> Nov  5 12:02:54 hikey kernel: [   22.381560] 3b40: 000000000000001c 000080005af95000 ffff800063e824c8 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.389417] 3b60: 0000000000000000 0000000000000000 00000000000001b2 6c62616e65206465
>>>>> Nov  5 12:02:54 hikey kernel: [   22.397276] 3b80: ffff00000862c298 00000000ffffffd0 ffff00000b5f3980 ffff000009290000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.405136] 3ba0: ffff000009406797 ffff00008940678f ffff000009269c08 ffffffffffffffff
>>>>> Nov  5 12:02:54 hikey kernel: [   22.412994] 3bc0: 0000000000000000 0000000000000000 0000000000000010 ffff800061726000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.420852] 3be0: 000000000000002c 000000000000f980 ffff80005d565e88 ffff00000b5f3d9c
>>>>> Nov  5 12:02:54 hikey kernel: [   22.428710] 3c00: 0000000000000002 0000000000000000 ffff000008a71870 ffff80005c139e38
>>>>> Nov  5 12:02:54 hikey kernel: [   22.436569] 3c20: 0000000000000000 ffff00000b5f3c80 ffff00000813e010 ffff00000b5f3c80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.444426] 3c40: ffff00000813e010 00000000000001c5 0000000000000000 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.452286] 3c60: ffffffffffffffff ffff800061800618 ffff00000b5f3c80 ffff00000813e010
>>>>> Nov  5 12:02:54 hikey kernel: [   22.460144] [<ffff00000813e010>] __enable_irq+0x78/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.465394] [<ffff00000813e058>] enable_irq+0x40/0x78
>>>>> Nov  5 12:02:54 hikey kernel: [   22.470493] [<ffff000000e228a8>] hisi_thermal_get_temp+0x1b0/0x1d8 [hisi_thermal]
>>>>> Nov  5 12:02:54 hikey kernel: [   22.478008] [<ffff0000087121a8>] of_thermal_get_temp+0x38/0x50
>>>>> Nov  5 12:02:54 hikey kernel: [   22.483869] [<ffff000008711790>] thermal_zone_get_temp+0x58/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.489903] [<ffff00000870e7bc>] thermal_zone_device_update.part.4+0x2c/0x1a8
>>>>> Nov  5 12:02:54 hikey kernel: [   22.497066] [<ffff00000870e9c8>] thermal_zone_device_check+0x40/0x50
>>>>> Nov  5 12:02:54 hikey kernel: [   22.503457] [<ffff0000080f1674>] process_one_work+0x19c/0x3d0
>>>>> Nov  5 12:02:54 hikey kernel: [   22.509236] [<ffff0000080f18f4>] worker_thread+0x4c/0x428
>>>>> Nov  5 12:02:54 hikey kernel: [   22.514664] [<ffff0000080f84fc>] kthread+0x134/0x138
>>>>> Nov  5 12:02:54 hikey kernel: [   22.519659] [<ffff000008085154>] ret_from_fork+0x10/0x1c
>>>>> Nov  5 12:02:54 hikey kernel: [   22.524988] ---[ end trace 328d4bb2d9b066a0 ]---
>>>>>
>>>>> This issue was solved when "hisi_thermal_alarm_irq" function was removed so only
>>>>> "hisi_thermal_alarm_irq_thread" would exist. This has fixed the issue for the
>>>>> unbalanced enablement since there is no more:
>>>>>
>>>>> 	disable_irq_nosync(irq);
>>>>> 	data->irq_enabled = false;
>>>>>
>>>>> logic being done in parallel to the threaded handler AND the
>>>>> thermal_zone_device_update() call only happens now if the temperature is already
>>>>> above the threshold.
>>>>>
>>>>
>>>> So should we revert a patch instead of taking these new ones?  Would
>>>> that be easier and is this a "real" issue or just an annoying warning
>>>> splat in the kernel log?
>>>
>>> Actually, this warning is introduced with the driver and all the
>>> plumbers around to fix an irq bouncing. There is no patch to revert
>>> without removing the driver.
>>
>> Greg,
>>
>> Patch 5 in this series seems to explain the best what is happening here:
>>
>>> With the following changes, we fix all in one:
>>>
>>> - Do the setup, one time, at probe time
>>>
>>> - Add the IRQF_ONESHOT, ack the interrupt in the threaded handler
>>>
>>> - Remove the interrupt handler
>>>
>>> - Set the correct value for the LAG register
>>>
>>> - Remove all the irq_enabled stuff in the code as the interruption
>>>   handling is fixed
>>>
>>> - Remove the 3ms delay
>>>
>>> - Reorder the initialization routine to be in the right order
>>
>> We can't revert anything because the breakage was there since the driver
>> was introduced.
> 
> So the driver was broken in 4.14, why not just use 4.19 instead?  This
> isn't a 4.14 regression, it's something that obviously no one has
> noticed for a year now, so why backport these big patches to 4.14 now?

It was not broken before this series but wobbly with a high latency to
read the temperature and an unusual interrupt handling scheme to work
around an uncatched register misconfiguration.

I think it was noticed but without finding the root cause of the issue.
This one is definitively solved with these patches and the resulting
code is consistent with the other thermal drivers.

All these patches were applied to Android-4.14 if worth to mention.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


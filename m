Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B870C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763E822424
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763E822424
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbeGCGto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:49:44 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:32907 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751760AbeGCGtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:49:42 -0400
Received: from [192.168.0.3] (ip5f5aebd9.dynamic.kabel-deutschland.de [95.90.235.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 886D02012BA054;
        Tue,  3 Jul 2018 08:49:40 +0200 (CEST)
Subject: Re: [PATCH] usb/host/pci-quirks: Only reset USB bus on NVIDIA devices
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.1807021302210.1574-100000@iolanthe.rowland.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <d9e9efa7-c74e-21b0-2fba-8fdbb2d5a35b@molgen.mpg.de>
Date:   Tue, 3 Jul 2018 08:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1807021302210.1574-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan,


Thank you very much for looking into this issue.

Am 02.07.2018 um 19:19 schrieb Alan Stern:
> On Mon, 2 Jul 2018, Alan Stern wrote:
> 
>>>>> The problem is, that currently 100 ms sleep is over 10 % of the overall
>>>>> execution time of the Linux kernel here. So I really like to not sleep
>>>>> if it’s not needed.
>>>>
>>>> It would be nice to execute the probes in parallel; that would reduce
>>>> the total delay to 50 ms.  However, that is the subject of a separate
>>>> discussion.
>>>>
>>>>>> Besides, doesn't it seem like a bad idea to reset the controller while
>>>>>> leaving devices on the USB bus in whatever state they happened to be?
>>>>>
>>>>> Yes, it’s probably not optimal.
>>>>>
>>>>> I wonder if the reset is needed, if the firmware has already initialized
>>>>> the device.
>>>>
>>>> The devices on the bus need to be reset, because the OS has no idea of
>>>> what they are and what the firmware has them doing.
>>>>
>>>> For example, the firmware may have assigned bus address 2 to a
>>>> keyboard.  But the OS can initialize the devices in a different order,
>>>> and it might want to assign bus address 2 to a USB drive.  Then you'd
>>>> have two devices trying to use the same address at the same time, which
>>>> would not be a good thing.
>>>
>>> Understood.
>>>
>>> So, what would be a way forward? Add a whitelist for boards or chipsets
>>> not needing the 50 ms delay?
>>
>> The 50-ms delay isn't for the board or the chipset; it is for the USB
>> devices that are plugged into the controller.  It is required by the
>> USB spec, so we can't get rid of it.
> 
> I may have been too hasty.  The drivers for other types of USB host
> controllers do not perform a USB bus reset during startup, so maybe
> OHCI doesn't really need it either.
> 
> We still need to put the controller into the correct state, but what
> happens to the bus shouldn't matter.  This is because reinitializing
> the controller disables all its ports, and the only way to enable a
> port is by sending a reset signal through it.  So the attached devices
> will end up getting reset one way or another, even if we don't do it
> explicitly during the handoff.
> 
> Therefore in theory we should be okay without the 50-ms delay at all.
> And we might as well tell the controller to go into the USB_RESET even
> if it already is in that state; testing the current state is more
> effort than just doing setting it.  Something like the patch below
> ought to work, although I wouldn't submit it for the -stable kernels
> since it doesn't fix a real bug.
> 
> It's not clear why OHCI has both a USB_RESET state and a
> HostControllerReset command, especially since the command changes the
> state to USB_SUSPEND instead of USB_RESET.  This is just one of several
> odd things in the OHCI specification.

> Index: usb-4.x/drivers/usb/host/pci-quirks.c
> ===================================================================
> --- usb-4.x.orig/drivers/usb/host/pci-quirks.c
> +++ usb-4.x/drivers/usb/host/pci-quirks.c
> @@ -783,15 +783,9 @@ static void quirk_usb_handoff_ohci(struc
>   	/* disable interrupts */
>   	writel((u32) ~0, base + OHCI_INTRDISABLE);
>   
> -	/* Reset the USB bus, if the controller isn't already in RESET */
> -	if (control & OHCI_HCFS) {
> -		/* Go into RESET, preserving RWC (and possibly IR) */
> -		writel(control & OHCI_CTRL_MASK, base + OHCI_CONTROL);
> -		readl(base + OHCI_CONTROL);
> -
> -		/* drive bus reset for at least 50 ms (7.1.7.5) */
> -		msleep(50);
> -	}
> +	/* Go into the USB_RESET state, preserving RWC (and possibly IR) */
> +	writel(control & OHCI_CTRL_MASK, base + OHCI_CONTROL);
> +	readl(base + OHCI_CONTROL);
>   
>   	/* software reset of the controller, preserving HcFmInterval */
>   	if (!no_fminterval)

Tested on ASRock E350M1 with GRUB as bootloader, and a mouse attached to 
the USB port. The mouse works under X.


Kind regards,

Paul

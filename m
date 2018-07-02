Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0AB23DD7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0AB23DD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeGBQS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:18:29 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40735 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752167AbeGBQS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:18:28 -0400
Received: from [141.14.220.54] (g54.guest.molgen.mpg.de [141.14.220.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A50702012D0DC0;
        Mon,  2 Jul 2018 18:18:26 +0200 (CEST)
Subject: Re: [PATCH] usb/host/pci-quirks: Only reset USB bus on NVIDIA devices
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.1807021158570.1574-100000@iolanthe.rowland.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <ad342918-1534-a499-ae25-63c8d8bff1d1@molgen.mpg.de>
Date:   Mon, 2 Jul 2018 18:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1807021158570.1574-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan,


Am 02.07.2018 um 18:03 schrieb Alan Stern:
> On Mon, 2 Jul 2018, Paul Menzel wrote:

>> Am 02.07.2018 um 17:45 schrieb Alan Stern:
>>> On Sun, 1 Jul 2018, Paul Menzel wrote:
>>>
>>>> Currently, on the AMD board Asus F2A85-M Pro there is a 100 ms delay as
>>>> the USB bus of each of the two OHCI PCI devices is reset. As a 50 ms
>>>> delay is done per the USB specification.
>>>>
>>>> Commit c6187597 (OHCI: final fix for NVIDIA problems (I hope))
>>>> unconditionally does the bus reset for
>>>>    all chipsets, while it was only doen for NVIDIA chipsets before.
>>>
>>> I don't follow this at all.  Prior to that commit, the bus reset (i.e.,
>>>
>>> 	writel(control & OHCI_CTRL_MASK, base + OHCI_CONTROL);
>>>
>>> ) was performed unconditionally for _all_ controllers.  (However, the
>>> 50-ms delay was used only for NVIDIA hardware.)  Following that commit,
>>> the reset is performed for all controllers, but only if the HCFS
>>> bitfield is nonzero.
>>>
>>>> As it should not be needed for non-NVIDIA chipsets, only do the reset
>>>> for Nvidia devices.
>>>
>>> Therefore this reasoning is wrong.
>>
>> True. Thank you for checking that.
>>
>>>> Tested on Asus F2A85-M PRO and ASRock E350M1. The USB keyboard works and
>>>> the LUKS passphrase can be entered.
>>>
>>> Unfortunately, there is a wide variety of OHCI controller hardware
>>> available.  Something that works on one or two controllers might not
>>> work on another.
>>
>> The problem is, that currently 100 ms sleep is over 10 % of the overall
>> execution time of the Linux kernel here. So I really like to not sleep
>> if it’s not needed.
> 
> It would be nice to execute the probes in parallel; that would reduce
> the total delay to 50 ms.  However, that is the subject of a separate
> discussion.
> 
>>> Besides, doesn't it seem like a bad idea to reset the controller while
>>> leaving devices on the USB bus in whatever state they happened to be?
>>
>> Yes, it’s probably not optimal.
>>
>> I wonder if the reset is needed, if the firmware has already initialized
>> the device.
> 
> The devices on the bus need to be reset, because the OS has no idea of
> what they are and what the firmware has them doing.
> 
> For example, the firmware may have assigned bus address 2 to a
> keyboard.  But the OS can initialize the devices in a different order,
> and it might want to assign bus address 2 to a USB drive.  Then you'd
> have two devices trying to use the same address at the same time, which
> would not be a good thing.

Understood.

So, what would be a way forward? Add a whitelist for boards or chipsets
not needing the 50 ms delay?


Kind regards,

Paul

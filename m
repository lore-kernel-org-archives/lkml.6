Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54415C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1782081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1782081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeKFAwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:52:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:6649 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbeKFAwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:52:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 07:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="84112992"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga008.fm.intel.com with ESMTP; 05 Nov 2018 07:31:48 -0800
Subject: Re: USB-C device hotplug issue
To:     Alan Stern <stern@rowland.harvard.edu>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bin Liu <b-liu@ti.com>,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dominik Bozek <dominikx.bozek@intel.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1810261000040.1467-100000@iolanthe.rowland.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <ac4ea7fa-9fd7-0987-a70c-11a26465e680@linux.intel.com>
Date:   Mon, 5 Nov 2018 17:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1810261000040.1467-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2018 17:07, Alan Stern wrote:
> On Fri, 26 Oct 2018, Dennis Wassenberg wrote:
> 
>>>> --- a/drivers/usb/core/hub.c
>>>> +++ b/drivers/usb/core/hub.c
>>>> @@ -2815,7 +2815,9 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
>>>>   					USB_PORT_FEAT_C_BH_PORT_RESET);
>>>>   			usb_clear_port_feature(hub->hdev, port1,
>>>>   					USB_PORT_FEAT_C_PORT_LINK_STATE);
>>>> -			usb_clear_port_feature(hub->hdev, port1,
>>>> +
>>>> +			if (!warm)
>>>> +				usb_clear_port_feature(hub->hdev, port1,
>>>>   					USB_PORT_FEAT_C_CONNECTION);
>>>>   
>>>>   			/*
>>>
>>> The key fact is that connection events can get lost if they happen to
>>> occur during a port reset.
>> Yes.
>>>
>>> I'm not entirely certain of the logic here, but it looks like the
>>> correct test to add should be "if (udev != NULL)", not "if (!warm)".
>>> Perhaps Mathias can confirm this

Sorry about the late response, got distracted while performing git
archeology.

"if (udev != NULL)" would seem more reasonable.

Logs show that clearing the FEAT_C_CONNECTION was originally added
after a hot reset failed, and before issuing a warm reset to a SS.Inactive
link.  (see 10d674a USB: When hot reset for USB3 fails, try warm reset.)

Apparently all the change flags needed to be cleared for some specific
host + device combination before issuing a warm reset for the enumeration
to work properly.

The change to always clear FEAT_C_CONNECTION for USB3 was done later in patch:
a24a607 USB: Rip out recursive call on warm port reset.

Motivation was:

"In hub_port_finish_reset, unconditionally clear the connect status
  change (CSC) bit for USB 3.0 hubs when the port reset is done.  If we
  had to issue multiple warm resets for a device, that bit may have been
  set if the device went into SS.Inactive and then was successfully warm
  reset."

>> I don't know if clearing the USB_PORT_FEAT_C_CONNECTION bit is
>> correct in case of a non warm reset. In my case I always observed a
>> warm reset because of the link state change.
>> Thats why I checked the warm variable to not change the behavoir for
>> cases a didn't checked for the first shot.
> 
> (The syntax of that last sentence is pretty mangled; I can't understand
> it.)
> 
> Think of it this way:
> 
> 	If a device was not attached before the reset, we don't want
> 	to clear the connect-change status because then we wouldn't
> 	recognize a device that was plugged in during the reset.
> 
> 	If a device was attached before the reset, we don't want any
> 	connect-change status which might be provoked by the reset to
> 	last, because we don't want the core to think that the device
> 	was unplugged and replugged when all that happened was a reset.
> 
> So the important criterion is whether or not a device was attached to
> the port when the reset started.  It's something of a coincidence that
> you only observe warm resets when there's nothing attached.
> 
>> During the first run of usb_hub_reset the udev is NULL because in
>> this situation the device is not attached logically.
>>
>> [  112.889810] usb 4-1-port1: XXX: port_event: portstatus: 0x2c0, portchange: 0x40!
>> [  113.201192] usb 4-1-port1: XXX: hub_port_reset: udev:            (nil)!
>> [  113.201198] usb 4-1-port1: XXX: hub_port_reset (not clearing USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x1!
>> [  113.253612] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x1!
>> [  113.377208] usb 4-1-port1: XXX: hub_port_reset: udev: ffff88046b302800!
>> [  113.377214] usb 4-1-port1: XXX: hub_port_reset (not clearing USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
>> [  113.429478] usb 4-1.1: new SuperSpeed USB device number 7 using xhci_hcd
>> [  113.442370] usb 4-1.1: New USB device found, idVendor=0781, idProduct=5596
>> [  113.442376] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> [  113.442381] usb 4-1.1: Product: Ultra T C
>> [  113.442385] usb 4-1.1: Manufacturer: SanDisk
>> [  113.442388] usb 4-1.1: SerialNumber: 4C530001131013121031
>>
>> Or maybe we can skip clearing the USB_PORT_FEAT_C_CONNECTION bit in
>> case of hub_port_reset completely without any other check?
> 
> See above.

Checking for udev sounds reasonable to me.
Not sure if we should worry about the specific host+device combo that needed flags
cleared before warm reset. See patch:

10d674a USB: When hot reset for USB3 fails, try warm reset.
https://marc.info/?l=linux-usb&m=131603549603799&w=2

-Mathias

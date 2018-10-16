Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A21C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D8420866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D8420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJPOlI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:41:08 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52408 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeJPOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:41:08 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3FE52CF367;
        Tue, 16 Oct 2018 08:59:30 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181015185128.GT22824@google.com>
Date:   Tue, 16 Oct 2018 08:52:07 +0200
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <8D254888-52A9-4201-882C-EDE71EE4CF5C@holtmann.org>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
 <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
 <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
 <20180927171305.GG22824@google.com> <20181004173338.GL22824@google.com>
 <9B742DB5-F584-4A47-A04B-4F72EB17519C@holtmann.org>
 <20181015185128.GT22824@google.com>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

>>>>>> void bt_sock_reclassify_lock(struct sock *sk, int proto);
>>>>>> 
>>>>>> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
>>>>> 
>>>>> Maybe change the API name to start with bt_ and get rid of device_?
>>>> 
>>>> device_ indicates that we get the BD_ADDR for a 'struct device' and
>>>> not for e.g. a 'struct fwnode_handle'.
>>>> 
>>>> Anyway with this version of the patch fwnode_get_bd_address() has been
>>>> scrapped and it might never be introduced again, so I'm open to change
>>>> the name to bt_ if there is a general preference for it.
>>> 
>>> Marcel, can you live with this being added to the Bluetooth code base
>>> instead of property? Also if you'd prefer the function to be named
>>> bt_get_bd_address() let me know.
>> 
>> explain to me again why this is useful?
> 
> The official binding for providing the BD_ADDR through the device tree
> is the property 'local-bd-address'. device_get_bd_address() provides a
> common API to retrieve the BD_ADDR instead of requiring BT drivers to
> use the lower level fwnode_property_read_u8_array(). It also avoids
> repeating the check for an all zeroes BD_ADDR in multiple drivers.
> 
>> I am failing to see the benefit if this is not part of the property.h API.
> 
> My understanding is that the intention of property.h it to provide an
> API for common property types used by drivers from different
> subsystems, hence the implementation 'lives' in drivers/base.
> Obtaining the BD_ADDR is clearly limited to the Bluetooth subsystem,
> and drivers/base doesn't seem to be the right place for it. It's true,
> device_get_mac_address() lives in the common property code, but that
> doesn't necessarily mean it really should be there and we should do
> the same. I agree with Sakari that the the approach taken by V4L2
> (drivers/media/v4l2-core/v4l2-fwnode.c) seems more appropriate.
> 
> That said I wouldn't raise opposition if the maintainers of
> drivers/base agreed to add device_get_mac_address() there, however so
> far several recent authors of property.[ch] have raised objections.

so if this is not in drivers/base/ then what is the point in making each driver do this? If it is a common property, then it can be well handled in the Bluetooth core when setting up the hardware.

This whole BD_ADDR via DT is stupid anyway. Just so that is clear up-front. It has been a total hack and fully relies on boot loaders doing too much magic and then using DT to hide this magic. The BD_ADDR is required to be unique and that means no user will ever create a DT with that set. The boot loader always has to read some magic value and then convert it and merge it into the actual DT provided to the kernel. The clean part would be just to have proper APIs to read the memory of the persistent / programmed BD_ADDR and then access that.

That all said, we have hdev->set_bdaddr address and the HCI_QUIRK_INVALID_BDADDR to mark the controller as not fully set up. And then actually user space can deal with getting the correct address and providing it. The code is already there that handles all of this if the BD_ADDR comes from user space. Actually hacking this into the driver and doing that in the hdev->setup callback is quirky to begin with. A user space provided address will just overwrite that.

If you really want to make this generic, then introduce HCI_QUIRK_USE_BDADDR_PROPERTY that a driver can set and then do that all in hci_dev_do_open() so that if no user space provided BD_ADDR is available, it is read from local-bt-address property and if that is not available or empty, then mark the the device as unconfigured.

I am intentionally saying unconfigured when you set HCI_QUIRK_USE_BDADDR_PROPERTY since I assume that the logic that we have behind HCI_QUIRK_INVALID_BDADDR is implied and whatever address comes back via Read_BD_Address is invalid. Otherwise this hardware should not set HCI_QUIRK_USE_BDADDR_PROPERTY at all.


Regards

Marcel


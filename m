Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF52EC5ACCD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A684521476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HG19WnjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A684521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeJQEzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:55:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39709 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:55:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so11428507pgv.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p9MokN1AKnRN4mepWaB8sA/0JJyICRGM5sbyv88okSU=;
        b=HG19WnjP68rECEeuqSmFU5uVHNO5pspSLbMjFfiz6Cq69Cr4hm0tztiDAeigEYnWgx
         H8G8rNid1fmzyclYepE6wwORDJd/CueiPDjn8koKmE0lT11NsV/8gjJCM3yQEpAiQVtd
         VSHB+e+rsY0426hGFQOAXOzXI450IvvRCuJME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p9MokN1AKnRN4mepWaB8sA/0JJyICRGM5sbyv88okSU=;
        b=MVsSQHY8nY7hH7Q1YHAz1INjpoz2bR4ImUQo7BgHNO+Q6nC/Nn7q/WZrswRNIvdcUP
         wKuvFd8aayTeVxN+acsrvpKwXlm1Tp2U58bJmCqhfVX5A3zmfTkj1DSMBTlDPuWj641R
         L6hW0+Kq4Oorh7uBXDu/pxEhNy24po4uPgbJpyKbvKzZKew3btqGywFqwXUX19/vJNSy
         39ZH48G1PZWVHDtZ9emtIxEhIHRevmwySS5qDzRNgvIW5uZy+isKgTOu6OjEzOhcWRfP
         pukX4myZ5KEZA7D6B7CnjJVXUVvUo7LFae5RC3WetDk/pHBPFdOhILG9DYyIhheCUtYR
         l+rg==
X-Gm-Message-State: ABuFfojZBbAEcBjMxNqvf7jb0Fne2d+V+7X6xBsLUL/0GZYS+22wnxO+
        2MW+yiuiIbt4L1hY53IHKLMNhw==
X-Google-Smtp-Source: ACcGV62ygpnrK90+CJr0EMGI/BW6L2nvRRsu2bSWdihax9w17FjCROQp2Lw2jiCWmsF3xZYNOcs4AQ==
X-Received: by 2002:a63:4952:: with SMTP id y18-v6mr21738957pgk.32.1539723767103;
        Tue, 16 Oct 2018 14:02:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id o7-v6sm24803853pgq.14.2018.10.16.14.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 14:02:46 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:02:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
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
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
Message-ID: <20181016210245.GU22824@google.com>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
 <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
 <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
 <20180927171305.GG22824@google.com>
 <20181004173338.GL22824@google.com>
 <9B742DB5-F584-4A47-A04B-4F72EB17519C@holtmann.org>
 <20181015185128.GT22824@google.com>
 <8D254888-52A9-4201-882C-EDE71EE4CF5C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8D254888-52A9-4201-882C-EDE71EE4CF5C@holtmann.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Tue, Oct 16, 2018 at 08:52:07AM +0200, Marcel Holtmann wrote:
> Hi Matthias,
> 
> >>>>>> void bt_sock_reclassify_lock(struct sock *sk, int proto);
> >>>>>> 
> >>>>>> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
> >>>>> 
> >>>>> Maybe change the API name to start with bt_ and get rid of device_?
> >>>> 
> >>>> device_ indicates that we get the BD_ADDR for a 'struct device' and
> >>>> not for e.g. a 'struct fwnode_handle'.
> >>>> 
> >>>> Anyway with this version of the patch fwnode_get_bd_address() has been
> >>>> scrapped and it might never be introduced again, so I'm open to change
> >>>> the name to bt_ if there is a general preference for it.
> >>> 
> >>> Marcel, can you live with this being added to the Bluetooth code base
> >>> instead of property? Also if you'd prefer the function to be named
> >>> bt_get_bd_address() let me know.
> >> 
> >> explain to me again why this is useful?
> > 
> > The official binding for providing the BD_ADDR through the device tree
> > is the property 'local-bd-address'. device_get_bd_address() provides a
> > common API to retrieve the BD_ADDR instead of requiring BT drivers to
> > use the lower level fwnode_property_read_u8_array(). It also avoids
> > repeating the check for an all zeroes BD_ADDR in multiple drivers.
> > 
> >> I am failing to see the benefit if this is not part of the property.h API.
> > 
> > My understanding is that the intention of property.h it to provide an
> > API for common property types used by drivers from different
> > subsystems, hence the implementation 'lives' in drivers/base.
> > Obtaining the BD_ADDR is clearly limited to the Bluetooth subsystem,
> > and drivers/base doesn't seem to be the right place for it. It's true,
> > device_get_mac_address() lives in the common property code, but that
> > doesn't necessarily mean it really should be there and we should do
> > the same. I agree with Sakari that the the approach taken by V4L2
> > (drivers/media/v4l2-core/v4l2-fwnode.c) seems more appropriate.
> > 
> > That said I wouldn't raise opposition if the maintainers of
> > drivers/base agreed to add device_get_mac_address() there, however so
> > far several recent authors of property.[ch] have raised objections.
> 
> so if this is not in drivers/base/ then what is the point in making
> each driver do this? If it is a common property, then it can be well
> handled in the Bluetooth core when setting up the hardware.

Agreed, it would be better if this can be handled in the Bluetooth core.

> This whole BD_ADDR via DT is stupid anyway. Just so that is clear
> up-front. It has been a total hack and fully relies on boot loaders
> doing too much magic and then using DT to hide this magic. The
> BD_ADDR is required to be unique and that means no user will ever
> create a DT with that set. The boot loader always has to read some
> magic value and then convert it and merge it into the actual DT
> provided to the kernel. The clean part would be just to have proper
> APIs to read the memory of the persistent / programmed BD_ADDR and
> then access that.

Yes, the DT approach relies on the bootloader which isn't ideal. Part
of the problem is that AFAIK there is currently no standard way for
storing/retrieving persistent, board specific values like BD ADDR, so
different custom mechanisms are used, which tend to be incompatible
with each other (e.g. Chrome OS uses VPD:
https://chromium.googlesource.com/chromiumos/platform/vpd/)

Using the bootloader & DT is a pragmatic approach, since the DT is
well established and the bootloader often already has DT awareness.

That said I agree that a common solution would make our lives easier.

> That all said, we have hdev->set_bdaddr address and the
> HCI_QUIRK_INVALID_BDADDR to mark the controller as not fully set
> up. And then actually user space can deal with getting the correct
> address and providing it. The code is already there that handles all
> of this if the BD_ADDR comes from user space. Actually hacking this
> into the driver and doing that in the hdev->setup callback is quirky
> to begin with. A user space provided address will just overwrite
> that.
> 
> If you really want to make this generic, then introduce
> HCI_QUIRK_USE_BDADDR_PROPERTY that a driver can set and then do that
> all in hci_dev_do_open() so that if no user space provided BD_ADDR
> is available, it is read from local-bt-address property and if that
> is not available or empty, then mark the the device as unconfigured.
> 
> I am intentionally saying unconfigured when you set
> HCI_QUIRK_USE_BDADDR_PROPERTY since I assume that the logic that we
> have behind HCI_QUIRK_INVALID_BDADDR is implied and whatever address
> comes back via Read_BD_Address is invalid. Otherwise this hardware
> should not set HCI_QUIRK_USE_BDADDR_PROPERTY at all.

Thanks for proposing this generic alternative solution and providing
details!

I'm not really experienced with hacking the Bluetooth core and don't
understand your proposal entirely:

I get the part of setting the quirk in the driver, checking for it in
hci_dev_do_open(), reading the address from 'local-bd-address',
setting it with hdev->bd_addr and marking the device as unconfigured
if the address is empty/unavailable. I interpret that you suggest that
'local-bd-address' should only be used if user space doesn't provide a
BD_ADDR. It is not evident to me where a user space provided address
is set, in any case it doesn't seem to be in hci_dev_do_open(), my
uneducated guess is that the address is set with the management
command SET_PUBLIC_ADDRESS. Could you clarify on this?

I also wonder how to identify the DT node corresponding to an HCI
device, for hci_qca it's the node of hdev->dev.parent, but I'm not
sure if that is universally true. If it isn't looking for the first
parent with a DT node could be an option.

Thanks

Matthias

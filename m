Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC6DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E802089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q90q92yP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E802089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbeGIOss (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932508AbeGIOsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:48:46 -0400
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8C67208A5;
        Mon,  9 Jul 2018 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531147725;
        bh=2piMlDgA7zuiwluyE/796A9k6JGu8H1vgKPqOL3Hv2A=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Q90q92yPXO7c+HpIdHuJWPuWRGZxhReW2X9DUa1rWOGmq8nI4peq201S8gcJBwNro
         XYEBm8oVZ4Yn+hLaJnJGOzsh2F7+neUxbW+unU8fgP5/xERHCUQ60PNRUGXSlqR87g
         sUWnyyPqCcJHwbVrIRIENCqHkXttbP1Vs7rkfuxM=
Received: by mail-oi0-f45.google.com with SMTP id y207-v6so36348366oie.13;
        Mon, 09 Jul 2018 07:48:45 -0700 (PDT)
X-Gm-Message-State: APt69E3LL8pFxZcyEwfNyRYg4LqrtGJnTrLMGn8gjlJd/opbkUy41m1d
        qD+Caa7B9VgxCFlyeYhkC3ciraV2WqjrxgMrles=
X-Google-Smtp-Source: AAOMgpdu8RLOGdUuoWLxKbrre4aPYjNFxK+dsJ4EEVtqBHjZHJ0hyyttQlw0/IUiF1Ww5z6SjYm9Z/f3kwZJvRrIVLU=
X-Received: by 2002:aca:b857:: with SMTP id i84-v6mr24834228oif.279.1531147725026;
 Mon, 09 Jul 2018 07:48:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:6952:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 07:48:44 -0700 (PDT)
In-Reply-To: <20180708171418.GA11476@wunner.de>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org> <20180708171418.GA11476@wunner.de>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Mon, 9 Jul 2018 08:48:44 -0600
X-Gmail-Original-Message-ID: <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
Message-ID: <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during reset
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/18, Lukas Wunner <lukas@wunner.de> wrote:
> On Tue, Jul 03, 2018 at 11:43:26AM -0400, Sinan Kaya wrote:
>> On 7/3/2018 10:34 AM, Lukas Wunner wrote:
>> > We've already got the ->reset_slot callback in struct hotplug_slot_ops,
>> > I'm wondering if we really need additional ones for this use case.
>>
>> As I have informed you before on my previous reply, the pdev->slot is
>> only valid for children objects such as endpoints not for a bridge when
>> using pciehp.
>>
>> The pointer is NULL for the host bridge itself.
>
> Right, sorry, I had misremembered how this works.  So essentially the
> pointer is only set for the devices "in" the slot, but not for the bridge
> "to" that slot.  If the slot isn't occupied, *no* pci_dev points the
> struct pci_slot.  Seems counter-intuitive to be honest.

That is true. There is a bit of history here. Back in pci days, you
would have each PCI device number as a hotplug slot. There would be
multiple slots under a bridge. There is a one to many relationship.

>
> Thanks for the explanation of the various reset codepaths, I'm afraid my
> understanding of that portion of the PCI core is limited.
>
> Browsing through drivers/pci/pci.c, I notice pci_dev_lock() and
> pci_dev_save_and_disable(), both are called from reset codepaths and
> apparently seek to stop access to the device during reset.  I'm wondering
> why DPC and AER remove devices in order to avoid accesses to them during
> reset, instead of utilizing these two functions?

This was the behavior until 4.18. Since 4.18 all devices are being
removed and reenumerated following a fatal error condition.

>
> My guess is that a lot of the reset code is historically grown and
> could be simplified and made more consistent, but that requires digging
> into the code and getting a complete picture.  I've sort of done that
> for pciehp, I think I'm now intimately familiar with 90% of it,
> so I'll be happy to review patches for it and answer questions,
> but I'm pretty much stumped when it comes to reset code in the PCI core.
>
> I treated the ->reset_slot() callback as one possible entry point into
> pciehp and asked myself if it's properly serialized with the rest of the
> driver and whether driver ->probe and ->remove is ordered such that
> the driver is always properly initialized when the entry point might be
> taken.  I did not look too closely at the codepaths actually leading to
> invocation of the ->reset_slot() callback.
>

Sure, this path gets called from vfio today and possibly via a reset
file in sysfs. A bunch of things need to fail before hitting slot
reset path.

However, vfio is a direct caller if hotplug is supported.

>
>> I was curious if we could use a single work queue for all pcie portdrv
>> services. This would also eliminate the need for locks that Lukas is
>> adding.
>>
>> If hotplug starts first,  hotplug code would run to completion before AER
>> and DPC service starts recovery.
>>
>> If DPC/AER starts first, my patch would mask the hotplug interrupts.
>>
>> My solution doesn't help if link down interrupt is observed before the
>> AER
>> or DPC services.
>
> If pciehp gets an interrupt quicker than dpc/aer, it will (at least with
> my patches) remove all devices, check if the presence bit is set,

Yup.

> and
> if so, try to bring the slot up again.

Hotplug driver should only observe a link down interrupt. Link would
come up in response to a secondary bus reset initiated by the AER
driver.

Can you point me to the code that would bring up the link in hp code?
Maybe, I am missing something.

> My (limited) understanding is
> that the link will stay down until dpc/aer react.
> pciehp_check_link_status()
> will wait 1 sec for the link, wait another 100 msec, then poll the vendor
> register for 1 sec before giving up.  So if dpc/aer are locked out for this
> long, they will only be able to reset the slot after 2100 msec.
>
> I've had a brief look at the PCIe r4.0 base spec and could not find
> anything about how pciehp and dpc/aer should coordinate.  Maybe that's
> an oversight, or the PCISIG just leaves this to the OS.
>
>
>> Another possibility is to add synchronization logic between these threads
>> obviously.
>
> Maybe call pci_channel_offline() in the poll loops of pcie_wait_for_link()
> and pci_bus_check_dev() to avoid waiting for the link if an error needs to
> be acted upon first?

Let me think about this.

>
> Thanks,
>
> Lukas
>

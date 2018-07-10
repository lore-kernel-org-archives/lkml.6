Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A301C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACF320936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsrD7gmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACF320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbeGJSaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733310AbeGJSaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:30:24 -0400
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D3C2083E;
        Tue, 10 Jul 2018 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531247412;
        bh=Sb9wfFILQKVb0esGwixzfyuuluVnP1gtSN7WwMDc1Fc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rsrD7gmM0DHr98GTJEwWz6vKcb0gP7v7or+QM1MSWci5f9mQXvxnWHec/kosQdDJt
         Jfd4QPWDUUnbzhNNtE098A6n63X3g1dEEGR32n0nze80nnPTWbO4QUZrc2rHUrdNM/
         4j5PsSJarIIty7FsbO1sar6Th8n74lMLQ/i3HHXc=
Received: by mail-oi0-f41.google.com with SMTP id w126-v6so44490306oie.7;
        Tue, 10 Jul 2018 11:30:12 -0700 (PDT)
X-Gm-Message-State: APt69E37J9Aj+w0oz9hCk1Bx1nVgPq7afDN83PdGduC4tLu6Bjfes73g
        U//+w/Jsl4fT08WbhQhCJojon7qAxcJASRYk27w=
X-Google-Smtp-Source: AAOMgpckpLB6D4jBbn/eOpLTBLrnHh2LlQsrfPZE7Tmm4kEB440N9SiyB2KrQHj+UIm6flQ/UFg1x7TkasqjevhoJt4=
X-Received: by 2002:aca:b455:: with SMTP id d82-v6mr27777354oif.234.1531247412071;
 Tue, 10 Jul 2018 11:30:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:6952:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 11:30:11
 -0700 (PDT)
In-Reply-To: <20180709160008.GA1490@wunner.de>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org> <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com> <20180709160008.GA1490@wunner.de>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Tue, 10 Jul 2018 14:30:11 -0400
X-Gmail-Original-Message-ID: <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
Message-ID: <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
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

On Mon, Jul 9, 2018 at 12:00 PM, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Jul 09, 2018 at 08:48:44AM -0600, Sinan Kaya wrote:
> > On 7/8/18, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Tue, Jul 03, 2018 at 11:43:26AM -0400, Sinan Kaya wrote:
> > > > My solution doesn't help if link down interrupt is observed before the
> > > > AER
> > > > or DPC services.
> > >
> > > If pciehp gets an interrupt quicker than dpc/aer, it will (at least with
> > > my patches) remove all devices, check if the presence bit is set,
> > > and if so, try to bring the slot up again.
> >
> > Hotplug driver should only observe a link down interrupt. Link would
> > come up in response to a secondary bus reset initiated by the AER
> > driver.
>
> PCIe hotplug doesn't have separate Link Down and Link Up interrupts,
> there is only a Link State *Changed* event.
>
> > Can you point me to the code that would bring up the link in hp code?
>
> I was referring to the situation with my recently posted pciehp patches
> applied, in particular patch [21/32] ("PCI: pciehp: Become resilient to
> missed events"):
> https://patchwork.ozlabs.org/patch/930389/
>
> When I get a presence or link changed event, I turn the slot off.  That
> includes removing all devices in the slot.  Because even if the slot is
> still occupied or link is up, there was definitely a change and the safe
> behavior is to assume that the card in the slot is now a different one
> than before.
>

We do have a bit of mess unfortunately. Error handling and hotplug drivers
do not play nicely with each other.

When hotplug driver observes a link down, we are not checking if the
link down happened because user really wanted to remove a card or
if it was because it was originated by an error handling service such
as AER/DPC.

I'm thinking that we could potentially check if a hotplug event is pending
at the entrance of fatal error handling. If it is pending, we could poll until
the status bit clears. That should flush the link down event.

Even then, link down indication of hotplug seem to turn off slot power
and LED.

If AER/DPC service runs after the hotplug driver, link won't come back
up as the power to the slot is turned off.

I'd like to hear about Bjorn's opinion before we throw something else
into this problem.

> Afterwards, I check if the slot is occupied or link is up.  If either
> of those conditions is true, I try to bring the slot up again.
>
> Thanks,
>
> Lukas

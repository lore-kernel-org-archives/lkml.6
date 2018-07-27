Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8A2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB23A20647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8dQ0DYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB23A20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389644AbeG0WZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389479AbeG0WZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:25:29 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCFB920647;
        Fri, 27 Jul 2018 21:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532725310;
        bh=YbVmsFV6zOuUFQY44XV4BhnndI5tSnGTCTTlt+E4RjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8dQ0DYGyhewLJSW+zrDEsJHfwEqHIPqln3jx3SS1uLrI9XfUJrngq2CsYc+2x2s8
         fHbSHsPsxD2ss1PAo8RdKu8E7r3JU6jTFoJUhDV0bpnPqRnykTeAMKL1yQQSGwEMKZ
         FwnjeOXKYFVOFnY+pjvCqDf9Rg2oAVQCAYzTqmiI=
Date:   Fri, 27 Jul 2018 16:01:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: Document ACPI description of PCI host bridges
Message-ID: <20180727210147.GE173328@bhelgaas-glaptop.roam.corp.google.com>
References: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153030406630.57832.11564334393458981467.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0iBZRJuh8Yu03p-k_rR_oxr9rJiOvRmvXpOxPjScM+w1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iBZRJuh8Yu03p-k_rR_oxr9rJiOvRmvXpOxPjScM+w1Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 11:40:52AM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 29, 2018 at 10:27 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Add a writeup about how PCI host bridges should be described in ACPI
> > using PNP0A03/PNP0A08 devices, PNP0C02 devices, and the MCFG table.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  Documentation/PCI/00-INDEX      |    2
> >  Documentation/PCI/acpi-info.txt |  183 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 185 insertions(+)
> >  create mode 100644 Documentation/PCI/acpi-info.txt
> >
> > diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
> > index 0f1d1de087f1..fc6af2957e55 100644
> > --- a/Documentation/PCI/00-INDEX
> > +++ b/Documentation/PCI/00-INDEX
> > @@ -1,5 +1,7 @@
> >  00-INDEX
> >         - this file
> > +acpi-info.txt
> > +       - info on how PCI host bridges are represented in ACPI
> >  MSI-HOWTO.txt
> >         - the Message Signaled Interrupts (MSI) Driver Guide HOWTO and FAQ.
> >  PCIEBUS-HOWTO.txt
> > diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-info.txt
> > new file mode 100644
> > index 000000000000..9b8e7b560b50
> > --- /dev/null
> > +++ b/Documentation/PCI/acpi-info.txt
> > @@ -0,0 +1,183 @@
> > +           ACPI considerations for PCI host bridges
> > +
> > +The general rule is that the ACPI namespace should describe everything the
> > +OS might use unless there's another way for the OS to find it [1, 2].
> > +
> > +For example, there's no standard hardware mechanism for enumerating PCI
> > +host bridges, so ACPI must describe each host bridge, the method for
> > +accessing PCI config space below it, the address space windows the bridge
> > +forwards to PCI, and the routing of legacy INTx interrupts.
> > +
> > +PCI devices *below* the host bridge generally do not need to be described
> > +via ACPI because the OS can discover them via the standard PCI enumeration
> > +mechanism, which uses config accesses to discover and identify the device
> > +and read and size its BARs.
> 
> While they can be discovered without ACPI, power management or hotplug
> may depend on it.
> 
> Also things like _PRT come to mind here.

Good point.  I added some text for these items (see below).

> > +ACPI resource description is done via _CRS objects of devices in the ACPI
> > +namespace [2].   The _CRS is like a generalized PCI BAR: the OS can read
> > +_CRS and figure out what resource is being consumed even if it doesn't have
> > +a driver for the device [3].  That's important because it means an old OS
> > +can work correctly even on a system with new devices unknown to the OS.
> > +The new devices might not do anything, but the OS can at least make sure no
> > +resources conflict with them.
> > +
> > +Static tables like MCFG, HPET, ECDT, etc., are *not* mechanisms for
> > +reserving address space!  The static tables are for things the OS needs to
> > +know early in boot, before it can parse the ACPI namespace.  If a new table
> > +is defined, an old OS needs to operate correctly even though it ignores the
> > +table.  _CRS allows that because it is generic and understood by the old
> > +OS; a static table does not.
> > +
> > +If the OS is expected to manage a non-discoverable device described via
> > +ACPI, that device will have a specific _HID/_CID that tells the OS what
> > +driver to bind to it, and the _CRS tells the OS and the driver where the
> > +device's registers are.
> > +
> > +PCI host bridges are PNP0A03 or PNP0A08 devices.  Their _CRS should
> > +describe all the address space they consume.  This includes all the windows
> > +they forward down to the PCI bus, as well as bridge registers that are not
> 
> I believe you mean registers of the host bridge itself here, but it is
> somewhat unclear if that applies to bridges below it too.

Right, I do mean host bridge registers for all the "bridge"
occurrences in this paragraph.  I changed all these references to
"host bridge".

PCI-to-PCI bridges below the host bridge are just like any other PCI
device, of course.  Their config registers are accessed via the normal
config accessors and their MMIO space (if any) would be included in
the host bridge's apertures.

> > +forwarded to PCI.  The bridge registers include things like secondary/
> > +subordinate bus registers that determine the bus range below the bridge,
> > +window registers that describe the apertures, etc.  These are all
> > +device-specific, non-architected things, so the only way a PNP0A03/PNP0A08
> > +driver can manage them is via _PRS/_CRS/_SRS, which contain the
> > +device-specific details.  The bridge registers also include ECAM space,
> > +since it is consumed by the bridge.

I made the following changes (hand-edited to remove trivial changes):

diff -u b/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-info.txt
--- b/Documentation/PCI/acpi-info.txt
+++ b/Documentation/PCI/acpi-info.txt
@@ -1,17 +1,21 @@
 
 For example, there's no standard hardware mechanism for enumerating PCI
-host bridges, so ACPI must describe each host bridge, the method for
-accessing PCI config space below it, the address space windows the bridge
-forwards to PCI, and the routing of legacy INTx interrupts.
-
-PCI devices *below* the host bridge generally do not need to be described
-via ACPI because the OS can discover them via the standard PCI enumeration
-mechanism, which uses config accesses to discover and identify the device
-and read and size its BARs.
+host bridges, so the ACPI namespace must describe each host bridge, the
+method for accessing PCI config space below it, the address space windows
+the host bridge forwards to PCI (using _CRS), and the routing of legacy
+INTx interrupts (using _PRT).
+
+PCI devices, which are below the host bridge, generally do not need to be
+described via ACPI.  The OS can discover them via the standard PCI
+enumeration mechanism, using config accesses to discover and identify
+devices and read and size their BARs.  However, ACPI may describe PCI
+devices if it provides power management or hotplug functionality for them
+or if the device has INTx interrupts connected by platform interrupt
+controllers and a _PRT is needed to describe those connections.
 
@@ -35,14 +39,14 @@
 
 PCI host bridges are PNP0A03 or PNP0A08 devices.  Their _CRS should
 describe all the address space they consume.  This includes all the windows
-they forward down to the PCI bus, as well as bridge registers that are not
-forwarded to PCI.  The bridge registers include things like secondary/
-subordinate bus registers that determine the bus range below the bridge,
-window registers that describe the apertures, etc.  These are all
-device-specific, non-architected things, so the only way a PNP0A03/PNP0A08
-driver can manage them is via _PRS/_CRS/_SRS, which contain the
-device-specific details.  The bridge registers also include ECAM space,
-since it is consumed by the bridge.
+they forward down to the PCI bus, as well as registers of the host bridge
+itself that are not forwarded to PCI.  The host bridge registers include
+things like secondary/subordinate bus registers that determine the bus
+range below the bridge, window registers that describe the apertures, etc.
+These are all device-specific, non-architected things, so the only way a
+PNP0A03/PNP0A08 driver can manage them is via _PRS/_CRS/_SRS, which contain
+the device-specific details.  The host bridge registers also include ECAM
+space, since it is consumed by the host bridge.

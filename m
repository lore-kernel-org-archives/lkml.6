Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082F2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B723C2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKz1rptx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B723C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeH1X22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbeH1X22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:28:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD9F2087E;
        Tue, 28 Aug 2018 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535484920;
        bh=IwdAt1JnkKIHE2eBkSYTaVeIBpAUu/3DixE7O7eK9L4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKz1rptxphJ4LaHa3En7DUWBZ6ggIe6ymDhMijOh3sVHAkjFPzKe+ks0yYZ/vmNQZ
         I8jQDCDA4xhYU30QBIvJbHUN1QBEPNmH45OopGcdI2Ekdqqw8hprrYz/YGgxw3/UAO
         u+LHDQHQTlpRXmOkHltXRbqS9xeZYJIJ1Tk4sQe4=
Date:   Tue, 28 Aug 2018 14:35:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zihan Yang <whois.zihan.yang@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Peer bridge fixup issue under multiple pci domain
Message-ID: <20180828193517.GA158292@bhelgaas-glaptop.roam.corp.google.com>
References: <CAKwiv-gK1wxw57TVK7GXe3bfkr=0eCS9zn7F_mZRYUL+2Ovr9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwiv-gK1wxw57TVK7GXe3bfkr=0eCS9zn7F_mZRYUL+2Ovr9w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc EDAC folks, LKML]

On Sat, Aug 25, 2018 at 10:58:57PM +0800, Zihan Yang wrote:
> Hi all,
> 
> I'm trying to use multiple pci domain in qemu q35, but I find there
> might be some issues in peer bridge fixup.
> 
> In short, pcibios_fixup_peer_bridges function assumes only one pci
> domain (0) by default. This is OK when as qemu by default uses only
> one pci domain too. However, if I add another host bridge which is
> put into pci domain 1 by using _SEG, and a pcie_pci_bridge is attached
> to the bus 1 under this new pci domain 1 rather than domain 0, the
> kernel will recognize the bus 01 differently.
> 
> More specifically, pcibios_fixup_peer_bridges only reads all the buses
> under domain 0 but it can read the pci bus 01 in pci domain 1 and treat
> it as a peer bus of 0000:00. The consequence is this 01 bus is recognized
> as 0000:01, but it should have been recognized as 0001:01.
> 
> The host bus 0001:00 can be recognized so I guess pcibios_fixup_peer_bridges
> needs updating to take care of multiple domains? Or is it just an bios issue?
> I'm not quite sure and I'm open to any suggestions.

Is there something that actually does not work, or is this just a
concern that the code looks wrong?

pcibios_fixup_peer_bridges() is ancient history from before x86 used
the ACPI namespace to discover host bridges.  It blindly probes for
devices on buses 0-255, but as you say, only in domain 0.

Using multiple PCI domains really requires ACPI support so we know
what the other domains are (_SEG) and how to access their config space
(MCFG).  When we do have ACPI support in the platform and the kernel,
drivers/acpi/pci_root.c discovers all the host bridges in all domains
via PNP0A03 or PNP0A08 devices in the ACPI namespace, and in most
cases pcibios_fixup_peer_bridges() will do nothing.

However, there *are* systems where the firmware does not expose all
host bridges and in those cases, pcibios_fixup_peer_bridges() can be a
problem.  For example, Intel processors often have management devices
on bus 7f or ff.  If the ACPI namespace doesn't have a host bridge to
those buses, pci_root.c won't find them, but
pcibios_fixup_peer_bridges() *will*.

This leads to several problems.  Here's a dmesg sample from [1]
(found by googling for 'dmesg log "PCI: discovered peer bus ff"'):

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
  PCI: Discovered peer bus fe
  pci_bus 0000:fe: root bus resource [io  0x0000-0xffff]
  pci_bus 0000:fe: root bus resource [mem 0x00000000-0xffffffffff]
  pci 0000:fe:03.0: [8086:2d98] type 00 class 0x060000
  PCI: Discovered peer bus ff
  pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
  pci_bus 0000:ff: root bus resource [mem 0x00000000-0xffffffffff]
  pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000
  EDAC MC1: Giving out device to module i7core_edac.c controller i7 core #1: DEV 0000:fe:03.0 (INTERRUPT)
  EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:fe:03.0 (POLLED)
  EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:ff:03.0 (INTERRUPT)
  EDAC PCI1: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)

Some of the problems are:

  - Firmware may have omitted the host bridges to [bus fe] and
    [bus ff] from the ACPI namespace because *it* is using those
    management devices, so EDAC blindly using them is a potential
    conflict.

  - pcibios_fixup_peer_bridges() only scans domain 0, so if this
    system had multiple domains, EDAC would only work on things in
    domain 0, ignoring other domains.

  - The PCI core can't do bus number assignment correctly for devices
    behind bridge PCI0.  The firmware told us [bus 00-ff] was
    available, so the core may assign bus number fe to some deep
    switch hierarchy.  But bus fe conflicts with the devices on the
    "peer bus fe".  This part is a firmware bug: it should have told
    us that PCI0 leads to [bus 00-fd], not [bus 00-ff].

  - The PCI core can't do resource assignment correctly for devices on
    [bus fe] and [bus ff].  It has no information about what MMIO and
    I/O port are routed to those buses, so it assumes *all* memory and
    I/O ports are routed there, which is clearly incorrect.  This part
    is a Linux bug; we really shouldn't be poking around for buses
    that ACPI didn't tell us about.

Bjorn

[1] https://bugs.freedesktop.org/attachment.cgi?id=136529

Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26A3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817172124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817172124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeHQNaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:30:30 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50617 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeHQNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:30:29 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LnSVK-1gLqnN1ClK-00haWR; Fri, 17 Aug 2018 12:27:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 00/15] PCI: turn some __weak functions into callbacks
Date:   Fri, 17 Aug 2018 12:26:30 +0200
Message-Id: <20180817102645.3839621-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:dWl+hzcJroIhS3/jGbVkLP4YuN1iaMm1kiokR+JWz1c8kXoip1x
 WiL9n7z0xcIn+dIlrCPcb4lwLtwRSjzq7b7I3TrR++GaTKkY7QzBS4x1M+Is3MkdtcmmytP
 rMOMOo2lyhTKf2nO2cYd09N7IAubXneAPaa9IbX5rR6DHfZfBRKsDcEhaDKyVgAgNn70Aw7
 bQrmMZdYVZgabyMU89ZRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:374uKI/eH50=:/brEApJ45kswqUCVVqQRN/
 C/RgIDajIouVdL2I2bYXVia6dsp2qbt57fv1adPrhV34B+G73TTgHO1JYlIGdzpBWsvVKtZli
 LrVJbt8y9ebPmXr0nAjNsuwjVqG2aoFjyLQEEuH/gRvvwAOk/tJnvb4iYlLeo9eqNteKeJtDa
 Skl+zGBraYO8vdH7Jf4JxG8PNhhiSE8SabTJBIYVYKMPLbOtC5dh/4HfP2EAjmAnfHesGPyar
 qR/N6IHDdNimkavARF8yEjzQqSjHvjG/kPKej8eOKpY0Ka/NP9EwybRagLFs9TdVlTB1VhIs9
 CYpQO8UyCv7pf1aswd9jT53Y6T7KiL86czeEw1rzVZ8j4ofn6maQgvPrB4OGi0sAuFn6clxkI
 Y9AYEKm7uKlYmmp9uBWIejmZxqpUhKxjFOOA8WIZvHthNS0ZJT1LgmyDm0T56POPEYFkXYQH5
 HjmOQ0XGf17t0WphUybYoud3GM2/w7MOwWLdjXJIlhef8oqw+w9fbtp7eT3FiTO6DqlPEN53B
 QUlFxAdhwt+4pqDu16XgsfZY5iZQ4x3c4bqNVRSgqIioIDiIqEBjo21qenoXzhYbN90+nBkC5
 IWNZWpyV0Qsx5BIMbRTTvq81sjtPunWRAo5/7JYhf+BAfkzjQB7hpzwtcIcJebvvUir6JmFv1
 z31OYtUfPkkV/xO3343wqxnJ1Ioil/lVExXxEVMt0PkbQU4vWsPujYl8cu2BgiU0qWHo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn and others,

Triggered by Christoph's patches, I had another go at converting
all of the remaining pci host bridge implementations to be based
on pci_alloc_host_bridge and a separate registration function.

This is made possible through work from Lorenzo and others to
convert many of the existing drivers, as well as the removal
of some of the older architectures that nobody used.

I'm adding a bit of duplication into the less maintained code
here, but it makes everything more consistent, and gives an
easy place to hook up callback functions etc.

The three parts of this series are:

a) push up the registration into the callers (this is where
   code gets added)
b) clean up some of the more common host bridge
   implementations again to integrate that code better.
   This could be done for the rest as well, or we could just
   leave them alone.
c) start moving the __weak functions into callbacks in
   pci_host_bridge. This is intentionally incomplete, since
   it is a lot of work to do it for all those functions,
   and I want to get consensus on the approach first, as well
   as maybe get other developers to help out with the rest.

Please have a look.

       Arnd

[1] https://lore.kernel.org/lkml/4288331.jNpl6KXlNO@wuerfel/
[2] https://patchwork.kernel.org/patch/10555657/

Arnd Bergmann (15):
  PCI: clean up legacy host bridge scan functions
  PCI: move pci_scan_bus into callers
  PCI: move pci_scan_root_bus into callers
  PCI: export pci_register_host_bridge
  PCI: move pci_create_root_bus into callers
  powerpc/pci: fold pci_create_root_bus into pcibios_scan_phb
  PCI/ACPI: clean up acpi_pci_root_create()
  x86: PCI: clean up pcibios_scan_root()
  PCI: xenfront: clean up pcifront_scan_root()
  sparc/PCI: simplify pci_scan_one_pbm
  PCI: hyperv: convert to pci_scan_root_bus_bridge
  PCI: make pcibios_bus_add_device() a callback function
  PCI: turn pcibios_alloc_irq into a callback
  PCI: make pcibios_root_bridge_prepare a callback
  PCI: make pcibios_add_bus/remove_bus callbacks

 arch/arm64/kernel/pci.c               |  40 ++-----
 arch/ia64/pci/pci.c                   |  25 +----
 arch/ia64/sn/kernel/io_init.c         |  27 +++++
 arch/microblaze/pci/pci-common.c      |  27 +++++
 arch/powerpc/include/asm/pci-bridge.h |   3 +
 arch/powerpc/kernel/pci-common.c      |  60 +++++------
 arch/s390/pci/pci.c                   |  30 +++++-
 arch/sh/drivers/pci/pci.c             |   1 +
 arch/sh/drivers/pci/pcie-sh7786.c     |   3 +-
 arch/sh/include/asm/pci.h             |   2 +
 arch/sparc/kernel/pci.c               |  40 ++++---
 arch/sparc/kernel/pcic.c              |  35 ++++++
 arch/x86/pci/acpi.c                   |  15 +--
 arch/x86/pci/common.c                 |  42 ++++----
 arch/xtensa/kernel/pci.c              |  27 +++++
 drivers/acpi/pci_root.c               |  43 +++++---
 drivers/parisc/dino.c                 |  28 +++++
 drivers/parisc/lba_pci.c              |  28 +++++
 drivers/pci/bus.c                     |   8 +-
 drivers/pci/controller/pci-hyperv.c   |  47 ++++----
 drivers/pci/controller/vmd.c          |  30 +++++-
 drivers/pci/hotplug/ibmphp_core.c     |  35 ++++++
 drivers/pci/pci-driver.c              |  13 ++-
 drivers/pci/probe.c                   | 150 +++++++++-----------------
 drivers/pci/xen-pcifront.c            |  40 +++----
 include/linux/acpi.h                  |   2 +
 include/linux/pci.h                   |  17 ++-
 27 files changed, 514 insertions(+), 304 deletions(-)

-- 
2.18.0


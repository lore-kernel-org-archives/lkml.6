Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B0AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90DE2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90DE2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391731AbeKVN3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:29:17 -0500
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:47536
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731067AbeKVN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:29:17 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id Pf51gqkpNse9VPf51gykHp; Wed, 21 Nov 2018 19:51:00 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gPf51-00048v-Pr; Wed, 21 Nov 2018 19:50:59 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/4] Hyper-V: Enable Linux guests on Hyper-V on ARM64 
Date:   Thu, 22 Nov 2018 02:50:51 +0000
Message-Id: <20181122025051.15886-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMrqRm8wAJzbO5vcN76QRKxvs0DsCTqAAOZeKJUc+2Be2noxeStliqE+4ri6UIRPNihKfAbwKp974LGqdzjR7Kr33eES1FQOGCPuZnrOS42EAHI7UrF6
 W6gB3P9+nE6ejXAorkuEhpnudmLVQGQl4hdknV0xWjlrOp8d8jYckGrchYrIMD5d0bEldDoxwZaHT68cuZJdtLOqc7WdRJJDwDXgyLS7LSps5qm2whRLd77J
 TjAuM5rieBOh6OnNPWQX1vum9PyNVbKF4cTvbuyf7Mw7CkJLaLpBZMPDx4OJN5zCioYlzIu+g/vTxKicFU85/5ptzA1PR8LxWXW65olZOKhqqam6I76t6wLG
 x5bdQMTNLA+PcmCNG0FbdHACwEGDjykJeOCjvqS/qBqJs3qCMqsYF4PHG8vFp2eeyMz+YaD6TNDqwYOnEK8nFXTRox3jBiWpHLATU9oc4PjZoZWkgwhgtU/j
 7qwBWjcxBPsZ7E3WdppuRIWUCcvNFQ5p+wR0IDJambl/78F59cxXmK7yaXBGdW/jBQTf/Jhog/xbM77x
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

This series enables Linux guests running on Hyper-V on ARM64
hardware. New ARM64-specific code in arch/arm64/hyperv initializes
Hyper-V, including its synthetic clocks and hypercall mechanism.
Existing architecture independent drivers for Hyper-V's VMbus and
synthetic devices just work when built for ARM64. Hyper-V code is
built and included in the image and modules only if CONFIG_HYPERV
is enabled.

The four patches are organized as follows:
1) Add include files that define the Hyper-V interface as
   described in the Hyper-V Top Level Functional Spec (TLFS), plus
   additional definitions specific to Linux running on Hyper-V.

2) Add core Hyper-V support on ARM64, including hypercalls,
   synthetic clock initialization, and interrupt handlers.

3) Update the existing VMbus driver to generalize interrupt
   management across x86/x64 and ARM64.

4) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.

Some areas of Linux guests on Hyper-V on ARM64 are a work-
in-progress, primarily due to work still being done in Hyper-V:

* Hyper-V on ARM64 currently runs with a 4 Kbyte page size, and only
  supports guests with a 4 Kbyte page size. Because Hyper-V uses
  shared pages to communicate between the guest and the hypervisor,
  there are open design decisions on the page size to use when
  the guest is using 16K/64K pages.  Once those issues are
  resolved and Hyper-V fully supports 16K/64K guest pages, changes
  may be needed in the Linux drivers for Hyper-V synthetic devices.

* Hyper-V on ARM64 does not currently support mapping PCI devices
  into the guest address space. The Hyper-V PCI driver at
  drivers/pci/host/pci-hyperv.c has x86/x64-specific code and is
  not being built for ARM64.

In a few cases, terminology from the x86/x64 world has been carried
over into the ARM64 code ("MSR", "TSC").  Hyper-V still uses the
x86/x64 terminology and has not replaced it with something more
generic, so the code uses the Hyper-V terminology.  This will be
fixed when Hyper-V updates the usage in the TLFS.


Michael Kelley (4):
  arm64: hyperv: Add core Hyper-V include files
  arm64: hyperv: Add support for Hyper-V as a hypervisor
  Drivers: hv: vmbus: Add hooks for per-CPU IRQ
  Drivers: hv: Enable CONFIG_HYPERV on ARM64

 MAINTAINERS                          |   4 +
 arch/arm64/Makefile                  |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_hvc.S           |  54 ++++
 arch/arm64/hyperv/hv_init.c          | 441 +++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         | 178 +++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h | 338 ++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h    | 116 +++++++
 arch/x86/include/asm/mshyperv.h      |   4 +
 drivers/hv/Kconfig                   |   3 +-
 drivers/hv/hv.c                      |   2 +
 include/asm-generic/mshyperv.h       | 240 +++++++++++++++
 12 files changed, 1382 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_hvc.S
 create mode 100644 arch/arm64/hyperv/hv_init.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h
 create mode 100644 include/asm-generic/mshyperv.h

-- 
2.19.1


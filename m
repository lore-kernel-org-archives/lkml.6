Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87CBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C452173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfAHPiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:38:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:61283 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfAHPiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:38:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 07:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,454,1539673200"; 
   d="scan'208";a="116458381"
Received: from cweger-mobl1.ger.corp.intel.com (HELO [10.249.42.158]) ([10.249.42.158])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2019 07:37:58 -0800
Subject: [PATCH] drm: Require PCI for selecting VGA_ARB.
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3a1c95bb-9986-663d-09a1-8c7e84d0a7a7@molgen.mpg.de>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <6ba074cd-bd1b-3844-8a3b-b0cfb34e24bc@linux.intel.com>
Date:   Tue, 8 Jan 2019 16:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <3a1c95bb-9986-663d-09a1-8c7e84d0a7a7@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 08-01-2019 om 16:07 schreef Paul Menzel:
> Dear Linux folks,
>
>
> Building Linux 5.0-rc1 fails with the errors below. Please find the
> configuration file attached.
>
> ```
> $ make -j120
> […]
> drivers/gpu/vga/vgaarb.c: In function ‘__vga_tryget’:
> drivers/gpu/vga/vgaarb.c:286:14: error: ‘PCI_VGA_STATE_CHANGE_DECODES’ undeclared (first use in this function); did you mean ‘PCI_SUBTRACTIVE_DECODE’?
>      flags |= PCI_VGA_STATE_CHANGE_DECODES;
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>               PCI_SUBTRACTIVE_DECODE
> drivers/gpu/vga/vgaarb.c:286:14: note: each undeclared identifier is reported only once for each function it appears in
>   CC [M]  net/netfilter/xt_realm.o
>   CC      drivers/hid/hid-cherry.o
> drivers/gpu/vga/vga_switcheroo.c: In function ‘vga_switcheroo_runtime_suspend’:
> drivers/gpu/vga/vga_switcheroo.c:1053:2: error: implicit declaration of function ‘pci_bus_set_current_state’; did you mean ‘__set_current_state’? [-Werror=implicit-function-declaration]
>   pci_bus_set_current_state(pdev->bus, PCI_D3cold);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~
>   __set_current_state
> drivers/gpu/vga/vgaarb.c:291:13: error: ‘PCI_VGA_STATE_CHANGE_BRIDGE’ undeclared (first use in this function); did you mean ‘PCI_VGA_STATE_CHANGE_DECODES’?
>     flags |= PCI_VGA_STATE_CHANGE_BRIDGE;
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>              PCI_VGA_STATE_CHANGE_DECODES
>   CC      fs/reiserfs/dir.o
>   LD [M]  net/tipc/tipc.o
> drivers/gpu/vga/vga_switcheroo.c: In function ‘vga_switcheroo_runtime_resume’:
> drivers/gpu/vga/vga_switcheroo.c:1067:2: error: implicit declaration of function ‘pci_wakeup_bus’; did you mean ‘__wake_up_bit’? [-Werror=implicit-function-declaration]
>   pci_wakeup_bus(pdev->bus);
>   ^~~~~~~~~~~~~~
>   __wake_up_bit
> drivers/gpu/vga/vgaarb.c:293:3: error: implicit declaration of function ‘pci_set_vga_state’; did you mean ‘pci_set_power_state’? [-Werror=implicit-function-declaration]
>    pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
>    ^~~~~~~~~~~~~~~~~
>    pci_set_power_state
>   CC      fs/read_write.o
>   CC      drivers/hid/hid-chicony.o
>   CC      drivers/hid/hid-cypress.o
> drivers/gpu/vga/vgaarb.c: In function ‘vga_arb_device_init’:
> drivers/gpu/vga/vgaarb.c:1495:25: error: ‘pci_bus_type’ undeclared (first use in this function); did you mean ‘pci_pcie_type’?
>   bus_register_notifier(&pci_bus_type, &pci_notifier);
>                          ^~~~~~~~~~~~
>                          pci_pcie_type
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:277: drivers/gpu/vga/vgaarb.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> […]
> ```
>
>
> Kind regards,
>
> Paul

WARNING: unmet direct dependencies detected for VGA_ARB
  Depends on [n]: HAS_IOMEM [=y] && PCI [=n] && !S390
  Selected by [y]:
  - VGA_SWITCHEROO [=y] && HAS_IOMEM [=y] && X86 [=y] && ACPI [=y]

So I guess you need to enable PCI, probably not a common config you're using. :)

Especially since you selected EXPERT.

Oh well, apply this with git am --scissors?
-----8<----
When configuring the kernel without PCI we can still enable VGA switcheroo,
which is not possible because VGA_ARB cannot be selected.

Remove this by depending on PCI for !S390.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index b677e5d524e6..ef5671475870 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -21,6 +21,7 @@ config VGA_SWITCHEROO
 	bool "Laptop Hybrid Graphics - GPU switching support"
 	depends on X86
 	depends on ACPI
+	depends on (PCI && !S390) # For VGA_ARB
 	select VGA_ARB
 	help
 	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer


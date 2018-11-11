Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68017C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDAE223CA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z7BSiSLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDAE223CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404303AbeKLIXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404230AbeKLIXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:14 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0500C208A3;
        Sun, 11 Nov 2018 22:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975596;
        bh=mKAhBxfqbgZ9LMeDkIjyaz05jHNPnXwhsGB6atKafoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7BSiSLc6OMP5tvBlLB/ms4uPPCFU28/iE+dHxrawNaf6+lnJ5ZBFR8xgkIxn1FB5
         B+eEIWWPbBeLhLvjJfEUqWtPlKOD8Xc3e1dNFS1NlYMl6PLp3RuIck9zyPAs6ucSOH
         uzVkFMilxQIciIfk+VauewN3ivuYZIpuuMeyn24g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.14 179/222] TC: Set DMA masks for devices
Date:   Sun, 11 Nov 2018 14:24:36 -0800
Message-Id: <20181111221703.059025445@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@linux-mips.org>

commit 3f2aa244ee1a0d17ed5b6c86564d2c1b24d1c96b upstream.

Fix a TURBOchannel support regression with commit 205e1b7f51e4
("dma-mapping: warn when there is no coherent_dma_mask") that caused
coherent DMA allocations to produce a warning such as:

defxx: v1.11 2014/07/01  Lawrence V. Stefani and others
tc1: DEFTA at MMIO addr = 0x1e900000, IRQ = 20, Hardware addr = 08-00-2b-a3-a3-29
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 dfx_dev_register+0x670/0x678
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.19.0-rc6 #2
Stack : ffffffff8009ffc0 fffffffffffffec0 0000000000000000 ffffffff80647650
        0000000000000000 0000000000000000 ffffffff806f5f80 ffffffffffffffff
        0000000000000000 0000000000000000 0000000000000001 ffffffff8065d4e8
        98000000031b6300 ffffffff80563478 ffffffff805685b0 ffffffffffffffff
        0000000000000000 ffffffff805d6720 0000000000000204 ffffffff80388df8
        0000000000000000 0000000000000009 ffffffff8053efd0 ffffffff806657d0
        0000000000000000 ffffffff803177f8 0000000000000000 ffffffff806d0000
        9800000003078000 980000000307b9e0 000000001e900000 ffffffff80067940
        0000000000000000 ffffffff805d6720 0000000000000204 ffffffff80388df8
        ffffffff805176c0 ffffffff8004dc78 0000000000000000 ffffffff80067940
        ...
Call Trace:
[<ffffffff8004dc78>] show_stack+0xa0/0x130
[<ffffffff80067940>] __warn+0x128/0x170
---[ end trace b1d1e094f67f3bb2 ]---

This is because the TURBOchannel bus driver fails to set the coherent
DMA mask for devices enumerated.

Set the regular and coherent DMA masks for TURBOchannel devices then,
observing that the bus protocol supports a 34-bit (16GiB) DMA address
space, by interpreting the value presented in the address cycle across
the 32 `ad' lines as a 32-bit word rather than byte address[1].  The
architectural size of the TURBOchannel DMA address space exceeds the
maximum amount of RAM any actual TURBOchannel system in existence may
have, hence both masks are the same.

This removes the warning shown above.

References:

[1] "TURBOchannel Hardware Specification", EK-369AA-OD-007B, Digital
    Equipment Corporation, January 1993, Section "DMA", pp. 1-15 -- 1-17

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20835/
Fixes: 205e1b7f51e4 ("dma-mapping: warn when there is no coherent_dma_mask")
Cc: stable@vger.kernel.org # 4.16+
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tc/tc.c    |    8 +++++++-
 include/linux/tc.h |    1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/tc/tc.c
+++ b/drivers/tc/tc.c
@@ -2,7 +2,7 @@
  *	TURBOchannel bus services.
  *
  *	Copyright (c) Harald Koerfgen, 1998
- *	Copyright (c) 2001, 2003, 2005, 2006  Maciej W. Rozycki
+ *	Copyright (c) 2001, 2003, 2005, 2006, 2018  Maciej W. Rozycki
  *	Copyright (c) 2005  James Simmons
  *
  *	This file is subject to the terms and conditions of the GNU
@@ -10,6 +10,7 @@
  *	directory of this archive for more details.
  */
 #include <linux/compiler.h>
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -92,6 +93,11 @@ static void __init tc_bus_add_devices(st
 		tdev->dev.bus = &tc_bus_type;
 		tdev->slot = slot;
 
+		/* TURBOchannel has 34-bit DMA addressing (16GiB space). */
+		tdev->dma_mask = DMA_BIT_MASK(34);
+		tdev->dev.dma_mask = &tdev->dma_mask;
+		tdev->dev.coherent_dma_mask = DMA_BIT_MASK(34);
+
 		for (i = 0; i < 8; i++) {
 			tdev->firmware[i] =
 				readb(module + offset + TC_FIRM_VER + 4 * i);
--- a/include/linux/tc.h
+++ b/include/linux/tc.h
@@ -84,6 +84,7 @@ struct tc_dev {
 					   device. */
 	struct device	dev;		/* Generic device interface. */
 	struct resource	resource;	/* Address space of this device. */
+	u64		dma_mask;	/* DMA addressable range. */
 	char		vendor[9];
 	char		name[9];
 	char		firmware[9];



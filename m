Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA582080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA582080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbeKLFzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51832 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726992AbeKLFzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:05 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsz-0000lK-OX; Sun, 11 Nov 2018 19:59:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001Z3-Nj; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Burton" <paul.burton@mips.com>,
        "Hauke Mehrtens" <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        "=?UTF-8?Q?Rafa=C5=82=20?= =?UTF-8?Q?Mi=C5=82ecki?=" 
        <zajec5@gmail.com>,
        "Chris Packham" <chris.packham@alliedtelesis.co.nz>,
        "James Hogan" <jhogan@kernel.org>,
        "Tokunori Ikegami" <ikegami@allied-telesis.co.jp>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.189575243@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 151/366] MIPS: BCM47XX: Enable 74K Core ExternalSync
 for PCIe erratum
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tokunori Ikegami <ikegami@allied-telesis.co.jp>

commit 2a027b47dba6b77ab8c8e47b589ae9bbc5ac6175 upstream.

The erratum and workaround are described by BCM5300X-ES300-RDS.pdf as
below.

  R10: PCIe Transactions Periodically Fail

    Description: The BCM5300X PCIe does not maintain transaction ordering.
                 This may cause PCIe transaction failure.
    Fix Comment: Add a dummy PCIe configuration read after a PCIe
                 configuration write to ensure PCIe configuration access
                 ordering. Set ES bit of CP0 configu7 register to enable
                 sync function so that the sync instruction is functional.
    Resolution:  hndpci.c: extpci_write_config()
                 hndmips.c: si_mips_init()
                 mipsinc.h CONF7_ES

This is fixed by the CFE MIPS bcmsi chipset driver also for BCM47XX.
Also the dummy PCIe configuration read is already implemented in the
Linux BCMA driver.

Enable ExternalSync in Config7 when CONFIG_BCMA_DRIVER_PCI_HOSTMODE=y
too so that the sync instruction is externalised.

Signed-off-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/19461/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/bcm47xx/setup.c        | 6 ++++++
 arch/mips/include/asm/mipsregs.h | 3 +++
 2 files changed, 9 insertions(+)

--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -253,6 +253,12 @@ static int __init bcm47xx_cpu_fixes(void
 		 */
 		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
 			cpu_wait = NULL;
+
+		/*
+		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
+		 * Enable ExternalSync for sync instruction to take effect
+		 */
+		set_c0_config7(MIPS_CONF7_ES);
 		break;
 #endif
 	}
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -674,6 +674,8 @@
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
+/* ExternalSync */
+#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
 
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
@@ -1817,6 +1819,7 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
+__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Bz4EOmLhGluiLgAAmS7hNA
	; Fri, 08 Jun 2018 20:04:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D4612601D2; Fri,  8 Jun 2018 20:04:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6uedW4k"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4E57F605A5;
	Fri,  8 Jun 2018 20:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E57F605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeFHUEs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeFHUEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:04:47 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E47420874;
        Fri,  8 Jun 2018 20:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488286;
        bh=7zgfdFxrBLqH2edqwUxYuNlO7pXPr5rQj8TJpePjoM8=;
        h=Subject:From:To:Cc:Date:From;
        b=P6uedW4kDcBFjHHJ+P0sCr7tral0AzBxKWN5fB8kmHT/nhYOVR4pBt9OBkjgtfvDU
         mInCQ6xGOy68LyMwTmtNe5nhaw3N5YRcO89caAhZ838hWT3VRZwgqmdg4wn/URvfUP
         S3bjBycrOuKFbQZUEaDq/b0Li04whSYB2c2DFoUY=
Subject: [RFC PATCH v1 00/13] PCI/AER: Squash into one file
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:04:45 -0500
Message-ID: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AER code is scattered across several files and buried a little too deep
in the hierarchy, which makes it a bit of a hassle to browse.  Consolidate
it all in a single file (plus the optional aer_inject module) and move it
up one level to drivers/pci/pcie/aer.c.

This is all pure code moves; no functional changes intended.

---

Bjorn Helgaas (13):
      PCI/AER: Remove forward declarations
      PCI/AER: Reorder code to group probe/remove stuff together
      PCI/AER: Squash aerdrv_core.c into aerdrv.c
      PCI/AER: Squash aerdrv_errprint.c into aerdrv.c
      PCI/AER: Squash aerdrv_acpi.c into aerdrv.c
      PCI/AER: Squash ecrc.c into aerdrv.c
      PCI/AER: Remove duplicate pcie_port_bus_type declaration
      PCI/AER: Move pcie_aer_get_firmware_first() to portdrv.h
      PCI/AER: Move aer_irq() declaration to portdrv.h
      PCI/AER: Move private AER things to aerdrv.c
      PCI/AER: Squash Kconfig.debug into Kconfig
      PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/
      PCI/AER: Use "PCI Express" consistently in Kconfig text


 drivers/pci/pcie/Kconfig               |   41 +
 drivers/pci/pcie/Makefile              |    3 
 drivers/pci/pcie/aer.c                 | 1377 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/Kconfig           |   29 -
 drivers/pci/pcie/aer/Kconfig.debug     |   19 
 drivers/pci/pcie/aer/Makefile          |   13 
 drivers/pci/pcie/aer/aer_inject.c      |  550 -------------
 drivers/pci/pcie/aer/aerdrv.c          |  371 ---------
 drivers/pci/pcie/aer/aerdrv.h          |   95 --
 drivers/pci/pcie/aer/aerdrv_acpi.c     |  141 ---
 drivers/pci/pcie/aer/aerdrv_core.c     |  496 ------------
 drivers/pci/pcie/aer/aerdrv_errprint.c |  260 ------
 drivers/pci/pcie/aer/ecrc.c            |  117 ---
 drivers/pci/pcie/aer_inject.c          |  551 +++++++++++++
 drivers/pci/pcie/dpc.c                 |    1 
 drivers/pci/pcie/portdrv.h             |   15 
 16 files changed, 1983 insertions(+), 2096 deletions(-)
 create mode 100644 drivers/pci/pcie/aer.c
 delete mode 100644 drivers/pci/pcie/aer/Kconfig
 delete mode 100644 drivers/pci/pcie/aer/Kconfig.debug
 delete mode 100644 drivers/pci/pcie/aer/Makefile
 delete mode 100644 drivers/pci/pcie/aer/aer_inject.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv.h
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_acpi.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_core.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_errprint.c
 delete mode 100644 drivers/pci/pcie/aer/ecrc.c
 create mode 100644 drivers/pci/pcie/aer_inject.c

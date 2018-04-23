Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZqvCDhb3l5/5Dltu+inBPiMMZK16Z0pOAnCr23TDNdGrIuoc7M3S7c94ijgJQesdGu0kDPx
ARC-Seal: i=1; a=rsa-sha256; t=1524496997; cv=none;
        d=google.com; s=arc-20160816;
        b=PnN/uo+eUvOOjqpdZYaLUIqi/7Efuw1mPHwhiXeEzpLlECUEIChWSmGJFEozGGVxmM
         oDYjuvF3WUrA8Fh81pUeIak13Ob/7ztbdUHzvOH9vNe43MhVyUUHuKEJXMBXkh/O//kD
         /L713y34ngRDImU16cZtdci6CVSneRoCniJIqCqvMmLqXKXwyqsXngfaJkVIzrflcjSK
         3fwjxyu8IwwZq4Ln+TetenNhQRxpK35yGTmSSnB2tpYlIxzIacgKVzHJqZ+5H1xjw/JM
         RQZtMW7cNdPAFBo1XZDHEeJYzulmpZXcGgeWed/J6yC31yD10GyT3FUMrpAqRuMO8iRE
         YqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=GOVyhP4UHbCHrCx00ylS38NV6qUeFSRkZbkusrnu390=;
        b=jIqkuYJ4SVBwa+GB8dxVWsnWhvrV63kNa8W0Yh9yfz27L7wVy1IcQRpmD16NBDM4me
         qnR0t5W/exqr9zkht8yHgTfZcz+TwcBhfJOVE+K3TUMUUFg6Cfa0ycoiwsrdsj/qIJ+1
         hzfNBgRmvU6jn3C2DZAtGfxv6TRcAcFluJRnaEqHUqsd5DUZ91Xx8XH18P4TGyESKim2
         Jm5licGWlqZliSIuqAnsvOea1FfKFpu3kA2glU2mST76OCpDkv7+5HkSN+N5PTgIYC1v
         UxADfYsfy7wbep1qBOW9B43TkQP8NPrd0FhVYaf54U+mcxVaCszFlzace2Q2EXIKygWm
         SYfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="126091297"
X-IronPort-AV: E=McAfee;i="5900,7806,8871"; a="144918531"
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>,
	Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v14 0/9] Address error and recovery for AER and DPC
Date: Mon, 23 Apr 2018 11:23:04 -0400
Message-Id: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550963799959493?=
X-GMAIL-MSGID: =?utf-8?q?1598550963799959493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set brings in error handling support for DPC

The current implementation of AER and error message broadcasting to the
EP driver is tightly coupled and limited to AER service driver.
It is important to factor out broadcasting and other link handling
callbacks. So that not only when AER gets triggered, but also when DPC get
triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.

The goal of the patch-set is:
DPC should handle the error handling and recovery similar to AER, because 
finally both are attempting recovery in some or the other way,
and for that error handling and recovery framework has to be loosely
coupled.

It achieves uniformity and transparency to the error handling agents such
as AER, DPC, with respect to recovery and error handling.

So, this patch-set tries to unify lot of things between error agents and
make them behave in a well defined way. (be it error (FATAL, NON_FATAL)
handling or recovery).

The FATAL error handling is handled with remove/reset_link/re-enumerate
sequence while the NON_FATAL follows the default path.
Documentation/PCI/pci-error-recovery.txt talks more on that.

Changes since v13:
    Bjorn's comments addressed
    > handke FATAL errors with remove devices followed by re-enumeration.
    > changes in AER and DPC along with required Documentation.
Changes since v12:
    Bjorn's and Keith's Comments addressed.
    > Made DPC and AER error handling identical <aligned err.c>
    > hanldled cases for hotplug enabled system differently.
Changes since v11:
    Bjorn's comments addressed.
    > rename pcie-err.c to err.c
    > removed EXPORT_SYMBOL
    > made generic find_serivce function in port driver.
    > removed mutex patch as no need to have mutex in pcie_do_recovery
    > brough in DPC_FATAL in aer.h
    > so now all the error codes (AER and DPC) are unified in aer.h
Changes since v10:
    Christoph Hellwig's, David Laight's and Randy Dunlap's
    comments addressed.
        > renamed pci_do_recovery to pcie_do_recovery
        > removed inner braces in conditional statements.
        > restrctured the code in pci_wait_for_link
        > EXPORT_SYMBOL_GPL
Changes since v9:
    Sinan's comments addressed.
        > bool active = true; unnecessary variable removed.
Changes since v8:
    Fixed Kbuild errors.
Changes since v7:
    Rebased the code on pci master
        > https://kernel.googlesource.com/pub/scm/linux/kernel/git/helgaas/pci
Changes since v6:
    Sinan's and Stefan's comments implemented.
        > reordered patch 6 and 7
        > cleaned up
Changes since v5:
    Sinan's and Keith's comments incorporated.
        > made separate patch for mutex
        > unified error repotting codes into driver/pci/pci.h
        > got rid of wait link active/inactive and
          made generic function in driver/pci/pci.c
Changes since v4:
    Bjorn's comments incorporated.
        > Renamed only do_recovery.
        > moved the things more locally to drivers/pci/pci.h
Changes since v3:
    Bjorn's comments incorporated.
        > Made separate patch renaming generic pci_err.c
        > Introduce pci_err.h to contain all the error types and recovery
        > removed all the dependencies on pci.h
Changes since v2:
    Based on feedback from Keith:
    "
    When DPC is triggered due to receipt of an uncorrectable error Message,
    the Requester ID from the Message is recorded in the DPC Error
    Source ID register and that Message is discarded and not forwarded Upstream.
    "
    Removed the patch where AER checks if DPC service is active
Changes since v1:
    Kbuild errors fixed:
        > pci_find_dpc_dev made static
        > ras_event.h updated
        > pci_find_aer_service call with CONFIG check
        > pci_find_dpc_service call with CONFIG check

Oza Pawandeep (9):
  PCI/AER: Rename error recovery to generic PCI naming
  PCI/AER: Factor out error reporting from AER
  PCI/PORTDRV: Implement generic find service
  PCI/PORTDRV: Implement generic find device
  PCI/DPC: Unify and plumb error handling into DPC
  PCI: Unify wait for link active into generic PCI
  PCI/DPC: Disable ERR_NONFATAL for DPC
  PCI/AER/DPC: Align FATAL error handling for AER and DPC
  pci-error-recovery: Add AER_FATAL handling

 Documentation/PCI/pci-error-recovery.txt |  35 ++-
 drivers/pci/hotplug/pciehp_hpc.c         |  20 +-
 drivers/pci/pci.c                        |  30 +++
 drivers/pci/pci.h                        |   5 +
 drivers/pci/pcie/Makefile                |   2 +-
 drivers/pci/pcie/aer/aerdrv.c            |   2 +
 drivers/pci/pcie/aer/aerdrv.h            |  30 ---
 drivers/pci/pcie/aer/aerdrv_core.c       | 317 +-------------------------
 drivers/pci/pcie/err.c                   | 374 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/pcie-dpc.c              |  63 +++---
 drivers/pci/pcie/portdrv.h               |   4 +
 drivers/pci/pcie/portdrv_core.c          |  69 ++++++
 include/linux/aer.h                      |   2 +
 include/uapi/linux/pci_regs.h            |   3 +-
 14 files changed, 552 insertions(+), 404 deletions(-)
 create mode 100644 drivers/pci/pcie/err.c

-- 
2.7.4

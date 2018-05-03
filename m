Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZqtaPB0VrkNs3Grq8Q79N4ZWXQ/lbWd33a0zVVSN9N80LzmOAIesHycBbogdT5wc5bj3nV4
ARC-Seal: i=1; a=rsa-sha256; t=1525323845; cv=none;
        d=google.com; s=arc-20160816;
        b=Uo+OeAWn6E03/6TgYczWATy+hM5vyOrgMAHE8qHyjU3bdd4q1fNv/yUyPTPcDsvK8e
         rgvtTjQ9XYAsVMbyrJWFufeMj/tkFc3MCyxVHvHVb4T/2dVbXinT6+DtDZzFYTUe+Eaj
         gJDyw8UVLz1atlZE7RLRDUfh2hHZIDW9PRYwfUWfWPLXONKs5gS/mxbW9H8onP4f7lqw
         RFpLb9OUwoOJmFk686SQBBWtodIoIuc8YptgSj0gJ4RXU7fibYwSccaVHv3co6vJY8p4
         OkpjDJteTvPF39+UEA5HJ3RNHgu+RycJ1fFJJIcfFIT3uU6bQ/feWU0MHgv41stdVSAh
         Z4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=IsqNRNJtqlshF2exJ90SnQ9Ep3dpEkHx8AASTBoZVwQ=;
        b=Yo3Vzfk6emXx6JelCxlbB2Y98eOYBwY1zvk1MrBENKwK/WU6q8NiUNkXFM+SxW+tvP
         E7FSqCPYBBDExFHXdIKpxRQhiXfKS0gQzptktdBxiYFuZeAlVWMmxmV4o+OCAIcoF6ck
         j8BOsRyJSthU5hlbyNAjTITqBn/eSgSgRQf+Gpz0zzEn+/EdhAwKp0ygAa9GvAAwLCR2
         o2dYZus5Xvjj49eeFXA+6Pevh86ASOWzxm37mt5EciaUDhI4+2/PnIrGwnYXLKxEoJxA
         0R4Qjvz5MjbxgRYi/oi5oDREQh4Fz6y/oKumaNoPWFwIN+AG6JvAafUfBT0sHGkafWjw
         RSvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="126361290"
X-IronPort-AV: E=McAfee;i="5900,7806,8881"; a="182707647"
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
Subject: [PATCH v15 0/9] Address error and recovery for AER and DPC
Date: Thu,  3 May 2018 01:03:49 -0400
Message-Id: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417976450884015?=
X-GMAIL-MSGID: =?utf-8?q?1599417976450884015?=
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

Changes since v14:
    Bjorn's comments addressed
    > simplified the patch set, and moved AER_FATAL handling in the beginning.
    > rebase the code to 4.17-rc1.
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
  PCI: Unify wait for link active into generic PCI
  pci-error-recovery: Add AER_FATAL handling
  PCI/AER: Handle ERRR_FATAL with removal and re-enumeration of devices
  PCI/AER: Rename error recovery to generic PCI naming
  PCI/AER: Factor out error reporting from AER
  PCI/PORTDRV: Implement generic find service
  PCI/PORTDRV: Implement generic find device
  PCI/DPC: Unify and plumb error handling into DPC
  PCI/DPC: Disable ERR_NONFATAL and enable ERR_FATAL for DPC

 Documentation/PCI/pci-error-recovery.txt |  35 ++-
 drivers/pci/hotplug/pciehp_hpc.c         |  20 +-
 drivers/pci/pci.c                        |  29 +++
 drivers/pci/pci.h                        |   4 +
 drivers/pci/pcie/Makefile                |   2 +-
 drivers/pci/pcie/aer/aerdrv.c            |   2 +
 drivers/pci/pcie/aer/aerdrv.h            |  30 ---
 drivers/pci/pcie/aer/aerdrv_core.c       | 317 +-------------------------
 drivers/pci/pcie/dpc.c                   |  58 +++--
 drivers/pci/pcie/err.c                   | 374 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h               |   4 +
 drivers/pci/pcie/portdrv_core.c          |  67 ++++++
 include/linux/aer.h                      |   1 +
 include/uapi/linux/pci_regs.h            |   1 +
 14 files changed, 540 insertions(+), 404 deletions(-)
 create mode 100644 drivers/pci/pcie/err.c

-- 
2.7.4

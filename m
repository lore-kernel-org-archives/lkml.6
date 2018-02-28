Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x226Lw2QcPJO1eoVMovFZ4oXy6Y1NsA2eyjsU+OLaA2cuBngD+EdSyTFSAzNTmsXoo39iw+T4
ARC-Seal: i=1; a=rsa-sha256; t=1519837477; cv=none;
        d=google.com; s=arc-20160816;
        b=XDq4Tnxkmz36xhtGx3Eh3QM4SZpVa3NNQI7rRN6H6ve2FG9G9cDHEnfFuzE1GryqUr
         h8/drI47i0GO4GjoHe5ILVAPxVlf8Bl3MWFYlkFLqkch0zWRG67XN21qqsTLB4theTqj
         xZ6sr2ON3vhEtwnucKT6x4xVjxPa8zSdAa9ZrJW16kQEQg5IOYnI7AOqxg1sF9Wl6kKr
         CByDMD6oLPbNySgJndhFH9peiA7Q79FMWUxlfhIzVbng75gblgCfs8gmaI4unD8FLjUs
         Ph+iW9zsqJzystitH+v2r9yTyOwv+Gxh2310s6Jsg+qvY1elLyDLKgt2S3lgjwLOkYgn
         BuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=R5o30LX6k1ejYYOJpvX4G4LY9TqNkS5uYxpf9lgNRss=;
        b=uyjjV4kfWNKVHy4cpXhkbdfqksG9Uvcl3s7ff9wvSU78PDxGVlIdQMrMKISqafYhg7
         LN5gR2yMTM7taL9wo5FII2L3GoI5Oa0vFXzQ/Ni3IAB0wztprRJwAJn6wXt1qiKoIR3R
         GemDGs6dbsWes0tNqGeJ+21R5WaLVkPv4RhqWGDHsNxMMJ53jTamgMczP1oCBoPNSR/j
         UGQZzPlxNdoyb0SwgUxw0c8h2ibBF9XyUCxStk+Sg2bxjvRkt0iieWuNdFJOTPLen43t
         iQ8+dT9rORg25DthH3Sto22zkexG+gKrlJFVhkWFBQONejuPqWLB2yxgsokwNMRu14ST
         CuAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DHlVYuVl;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WchoWBFz;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DHlVYuVl;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WchoWBFz;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD27760240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=poza@codeaurora.org
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
Subject: [PATCH v12 0/6] Address error and recovery for AER and DPC
Date: Wed, 28 Feb 2018 22:34:11 +0530
Message-Id: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1593665102741565714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set brings in error handling support for DPC

The current implementation of AER and error message broadcasting to the
EP driver is tightly coupled and limited to AER service driver.
It is important to factor out broadcasting and other link handling
callbacks. So that not only when AER gets triggered, but also when DPC get
triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.

DPC should enumerate the devices after recovering the link, which is
achieved by implementing error_resume callback.

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

Oza Pawandeep (6):
  PCI/AER: Rename error recovery to generic PCI naming
  PCI/AER: Factor out error reporting from AER
  PCI/PORTDRV: Implement generic find service
  PCI/DPC: Unify and plumb error handling into DPC
  PCI: Unify wait for link active into generic PCI
  PCI/DPC: Enumerate the devices after DPC trigger event

 drivers/pci/hotplug/pciehp_hpc.c   |  20 +--
 drivers/pci/pci.c                  |  29 +++
 drivers/pci/pci.h                  |   5 +
 drivers/pci/pcie/Makefile          |   2 +-
 drivers/pci/pcie/aer/aerdrv.h      |  30 ----
 drivers/pci/pcie/aer/aerdrv_core.c | 317 +-------------------------------
 drivers/pci/pcie/err.c             | 359 +++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/pcie-dpc.c        |  90 ++++++++--
 drivers/pci/pcie/portdrv.h         |   2 +
 drivers/pci/pcie/portdrv_core.c    |  43 +++++
 include/linux/aer.h                |   2 +
 11 files changed, 521 insertions(+), 378 deletions(-)
 create mode 100644 drivers/pci/pcie/err.c

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

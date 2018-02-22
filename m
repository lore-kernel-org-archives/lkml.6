Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x2244XT0k9+KLXT3FYH/0i4+q0rk0fHoEcLUvC55CMXEnrNl9lNPcGOGmN9s9fnkoT2MEBbkx
ARC-Seal: i=1; a=rsa-sha256; t=1519285583; cv=none;
        d=google.com; s=arc-20160816;
        b=I268c2l3YcLmtSixjuj+bMwTz2yWMo6lp8zavnvJVpjbG2MVm7hjQmV+5fX/xT3lj4
         7V1q84kDqOzodw0yi9RMSLdgUwSKYF6xx3D4QJcaMF51qQ+CjDGrTQ3JqB04jAkqTQcv
         hfNNnJ/WslxzA+8Rj3+aXu8GjYx1Bf3F1KZWvLxwm5PsG/kfahi1fCwyK+M8puOPajox
         d5+950l0Dh7L9o3waQB92j9mjg92VX/fsz4846jUjpidlT+ug4L08z4lE6j2HFouYaPS
         Gl+qlcDIhjfEl4oOIsqVCfkdj3ryzSC9zNh0k6nGEdqhlq+k99xPgZaBxG1djdpH4U1g
         Tp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=0iVqLB17v3qyR8v47m+nwLKCpehLgVYfe3Q18mNaV6E=;
        b=ALUWutZaBB/NXH9ul0FVvxFbOvZuZ3yDdyDq89EgKk+S0JuD7gneL1kk2NfR17BplS
         NiGcitbxaLYQsnFbGHNSaJcPqn76sLu9DP2X/jKO46lB7Put2deKeFLxhownT+dmvyZt
         Hio1No3zVrlCVndHBJT1u2088RUZPXiCtHu+zvmoXr6G6L/SzBMFoNWEkINkbp05a1WZ
         qd2F+MOZ4b5gexc1IAqlDo7f78/Lh3fTa39hl8QQhnwNw5MZAT2R+znyZc9YgUFOnPt0
         W6U3rsrtum+79RIF6S8Mg6TeMJSWlRzQjY1gC2LRV6WPm1zpTRdYJ8uuMTtDudwMsATO
         vkFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UEcYPzK8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=m+mi7c2j;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UEcYPzK8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=m+mi7c2j;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2712F606DC
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
Subject: [PATCH v9 0/7] Address error and recovery for AER and DPC
Date: Thu, 22 Feb 2018 13:16:04 +0530
Message-Id: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086399695598263?=
X-GMAIL-MSGID: =?utf-8?q?1593086399695598263?=
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

Changes since v8:
    Fixed Kbuild errors.
Changes since v7:
    Rebased the code on pci master.
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

Oza Pawandeep (7):
  PCI/AER: Rename error recovery to generic pci naming
  PCI/AER: factor out error reporting from AER
  PCI/ERR: add mutex to synchronize recovery
  PCI/DPC: Unify and plumb error handling into DPC
  PCI/AER: Unify aer error defines at single space
  PCI/DPC: Enumerate the devices after DPC trigger event
  PCI: Unify wait for link active into generic pci

 drivers/acpi/apei/ghes.c               |   1 +
 drivers/pci/hotplug/pciehp_hpc.c       |  21 +-
 drivers/pci/pci.c                      |  39 +++-
 drivers/pci/pci.h                      |  11 +
 drivers/pci/pcie/Makefile              |   2 +-
 drivers/pci/pcie/aer/aerdrv.h          |  30 ---
 drivers/pci/pcie/aer/aerdrv_core.c     | 293 +-------------------------
 drivers/pci/pcie/aer/aerdrv_errprint.c |   1 +
 drivers/pci/pcie/pcie-dpc.c            | 115 ++++++++++-
 drivers/pci/pcie/pcie-err.c            | 366 +++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h             |   2 +
 include/linux/aer.h                    |   4 -
 include/linux/pci.h                    |   1 +
 13 files changed, 534 insertions(+), 352 deletions(-)
 create mode 100644 drivers/pci/pcie/pcie-err.c

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqvo5rbDLjyVuTGwt6UyaQ6GicKevlq5VbFOFL0fzFJ+Da38ud+Quege+iXTivP67/QJe8o
ARC-Seal: i=1; a=rsa-sha256; t=1526071892; cv=none;
        d=google.com; s=arc-20160816;
        b=Mg6H+xaTgR7d2XNOzM6XHufp5LH3+cLgmYVbMJMmth1BE58R324acaDfqLrneHh4HJ
         dcogFQVhLu0GYD6a0Qb9nyncYn3YD04E2NRzVvmLwMOu8uXACorKKZXuqBq2NEO8/gcS
         K9IuXNattMTcB/fvWmEVGyENxO/VojZ23YAG5xQYWFXl4lfpMLmX1wgIULnQ3EvS6N9v
         OeDstyEUkjg0MV3kmqjPnszdUSknNO1Jj7Eh1TykOzFicToHHC+dTa7lNcJze7scHZVb
         QxF897vAb7EYzKF0J19jO+53gAErH8giFgplMPm3MKsYuhMuxyAiKAGbKtEIz1aAIk3w
         XxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=LS9kUFfKuJlnzy3HtnqogJqUloh/KpGmjfg8jtw0OEk=;
        b=DGu1bPlysA0R5GKh8RtndKz9nUgQYTwKcs62R1s0yrD5M+iVWuCT7u1n3HzrvPTfaN
         4+pOr8NkU+/TKAM2AZuGo7b0rymt5C1uaNF/tq+glot66GNBG4bHKvcjLidfGJPkPLhY
         PA6nMugWb6fuYj5tFToTKlklqfsVJ74fRSAlQad27To+W/clBefxnkMI3CtISbxzzHd4
         76YVyDSYkCVOFW1UnmDwvsgsRiRKVuKPl7b1M3uoOUmq61LJTPHa7Bg23dI0LHmhaoN6
         cUph3drGUUGnnblo/k7LsjJLw92T8jE9aH5Wpsu0IPccAuDaEyP/th+9cj9/60y8BD90
         tUlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104725"
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Jean Delvare <khali@linux-fr.org>,
	"Christoph Hellwig" <hch@infradead.org>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 00/23] IOMMU and VT-d driver support for Shared Virtual Address (SVA)
Date: Fri, 11 May 2018 13:53:52 -0700
Message-Id: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361036375004?=
X-GMAIL-MSGID: =?utf-8?q?1600202361036375004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
platforms allow address space sharing between device DMA and applications.
SVA can reduce programming complexity and enhance security. To enable SVA
in the guest, i.e. shared guest application address space and physical
device DMA address, IOMMU driver must provide some new functionalities.

This patchset is a follow-up on the discussions held at LPC 2017
VFIO/IOMMU/PCI track. Slides and notes can be found here:
https://linuxplumbersconf.org/2017/ocw/events/LPC2017/tracks/636

The complete guest SVA support also involves changes in QEMU and VFIO,
which has been posted earlier.
https://www.spinics.net/lists/kvm/msg148798.html

This is the IOMMU portion follow up of the more complete series of the
kernel changes to support vSVA. Please refer to the link below for more
details. https://www.spinics.net/lists/kvm/msg148819.html

Generic APIs are introduced in addition to Intel VT-d specific changes,
the goal is to have common interfaces across IOMMU and device types for
both VFIO and other in-kernel users.

At the top level, new IOMMU interfaces are introduced as follows:
 - bind guest PASID table
 - passdown invalidations of translation caches
 - IOMMU device fault reporting including page request/response and
   non-recoverable faults.

For IOMMU detected device fault reporting, struct device is extended to
provide callback and tracking at device level. The original proposal was
discussed here "Error handling for I/O memory management units"
(https://lwn.net/Articles/608914/). I have experimented two alternative
solutions:
1. use a shared group notifier, this does not scale well also causes unwanted
notification traffic when group sibling device is reported with faults.
2. place fault callback at device IOMMU arch data, e.g. device_domain_info
in Intel/FSL IOMMU driver. This will cause code duplication, since per
device fault reporting is generic.

The additional patches are Intel VT-d specific, which either implements or
replaces existing private interfaces with the generic ones.

This patchset is based on the work and ideas from many people, especially:
Ashok Raj <ashok.raj@intel.com>
Liu, Yi L <yi.l.liu@linux.intel.com>
Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Thanks,

Jacob

V5
	- Removed device context cache and non-pasid TLB invalidation type
	- Simplified and sorted granularities for the remaining TLB
	invalidation types, per discussion and review by Jean-Philippe Brucker.
	- Added a setup parameter for page response timeout
	- Added version and size checking in bind PASID and invalidation APIs
	- Fixed locking and error handling in device fault reporting API based
	  on Jean's review

V4
	- Futher integrate feedback for iommu_param and iommu_fault_param
	  from Jean and others.
	- Handle fault reporting error and race conditions. Keep tracking per
	  device pending page requests such that page group response can be
	  sanitized.
	- Added a timer to handle irresponsive guest who does not send page
	  response on time.
	- Use a workqueue for VT-d non-recorverable IRQ fault handling.
	- Added trace events for invalidation and fault reporting.
V3
	- Consolidated fault reporting data format based on discussions on v2,
	  including input from ARM and AMD.
	- Renamed invalidation APIs from svm to sva based on discussions on v2
	- Use a parent pointer under struct device for all iommu per device data
	- Simplified device fault callback, allow driver private data to be
	  registered. This might make it easy to replace domain fault handler.
V2
	- Replaced hybrid interface data model (generic data + vendor specific
	data) with all generic data. This will have the security benefit where
	data passed from user space can be sanitized by all software layers if
	needed.
	- Addressed review comments from V1
	- Use per device fault report data
	- Support page request/response communications between host IOMMU and
	guest or other in-kernel users.
	- Added unrecoverable fault reporting to DMAR
	- Use threaded IRQ function for DMAR fault interrupt and fault
	  reporting

Jacob Pan (22):
  iommu: introduce bind_pasid_table API function
  iommu/vt-d: move device_domain_info to header
  iommu/vt-d: add a flag for pasid table bound status
  iommu/vt-d: add bind_pasid_table function
  iommu/vt-d: add definitions for PFSID
  iommu/vt-d: fix dev iotlb pfsid use
  iommu/vt-d: support flushing more translation cache types
  iommu/vt-d: add svm/sva invalidate function
  iommu: introduce device fault data
  driver core: add per device iommu param
  iommu: add a timeout parameter for prq response
  iommu: introduce device fault report API
  iommu: introduce page response function
  iommu: handle page response timeout
  iommu/config: add build dependency for dmar
  iommu/vt-d: report non-recoverable faults to device
  iommu/intel-svm: report device page request
  iommu/intel-svm: replace dev ops with fault report API
  iommu/intel-svm: do not flush iotlb for viommu
  iommu/vt-d: add intel iommu page response function
  trace/iommu: add sva trace events
  iommu: use sva invalidate and device fault trace event

Liu, Yi L (1):
  iommu: introduce iommu invalidate API function

 Documentation/admin-guide/kernel-parameters.txt |   8 +
 drivers/iommu/Kconfig                           |   1 +
 drivers/iommu/dmar.c                            | 209 ++++++++++++++-
 drivers/iommu/intel-iommu.c                     | 338 ++++++++++++++++++++++--
 drivers/iommu/intel-svm.c                       |  84 ++++--
 drivers/iommu/iommu.c                           | 311 +++++++++++++++++++++-
 include/linux/device.h                          |   3 +
 include/linux/dma_remapping.h                   |   1 +
 include/linux/dmar.h                            |   2 +-
 include/linux/intel-iommu.h                     |  52 +++-
 include/linux/intel-svm.h                       |  20 +-
 include/linux/iommu.h                           | 216 ++++++++++++++-
 include/trace/events/iommu.h                    | 112 ++++++++
 include/uapi/linux/iommu.h                      | 124 +++++++++
 14 files changed, 1409 insertions(+), 72 deletions(-)
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.7.4

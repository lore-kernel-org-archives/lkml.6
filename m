Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELsgUdkuvMVttQrDo/m3DAwSzhK9o7VWWSjePmLjBIhrQl94kQ3RasUhVceHMlM/az8Tc3GP
ARC-Seal: i=1; a=rsa-sha256; t=1521774601; cv=none;
        d=google.com; s=arc-20160816;
        b=WAU/JqLYgfAtZNptWZNUTKiaVfA73AZaNl813GBXTG/QKcVS5UYsdsAo3HP3mp4hYN
         2tvOAX4ExHGb5AATiUuFQHuQMWmXeKmoh1Lq1p7k+3CAbSPiKWMFPvHh4rhmZ+MkB3ZD
         pDt/1fI4FmqslJPRldxKHY7s1g7iqcXYfqgGyHBQLW/WXbN74KklK478NJF6MitTFP5L
         /zAGrzW1otTRdGIa0OJjtE93eJGTp+SfkLXyehOfYmQviXTGSGlUz0k46iO9H1yiev0N
         x8Ol5pnBLq/B6mfFTagB9mzEIsZvaGLst3VrUEEqxOpUt0AVtfDgwxcOqpwTVps2Wejv
         w4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=ax3DhhXqZJHsfEjKW7ut2tIVjC1Rc6VEZ/r8Iyj61lE=;
        b=kQDcWGq58PBmbh3OmPbBpGA3k/ouBAkQstfH8FuNEQpjVXiIROED02PIgwO0P6zzac
         bMTgEOD9MNqrifzASMNB7Fd8XpPC9imHnyKD2Hti6gLQkeOUdNGp2B7io5T9PHP/nQEx
         UHxiz83QgRLPKFDdGJBVC5JI2IFzlj5WZmE9UbF1a2FVfwTlVva8OSrWrnAbStKeiB8r
         SWIcSvMcfP9K6ar048RUPUbM/pwo5MKCuLAjRMhtIrNuHLsNwTNnyPuFTEruYgIRLVHv
         XU9phsTcbgSUVQKCh9hPhOKNapZ+rAr8Ozpj9Ubi0hJa6JejgJ6r5fzqBkUbVznIn8kI
         /+wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26315935"
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean Delvare <khali@linux-fr.org>,
	"Christoph Hellwig" <hch@infradead.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 00/22] IOMMU and VT-d driver support for Shared Virtual Address (SVA)
Date: Thu, 22 Mar 2018 20:11:52 -0700
Message-Id: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696324607362773?=
X-GMAIL-MSGID: =?utf-8?q?1595696324607362773?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

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


Jacob Pan (21):
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

 drivers/iommu/Kconfig         |   1 +
 drivers/iommu/dmar.c          | 207 ++++++++++++++++++++++-
 drivers/iommu/intel-iommu.c   | 376 +++++++++++++++++++++++++++++++++++++++---
 drivers/iommu/intel-svm.c     |  82 +++++++--
 drivers/iommu/iommu.c         | 284 ++++++++++++++++++++++++++++++-
 include/linux/device.h        |   3 +
 include/linux/dma_remapping.h |   1 +
 include/linux/dmar.h          |   2 +-
 include/linux/intel-iommu.h   |  52 +++++-
 include/linux/intel-svm.h     |  20 +--
 include/linux/iommu.h         | 226 ++++++++++++++++++++++++-
 include/trace/events/iommu.h  | 112 +++++++++++++
 include/uapi/linux/iommu.h    | 111 +++++++++++++
 13 files changed, 1405 insertions(+), 72 deletions(-)
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.7.4

Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/mkcMhIFBfp/OPIyPgBFCTAHFn7CzAdhgjFOmHKzDCls4rMb+I25IOxO32amGOxzpVigKj
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=WUvzjKceuPoVC5R5CQ6wfEv1L10Rax2XUWJH3zU14Pq+H10Q5xScSpZP1+RF8pNoKA
         pfN8+NIPaszl80bW5JwwYjAf+8j9G5pQnElApzWgD+3Gzf+lCFhuY98gx0fcQheqHcTG
         3lJPN57ecZlI5KqktMTJv0ST3pH2SQX6sbgGZ43pRhSPpl7Ww5S+LsnIVaNYo/83pU82
         jd0Xf0c3BPN77foiqBNYusZGHbNBu1QdKZwlhsiMOthSaoNvxzQk3FDCN/e7X03MKfhd
         bkd2y89ZyHt1OZ/TEmderVHs7DbZOdW4Rpf6HZ9nuKaMEEODaSjsv4W3K586cVBWlbww
         d9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=la+nNPxR8Owj1th0qgZahGRYtDdWbFK4485x0rpdarc=;
        b=t2RK4D9GOOlc+i0IH+cHJTfVNbMFZWrnd3pYFHH2ShdugkyAnVtqz1VhLVevTa4w/L
         k4e6J+//49mtkM7YinKb61Ui26HCH8jBE7TGzB4YJ9OIyQaS+vAh9Q0SR8EnI54AnKHl
         xmUwPH44q8WPOVi6Rvm8s++PpnOl1nHGOixJz82AMkZNNvkWYNzLA00iWL1KLnoXzRqb
         eksJ2dCiK2mkmzfSxxoy/bgXxYChfyKU/LPRsGvlr0QdzMlo5D6q+3k7H0WGrnLUjiQG
         +MmrnUqR/NMKbLwiIGeJvyvfXLZT58zr6+gH6evqabQrry29vaxtbb/5jVTkmX7pzBZO
         jXuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740169"
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
Subject: [PATCH v4 11/22] driver core: add per device iommu param
Date: Mon, 16 Apr 2018 14:49:00 -0700
Message-Id: <1523915351-54415-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910526394062?=
X-GMAIL-MSGID: =?utf-8?q?1597940910526394062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DMA faults can be detected by IOMMU at device level. Adding a pointer
to struct device allows IOMMU subsystem to report relevant faults
back to the device driver for further handling.
For direct assigned device (or user space drivers), guest OS holds
responsibility to handle and respond per device IOMMU fault.
Therefore we need fault reporting mechanism to propagate faults beyond
IOMMU subsystem.

There are two other IOMMU data pointers under struct device today, here
we introduce iommu_param as a parent pointer such that all device IOMMU
data can be consolidated here. The idea was suggested here by Greg KH
and Joerg. The name iommu_param is chosen here since iommu_data has been used.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Link: https://lkml.org/lkml/2017/10/6/81
---
 include/linux/device.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0059b99..7c79e4e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -41,6 +41,7 @@ struct iommu_ops;
 struct iommu_group;
 struct iommu_fwspec;
 struct dev_pin_info;
+struct iommu_param;
 
 struct bus_attribute {
 	struct attribute	attr;
@@ -897,6 +898,7 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu_fwspec: IOMMU-specific properties supplied by firmware.
+ * @iommu_param: Per device generic IOMMU runtime data
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -986,6 +988,7 @@ struct device {
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
 	struct iommu_fwspec	*iommu_fwspec;
+	struct iommu_param	*iommu_param;
 
 	bool			offline_disabled:1;
 	bool			offline:1;
-- 
2.7.4

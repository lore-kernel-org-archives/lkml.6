Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELsTgR40x6g2DrVc4ZKr0LZEBzSragQSvagVFcNGzhSNQ2o8rEXYTetJc2QTmuPFZYlpCHQ+
ARC-Seal: i=1; a=rsa-sha256; t=1521774607; cv=none;
        d=google.com; s=arc-20160816;
        b=b/zwlvMJs0R21qGG8rNQHz7R4g8WgAU3VV/xagIGjDaP4oDnzQrWooA3HEmqSKQQpc
         vMXQKR+tTI1yODHwAW9BjBgjqvWFtvvUG12dJ+AlXouVXB97CZDVbv39fFiSCxWqB3gr
         l/Ty7RsE12lZYDZISu3e/ENx9S+jxAXR3i8WnFk+Pkx0wLsR6FjZnd8IsU+HB1J2PlXZ
         sjDzrRgREnTPKT1YEg8QvfAha4AE6Ehfy11cA+zMc/ROzP3BAX3BfwPeDlBV6ixXNpzM
         pCgKs0BseSYsKHdUQ+1hQysTQqRSkP4LG+7dU1i7uTPv06dAIP87fXaGYvt4IDFhDwIh
         ljsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=m3p8PAdMaSOchIhHUh64KINvisM9v5MbIp3oFSuPb54=;
        b=wzwadsmrBH8hL8dIh4DKanpc6SApbDav/UK7f58DJS1NpVWtNoo3bNWyrtwElrIcZ/
         EQV9W99dbOsewCcHD0uLKg9MqI8saSuAb4xNtdZOGDYAa6MNaeZZDSowrMcgXC/b4Ho8
         PstvGXAp6KpgKF0jTFsp+m+UDjE2jNPWVWTtBAEXRJXtitBeR1n4z2IszqLiGuzYYpzD
         geI0b+jgfLOtyvBgp1yZHg+xf0hZ/YCS7GuBOadStkVEPGlV1ef5yyvmhyKLlxdUc9Eh
         lu54XPNT2cJO/PnJ2ODZPPYNkCS+Ag2DU0Mxi/JyycY2CfE+F4qyZgq7mn1XlONveXmI
         0opw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26316006"
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
Subject: [PATCH v4 11/22] driver core: add per device iommu param
Date: Thu, 22 Mar 2018 20:12:03 -0700
Message-Id: <1521774734-48433-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696330699898501?=
X-GMAIL-MSGID: =?utf-8?q?1595696330699898501?=
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
index b093405..35d9f34 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -41,6 +41,7 @@ struct iommu_ops;
 struct iommu_group;
 struct iommu_fwspec;
 struct dev_pin_info;
+struct iommu_param;
 
 struct bus_attribute {
 	struct attribute	attr;
@@ -872,6 +873,7 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu_fwspec: IOMMU-specific properties supplied by firmware.
+ * @iommu_param: Per device generic IOMMU runtime data
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -961,6 +963,7 @@ struct device {
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
 	struct iommu_fwspec	*iommu_fwspec;
+	struct iommu_param	*iommu_param;
 
 	bool			offline_disabled:1;
 	bool			offline:1;
-- 
2.7.4

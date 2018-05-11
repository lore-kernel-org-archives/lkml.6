Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZq1TuorIngQSx2RPLPqfMxfjTI1EiYp1RfcHPfmH8hl+3igQrNKlt2yZbkoU7kHFSPm9Kee
ARC-Seal: i=1; a=rsa-sha256; t=1526071894; cv=none;
        d=google.com; s=arc-20160816;
        b=x7G9e6NxdUkELyUdBxCYPU9orklz4uqokeGA7YYNSfTRAMncyQEfavQOP0+4XaIHRG
         bwwMtowu+o46k0Pw3SUgbyEtWT4J8UKpRqRh7vkDQ5xuCdJpbVUQv5vUca2YKxZn+Ifq
         G8r5nDE+S1GNquuho3a45g7bj6bs1TuEAlvFv+9XCgderYbdBATXN/IWe3V0880p86IU
         4jzwF8PhJAPoutNRu5tgRYSHS3qCqBUyEKWKjSXSr+Vh/QridLNN4il/d7LO3E1dORY3
         3G+TkakWBBXUPeSaDe6XFHlJmnk1wVi7giXi1VN9/5mZqNwDjwttEz/EfAHs5AZSutE8
         T/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=I2WCPZfUKLoUrlBk/MGjkVu7yjUS1LWdNADqThrlZI0=;
        b=mV0o2t8LxQzpbEy0fRL0wZ0kyd1dqfr7/rLi6edkoWK1I5r0m9Lp50XNQ0Onc73KyC
         GKkrOzHkQh6feFDOlddw0uYT+xSBbd4NnLUQKHye9pP5zyCCjEfC15+DHizKAUep3YVq
         YGrg3NVdzbddgU+pRG0SA1dTxJmCzXkARd7L8M3NBhekpECaquVCp9w9uRLTukIxn7NU
         585AI4b4CLPO2/8Ygy3TFXPxZjUZfpJThncSS5Zj9VUqfv8Z1jUO39xuGrrMJGci64Gr
         Qho8qkPCwFnLRGgg8ZtAvdL3ttelt8NbUUPG/GyVywF+w0bnRXFJ7jY9P+J+fhovTxDy
         x5Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104766"
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
Subject: [PATCH v5 11/23] driver core: add per device iommu param
Date: Fri, 11 May 2018 13:54:03 -0700
Message-Id: <1526072055-86990-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363087328844?=
X-GMAIL-MSGID: =?utf-8?q?1600202363087328844?=
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lkml.org/lkml/2017/10/6/81
---
 include/linux/device.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 4779569..c1b1796 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -41,6 +41,7 @@ struct iommu_ops;
 struct iommu_group;
 struct iommu_fwspec;
 struct dev_pin_info;
+struct iommu_param;
 
 struct bus_attribute {
 	struct attribute	attr;
@@ -899,6 +900,7 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu_fwspec: IOMMU-specific properties supplied by firmware.
+ * @iommu_param: Per device generic IOMMU runtime data
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -988,6 +990,7 @@ struct device {
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
 	struct iommu_fwspec	*iommu_fwspec;
+	struct iommu_param	*iommu_param;
 
 	bool			offline_disabled:1;
 	bool			offline:1;
-- 
2.7.4

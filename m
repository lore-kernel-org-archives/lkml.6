Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELtoIyUfVuEkgiG3gJxogeRj5ACOrOsts8SQLN7k0c5snL4UXPRtWyDb5KKtljsYVqlzOWry
ARC-Seal: i=1; a=rsa-sha256; t=1521774604; cv=none;
        d=google.com; s=arc-20160816;
        b=bUmBTFDXA9ssoNJOA8OdYcOxR3cO9E6wsXpVaGK8Y8Kp2b6N8YLFrP7YYy4tPUb24p
         VHFkfFixzBAqP5yxnoyrUNdyclb5Du46mbHsja2EROqUxsyvKE/grnhJx6vMe4ScxHRW
         aBNOY2IdLTP0WRY8OO0Juu8X68krzTyZznhbn26cCfrRMUuSpU6K6FYdkE3kFi2yRCp2
         0he/ef3GkS07HkzuoJzcMYqMEgufvF0X3kPgxGEbhTfkG1HhzJ3A0Sxq3kxV4246oGm4
         URI5GelTW+SfRErRELSNqFM9+ZnTPShmzRHamRXd6ZNQMlBOhWy4wGu8LDV5Vw/+xldh
         9rRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Wu9ysDpyI4Kl5QVS7lW4a5OwoMW1MhCDYBiAy+uCDjw=;
        b=A2/p0efK8C+z4rHZKo9MQq3OpT683LD2GCXHRsUliNGBfxHhtA1hyKJS6wNd/yTVRe
         qrN1PpLFqAMaL20AKxNf71ltSdnwQjC+UsjC9do6CsmBnNy32bsMlwMqYOHYHkNc8U8j
         7OqQHCFaXZUHOnQdxzUplbc1rvLVVuMhodDwHYBG7vIKBQWp/2TmNyxNRJD57upeQtgG
         37q4787rge7gtxUraOxix/SNN5IxRbvpUOteee7TaxWPb1bbAJD1Af7UgGEsfvZtNrfx
         f2W0Y1bTVArRxvbaq3ET7E5UWRwii2FlW+weCp4kZ/CK6V76FdOPZq3ft1MZAIQLYqqp
         Xl8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26315977"
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
Subject: [PATCH v4 06/22] iommu/vt-d: add definitions for PFSID
Date: Thu, 22 Mar 2018 20:11:58 -0700
Message-Id: <1521774734-48433-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696327701556858?=
X-GMAIL-MSGID: =?utf-8?q?1595696327701556858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When SRIOV VF device IOTLB is invalidated, we need to provide
the PF source ID such that IOMMU hardware can gauge the depth
of invalidation queue which is shared among VFs. This is needed
when device invalidation throttle (DIT) capability is supported.

This patch adds bit definitions for checking and tracking PFSID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/intel-iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index e4a16dc..0e3b618 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -114,6 +114,7 @@
  * Extended Capability Register
  */
 
+#define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
 #define ecap_pss(e)		((e >> 35) & 0x1f)
 #define ecap_eafs(e)		((e >> 34) & 0x1)
@@ -284,6 +285,7 @@ enum {
 #define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
 #define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
 #define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
+#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xff0) << 48))
 #define QI_DEV_IOTLB_SIZE	1
 #define QI_DEV_IOTLB_MAX_INVS	32
 
@@ -308,6 +310,7 @@ enum {
 #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
 #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
 #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
+#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xff0) << 48))
 #define QI_DEV_EIOTLB_MAX_INVS	32
 
 #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
@@ -440,6 +443,7 @@ struct device_domain_info {
 	struct list_head global; /* link to global list */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
+	u16 pfsid;		/* SRIOV physical function source ID */
 	u8 pasid_supported:3;
 	u8 pasid_enabled:1;
 	u8 pri_supported:1;
-- 
2.7.4

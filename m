Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx492kQ2nB6MQQX6d3eprLwXfggp8aAIvs8f9lTeRWastQyhYUrorhVwA1T7NWDtTb7Q9xQtc
ARC-Seal: i=1; a=rsa-sha256; t=1523915204; cv=none;
        d=google.com; s=arc-20160816;
        b=TB/l/Y7uuLK+1bgbknhxk6fVXcC4j3d1sVai+S4YoN68C4k+KLm0VORvfrMXBX2Zn/
         J95R5fVLfqeZuJHGOw0/hGXUNHGQ5yJ9Eqdl5NQnjGpYmnbft6CfPCifteXil2CVs18b
         Lx0Zhmcwiq0k1TuTs1y6iza9JA0q0ofwQDhts4D5avk2IUrPP6Mc+QEEi7YwROywQwg3
         iRFtwij2TckWEogZBXg6EQ99DLc41cx+NinoifgMBRwEmsuk8jEryVAgpgaddITl/ght
         x0F9IcCmOG0oN/JEePEfcQUp9FCNCqfuihGxhLaObDhqfwbMDbGXK+yomnBssIHPWnp9
         +V1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=9XB5zZUZr+RGyzSozDdOaoI8Tc3vUsBP6NjDOlmHsgQ=;
        b=ioQwJXD9cHYeVd1kvkqvYzYtDe7LgmYxL3btAzUwEJabIxu5Vhn66fp97F1HWqsmDs
         0nYujmwv/nawHC+mAGbc17fP/fGunOxTToun04Q8mJk7dTNaALPRJFfTWfTc+iOqNJi5
         owoZE8NEwhFkX+eFmmGwXmNd5MYOkz8Y96Jb4T2VBmU3RS67sqEJYeX3TQqvmEeW1qz6
         udNgplcWZ2mH2RP+omQ+1YQhulkhwwqjIRSu4ALoaj4Fagz8lBzbhXFngAqzF08ZOBAV
         nO69zBEvpfaOQc9gHduMqhXcHi5Q6f6EFzdtKJNhg4gP2yzx6s0FLwZPncUn0UmroyFM
         zCgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740151"
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
Subject: [PATCH v4 06/22] iommu/vt-d: add definitions for PFSID
Date: Mon, 16 Apr 2018 14:48:55 -0700
Message-Id: <1523915351-54415-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909644139134?=
X-GMAIL-MSGID: =?utf-8?q?1597940909644139134?=
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
index ddc7d79..dfacd49 100644
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
@@ -467,6 +470,7 @@ struct device_domain_info {
 	struct list_head global; /* link to global list */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
+	u16 pfsid;		/* SRIOV physical function source ID */
 	u8 pasid_supported:3;
 	u8 pasid_enabled:1;
 	u8 pri_supported:1;
-- 
2.7.4

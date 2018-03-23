Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELvknqTB8elkU+X1UIJeRrpf/WS8r4AUGnN9rkOQED50REw0M/6qs1m14tYrvX/6rpk2g8jZ
ARC-Seal: i=1; a=rsa-sha256; t=1521774611; cv=none;
        d=google.com; s=arc-20160816;
        b=JOfiPtI/GBEFYM78ib2zfxn87JADrh2sO3Oxn0uHYACxG37y48L4wiXORnWfI2iPpS
         FgXCRoGAooMTcVYu2JQtWLdYnmvtCXw+eEemNGGrKH/S5YXkqm7HBgS8s5ElUwNnpwZ4
         QfUqf7zbAaR/v5/mgyMsE48iFUbdLFzoeAIZalsB+56vYnZ9e97CfDXLSpIOZGkTH02y
         oBzB+RIhWQtyrEQzRak+RLA6kPHxRcG6iU8kEt1YY4bUIOJ+mW1NzaPlm+PiIaQuXfc/
         RLu7e7YYRvg+9DPsNp1ZusFJOg9jki8M6aNOJZPfe+gxXjrIK6SbXP39kDER2HWHx4yK
         qwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=I17bvL4mHfp9JyBslnOuAkoaRiXOtoJonfB8y3fqFbc=;
        b=z1Cw9v8mAkuynb1WG36hKj+Ir0KeqadjrkSgjjkHGrjWQfTgUnHsyqZnhOroYVKSw8
         au/faeNBohnPyFneJwLbkor81Xah2HG0f+1fa+MHxsaNHWxXSJWvJaouSmhbX5AbH7wm
         PB5zVfqfSHGH1kPR/VUYInqD4V+GqtA6bZgyGa/ttkrRLui35ul0w5HdiXTyquwGhu/L
         m841wAyNNDeQ8I75nFMmxYQPZ0y0l9eMnZVWG0g2oCHXDlfKTNz9yfg6GCC5Pv+yP3gC
         RGb8mxJPTeTyXlYJpYo5MTQ8/8Pl3juV8cV/FHet18nECXhIJGQwxLK2Yxs/f3k9z8IX
         YlfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26316042"
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
Subject: [PATCH v4 19/22] iommu/intel-svm: do not flush iotlb for viommu
Date: Thu, 22 Mar 2018 20:12:11 -0700
Message-Id: <1521774734-48433-20-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696335099299638?=
X-GMAIL-MSGID: =?utf-8?q?1595696335099299638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

vIOMMU passdown invalidation will be inclusive, PASID cache invalidation
includes TLBs. See Intel VT-d Specification Ch 6.5.2.2 for details.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3a7bc77..66b8e10 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -284,7 +284,9 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
 		intel_flush_pasid_dev(svm, sdev, svm->pasid);
-		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
+		/* for emulated iommu, PASID cache invalidation implies IOTLB/DTLB */
+		if (!cap_caching_mode(svm->iommu->cap))
+			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 	}
 	rcu_read_unlock();
 
-- 
2.7.4

Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZreddMmItUDYB9VED1pQJ2QcW/jZJIDwQ9RkotNaHmzx/yj4rrp+O0NX7fUEHxeXnh9yVY+
ARC-Seal: i=1; a=rsa-sha256; t=1526071895; cv=none;
        d=google.com; s=arc-20160816;
        b=0G1hHv7NEWgtNmkzONJMMo3HutmQ5EAK26UrDEhNJpNB0hHAxl0K/B4+RrKwDM2epT
         jSkmwMiIGpMoyEjdzC0rhy6iMOo7lB2blhBiQHDufTL9N9qgTLBgC/PUxMsvBn9bXOUS
         TMsHSGZ7swoJnbaGxFeZAzGVz/JoAg73G8PT/Mpu9i5YuwrqK4zDCNfPb6pu63YHJOYU
         qiVyzDo1Wufm8a/BGTNn+WapYSGepZh8oCH4TfkhogfWqw/TZG7H1UdhySb8bu30rMuD
         J53enRF8y5YJuxOTGbMGhI2zdSUCef4t6qTA35YnY7KAs44V5aUjlsqhW4i90xpuOskJ
         r9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gpL1yKAn4vTIIPj+2YRp2a32xwSR212L6qyEpVFXbDQ=;
        b=txsq6GzsKqok6XodtRKUTFQfYiaDJP1XcRHIoL38DilDAf55pqG/iYkzhFp6K3n+J2
         5qBkT1QoO9xVl27MMlJxwz1KxqMdFuVv9EwFEcxWA1aydG6nd4Euwx6dyezlieX8Vz2c
         UkhQAlJ/etDYG5O/9EcIdhKvNhFvOWkAaGvJJBgxJ616RL5li8FExKfimFWxsxPi26aM
         c3LS7ccY1ehAGQQFb9vRo42lxHa+ZR6n+B8fbtbCKLLvZz1CGhr+kuCue235BGPknz7R
         ktM3hlNZsNpyLJ+AQwv3ty/e3kfVn7kXEdm76LgF0105O9HGyvMiUfBi1C+on6A9obt4
         L8gw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104795"
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
Subject: [PATCH v5 20/23] iommu/intel-svm: do not flush iotlb for viommu
Date: Fri, 11 May 2018 13:54:12 -0700
Message-Id: <1526072055-86990-21-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363980525687?=
X-GMAIL-MSGID: =?utf-8?q?1600202363980525687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

vIOMMU passdown invalidation will be inclusive, PASID cache invalidation
includes TLBs. See Intel VT-d Specification Ch 6.5.2.2 for details.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index bdda1b6..697d5c2 100644
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

Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx48L+Tx3tAeNxMk5ezKD8/PlSC8WRQlDwMhM35Z2b8icUOwsZI15yKf6bstP8nuOlZaTHhPj
ARC-Seal: i=1; a=rsa-sha256; t=1523915204; cv=none;
        d=google.com; s=arc-20160816;
        b=tw6G2lIc2ZhTGuNeZGC95Gvezo7mp3e1IcEVtAd7iCQDwDLmqe2OEWorKv+nPiUTTY
         1kqUt27oy1zpOWAdCaDXbPe0Vt+9nR/JpBHs6X8j0d0BlR+Zw/9jQcSsDz2BS+n8zQWp
         BF4jFxEQ+oYzQVFqY8i5m7ChGfmKmXeY2uVEm3YTHej9aS78Y7rOYV0pJQo/pfyPI4Et
         4JJA+Wz6pQo/fuYRsnP6wCF1daK+mbEv0Cmme8KDVGuOKnd9hrSWgAfBcuL9Rs4n4KPQ
         4o4cbIEakXaUlQrHCyszhwDXTZBQG2gM+HSHO6dKK3ajp3Fg3r0Fac2BDM5Xr+XSO5Qr
         YjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gpL1yKAn4vTIIPj+2YRp2a32xwSR212L6qyEpVFXbDQ=;
        b=hE6gUFm8wXxYCOkoPQU83QrlY57qFdJGH61F75iYSyEyN1sWGOHmm6NoERJZ3xXsNc
         dQFjpy0apaIMxRtFgFGV2AMaM5ZyWCoAP++pN0IOTwAfWuuM7q4DYWp6kk9Lo5nNMQU7
         kqFcPYMrU0rTcHYaNCLEcL9dzGXWtrRo1a2sDW8pp3le4d4bKmUIZ3WUQE4QtIXGV83Y
         05D2WN33stOpxbMtHFctHH+jkGbIE1yHT2CtPT6GL6XUBYsOh7gLX556xETfMXGuPLg9
         rdY9UpEYrM1RnDRT6h1FeeKIpQAcVOPqYSRY3Z7Qbp2iIrFXVGwhRAyOZMHulBANoVQh
         n/Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740194"
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
Subject: [PATCH v4 19/22] iommu/intel-svm: do not flush iotlb for viommu
Date: Mon, 16 Apr 2018 14:49:08 -0700
Message-Id: <1523915351-54415-20-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910062854256?=
X-GMAIL-MSGID: =?utf-8?q?1597940910062854256?=
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

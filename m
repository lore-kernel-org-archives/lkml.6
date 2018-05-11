Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqNplRu/l/jVe3gmXOlKZhGk/MWOv+Xzq6klnwJag/ht1dKx6YwQuemTxswAL6Ld1OJFQZN
ARC-Seal: i=1; a=rsa-sha256; t=1526071895; cv=none;
        d=google.com; s=arc-20160816;
        b=IYZ4KcNB+E59n2+5Uqq6/TkSNGOrptgEnew+EiUL72Cm3XiMv7x2f2AgTMCZEMOtPu
         gTPmN4xSLHfnZLXHBT/Hw82SJVAmakVmsl+oO1S9OazFWI9a53yTWgqHrkRIkeE8CTxj
         lf/H1qbW0fSd5wIjWYKR+/f3X4ZZwSxaT69cpvG8tRW1mNdMjdHORhP4TNJWREImcELc
         g00PofNfGYNBkdEGdsUkGkIAywr2SC6wAhexBMux2kLEAR1bg+oocSVEzUp+6XHd7wks
         G8HCYa5X6dC7zi4hCPrveIpkoI8SkTk6XKGrPvjfpdIMp+yj0qRHYyTOhaHTl5MQgHN0
         82wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2i15vuqDOD/v/9ACO7r7FYAW+rsY05c1oRu7NPVqR2A=;
        b=zmsXhi1wuWP6TjThvienipOD7N8Vy7gGT4tBa3kcESE6to1EnJoNPfSwPMzkkx8x9i
         sFAPHPtkWyjrvqTRIelSsaApaPU4CDISlKRTTgrXXLRTvi4vnRnxIUsZ5oSXjGfO06xM
         iSwoOMmhCntNe2OJITUP9m3Yiof9gtT4l5UXDyNz9Rxe7yd54JX0S1f7nG60/3p34Pqt
         vmkq+81PGgAGM8KX6cX76f39KMq54DDG9Alr+fp6GTzkQ9wMKAhX7vpGCCV3713+rXtQ
         8xoXmJJ/AsjF9YLax9Olg2tAQz4wpOKxnzZImOEyEPWK9pl1a5PhY+XWRM3++M0mNkfO
         jFFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104805"
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
Subject: [PATCH v5 23/23] iommu: use sva invalidate and device fault trace event
Date: Fri, 11 May 2018 13:54:15 -0700
Message-Id: <1526072055-86990-24-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202364101861633?=
X-GMAIL-MSGID: =?utf-8?q?1600202364101861633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For performance and debugging purposes, these trace events help
analyzing device faults and passdown invalidations that interact
with IOMMU subsystem.
E.g.
IOMMU:0000:00:0a.0 type=2 reason=0 addr=0x00000000007ff000 pasid=1
group=1 last=0 prot=1

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1f2f49e..0108970 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1006,6 +1006,7 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 		mutex_unlock(&fparam->lock);
 	}
 	ret = fparam->handler(evt, fparam->data);
+	trace_dev_fault(dev, evt);
 done_unlock:
 	mutex_unlock(&dev->iommu_param->lock);
 	return ret;
@@ -1574,6 +1575,7 @@ int iommu_sva_invalidate(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->sva_invalidate(domain, dev, inv_info);
+	trace_sva_invalidate(dev, inv_info);
 
 	return ret;
 }
@@ -1611,6 +1613,7 @@ int iommu_page_response(struct device *dev,
 		if (evt->pasid == msg->pasid &&
 		    msg->page_req_group_id == evt->page_req_group_id) {
 			msg->private_data = evt->iommu_private;
+			trace_dev_page_response(dev, msg);
 			ret = domain->ops->page_response(dev, msg);
 			list_del(&evt->list);
 			kfree(evt);
-- 
2.7.4

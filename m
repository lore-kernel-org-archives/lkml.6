Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx49Wxcwr9WSzOL41amxGc+yyCMXZOnQ8zzkUIbhCMcKezOMlHK6r/yAoKv04e49xtxv1g2SX
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=ypjb8EWXpakBYcpqmmDsT0NroXv9VuHm0DwZdbKtPg30J9BsCxlFsHKnzSvh3yGUKK
         7NYwjSrkZ5X9Bt3x1t2wn8F63pZKleaNAMHJ6N47y20C/v80ViFxjIrxhdfn3nLyYowI
         /eqAIhzz962SCO4q11BR0Wm1twn87z7Lys+9hPwLB5XhM3R6B9qFC5blXq7wNJeKa0Aq
         5JD/BpKy4ulBADujMvRbYwI9Z4pIlZpe/OKNGHF3ueAdwKxc+Ges1MyX0EJbKgz6FEeH
         YQQUONgcpaY5DJOOSg9rVxbtboBLhvmldDgWRyvRxgZc36ZhfLCSDGMLqYCrvzKPlnvo
         U+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=AWyUTf89RtmcPXz7J2ozMdOV1ro7FaVNGacLH2xpQ+Q=;
        b=Kwgpw6aJ+iy/JCcS1Vw3SELBdJbyl+W+l+T1WNcodB4OeYHhEYgNLPCH05e29TJrAZ
         ScP8oG0lJ9eqZRI9SeOx2p4tYjpyp7j9nC3DSWG0XjUZqRww/V0yW8/IDNE5NbIQ168A
         aCjHkD9FoAdKKeiZ5YTN3NVLMCZw8ZwTUOqsWahr43aXuPkeU3KC6UpTwa5p2zPwxsy+
         wKTJTMr5icnk392aENrad4u6rxBLLYSixh8MgUgPFb696Bc29ZHYI+bPsnM0opUvd96E
         WaFY5PjzUabSgSXKSGiVCnySANknujJSzaR+8DkAAPA8Quy1VHfLV6FV/4IGHsYxi9sM
         x2OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740203"
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
Subject: [PATCH v4 22/22] iommu: use sva invalidate and device fault trace event
Date: Mon, 16 Apr 2018 14:49:11 -0700
Message-Id: <1523915351-54415-23-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940911067755677?=
X-GMAIL-MSGID: =?utf-8?q?1597940911067755677?=
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
index f6512692..e2090d2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -979,6 +979,7 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 		mutex_unlock(&fparam->lock);
 	}
 	ret = fparam->handler(evt, fparam->data);
+	trace_dev_fault(dev, evt);
 done_unlock:
 	mutex_unlock(&dev->iommu_param->lock);
 	return ret;
@@ -1547,6 +1548,7 @@ int iommu_sva_invalidate(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->sva_invalidate(domain, dev, inv_info);
+	trace_sva_invalidate(dev, inv_info);
 
 	return ret;
 }
@@ -1584,6 +1586,7 @@ int iommu_page_response(struct device *dev,
 		if (evt->pasid == msg->pasid &&
 		    msg->page_req_group_id == evt->page_req_group_id) {
 			msg->private_data = evt->iommu_private;
+			trace_dev_page_response(dev, msg);
 			ret = domain->ops->page_response(dev, msg);
 			list_del(&evt->list);
 			kfree(evt);
-- 
2.7.4

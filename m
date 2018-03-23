Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELtAQFNNLAfGKpOmJfFuFzFFeAtyiNF8u0KfTBSADXVcA2XQ2vXJxZzNEt0qflMRnCBp0eTZ
ARC-Seal: i=1; a=rsa-sha256; t=1521774613; cv=none;
        d=google.com; s=arc-20160816;
        b=NnGsTm3jc21niPthlYcCxUODsgHmky40TQmcihNQjvYGqxpi1yng9LSsPXFb6HbnXG
         g9NKR+usB2vpvbgSU5rrcwlB47i6rzlrRNxsWithn5HOuPc1mlsQtjOC4fHcIiHhOhGx
         P0pkLQmfutOQBv2LWQEIBDsab7bLWu5bdIxVVRIXgvAowtevtYttbJaHbsxEYhJkXGLL
         wyOpGlxdb++mgHrhRuHm/8pboxXMCapVAfrFlGrf7MdhjnvZeBv2YRpu1Cqs39G/MIUa
         38lDOgIV1kcJwY585uCko84xbkuyxULgQ1xPUWkP1Oyd9oATTqB22iGzvtJ0kYLcL7l7
         zLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Xk3/mo9nttM4gdNcxVIDFCTvI0oTGjmRFAF1YEff7/4=;
        b=V9FWXbqb4g0Le+JUnZ0635j7zWXb8UEN6fA/Ns2LLGjkCnYhgsReh8Hf8hlQAKdJ1N
         PzqMBBdD8V5Pcxu63avBkj3WBuoxSKl3bUMbmbR7uyt8l0nh3Sn5nSPqXtsfdjaXVCzz
         +xs7/jaHRkfz+Jn+4SZs0ezd7p0kHzXAwZWVwPm7qDyK9IZ+5D01l5w3fnqydDIPsGOG
         nlxkyahRPRwCFwjkrfg/4mlM7+GCKmFUvxlePABVSJ28OU3o/ErTurGKwpQ8l2+lzTEr
         H8X7RNg59r13Ox+sug/P13B7m8p43wRQ+5oXdCOQtL/2piQXTm2PIBewo4kUU8Hdrs7U
         1/Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26316054"
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
Subject: [PATCH v4 22/22] iommu: use sva invalidate and device fault trace event
Date: Thu, 22 Mar 2018 20:12:14 -0700
Message-Id: <1521774734-48433-23-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696337526958070?=
X-GMAIL-MSGID: =?utf-8?q?1595696337526958070?=
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
index 1e74944..e5fc345 100644
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

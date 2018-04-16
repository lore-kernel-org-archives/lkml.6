Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+u6vh1/xMbjYQuvLMAMvzadsBxD3lqFrcc0Mvu7mF4OlZkJcrmgQNntAZCwp+JLNb7MQEl
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=kMJogImlfEaA1NPjhVPwtE19rfpnQ/2gNAVrAJIVaKDjt41t1+8UR6EcaI8xG5pRTy
         3cMluKmyW3qbBHCWWPc/Be01D4i236WZjXKYhEm4KM27ELth/DCWX3VHuYzP/jEMspvB
         hCRwg4u71AMqwDjK/2L85iFp+k3lwgmTeNMKD8oV8bCRpDKZsHHM14vUCQgVwrI+TIMS
         oC/gGtlElbHwbzKjAE4NPGCOxrX+KmjFnGO8HQv5GcRzNciayimrZxnTAiPd5spuGtYz
         Ubl91zs7fiqwfHk0fD3V7SWFXhtrLFYlDkiWFQdJO7Ojs4N9DWtZ3jtvp3JK16jlv+8p
         ce3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=LQy54NNnfUMaAYolZleLvjD6T+YJkEX5uNF9K+MYKgM=;
        b=VnszsVRqyjgx3lBVDDxGGdrgKA0W36XCCiJXyUNZV9GL9BdfUU2jRX0XHF6kZWD1Ub
         LBz/pRCFgYNPQJVNHmKcSLgEL+lsS9YG6r2p/3YZUmkliGd6zf8BmAAaZdmbPw7spi0z
         msf8W6U5Z/ESwy8V7oJX5OkbmE1RM1TSIfhUCfiXsbvDUUtr2hzg1rx34/EbeOyl1chy
         bN9mVo4YxmM9cJah1TrWr0MhSjBM5b4UBMsPWOdIR4rQEkadUynC5kSqEqh06q7KZkDg
         oLhfWBXoyw3oqRWwQhu6e1dHfQ/y0b3nDtrTt5guD4GS4u8sdeCkI/M29EpBAvDzn072
         8upQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740200"
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
Subject: [PATCH v4 21/22] trace/iommu: add sva trace events
Date: Mon, 16 Apr 2018 14:49:10 -0700
Message-Id: <1523915351-54415-22-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910948839508?=
X-GMAIL-MSGID: =?utf-8?q?1597940910948839508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/trace/events/iommu.h | 112 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 72b4582..e64eb29 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -12,6 +12,8 @@
 #define _TRACE_IOMMU_H
 
 #include <linux/tracepoint.h>
+#include <linux/iommu.h>
+#include <uapi/linux/iommu.h>
 
 struct device;
 
@@ -161,6 +163,116 @@ DEFINE_EVENT(iommu_error, io_page_fault,
 
 	TP_ARGS(dev, iova, flags)
 );
+
+TRACE_EVENT(dev_fault,
+
+	TP_PROTO(struct device *dev,  struct iommu_fault_event *evt),
+
+	TP_ARGS(dev, evt),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(int, type)
+		__field(int, reason)
+		__field(u64, addr)
+		__field(u32, pasid)
+		__field(u32, pgid)
+		__field(u32, last_req)
+		__field(u32, prot)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+		__entry->type = evt->type;
+		__entry->reason = evt->reason;
+		__entry->addr = evt->addr;
+		__entry->pasid = evt->pasid;
+		__entry->pgid = evt->page_req_group_id;
+		__entry->last_req = evt->last_req;
+		__entry->prot = evt->prot;
+	),
+
+	TP_printk("IOMMU:%s type=%d reason=%d addr=0x%016llx pasid=%d group=%d last=%d prot=%d",
+		__get_str(device),
+		__entry->type,
+		__entry->reason,
+		__entry->addr,
+		__entry->pasid,
+		__entry->pgid,
+		__entry->last_req,
+		__entry->prot
+	)
+);
+
+TRACE_EVENT(dev_page_response,
+
+	TP_PROTO(struct device *dev,  struct page_response_msg *msg),
+
+	TP_ARGS(dev, msg),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(int, code)
+		__field(u64, addr)
+		__field(u32, pasid)
+		__field(u32, pgid)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+		__entry->code = msg->resp_code;
+		__entry->addr = msg->addr;
+		__entry->pasid = msg->pasid;
+		__entry->pgid = msg->page_req_group_id;
+	),
+
+	TP_printk("IOMMU:%s code=%d addr=0x%016llx pasid=%d group=%d",
+		__get_str(device),
+		__entry->code,
+		__entry->addr,
+		__entry->pasid,
+		__entry->pgid
+	)
+);
+
+TRACE_EVENT(sva_invalidate,
+
+	TP_PROTO(struct device *dev,  struct tlb_invalidate_info *ti),
+
+	TP_ARGS(dev, ti),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(int, type)
+		__field(u32, granu)
+		__field(u32, flags)
+		__field(u8, size)
+		__field(u32, pasid)
+		__field(u64, addr)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(dev));
+		__entry->type = ti->hdr.type;
+		__entry->flags = ti->flags;
+		__entry->granu = ti->granularity;
+		__entry->size = ti->size;
+		__entry->pasid = ti->pasid;
+		__entry->addr = ti->addr;
+	),
+
+	TP_printk("IOMMU:%s type=%d flags=0x%08x granu=%d size=%d pasid=%d addr=0x%016llx",
+		__get_str(device),
+		__entry->type,
+		__entry->flags,
+		__entry->granu,
+		__entry->size,
+		__entry->pasid,
+		__entry->addr
+	)
+);
+
+
 #endif /* _TRACE_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.7.4

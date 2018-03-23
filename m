Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELuUDaNm+s04hOnfGgWpLQyL6D5jm/CjqZQgmchcTmNV8I3o58yYunmezk3yePngqoVehBRh
ARC-Seal: i=1; a=rsa-sha256; t=1521774612; cv=none;
        d=google.com; s=arc-20160816;
        b=h6o2XmzrG5FMfNGQc8k0+b6AGeXvH222U4Ccdk2gkcwSIh11zRfVLmROWQ8GBeaNX3
         cY+SZzX8/xZh9IK24t4hcORmj2xM8Al/KBpRbnoyOZ1F1nHqpzu+uF+GDkygQWw7MRH6
         9Bc4EnDQ7S//4EWgzcXl7D0kKuvtEzr/ZW6NknJi6cWDF+yOIJPzSGi7+A53X7aV8wiR
         kCP+UfECBTqNmRt1qnitjNB2TBqLFKUMh2vb9WLChMTmDtmshaqcMeBKsQVPNGVpEqo7
         vSAAF9Q1YOMZl8mu12/2J16hoMph+qORwlvy4hJHLHdYeVxeNq9W6MIoCzJ0HcSDXl4m
         XJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=LQy54NNnfUMaAYolZleLvjD6T+YJkEX5uNF9K+MYKgM=;
        b=UeaUDU3uY7BHwaWTrOmkVFLdfrDHExXh+GA6nEbVvf1G5yCoSQITF2JHEFOArcc6jz
         7Y07RNJggk9Wh6/U619w4csK+Dck22ukfT+Ho1iNH2Dyr9iSuBAFtkOf8IzPIHW+VvtK
         a4W6lqfJ014wvSt3zoauobhlVTpg89GzuVCl1Z1StMLQZPqVMd2NNTyPckQm3uSh4yOW
         +KluPtkMasne7zIiAvDa9GQAdG9lIIl7VAjsE/ixdltG7BVCWZD3ULoAwznQIeD5uT+S
         ZGPvyzIJSypjURZMIiOG+gTkzdkTTFiZ7cbhww2XHodb7WAqnH0dDC5oyGRL/xM7AoG1
         ascQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26316050"
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
Subject: [PATCH v4 21/22] trace/iommu: add sva trace events
Date: Thu, 22 Mar 2018 20:12:13 -0700
Message-Id: <1521774734-48433-22-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696336210070974?=
X-GMAIL-MSGID: =?utf-8?q?1595696336210070974?=
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

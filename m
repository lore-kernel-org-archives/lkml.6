Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqCX/WddYjuB1AM8HKL2A8w0SAbUgyGEThNNkpMJsgW1TFJllblLYwHm23aAYfYatLaro/a
ARC-Seal: i=1; a=rsa-sha256; t=1526071895; cv=none;
        d=google.com; s=arc-20160816;
        b=Qkr+2ZLyonckkz2KpTBt0U/8jRgWEq96E+2Yla7v7rLB0e9tTmThJkWD6gc5eS3zxP
         ZcLpfFfm4EEm8LP8VsCo9TOpJ0dIzDHXCFTBMO9VlZaP+xvxzG00W1J0zgiMWHlSNzNM
         1ZosGkg3uKGKUSDjApQ6y/ynCW/74BOP+VdBnPchN9dMgpllGwgAOpVblrRLG/UXO8xs
         dZMSfLtdpbVWUTSZpkxqKaht6um7rFhhqZTS5tLvHJHO6uOqtU995brbZwFln/tDkH96
         AKKZ3y2VBfQjnWfhVp4daDWg/W3LlK+hyYaq9SkvK44+u7xxuzCt4PvWkByNDGtGTew1
         hvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4b+5+ezSoW5ojAXXDFLcgri5qd7dZAhG43YO3wX9O4A=;
        b=tNCI8QBuDqzjzk0lfkwMo6uPoNjaZSombTuRzFs/2sR0FHFpnv3jlWKsUHb1IZRYvJ
         CyjzUIEvhdSyLUqkFCOd9f/aMj2vH9eH25kJ6u0hwiN86RDQAt2oeLri1P/sNruoZs23
         blR/Mor93QHWWN/XWYtYzAvsWnUrPHI0Ts5r9QLlEHvDM3w418LMpN6gXWWsrufp58eM
         +uyh7uUaW+qmZV8AxBVUOjGZi3A0AA6a4yjBLzxKenh9PPTzKKp0uY/EJbPt7yfQbtF6
         G8ylL9gqBqkQUs6fNKVIedtrGLjn6MnPsDXmTLW2gB1x1APkndUr0btm2+O/QelPOAPk
         3POQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104778"
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
Subject: [PATCH v5 15/23] iommu: handle page response timeout
Date: Fri, 11 May 2018 13:54:07 -0700
Message-Id: <1526072055-86990-16-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363768984525?=
X-GMAIL-MSGID: =?utf-8?q?1600202363768984525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When IO page faults are reported outside IOMMU subsystem, the page
request handler may fail for various reasons. E.g. a guest received
page requests but did not have a chance to run for a long time. The
irresponsive behavior could hold off limited resources on the pending
device.
There can be hardware or credit based software solutions as suggested
in the PCI ATS Ch-4. To provide a basic safty net this patch
introduces a per device deferrable timer which monitors the longest
pending page fault that requires a response. Proper action such as
sending failure response code could be taken when timer expires but not
included in this patch. We need to consider the life cycle of page
groupd ID to prevent confusion with reused group ID by a device.
For now, a warning message provides clue of such failure.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  4 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 02fed3e..1f2f49e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -827,6 +827,37 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
 }
 EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 
+static void iommu_dev_fault_timer_fn(struct timer_list *t)
+{
+	struct iommu_fault_param *fparam = from_timer(fparam, t, timer);
+	struct iommu_fault_event *evt;
+
+	u64 now;
+
+	now = get_jiffies_64();
+
+	/* The goal is to ensure driver or guest page fault handler(via vfio)
+	 * send page response on time. Otherwise, limited queue resources
+	 * may be occupied by some irresponsive guests or drivers.
+	 * When per device pending fault list is not empty, we periodically checks
+	 * if any anticipated page response time has expired.
+	 *
+	 * TODO:
+	 * We could do the following if response time expires:
+	 * 1. send page response code FAILURE to all pending PRQ
+	 * 2. inform device driver or vfio
+	 * 3. drain in-flight page requests and responses for this device
+	 * 4. clear pending fault list such that driver can unregister fault
+	 *    handler(otherwise blocked when pending faults are present).
+	 */
+	list_for_each_entry(evt, &fparam->faults, list) {
+		if (time_after64(now, evt->expire))
+			pr_err("Page response time expired!, pasid %d gid %d exp %llu now %llu\n",
+				evt->pasid, evt->page_req_group_id, evt->expire, now);
+	}
+	mod_timer(t, now + prq_timeout);
+}
+
 /**
  * iommu_register_device_fault_handler() - Register a device fault handler
  * @dev: the device
@@ -879,6 +910,9 @@ int iommu_register_device_fault_handler(struct device *dev,
 	param->fault_param->data = data;
 	INIT_LIST_HEAD(&param->fault_param->faults);
 
+	if (prq_timeout)
+		timer_setup(&param->fault_param->timer, iommu_dev_fault_timer_fn,
+			TIMER_DEFERRABLE);
 done_unlock:
 	mutex_unlock(&param->lock);
 
@@ -935,6 +969,8 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 {
 	int ret = 0;
 	struct iommu_fault_event *evt_pending;
+	struct timer_list *tmr;
+	u64 exp;
 	struct iommu_fault_param *fparam;
 
 	/* iommu_param is allocated when device is added to group */
@@ -955,7 +991,17 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 			ret = -ENOMEM;
 			goto done_unlock;
 		}
+		/* Keep track of response expiration time */
+		exp = get_jiffies_64() + prq_timeout;
+		evt_pending->expire = exp;
 		mutex_lock(&fparam->lock);
+		if (list_empty(&fparam->faults)) {
+			/* First pending event, start timer */
+			tmr = &dev->iommu_param->fault_param->timer;
+			WARN_ON(timer_pending(tmr));
+			mod_timer(tmr, exp);
+		}
+
 		list_add_tail(&evt_pending->list, &fparam->faults);
 		mutex_unlock(&fparam->lock);
 	}
@@ -1572,6 +1618,13 @@ int iommu_page_response(struct device *dev,
 		}
 	}
 
+	/* stop response timer if no more pending request */
+	if (list_empty(&param->fault_param->faults) &&
+		timer_pending(&param->fault_param->timer)) {
+		pr_debug("no pending PRQ, stop timer\n");
+		del_timer(&param->fault_param->timer);
+	}
+
 done_unlock:
 	mutex_unlock(&param->fault_param->lock);
 	return ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 722b90f..f3665b7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -360,6 +360,7 @@ enum iommu_fault_reason {
  * @iommu_private: used by the IOMMU driver for storing fault-specific
  *                 data. Users should not modify this field before
  *                 sending the fault response.
+ * @expire: time limit in jiffies will wait for page response
  */
 struct iommu_fault_event {
 	struct list_head list;
@@ -373,6 +374,7 @@ struct iommu_fault_event {
 	u32 prot;
 	u64 device_private;
 	u64 iommu_private;
+	u64 expire;
 };
 
 /**
@@ -380,11 +382,13 @@ struct iommu_fault_event {
  * @dev_fault_handler: Callback function to handle IOMMU faults at device level
  * @data: handler private data
  * @faults: holds the pending faults which needs response, e.g. page response.
+ * @timer: track page request pending time limit
  * @lock: protect pending PRQ event list
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
 	struct list_head faults;
+	struct timer_list timer;
 	struct mutex lock;
 	void *data;
 };
-- 
2.7.4

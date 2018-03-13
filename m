Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AG47ELuO1UImST5ogTWLGi8XfjYLxw2sTU2HzeL83+rk3w6cD82IcxneGM0R5eBNzKXLJh2wZ1t0
ARC-Seal: i=1; a=rsa-sha256; t=1520931367; cv=none;
        d=google.com; s=arc-20160816;
        b=NOtVHnEkhkyxnujmpelFwFooOXCCG8dV3XiTII5FMQvekWN7juDnCszeBoATveObkA
         ZyOlDtFxhgKRChyUBzB3DpTA2T3EPJvdQc0WLUafcALiOd9aOqLfp0s5SGkiYp3XAxK5
         n0Y4S9y3PGBQmPbs9blt6WTcQCogpOwVK55753jkraER4Ev0zzPM9iSzuPEhRcuMaB+q
         XCA9ExuSoMyZaxiOXKou2tA1qAdfqqQzgOeCh1xo3hFooM+lsb2cm7RaQ75pYpaESggI
         cyhieDfIfsIP3+I8HLp3y5VmNarK+DbsrFW1ITS9MlQf09yD3gt1F/xn0Yau9F3z/wA7
         J6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=xSjuxkzt7Bdix4yG+U3IFlWuFrhzLN9ID1OsVrTbH2k=;
        b=jLCNGh0oiDnoqkz5W3elOw62mBtIvWoL6INvZRvALnZTLJmLqvzH46oL8FDKKs7xHm
         3CzluOrvCiagQugw/ghuEXcwJHP6P4Ud1Uw1/QaubQDk2IPXJifRR4bg1xnF/QxfL7hC
         XSBUtEwe95A3vNzY9sQaMYxU9bnQpmjE0YSRswIEq3jXRu8E2F9LY/0NpXHGG2HlBrrH
         PfbMDpDPtgwbG/glyuVpEEC+M6gIejhXmhwvIl7r7nnNZZaWTT6B5Qaj52dZW2Cbz5iL
         vNblHrrQog6HWXhK2XjNzdEPdWJ25TQwMOt05ffkAs/rYmRiOuvWlD4u20EBU9MMkPRu
         LNHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ihbWyDkG;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IIyzhMgz;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ihbWyDkG;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IIyzhMgz;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3824060858
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org,
	robh+dt@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux-foundation.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com,
	will.deacon@arm.com,
	robdclark@gmail.com,
	tfiga@chromium.org,
	sricharan@codeaurora.org,
	m.szyprowski@samsung.com,
	architt@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	vivek.gautam@codeaurora.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v9 1/5] driver core: Find an existing link between two devices
Date: Tue, 13 Mar 2018 14:25:30 +0530
Message-Id: <20180313085534.11650-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594812129788829883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The lists managing the device-links can be traversed to
find the link between two devices. The device_link_add() APIs
does traverse these lists to check if there's already a link
setup between the two devices.
So, add a new APIs, device_link_find(), to find an existing
device link between two devices - suppliers and consumers.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 * New patch added to this series.

 drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
 include/linux/device.h |  2 ++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5847364f25d9..e8c9774e4ba2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 	return 0;
 }
 
+/**
+ * device_link_find - find any existing link between two devices.
+ * @consumer: Consumer end of the link.
+ * @supplier: Supplier end of the link.
+ *
+ * Returns pointer to the existing link between a supplier and
+ * and consumer devices, or NULL if no link exists.
+ */
+struct device_link *device_link_find(struct device *consumer,
+				     struct device *supplier)
+{
+	struct device_link *link = NULL;
+
+	if (!consumer || !supplier)
+		return NULL;
+
+	list_for_each_entry(link, &supplier->links.consumers, s_node)
+		if (link->consumer == consumer)
+			break;
+
+	return link;
+}
+EXPORT_SYMBOL_GPL(device_link_find);
+
 /**
  * device_link_add - Create a link between two devices.
  * @consumer: Consumer end of the link.
@@ -195,9 +219,9 @@ struct device_link *device_link_add(struct device *consumer,
 		goto out;
 	}
 
-	list_for_each_entry(link, &supplier->links.consumers, s_node)
-		if (link->consumer == consumer)
-			goto out;
+	link = device_link_find(consumer, supplier);
+	if (link)
+		goto out;
 
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
diff --git a/include/linux/device.h b/include/linux/device.h
index b093405ed525..13bc1884c3eb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1278,6 +1278,8 @@ extern const char *dev_driver_string(const struct device *dev);
 struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
+struct device_link *device_link_find(struct device *consumer,
+				     struct device *supplier);
 
 #ifdef CONFIG_PRINTK
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

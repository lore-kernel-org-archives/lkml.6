Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqIbLBt1tHQgVSNB8+mgU+JNNTsLU78eTd1QcyusA+Hx5vRu0SGb2RE0dNP9MeQTw/smi5I
ARC-Seal: i=1; a=rsa-sha256; t=1526071894; cv=none;
        d=google.com; s=arc-20160816;
        b=CB9Nu3hLIwbAv0QiR0/D4czPxljsEmSc0Fakg2VLfuF+wazd3+wMRsuRZqYRhyrN5n
         jFv4xtnXv312WQpX+52h8A/pqlkee8cYhjEy59+PnrJIIVmvgt7xejkrhJvY6ayM0ZGP
         61FRpk35JjL6bQzzK2hWYUpOg04MOzTC71a3tcefhIRj3TFrrZtRujZjBohcUGKRCyq7
         Z5t2CvTywXptetB4M1EfcPBubsO2AbDZI4xJNaSQ0YHHqKJXJGNTaMRudbuj7Sdcbhxo
         EO8fl0b/lTiqs3GKFNrqjCC2+1E/a5DlVOmWWTIyV25MqrbVXxSUhnOswyPxcbZtWiP5
         zbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=u5v44CQN1ci5MoVKRUvqelFGDG+SRdxaZzDTq1g7EyM=;
        b=sAQd3WGfBqruOyRGBIE4q3TFldqOtUc4oNwcSPT/GBALC4RvTmFXrbVaw8RrPDvGKR
         EGpdYNeD6jWyPnDj3jFjsI/FsafroMbzASrige3omNf4wAQiJOMN+Nu/ZGM5mIQAHW9B
         dosXSV46YtriENhwusFKgUgyreZb2Zo/syndnL1X7519YXUDruw+H3gvxodvF6bWjqpX
         OX6yx8/sNwyg6krQZefaLEFli5DhJ/h01wmVDRTt6Wa9Zw4XSYcrj5RH6M8gWLN10Tar
         3IeftPi2RvmK6lqlEzNsFzEOCtdiNDdPLGk1UlEBklbbrV48+HyakrknNaMUMlAadanA
         +JNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104769"
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
Subject: [PATCH v5 12/23] iommu: add a timeout parameter for prq response
Date: Fri, 11 May 2018 13:54:04 -0700
Message-Id: <1526072055-86990-13-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362559263612?=
X-GMAIL-MSGID: =?utf-8?q?1600202362559263612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When an IO page request is processed outside IOMMU subsystem, response can be
delayed or lost. Add a tunable setup parameter such that user can chooose
the timeout for IOMMU to track pending page requests.
This timeout mechanism is a basic safty net which can be implemented in conjunction
with credit based or device level page response exception handling.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
 drivers/iommu/iommu.c                           | 28 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28e..5c1e836 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1718,6 +1718,14 @@
 			1 - Bypass the IOMMU for DMA.
 			unset - Use IOMMU translation for DMA.
 
+	iommu.prq_timeout=
+			Timeout in seconds to wait for page response
+			of a pending page request.
+			Format: <integer>
+			Default: 10
+			0 - no timeout tracking
+			1 to 100 - allowed range
+
 	io7=		[HW] IO7 for Marvel based alpha systems
 			See comment before marvel_specify_io7 in
 			arch/alpha/kernel/core_marvel.c.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 784e019..3a49b96 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -37,6 +37,18 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+/*
+ * Timeout to wait for page response of a pending page request. This is
+ * intended as a basic safty net in case a pending page request is not
+ * responded for an exceptionally long time. Device may also implement
+ * its own protection mechanism against this exception.
+ * Units are in jiffies with a range between 1 - 100 seconds equivalent.
+ * Default to 10 seconds.
+ * Setting 0 means no timeout tracking.
+ */
+#define IOMMU_PAGE_RESPONSE_MAX_TIMEOUT (HZ * 100)
+#define IOMMU_PAGE_RESPONSE_DEF_TIMEOUT (HZ * 10)
+static unsigned long prq_timeout = IOMMU_PAGE_RESPONSE_DEF_TIMEOUT;
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
@@ -125,6 +137,22 @@ static int __init iommu_set_def_domain_type(char *str)
 }
 early_param("iommu.passthrough", iommu_set_def_domain_type);
 
+static int __init iommu_set_prq_timeout(char *str)
+{
+	unsigned long timeout;
+
+	if (!str)
+		return -EINVAL;
+	timeout = simple_strtoul(str, NULL, 0);
+	timeout = timeout * HZ;
+	if (timeout > IOMMU_PAGE_RESPONSE_MAX_TIMEOUT)
+		return -EINVAL;
+	prq_timeout = timeout;
+
+	return 0;
+}
+early_param("iommu.prq_timeout", iommu_set_prq_timeout);
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
-- 
2.7.4

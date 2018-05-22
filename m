Return-Path: <rajatja@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527028104; cv=none;
        d=google.com; s=arc-20160816;
        b=nCellL8TYqDQUA3GL7oEL/J3MkA9VMXsrlHeVnd+oqet03i7iqDh8xTd9iTdQEri1e
         YXuqB6XtzuUWYHltTMo1LZRc6LEOl27Wim5opxx1QxA1nN2d75TpjnL4agM+fWuAcTfs
         69C6xaxzaY6Y+Kf8EjpaGXC8PdVAxJRPQALL2MBTWsgdFWrtymB22ygGqfocJ8rXddMS
         aw8H6WMFzMGt1R1+3l1Kp6omlB0xQtZlJNqEdvyOhahj5AhlyOWSVqUDWHJSV52/FBEz
         lZW5yOQQWWrL4GzwBaZfJcoehldP8r9j5kK8NrNWWcZse4MDrpqlh+SfmG1Q0F5dB1ds
         1AUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=SRrivjhPDLWdNV30qpcVtjkn9lTsMaVb6ioXmX3jBo0=;
        b=igyYt2Su/E3R2f0JnbMnyvVJIBC8RxaXm7K8TQCJEiIepOyNeFID/eP+4wIjKXE6Uf
         puv37MGfTVPFdGsTYNbyILh0f0q5gOHUZqnBHM2vPlmZWKgc0Bur8YWHf2+Pzjxd8GYp
         CaIDQtL9PMRKca9NiHl2A2XLynx06yB1jEz+azTyNmlT4NHlzU+JdttQxDaStTLSLVBw
         5a7BhRt4LrbPtoyL1mbcXjc6khB5wjSWrHqVkRR/id73br0/+aq3QAVvpreq6uMxF6Hz
         lvTzfh5zAkoWLktn7BdWU+9BZQJSvEJqlEzcuuFzBxstu2pEijz69Q3OQu2M1a6kIpCR
         rMTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YgGo/YTn;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YgGo/YTn;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZpQ+sSHzqU5dhzLA6U9wKRe/3dc2WmZzYXrqAVDCEMj9tEBB/+oWxAVgnuQMvqrKRq4K+71eQ==
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajat Jain <rajatja@google.com>,
	Frederick Lawler <fred@fredlawl.com>,
	Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jes Sorensen <jsorensen@fb.com>,
	Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com,
	Rajat Jain <rajatj@google.com>
Subject: [PATCH 3/5] PCP/AER: Add sysfs attributes to provide breakdown of AERs
Date: Tue, 22 May 2018 15:28:03 -0700
Message-Id: <20180522222805.80314-4-rajatja@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180522222805.80314-1-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205021860277520?=
X-GMAIL-MSGID: =?utf-8?q?1601205021860277520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add sysfs attributes to provide breakdown of the AERs seen,
into different type of correctable or uncorrectable errors:

dev_breakdown_correctable
dev_breakdown_uncorrectable

Signed-off-by: Rajat Jain <rajatj@google.com>
---
 drivers/pci/pcie/aer/aerdrv.h          |  6 ++++++
 drivers/pci/pcie/aer/aerdrv_errprint.c |  6 ++++--
 drivers/pci/pcie/aer/aerdrv_stats.c    | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index b5d5ad6f2c03..048fbd7c9633 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -89,6 +89,12 @@ int pci_aer_stats_init(struct pci_dev *pdev);
 void pci_aer_stats_exit(struct pci_dev *pdev);
 void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
 
+extern const char
+*aer_correctable_error_string[AER_MAX_TYPEOF_CORRECTABLE_ERRS];
+
+extern const char
+*aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCORRECTABLE_ERRS];
+
 #ifdef CONFIG_ACPI_APEI
 int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
 #else
diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 5e8b98deda08..5585f309f1a8 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -68,7 +68,8 @@ static const char *aer_error_layer[] = {
 	"Transaction Layer"
 };
 
-static const char *aer_correctable_error_string[] = {
+const char
+*aer_correctable_error_string[AER_MAX_TYPEOF_CORRECTABLE_ERRS] = {
 	"Receiver Error",		/* Bit Position 0	*/
 	NULL,
 	NULL,
@@ -87,7 +88,8 @@ static const char *aer_correctable_error_string[] = {
 	"Header Log Overflow",		/* Bit Position 15	*/
 };
 
-static const char *aer_uncorrectable_error_string[] = {
+const char
+*aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCORRECTABLE_ERRS] = {
 	"Undefined",			/* Bit Position 0	*/
 	NULL,
 	NULL,
diff --git a/drivers/pci/pcie/aer/aerdrv_stats.c b/drivers/pci/pcie/aer/aerdrv_stats.c
index 87b7119d0a86..5f0a6e144f56 100644
--- a/drivers/pci/pcie/aer/aerdrv_stats.c
+++ b/drivers/pci/pcie/aer/aerdrv_stats.c
@@ -61,10 +61,35 @@ aer_stats_aggregate_attr(dev_total_cor_errs);
 aer_stats_aggregate_attr(dev_total_fatal_errs);
 aer_stats_aggregate_attr(dev_total_nonfatal_errs);
 
+#define aer_stats_breakdown_attr(field, stats_array, strings_array)            \
+	static ssize_t                                                         \
+	field##_show(struct device *dev, struct device_attribute *attr,        \
+		     char *buf)                                                \
+{                                                                              \
+	unsigned int i;                                                        \
+	char *str = buf;                                                       \
+	struct pci_dev *pdev = to_pci_dev(dev);                                \
+	u64 *stats = pdev->aer_stats->stats_array;                             \
+	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {                      \
+		if (strings_array[i])                                          \
+			str += sprintf(str, "%s = 0x%llx\n",                   \
+				       strings_array[i], stats[i]);            \
+	}                                                                      \
+	return str-buf;                                                        \
+}                                                                              \
+static DEVICE_ATTR_RO(field)
+
+aer_stats_breakdown_attr(dev_breakdown_correctable, dev_cor_errs,
+			 aer_correctable_error_string);
+aer_stats_breakdown_attr(dev_breakdown_uncorrectable, dev_uncor_errs,
+			 aer_uncorrectable_error_string);
+
 static struct attribute *aer_stats_attrs[] __ro_after_init = {
 	&dev_attr_dev_total_cor_errs.attr,
 	&dev_attr_dev_total_fatal_errs.attr,
 	&dev_attr_dev_total_nonfatal_errs.attr,
+	&dev_attr_dev_breakdown_correctable.attr,
+	&dev_attr_dev_breakdown_uncorrectable.attr,
 	NULL
 };
 
-- 
2.17.0.441.gb46fe60e1d-goog

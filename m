Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520629806; cv=none;
        d=google.com; s=arc-20160816;
        b=v3kDBtHY0NiFcvWlEjAAqExlX8Cga2LgewWEdun/RfJ3DpQdkP6hp0B0DnC6Llmi5t
         6iAj9jMzYwzj8doW6uwGupOjg6A9V2rfgXWjlt4DgqbvlB8LXOvmwkfBBGL6ghrLxlUF
         vwJwEU7DaZx/fDlytzCPKxUuIwWC/8PYhWzh+fEYNBGbHuIlZaJiSVKR3a/qfAAvnLnV
         C8/J7x0JNbyiA3+vPXPkSPzHpV5hDNg8CJxOfYlnICCSpkKntNo8GqMeVLTbZhAIy2Bm
         zFUfEZn1rnl1hgBc3hkNXmE5q61Vq0dBDMQjLOe2Z9F58uURWjKXQrvsW9Eqt7JGCS6f
         gaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=7dJ61Js48E3Ds72/6TrlMw7o9MrSnzRN7XqpAPjyplI=;
        b=zvvQEVTMmkJ9UaMWAJgrSyOoirb0E5HB9FlreHDYiiiLH4lt/Gj0yuY1gE9GLvzhBz
         5Zku9kYYfnSzSsnjLEiRHHE4OZe3ZhxgDbpvDuKhbvMIPm/PO+B/CNXA6fSh4nM1S+Nj
         TU6QIs9Nadu22B+86NjPj6qUkmWT2oCiMg0YGBpV+iqNxUZAY42iTTTFQSSd5hqFHj8m
         cCBrkDqr1VlUhnJA7LXheIk3d16r5ZNmsaCw3Rb0CcwypvmwTwz7d5YycvKzcUG1UMhl
         5G+6ywuKPqQSyKR8VdeO/HotNBQXNTnkC3xeLB/uXiUE6cspG356QMsfKGoUazEQaj1D
         QRRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ByBvWMEv;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ByBvWMEv;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuC3qQglFr1vVFC6H4sMHfFc+1EHFZPCJ62XCWsL/U2shuyKr/LhtF9GPEEQPHMn+45ho9EIQ==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net,
	robh+dt@kernel.org,
	mturquette@baylibre.com,
	khilman@baylibre.com,
	vincent.guittot@linaro.org,
	skannan@codeaurora.org,
	bjorn.andersson@linaro.org,
	amit.kucheria@linaro.org,
	seansw@qti.qualcomm.com,
	davidai@quicinc.com,
	mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	georgi.djakov@linaro.org
Subject: [PATCH v4 3/7] interconnect: Add debugfs support
Date: Fri,  9 Mar 2018 23:09:54 +0200
Message-Id: <20180309210958.16672-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495920063495785?=
X-GMAIL-MSGID: =?utf-8?q?1594495920063495785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a functionality to provide information about the current constraints
per each node and provider.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 6306e258b9b9..a06f752a6aaa 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -6,6 +6,7 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -15,11 +16,13 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_provider_list);
 static DEFINE_MUTEX(icc_provider_list_mutex);
 static DEFINE_MUTEX(icc_path_mutex);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -46,6 +49,73 @@ struct icc_path {
 	struct icc_req reqs[0];
 };
 
+#ifdef CONFIG_DEBUG_FS
+
+static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
+{
+	if (!n)
+		return;
+
+	seq_printf(s, "%-30s %12d %12d\n",
+		   n->name, n->avg_bw, n->peak_bw);
+}
+
+static int icc_summary_show(struct seq_file *s, void *data)
+{
+	struct icc_provider *provider;
+
+	seq_puts(s, " node                                   avg         peak\n");
+	seq_puts(s, "--------------------------------------------------------\n");
+
+	mutex_lock(&icc_provider_list_mutex);
+
+	list_for_each_entry(provider, &icc_provider_list, provider_list) {
+		struct icc_node *n;
+
+		mutex_lock(&provider->lock);
+		list_for_each_entry(n, &provider->nodes, node_list) {
+			icc_summary_show_one(s, n);
+		}
+		mutex_unlock(&provider->lock);
+	}
+
+	mutex_unlock(&icc_provider_list_mutex);
+
+	return 0;
+}
+
+static int icc_summary_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, icc_summary_show, inode->i_private);
+}
+
+static const struct file_operations icc_summary_fops = {
+	.open		= icc_summary_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init icc_debugfs_init(void)
+{
+	struct dentry *file;
+
+	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
+	if (!icc_debugfs_dir) {
+		pr_err("interconnect: error creating debugfs directory\n");
+		return -ENODEV;
+	}
+
+	file = debugfs_create_file("interconnect_summary", 0444,
+				   icc_debugfs_dir, NULL, &icc_summary_fops);
+	if (!file)
+		return -ENODEV;
+
+	return 0;
+}
+late_initcall(icc_debugfs_init);
+#endif
+
 static struct icc_node *node_find(const int id)
 {
 	struct icc_node *node;

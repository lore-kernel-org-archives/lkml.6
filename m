Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522379761; cv=none;
        d=google.com; s=arc-20160816;
        b=RvCvUKm5kjBGqiC8F1V8syI7w1LwNdMUYZgXPbeY2gWxGtRhu4Fl3piW+eLA6UemDz
         bVhyHi36mTKoCIg5veKjeADUleR27xKpAVhmRbn1rIRfvaEhG+J1ZKoy7pqyiy0L/P0v
         qug2ARRJUG3DMf6hwjWpKNVeuMO0V5wWGbvsVY/NaK2MuO56VPy4wo2Gtdtu/bz9qYl+
         MZMDts70/18tLBwEi13t8j4bTfifJbvzcADvekEfDnfgxcabLHnbCo2ZRxGVliHmTCDA
         EGpg56rW59Z99sv0YvcnV8Ro9NILxRCpUBdkLCNQoDdr6yuTdffx9jQwY3b1zuBuWqGN
         Ky8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=SC+Y9Dd4/hPslmxENYAISjheGeV9ItZkUbxFlXes27Q=;
        b=gp05QNkA1HZ44OtK53vjQqJnJqBman8GLbNMFftyRUiFJiZCQF0HhhCPF5u43DMKqD
         fEuJnK4uhrIikwrx3JGgObRUGLmJyCitQKwVWNDL5EUVP1YZqci2gSaQVFRLUGarQ7wc
         3/zGDd/kNCCgBDP0yz+lemgrEz+VaG6fusYL8iJ5+lUl+q1Cf32vwj3iPXqcPw1zzYzT
         fUjwjhPzpLPd7NdQDSflclFP6xMWVEbIokoXGBilBroOaoOBSRARo16nS53HJieMoQIN
         V9XobnsIzKbXkOzgMbNGBl/L4VkAXprLZUI6sfRDGHVmdRav7OCzmLLMnQKAD/SVZX6E
         34XA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ez0z0TLi;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ez0z0TLi;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49EuRTRNjrhIqET/ZDRC554AasLY9Vi2sj8FqY047A6JgmBRx7fdZxqOe5/uI3OZzXqJ7iGiA==
From: Leo Yan <leo.yan@linaro.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	Kim Phillips <kim.phillips@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 3/6] coresight: Support panic kdump functionality
Date: Fri, 30 Mar 2018 11:15:21 +0800
Message-Id: <1522379724-30648-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
References: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596330879952458312?=
X-GMAIL-MSGID: =?utf-8?q?1596330879952458312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After kernel panic happens, Coresight tracing data has much useful info
which can be used for analysis.  For example, the trace info from ETB
RAM can be used to check the CPU execution flows before the crash.  So
we can save the tracing data from sink devices, and rely on kdump to
save DDR content and uses "crash" tool to extract Coresight dumping
from the vmcore file.

This patch is to add a simple framework to support panic dump
functionality; it registers panic notifier, and provide the helper
functions coresight_kdump_source()/coresight_kdump_sink() so Coresight
source and sink devices can be recorded into Coresight kdump node for
kernel panic kdump.

When kernel panic happens, the notifier iterates dump array and invoke
callback function to dump tracing data.  Later the tracing data can be
used to reverse execution flow before the kernel panic.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig                |   9 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 .../hwtracing/coresight/coresight-panic-kdump.c    | 199 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h       |  12 ++
 include/linux/coresight.h                          |   4 +
 5 files changed, 225 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-panic-kdump.c

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ef9cb3c..3089abf 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -103,4 +103,13 @@ config CORESIGHT_CPU_DEBUG
 	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
 	  for detailed description and the example for usage.
 
+config CORESIGHT_PANIC_KDUMP
+	bool "CoreSight Panic Kdump driver"
+	depends on ARM || ARM64
+	help
+	  This driver provides panic kdump functionality for CoreSight devices.
+	  When kernel panic happen Coresight device supplied callback function
+	  is to dump trace data to memory. From then on, kdump can be used to
+	  extract the trace data from kernel dump file.
+
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 61db9dd..946fe19 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
 obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
+obj-$(CONFIG_CORESIGHT_PANIC_KDUMP) += coresight-panic-kdump.o
diff --git a/drivers/hwtracing/coresight/coresight-panic-kdump.c b/drivers/hwtracing/coresight/coresight-panic-kdump.c
new file mode 100644
index 0000000..f4589e9
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-panic-kdump.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017~2018 Linaro Limited.
+#include <linux/coresight.h>
+#include <linux/coresight-pmu.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "coresight-priv.h"
+
+/**
+ * struct coresight_kdump_node - Node information for dump
+ * @source_csdev:	Handler for source coresight device
+ * @sink_csdev:		Handler for sink coresight device
+ */
+struct coresight_kdump_node {
+	struct coresight_device *source_csdev;
+	struct coresight_device *sink_csdev;
+};
+
+static DEFINE_SPINLOCK(coresight_kdump_lock);
+static struct coresight_kdump_node *coresight_kdump_nodes;
+static struct notifier_block coresight_kdump_nb;
+
+/**
+ * coresight_kdump_source - Set source dump info for specific CPU
+ * @cpu:	CPU ID
+ * @csdev:	Source device structure handler
+ * @data:	Pointer for source device metadata buffer
+ * @data_sz:	Size of source device metadata buffer
+ *
+ * This function is a helper function which is used to set/clear source device
+ * handler and metadata when the tracer is enabled; and it can be used to clear
+ * source device related info when the tracer is disabled.
+ *
+ * Returns:	0 on success, negative errno otherwise.
+ */
+int coresight_kdump_source(int cpu, struct coresight_device *csdev,
+			   char *data, unsigned int data_sz)
+{
+	struct coresight_kdump_node *node;
+	unsigned long flags;
+
+	if (!coresight_kdump_nodes)
+		return -EPROBE_DEFER;
+
+	spin_lock_irqsave(&coresight_kdump_lock, flags);
+
+	node = &coresight_kdump_nodes[cpu];
+	node->source_csdev = csdev;
+
+	csdev->kdump_buf = data;
+	csdev->kdump_buf_sz = data_sz;
+
+	spin_unlock_irqrestore(&coresight_kdump_lock, flags);
+	return 0;
+}
+
+/**
+ * coresight_kdump_sink - Set sink device handler for specific CPU
+ * @cpu:	CPU ID
+ * @csdev:	Sink device structure handler
+ *
+ * This function is a helper function which is used to set sink device handler
+ * when the Coresight path has been enabled for specific CPU; and it can be used
+ * to clear sink device handler when the path is disabled.
+ *
+ * Returns:	0 on success, negative errno otherwise.
+ */
+int coresight_kdump_sink(int cpu, struct coresight_device *csdev)
+{
+	struct coresight_kdump_node *node;
+	unsigned long flags;
+
+	if (!coresight_kdump_nodes)
+		return -EPROBE_DEFER;
+
+	spin_lock_irqsave(&coresight_kdump_lock, flags);
+
+	node = &coresight_kdump_nodes[cpu];
+	node->sink_csdev = csdev;
+
+	spin_unlock_irqrestore(&coresight_kdump_lock, flags);
+	return 0;
+}
+
+/**
+ * coresight_kdump_sink_cb - Invoke sink callback for specific CPU
+ * @cpu:	CPU ID
+ *
+ * This function is to invoke sink device corresponding callback.  It needs
+ * to check two cases: one case is the CPU has not been enabled for Coresight
+ * path so there totally has no trace data for the CPU, another case is the
+ * CPU shares the same sink device with other CPUs but the tracing data has
+ * been dumped by previous CPUs; it skips dump for these two cases.
+ */
+static void coresight_kdump_sink_cb(int cpu)
+{
+	struct coresight_kdump_node *node;
+	struct coresight_device *csdev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&coresight_kdump_lock, flags);
+
+	node = &coresight_kdump_nodes[cpu];
+	csdev = node->sink_csdev;
+
+	/* Path has not been enabled */
+	if (!csdev)
+		goto skip_dump;
+
+	/* Have been dumped by previous CPU */
+	if (csdev->kdump_buf)
+		goto skip_dump;
+
+	/* Invoke panic callback */
+	csdev = coresight_kdump_nodes[cpu].sink_csdev;
+	if (csdev && sink_ops(csdev)->panic_cb)
+		sink_ops(csdev)->panic_cb(csdev);
+
+skip_dump:
+	spin_unlock_irqrestore(&coresight_kdump_lock, flags);
+}
+
+/**
+ * coresight_kdump_notify - Invoke panic dump callbacks
+ * @nb:		Pointer to notifier block
+ * @event:	Notification reason
+ * @_unused:	Pointer to notification data object, unused
+ *
+ * This function is called when panic happens to invoke dump callbacks, it takes
+ * panic CPU tracing data with high priority to firstly invoke panic CPU sink
+ * callback function, then the notifier iterates callback functions one by one
+ * for other CPUs.  If one sink device is shared among CPUs, the sink panic
+ * callback is invoked for the first traversed CPU node and other sequential
+ * CPUs are skipped.
+ *
+ * Returns:	0 on success.
+ */
+static int coresight_kdump_notify(struct notifier_block *nb,
+				  unsigned long event, void *_unused)
+{
+	int cpu, first;
+
+	/* Give panic CPU trace data with high priority */
+	first = atomic_read(&panic_cpu);
+	coresight_kdump_sink_cb(first);
+
+	/* Dump rest CPUs trace data */
+	for (cpu = 0; cpu < num_possible_cpus(); cpu++) {
+		if (cpu == first)
+			continue;
+
+		coresight_kdump_sink_cb(cpu);
+	}
+
+	return 0;
+}
+
+/**
+ * coresight_kdump_init - Coresight kdump module initialization
+ *
+ * This function allcoates dump array and register panic norifier.
+ *
+ * Returns:	0 on success, negative errno otherwise.
+ */
+static int __init coresight_kdump_init(void)
+{
+	int ret;
+
+	coresight_kdump_nodes = kmalloc_array(num_possible_cpus(),
+					      sizeof(*coresight_kdump_nodes),
+					      GFP_KERNEL);
+	if (!coresight_kdump_nodes) {
+		pr_err("%s: kmalloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	memset(coresight_kdump_nodes, 0,
+	       num_possible_cpus() * sizeof(*coresight_kdump_nodes));
+
+	coresight_kdump_nb.notifier_call = coresight_kdump_notify;
+	ret = atomic_notifier_chain_register(&panic_notifier_list,
+					     &coresight_kdump_nb);
+	if (ret) {
+		pr_err("%s: unable to register notifier: %d\n",
+		       __func__, ret);
+		kfree(coresight_kdump_nodes);
+		return ret;
+	}
+
+	return 0;
+}
+postcore_initcall(coresight_kdump_init);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index f1d0e21d..76d27d6 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -151,4 +151,16 @@ static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
 static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
 #endif
 
+#ifdef CONFIG_CORESIGHT_PANIC_KDUMP
+extern int coresight_kdump_source(int cpu, struct coresight_device *csdev,
+				  char *data, unsigned int data_sz);
+extern int coresight_kdump_sink(int cpu, struct coresight_device *csdev);
+#else
+static inline int coresight_kdump_source(int cpu,
+		struct coresight_device *csdev,
+		char *data, unsigned int data_sz) { return 0; }
+static inline void coresight_kdump_sink(int cpu,
+		struct coresight_device *csdev) { return 0; }
+#endif
+
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d950dad..89aad8d 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -171,6 +171,8 @@ struct coresight_device {
 	bool orphan;
 	bool enable;	/* true only if configured as part of a path */
 	bool activated;	/* true only if a sink is part of a path */
+	char *kdump_buf;
+	unsigned int kdump_buf_sz;
 };
 
 #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
@@ -189,6 +191,7 @@ struct coresight_device {
  * @set_buffer:		initialises buffer mechanic before a trace session.
  * @reset_buffer:	finalises buffer mechanic after a trace session.
  * @update_buffer:	update buffer pointers after a trace session.
+ * @panic_cb:		hook function for panic notifier.
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev, u32 mode);
@@ -205,6 +208,7 @@ struct coresight_ops_sink {
 	void (*update_buffer)(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
 			      void *sink_config);
+	void (*panic_cb)(void *data);
 };
 
 /**
-- 
2.7.4

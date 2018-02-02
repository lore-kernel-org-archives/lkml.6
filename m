Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeBBOWr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:22:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbeBBOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:22:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3141860FEC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC v2 3/3] drivers: irqchip: pdc: log PDC info in FTRACE
Date: Fri,  2 Feb 2018 07:22:00 -0700
Message-Id: <20180202142200.6229-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202142200.6229-1-ilina@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archana Sathyakumar <asathyak@codeaurora.org>

Log key PDC pin configuration in FTRACE.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/irqchip/qcom-pdc.c |  7 ++++++
 include/trace/events/pdc.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 include/trace/events/pdc.h

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index a392380eada6..7f177ad88713 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -26,6 +26,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#define CREATE_TRACE_POINTS
+#include "trace/events/pdc.h"
 
 #define PDC_MAX_IRQS		126
 
@@ -68,6 +70,8 @@ static inline void pdc_enable_intr(struct irq_data *d, bool on)
 	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
 	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
 	spin_unlock_irqrestore(&pdc_lock, flags);
+
+	trace_irq_pin_config(PDC_ENTRY, pin_out, (u64)d->chip_data, 0, on);
 }
 
 static void qcom_pdc_gic_mask(struct irq_data *d)
@@ -149,6 +153,9 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 
 	pdc_reg_write(IRQ_i_CFG, pin_out, pdc_type);
 
+	trace_irq_pin_config(PDC_TYPE_CONFIG, pin_out, (u64)d->chip_data,
+				pdc_type, 0);
+
 	return irq_chip_set_type_parent(d, type);
 }
 
diff --git a/include/trace/events/pdc.h b/include/trace/events/pdc.h
new file mode 100644
index 000000000000..0e894bbc9e85
--- /dev/null
+++ b/include/trace/events/pdc.h
@@ -0,0 +1,55 @@
+/* Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pdc
+
+#if !defined(_TRACE_PDC_) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PDC_H_
+
+#include <linux/tracepoint.h>
+
+#define PDC_ENTRY		1
+#define PDC_TYPE_CONFIG		2
+
+TRACE_EVENT(irq_pin_config,
+
+	TP_PROTO(u32 func, int pin, u64 hwirq, u32 type, u32 enable),
+
+	TP_ARGS(func, pin, hwirq, type, enable),
+
+	TP_STRUCT__entry(
+		__field(u32, func)
+		__field(int, pin)
+		__field(u64, hwirq)
+		__field(u32, type)
+		__field(u32, enable)
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+		__entry->pin = pin;
+		__entry->hwirq = hwirq;
+		__entry->type = type;
+		__entry->enable = enable;
+	),
+
+	TP_printk("%s hwirq:%lu pin:%d type:%u enable:%u",
+		print_symbolic(__entry->func,
+				{ PDC_ENTRY, "pdc_entry" },
+				{ PDC_TYPE_CONFIG, "pdc_type_config" }),
+		__entry->pin, __entry->hwirq, __entry->type, __entry->enable)
+);
+
+#endif
+#define TRACE_INCLUDE_FILE pdc
+#include <trace/define_trace.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

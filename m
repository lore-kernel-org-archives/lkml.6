Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeEDCll (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:41:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:18423 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeEDClj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:41:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="221513546"
From: kan.liang@intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@intel.com>
Subject: [RESEND PATCH V7 6/8] perf/x86/intel/uncore: Support IIO free-running counters on SKX
Date: Thu,  3 May 2018 11:25:11 -0700
Message-Id: <1525371913-10597-6-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

As of Skylake Server, there are a number of free running counters in
each IIO Box that collect counts of per-box IO clocks and per-port
Input/Output x BW/Utilization.

The free running counters cannot be part of the existing IIO BOX,
because, quoting from Peter Zijlstra:
"This will result in some (probably) unexpected scheduling artifacts.
Probably the only way to really cure that is to have the free running
counters in their own PMU and not share with the GP counters of this
box."
Adding a new PMU for the free running counters.

The free-running counter is read-only and always active. Counting will
be suspended only when the IIO Box is powered down.

There are three types of IIO free-running counters on Skylake server, IO
CLOCKS counter, BANDWIDTH counters and UTILIZATION counters.
IO CLOCKS counter is a clock of IIO box.
BANDWIDTH counters are to count inbound(PCIe->CPU)/outbound(CPU->PCIe)
bandwidth.
UTILIZATION counters are to count input/output utilization.

The bit width of the free-running counters is 36-bits.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@intel.com>
---

Changes since V6:
 - Add a new PMU for IIO free running counters.

 arch/x86/events/intel/uncore_snbep.c | 82 ++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 22ec65b..d6b302e 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3484,6 +3484,87 @@ static struct intel_uncore_type skx_uncore_iio = {
 	.format_group		= &skx_uncore_iio_format_group,
 };
 
+enum perf_uncore_iio_freerunning_type_id {
+	SKX_IIO_MSR_IOCLK			= 0,
+	SKX_IIO_MSR_BW				= 1,
+	SKX_IIO_MSR_UTIL			= 2,
+
+	SKX_IIO_FREERUNNING_TYPE_MAX,
+};
+
+
+static struct freerunning_counters skx_iio_freerunning[] = {
+	[SKX_IIO_MSR_IOCLK]	= { 0xa45, 0x1, 0x20, 1, 36 },
+	[SKX_IIO_MSR_BW]	= { 0xb00, 0x1, 0x10, 8, 36 },
+	[SKX_IIO_MSR_UTIL]	= { 0xb08, 0x1, 0x10, 8, 36 },
+};
+
+static struct uncore_event_desc skx_uncore_iio_freerunning_events[] = {
+	/* Free-Running IO CLOCKS Counter */
+	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
+	/* Free-Running IIO BANDWIDTH Counters */
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port0,		"event=0xff,umask=0x24"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port0.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port1,		"event=0xff,umask=0x25"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port1.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port2,		"event=0xff,umask=0x26"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port2.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port3,		"event=0xff,umask=0x27"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port3.unit,	"MiB"),
+	/* Free-running IIO UTILIZATION Counters */
+	INTEL_UNCORE_EVENT_DESC(util_in_port0,		"event=0xff,umask=0x30"),
+	INTEL_UNCORE_EVENT_DESC(util_out_port0,		"event=0xff,umask=0x31"),
+	INTEL_UNCORE_EVENT_DESC(util_in_port1,		"event=0xff,umask=0x32"),
+	INTEL_UNCORE_EVENT_DESC(util_out_port1,		"event=0xff,umask=0x33"),
+	INTEL_UNCORE_EVENT_DESC(util_in_port2,		"event=0xff,umask=0x34"),
+	INTEL_UNCORE_EVENT_DESC(util_out_port2,		"event=0xff,umask=0x35"),
+	INTEL_UNCORE_EVENT_DESC(util_in_port3,		"event=0xff,umask=0x36"),
+	INTEL_UNCORE_EVENT_DESC(util_out_port3,		"event=0xff,umask=0x37"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_ops skx_uncore_iio_freerunning_ops = {
+	.read_counter		= uncore_msr_read_counter,
+};
+
+static struct attribute *skx_uncore_iio_freerunning_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	NULL,
+};
+
+static const struct attribute_group skx_uncore_iio_freerunning_format_group = {
+	.name = "format",
+	.attrs = skx_uncore_iio_freerunning_formats_attr,
+};
+
+static struct intel_uncore_type skx_uncore_iio_free_running = {
+	.name			= "iio_free_running",
+	.num_counters		= 17,
+	.num_boxes		= 6,
+	.num_freerunning_types	= SKX_IIO_FREERUNNING_TYPE_MAX,
+	.freerunning		= skx_iio_freerunning,
+	.ops			= &skx_uncore_iio_freerunning_ops,
+	.event_descs		= skx_uncore_iio_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
 static struct attribute *skx_uncore_formats_attr[] = {
 	&format_attr_event.attr,
 	&format_attr_umask.attr,
@@ -3557,6 +3638,7 @@ static struct intel_uncore_type *skx_msr_uncores[] = {
 	&skx_uncore_ubox,
 	&skx_uncore_chabox,
 	&skx_uncore_iio,
+	&skx_uncore_iio_free_running,
 	&skx_uncore_irp,
 	&skx_uncore_pcu,
 	NULL,
-- 
2.7.4

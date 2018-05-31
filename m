Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755141AbeEaMdA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:33:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755039AbeEaMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:32:56 -0400
Date: Thu, 31 May 2018 05:32:36 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-0f519f0352e37e7d71bdce5559517c74a35f6e33@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org, hpa@zytor.com,
        tglx@linutronix.de, kan.liang@intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, kan.liang@intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1525371913-10597-6-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-6-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Support IIO free-running
 counters on SKX
Git-Commit-ID: 0f519f0352e37e7d71bdce5559517c74a35f6e33
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0f519f0352e37e7d71bdce5559517c74a35f6e33
Gitweb:     https://git.kernel.org/tip/0f519f0352e37e7d71bdce5559517c74a35f6e33
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 3 May 2018 11:25:11 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 31 May 2018 12:36:28 +0200

perf/x86/intel/uncore: Support IIO free-running counters on SKX

As of Skylake Server, there are a number of free running counters in
each IIO Box that collect counts of per-box IO clocks and per-port
Input/Output x BW/Utilization.

The free running counters cannot be part of the existing IIO BOX,
because, quoting from Peter Zijlstra:

  "This will result in some (probably) unexpected scheduling artifacts.
   Probably the only way to really cure that is to have the free running
   counters in their own PMU and not share with the GP counters of this
   box."

So let's add a new PMU for the free running counters, as suggested.

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: http://lkml.kernel.org/r/1525371913-10597-6-git-send-email-kan.liang@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 82 ++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 77076a102e34..87dc0263a2e1 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3522,6 +3522,87 @@ static struct intel_uncore_type skx_uncore_iio = {
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
@@ -3595,6 +3676,7 @@ static struct intel_uncore_type *skx_msr_uncores[] = {
 	&skx_uncore_ubox,
 	&skx_uncore_chabox,
 	&skx_uncore_iio,
+	&skx_uncore_iio_free_running,
 	&skx_uncore_irp,
 	&skx_uncore_pcu,
 	NULL,

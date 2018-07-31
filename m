Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E904F208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E904F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeGaHoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:44:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeGaHoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:44:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6V63nvN2594685
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 23:03:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6V63nGm2594682;
        Mon, 30 Jul 2018 23:03:49 -0700
Date:   Mon, 30 Jul 2018 23:03:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-156c8b58ef5cfd97245928c95669fd4cb0f9c388@git.kernel.org>
Cc:     torvalds@linux-foundation.org, vincent.weaver@maine.edu,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        m.mizuma@jp.fujitsu.com, peterz@infradead.org, acme@redhat.com,
        mingo@kernel.org, kan.liang@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: kan.liang@linux.intel.com, mingo@kernel.org, acme@redhat.com,
          peterz@infradead.org, eranian@google.com, tglx@linutronix.de,
          jolsa@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
          torvalds@linux-foundation.org, m.mizuma@jp.fujitsu.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1532953688-15008-1-git-send-email-kan.liang@linux.intel.com>
References: <1532953688-15008-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/uncore: Fix hardcoded index of
 Broadwell extra PCI devices
Git-Commit-ID: 156c8b58ef5cfd97245928c95669fd4cb0f9c388
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  156c8b58ef5cfd97245928c95669fd4cb0f9c388
Gitweb:     https://git.kernel.org/tip/156c8b58ef5cfd97245928c95669fd4cb0f9c388
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 30 Jul 2018 08:28:08 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 31 Jul 2018 07:43:37 +0200

perf/x86/intel/uncore: Fix hardcoded index of Broadwell extra PCI devices

Masayoshi Mizuma reported that a warning message is shown while a CPU is
hot-removed on Broadwell servers:

  WARNING: CPU: 126 PID: 6 at arch/x86/events/intel/uncore.c:988
  uncore_pci_remove+0x10b/0x150
  Call Trace:
   pci_device_remove+0x42/0xd0
   device_release_driver_internal+0x148/0x220
   pci_stop_bus_device+0x76/0xa0
   pci_stop_root_bus+0x44/0x60
   acpi_pci_root_remove+0x1f/0x80
   acpi_bus_trim+0x57/0x90
   acpi_bus_trim+0x2e/0x90
   acpi_device_hotplug+0x2bc/0x4b0
   acpi_hotplug_work_fn+0x1a/0x30
   process_one_work+0x174/0x3a0
   worker_thread+0x4c/0x3d0
   kthread+0xf8/0x130

This bug was introduced by:

  commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for Broadwell CPUs")

The index of "QPI Port 2 filter" was hardcode to 2, but this conflicts with the
index of "PCU.3" which is "HSWEP_PCI_PCU_3", which equals to 2 as well.

To fix the conflict, the hardcoded index needs to be cleaned up:

 - introduce a new enumerator "BDX_PCI_QPI_PORT2_FILTER" for "QPI Port 2
   filter" on Broadwell,
 - increase UNCORE_EXTRA_PCI_DEV_MAX by one,
 - clean up the hardcoded index.

Debugged-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Reported-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: msys.mizuma@gmail.com
Cc: stable@vger.kernel.org
Fixes: 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for Broadwell CPUs")
Link: http://lkml.kernel.org/r/1532953688-15008-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.h       |  2 +-
 arch/x86/events/intel/uncore_snbep.c | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c9e1e0bef3c3..e17ab885b1e9 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -28,7 +28,7 @@
 #define UNCORE_PCI_DEV_TYPE(data)	((data >> 8) & 0xff)
 #define UNCORE_PCI_DEV_IDX(data)	(data & 0xff)
 #define UNCORE_EXTRA_PCI_DEV		0xff
-#define UNCORE_EXTRA_PCI_DEV_MAX	3
+#define UNCORE_EXTRA_PCI_DEV_MAX	4
 
 #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 87dc0263a2e1..51d7c117e3c7 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1029,6 +1029,7 @@ void snbep_uncore_cpu_init(void)
 enum {
 	SNBEP_PCI_QPI_PORT0_FILTER,
 	SNBEP_PCI_QPI_PORT1_FILTER,
+	BDX_PCI_QPI_PORT2_FILTER,
 	HSWEP_PCI_PCU_3,
 };
 
@@ -3286,15 +3287,18 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
 	},
 	{ /* QPI Port 0 filter  */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f86),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 0),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   SNBEP_PCI_QPI_PORT0_FILTER),
 	},
 	{ /* QPI Port 1 filter  */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f96),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 1),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   SNBEP_PCI_QPI_PORT1_FILTER),
 	},
 	{ /* QPI Port 2 filter  */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   BDX_PCI_QPI_PORT2_FILTER),
 	},
 	{ /* PCU.3 (for Capability registers) */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),

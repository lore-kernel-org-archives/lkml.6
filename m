Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeCTLST (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:18:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeCTLSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:18:17 -0400
Date: Tue, 20 Mar 2018 04:17:37 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-320b0651f32b830add6497fcdcfdcb6ae8c7b8a0@git.kernel.org>
Cc: gary.kroening@hpe.com, acme@redhat.com, vincent.weaver@maine.edu,
        eranian@google.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, torvalds@linux-foundation.org, peterz@infradead.org,
        kan.liang@linux.intel.com, mingo@kernel.org, andy.shevchenko@gmail.com,
        hpa@zytor.com, alexander.shishkin@linux.intel.com
Reply-To: vincent.weaver@maine.edu, acme@redhat.com, eranian@google.com,
        gary.kroening@hpe.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, peterz@infradead.org,
        kan.liang@linux.intel.com, torvalds@linux-foundation.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        andy.shevchenko@gmail.com, mingo@kernel.org
In-Reply-To: <1520967094-13219-1-git-send-email-kan.liang@linux.intel.com>
References: <1520967094-13219-1-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/uncore: Fix multi-domain PCI CHA
 enumeration bug on Skylake servers
Git-Commit-ID: 320b0651f32b830add6497fcdcfdcb6ae8c7b8a0
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

Commit-ID:  320b0651f32b830add6497fcdcfdcb6ae8c7b8a0
Gitweb:     https://git.kernel.org/tip/320b0651f32b830add6497fcdcfdcb6ae8c7b8a0
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 13 Mar 2018 11:51:34 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:58:47 +0100

perf/x86/intel/uncore: Fix multi-domain PCI CHA enumeration bug on Skylake servers

The number of CHAs is miscalculated on multi-domain PCI Skylake server systems,
resulting in an uncore driver initialization error.

Gary Kroening explains:

 "For systems with a single PCI segment, it is sufficient to look for the
  bus number to change in order to determine that all of the CHa's have
  been counted for a single socket.

  However, for multi PCI segment systems, each socket is given a new
  segment and the bus number does NOT change.  So looking only for the
  bus number to change ends up counting all of the CHa's on all sockets
  in the system.  This leads to writing CPU MSRs beyond a valid range and
  causes an error in ivbep_uncore_msr_init_box()."

To fix this bug, query the number of CHAs from the CAPID6 register:
it should read bits 27:0 in the CAPID6 register located at
Device 30, Function 3, Offset 0x9C. These 28 bits form a bit vector
of available LLC slices and the CHAs that manage those slices.

Reported-by: Kroening, Gary <gary.kroening@hpe.com>
Tested-by: Kroening, Gary <gary.kroening@hpe.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: abanman@hpe.com
Cc: dimitri.sivanich@hpe.com
Cc: hpa@zytor.com
Cc: mike.travis@hpe.com
Cc: russ.anderson@hpe.com
Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Link: http://lkml.kernel.org/r/1520967094-13219-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 0876798f2ac9..c98b943e58b4 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3563,24 +3563,27 @@ static struct intel_uncore_type *skx_msr_uncores[] = {
 	NULL,
 };
 
+/*
+ * To determine the number of CHAs, it should read bits 27:0 in the CAPID6
+ * register which located at Device 30, Function 3, Offset 0x9C. PCI ID 0x2083.
+ */
+#define SKX_CAPID6		0x9c
+#define SKX_CHA_BIT_MASK	GENMASK(27, 0)
+
 static int skx_count_chabox(void)
 {
-	struct pci_dev *chabox_dev = NULL;
-	int bus, count = 0;
+	struct pci_dev *dev = NULL;
+	u32 val = 0;
 
-	while (1) {
-		chabox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x208d, chabox_dev);
-		if (!chabox_dev)
-			break;
-		if (count == 0)
-			bus = chabox_dev->bus->number;
-		if (bus != chabox_dev->bus->number)
-			break;
-		count++;
-	}
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x2083, dev);
+	if (!dev)
+		goto out;
 
-	pci_dev_put(chabox_dev);
-	return count;
+	pci_read_config_dword(dev, SKX_CAPID6, &val);
+	val &= SKX_CHA_BIT_MASK;
+out:
+	pci_dev_put(dev);
+	return hweight32(val);
 }
 
 void skx_uncore_cpu_init(void)

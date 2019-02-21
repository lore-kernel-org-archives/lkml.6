Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C191C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E96D2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfBUBSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:18:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:44834 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfBUBSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:18:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 17:18:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,393,1544515200"; 
   d="scan'208";a="126016849"
Received: from aubrey-skl.sh.intel.com ([10.239.53.19])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2019 17:18:03 -0800
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v12 3/3] Documentation/filesystems/proc.txt: add AVX512_elapsed_ms
Date:   Thu, 21 Feb 2019 09:17:41 +0800
Message-Id: <20190221011741.97070-3-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221011741.97070-1-aubrey.li@linux.intel.com>
References: <20190221011741.97070-1-aubrey.li@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added AVX512_elapsed_ms in /proc/<pid>/status. Report it
in Documentation/filesystems/proc.txt

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 Documentation/filesystems/proc.txt | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..425f2f09c9aa 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -45,6 +45,7 @@ Table of Contents
   3.9   /proc/<pid>/map_files - Information about memory mapped files
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
+  3.12	/proc/<pid>/AVX512_elapsed_ms - time elapsed since last AVX512 use
 
   4	Configuring procfs
   4.1	Mount options
@@ -207,6 +208,7 @@ read the file /proc/PID/status:
   Speculation_Store_Bypass:       thread vulnerable
   voluntary_ctxt_switches:        0
   nonvoluntary_ctxt_switches:     1
+  AVX512_elapsed_ms:	8
 
 This shows you nearly the same information you would get if you viewed it with
 the ps  command.  In  fact,  ps  uses  the  proc  file  system  to  obtain its
@@ -224,7 +226,7 @@ asynchronous manner and the value may not be very precise. To see a precise
 snapshot of a moment, you can see /proc/<pid>/smaps file and scan page table.
 It's slow but very precise.
 
-Table 1-2: Contents of the status files (as of 4.19)
+Table 1-2: Contents of the status files (as of 5.1)
 ..............................................................................
  Field                       Content
  Name                        filename of the executable
@@ -289,6 +291,7 @@ Table 1-2: Contents of the status files (as of 4.19)
  Mems_allowed_list           Same as previous, but in "list format"
  voluntary_ctxt_switches     number of voluntary context switches
  nonvoluntary_ctxt_switches  number of non voluntary context switches
+ AVX512_elapsed_ms           time elapsed since last AVX512 use in millisecond
 ..............................................................................
 
 Table 1-3: Contents of the statm files (as of 2.6.8-rc3)
@@ -1948,6 +1951,29 @@ patched.  If the patch is being enabled, then the task has already been
 patched.  If the patch is being disabled, then the task hasn't been
 unpatched yet.
 
+3.12	/proc/<pid>/AVX512_elapsed_ms - time elapsed since last AVX512 use
+--------------------------------------------------------------------------
+If AVX512 is supported on the machine, this file displays time elapsed since
+last AVX512 usage of the task in millisecond.
+
+The per-task AVX512 usage tracking mechanism is added during context switch.
+When the task is scheduled out, the AVX512 timestamp of the task is tagged
+by jiffies if AVX512 usage is detected.
+
+When this interface is queried, AVX512_elapsed_ms is calculated as follows:
+
+	delta = (long)(jiffies_now - AVX512_timestamp);
+	AVX512_elpased_ms = jiffies_to_msecs(delta);
+
+Because this tracking mechanism depends on context switch, the number of
+AVX512_elapsed_ms could be inaccurate if the AVX512 using task runs alone on
+a CPU and not scheduled out for a long time. An extreme experiment shows a
+task is spinning on the AVX512 ops on an isolated CPU, but the longest elapsed
+time is close to 4 seconds(HZ = 250).
+
+So 5s or even longer is an appropriate threshold for the job scheduler to poll
+and decide if the task should be classifed as an AVX512 task and migrated
+away from the core on which a Non-AVX512 task is running.
 
 ------------------------------------------------------------------------------
 Configuring procfs
-- 
2.17.1


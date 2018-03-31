Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeCaKUE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 06:20:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46233 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeCaKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 06:20:02 -0400
Date: Sat, 31 Mar 2018 03:19:36 -0700
From: tip-bot for Harry Pan <tipbot@zytor.com>
Message-ID: <tip-1159e09476536250c2a0173d4298d15114df7a89@git.kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, bleung@chromium.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, puthik@chromium.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, vincent.weaver@maine.edu, harry.pan@intel.com,
        hpa@zytor.com
Reply-To: vincent.weaver@maine.edu, hpa@zytor.com, harry.pan@intel.com,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, puthik@chromium.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, acme@redhat.com, bleung@chromium.org
In-Reply-To: <20180309121549.630-3-harry.pan@intel.com>
References: <20180309121549.630-3-harry.pan@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Enable C-state residency events for
 Cannon Lake
Git-Commit-ID: 1159e09476536250c2a0173d4298d15114df7a89
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

Commit-ID:  1159e09476536250c2a0173d4298d15114df7a89
Gitweb:     https://git.kernel.org/tip/1159e09476536250c2a0173d4298d15114df7a89
Author:     Harry Pan <harry.pan@intel.com>
AuthorDate: Fri, 9 Mar 2018 20:15:48 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 31 Mar 2018 11:28:36 +0200

perf/x86/intel: Enable C-state residency events for Cannon Lake

Cannon Lake supports C1/C3/C6/C7, PC2/PC3/PC6/PC7/PC8/PC9/PC10
state residency counters, this patch enables those counters.

( The MSR information is based on Intel Software Developers' Manual,
  Vol. 4, Order No. 335592. )

Tested-by: Puthikorn Voravootivat <puthik@chromium.org>
Signed-off-by: Harry Pan <harry.pan@intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan.liang@intel.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: gs0622@gmail.com
Link: http://lkml.kernel.org/r/20180309121549.630-3-harry.pan@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/cstate.c | 44 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 72db0664a53d..9aca448bb8e6 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,50 +40,51 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM
+ *			 Available model: SLM,AMT,GLM,CNL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
- *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM
+ *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
+						CNL
  *			       Scope: Core
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
- *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM
+ *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
+ *						SKL,KNL,GLM,CNL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
- *			       Available model: SNB,IVB,HSW,BDW,SKL
+ *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
- *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM
+ *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
- *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL
- *						GLM
+ *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
+ *						GLM,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM
+ *						SKL,KNL,GLM,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
- *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL
+ *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT only
+ *			       Available model: HSW ULT,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT only
+ *			       Available model: HSW ULT,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT, GLM
+ *			       Available model: HSW ULT,GLM,CNL
  *			       Scope: Package (physical package)
  *
  */
@@ -486,6 +487,21 @@ static const struct cstate_model hswult_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model cnl_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C3_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES) |
+				  BIT(PERF_CSTATE_CORE_C7_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C3_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES) |
+				  BIT(PERF_CSTATE_PKG_C7_RES) |
+				  BIT(PERF_CSTATE_PKG_C8_RES) |
+				  BIT(PERF_CSTATE_PKG_C9_RES) |
+				  BIT(PERF_CSTATE_PKG_C10_RES),
+};
+
 static const struct cstate_model slm_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -557,6 +573,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, snb_cstates),
 
+	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
+
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
 

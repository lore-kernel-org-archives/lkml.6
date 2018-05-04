Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeEDRkE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:40:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57390 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeEDRj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:39:59 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        will.deacon@arm.com
Subject: [PATCH 3/6] arm64: use <linux/atomic.h> for cmpxchg
Date: Fri,  4 May 2018 18:39:34 +0100
Message-Id: <20180504173937.25300-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504173937.25300-1-mark.rutland@arm.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a number of arm64-specific files include <asm/cmpxchg.h> for
the definition of the cmpxchg helpers. This works fine today, but won't
when we switch over to instrumented atomics, and as noted in
Documentation/core-api/atomic_ops.rst:

  If someone wants to use xchg(), cmpxchg() and their variants,
  linux/atomic.h should be included rather than asm/cmpxchg.h, unless
  the code is in arch/* and can take care of itself.

... so let's switch to <linux/atomic.h> for these definitions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h     | 2 +-
 arch/arm64/include/asm/sync_bitops.h | 2 +-
 arch/arm64/mm/fault.c                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7c4c8f318ba9..c797c0fbbce2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -39,8 +39,8 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/cmpxchg.h>
 #include <asm/fixmap.h>
+#include <linux/atomic.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
diff --git a/arch/arm64/include/asm/sync_bitops.h b/arch/arm64/include/asm/sync_bitops.h
index eee31a9f72a5..24ed8f445b8b 100644
--- a/arch/arm64/include/asm/sync_bitops.h
+++ b/arch/arm64/include/asm/sync_bitops.h
@@ -3,7 +3,7 @@
 #define __ASM_SYNC_BITOPS_H__
 
 #include <asm/bitops.h>
-#include <asm/cmpxchg.h>
+#include <linux/atomic.h>
 
 /* sync_bitops functions are equivalent to the SMP implementation of the
  * original functions, independently from CONFIG_SMP being defined.
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4165485e8b6e..bfbc695e2ea2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -18,6 +18,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/atomic.h>
 #include <linux/extable.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
@@ -34,7 +35,6 @@
 #include <linux/hugetlb.h>
 
 #include <asm/bug.h>
-#include <asm/cmpxchg.h>
 #include <asm/cpufeature.h>
 #include <asm/exception.h>
 #include <asm/debug-monitors.h>
-- 
2.11.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeC2MXK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:23:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45551 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeC2MXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:23:06 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: [PATCH v8 04/10] jiffies: Introduce USER_TICK_USEC and redefine TICK_USEC
Date: Thu, 29 Mar 2018 14:03:27 +0200
Message-ID: <4774145.lbZZYcCZWE@aspire.rjw.lan>
In-Reply-To: <40092860.XNQZrLjKDd@aspire.rjw.lan>
References: <40092860.XNQZrLjKDd@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] 

Since the subsequent changes will need a TICK_USEC definition
analogous to TICK_NSEC, rename the existing TICK_USEC as
USER_TICK_USEC, update its users and redefine TICK_USEC
accordingly.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v7 -> v8: No changes.

---
 drivers/net/ethernet/sfc/mcdi.c |    2 +-
 include/linux/jiffies.h         |    7 +++++--
 kernel/time/ntp.c               |    2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

Index: linux-pm/include/linux/jiffies.h
===================================================================
--- linux-pm.orig/include/linux/jiffies.h
+++ linux-pm/include/linux/jiffies.h
@@ -62,8 +62,11 @@ extern int register_refined_jiffies(long
 /* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
 #define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
 
-/* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
-#define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
+/* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
+#define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)
+
+/* USER_TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
+#define USER_TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
 
 #ifndef __jiffy_arch_data
 #define __jiffy_arch_data
Index: linux-pm/drivers/net/ethernet/sfc/mcdi.c
===================================================================
--- linux-pm.orig/drivers/net/ethernet/sfc/mcdi.c
+++ linux-pm/drivers/net/ethernet/sfc/mcdi.c
@@ -375,7 +375,7 @@ static int efx_mcdi_poll(struct efx_nic
 	 * because generally mcdi responses are fast. After that, back off
 	 * and poll once a jiffy (approximately)
 	 */
-	spins = TICK_USEC;
+	spins = USER_TICK_USEC;
 	finish = jiffies + MCDI_RPC_TIMEOUT;
 
 	while (1) {
Index: linux-pm/kernel/time/ntp.c
===================================================================
--- linux-pm.orig/kernel/time/ntp.c
+++ linux-pm/kernel/time/ntp.c
@@ -31,7 +31,7 @@
 
 
 /* USER_HZ period (usecs): */
-unsigned long			tick_usec = TICK_USEC;
+unsigned long			tick_usec = USER_TICK_USEC;
 
 /* SHIFTED_HZ period (nsecs): */
 unsigned long			tick_nsec;

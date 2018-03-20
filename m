Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeCTQoP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:44:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48299 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeCTQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:43:45 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFT][PATCH v7 4/8] jiffies: Introduce USER_TICK_USEC and redefine TICK_USEC
Date: Tue, 20 Mar 2018 16:16:28 +0100
Message-ID: <4255295.KFD9yx16PH@aspire.rjw.lan>
In-Reply-To: <2390019.oHdSGtR3EE@aspire.rjw.lan>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since the subsequent changes will need a TICK_USEC definition
analogous to TICK_NSEC, rename the existing TICK_USEC as
USER_TICK_USEC, update its users and redefine TICK_USEC
accordingly.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

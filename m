Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeDTTz7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:55:59 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:49236 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750985AbeDTTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:55:58 -0400
From: Kshitiz Gupta <kshitiz.gupta@ni.com>
To: <jeffrey.t.kirsher@intel.com>, <richardcochran@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kshitiz Gupta <kshitiz.gupta@ni.com>
Subject: [PATCH RFC net-next] igb: adjust SYSTIM register using TIMADJ register
Date: Fri, 20 Apr 2018 14:56:36 -0500
Message-ID: <1524254196-21705-1-git-send-email-kshitiz.gupta@ni.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver adjusts time by reading the current time and then
modifying it before writing to SYSTIM register. This can introduce
inaccuracies in SYSTIM. With a PREEMPT_RT kernel, spinlocks may be
interrupted, which in the existing implementation may lead to increased
time between the read and the write.

Alternatively as per section 7.8.3.2 in the i210 data sheet, this
operation can be done more accurately by using the TIMADJ registers,
but this should only be used for adjustments less than one 8th of the
sync interval. Once this register is written, the software can poll on
TSICR.TADJ to make sure that adjustment operation is completed.

This change implements using TIMADJ registers for adjTime call for
deltas less a configurable threshold. This threshold is exposed as
configurable module parameter. Once the delta is written to the
register, driver polls on TSICR.TADJ register to make sure the
adjustment is finished. For deltas greater than this threshold the
driver reverts back to using the old Read-Modify-Write approach.

Signed-off-by: Kshitiz Gupta <kshitiz.gupta@ni.com>
---

This change does create an oddity in the way the adjument takes place.
For any adjustments greater than the threshold the operation is
"immediate", but for the case where this new approach of TIMADJ is
used it can lead to the driver blocking for 8ns * delta.
There is another approach that could be taken. The driver could write
the TIMADJ and return immediately. Any subsequent could block until the
operation is done or return EINPROGRESS to let the caller know to
retry.
---
 drivers/net/ethernet/intel/igb/e1000_regs.h |  1 +
 drivers/net/ethernet/intel/igb/igb_ptp.c    | 64 ++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_regs.h b/drivers/net/ethernet/intel/igb/e1000_regs.h
index d84afdd..607e0ee 100644
--- a/drivers/net/ethernet/intel/igb/e1000_regs.h
+++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
@@ -100,6 +100,7 @@
 #define E1000_SYSTIML    0x0B600 /* System time register Low - RO */
 #define E1000_SYSTIMH    0x0B604 /* System time register High - RO */
 #define E1000_TIMINCA    0x0B608 /* Increment attributes register - RW */
+#define E1000_TIMADJ     0x0B60C /* Time Adjustment Offset Register - RW */
 #define E1000_TSAUXC     0x0B640 /* Timesync Auxiliary Control register */
 #define E1000_TRGTTIML0  0x0B644 /* Target Time Register 0 Low  - RW */
 #define E1000_TRGTTIMH0  0x0B648 /* Target Time Register 0 High - RW */
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 9714b7f..6e9e0ac 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -76,6 +76,16 @@
 
 static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter);
 
+/* If adjTime is called with delta less that timadj_threshold the driver uses
+ * the TIMADJ register to update the SYSTIM register. This is used only for
+ * deltas which are less than 1/8th of the SYNC interval. Using default value
+ * of 15.6ms, which happens to be 1/8th of the default SYNC interval for
+ * IEEE 802.1AS-2011.
+ */
+static int timadj_threshold = 15625000;
+module_param(timadj_threshold, int, 0644);
+MODULE_PARM_DESC(timadj_threshold, "Threshold under which TIMADJ will be used to update SYSTIM");
+
 /* SYSTIM read access for the 82576 */
 static cycle_t igb_ptp_read_82576(const struct cyclecounter *cc)
 {
@@ -269,18 +279,60 @@ static int igb_ptp_adjtime_i210(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct igb_adapter *igb = container_of(ptp, struct igb_adapter,
 					       ptp_caps);
-	unsigned long flags;
+	unsigned long flags, timeout_us, i, wait_us = 1000;
+	unsigned long clock_interval_ns = 8;
 	struct timespec64 now, then = ns_to_timespec64(delta);
+	struct e1000_hw *hw = &igb->hw;
+	u32 adjust_offset = 0, tsicr = 0;
+	int ret = 0;
 
 	spin_lock_irqsave(&igb->tmreg_lock, flags);
 
-	igb_ptp_read_i210(igb, &now);
-	now = timespec64_add(now, then);
-	igb_ptp_write_i210(igb, (const struct timespec64 *)&now);
+	if (abs(delta) > timadj_threshold) {
+		igb_ptp_read_i210(igb, &now);
+		now = timespec64_add(now, then);
+		igb_ptp_write_i210(igb, (const struct timespec64 *)&now);
+	} else {
+		/* For smaller values based on the threshold set in the module
+		 * parameter adjust SYSTIM registers using TIMADJ registers.
+		 * Following the write access to the TIMADJ register, the
+		 * hardware at every 8ns clock repeats the following two steps:
+		 *
+		 * SYSTIM = SYSTIM + INC_TIME +/- 1 nsec. Add or subtract 1 nsec
+		 * is defined by TIMADJ.Sign ( 0 means Add and 1 means Subtract)
+		 *
+		 * Tadjust = Tadjust - 1 nsec
+		 */
 
-	spin_unlock_irqrestore(&igb->tmreg_lock, flags);
+		/* TIMADJ is one's complement, set the magnitude and sign */
+		adjust_offset = abs(delta);
+		if (delta < 0)
+			adjust_offset |= ISGN;
 
-	return 0;
+		wr32(E1000_TIMADJ, adjust_offset);
+
+		/* Poll on TSICR.TADJ flag. This is set when hardware completes
+		 * the adjustment based on TIMADJ register.
+		 */
+		timeout_us = timadj_threshold * clock_interval_ns;
+		for (i = 0; i < timeout_us; i += wait_us) {
+			tsicr = rd32(E1000_TSICR);
+
+			if (tsicr & TSINTR_TADJ)
+				break;
+
+			udelay(wait_us);
+		}
+
+		if (i >= timeout_us) {
+			tsicr = rd32(E1000_TSICR);
+			if (!(tsicr & TSINTR_TADJ))
+				ret = -ETIMEDOUT;
+		}
+	}
+
+	spin_unlock_irqrestore(&igb->tmreg_lock, flags);
+	return ret;
 }
 
 static int igb_ptp_gettime_82576(struct ptp_clock_info *ptp,
-- 
1.9.1

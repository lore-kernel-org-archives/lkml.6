Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeCUCIu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:08:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751902AbeCUCIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:08:41 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
Subject: [PATCH 4/4] vfio: ccw: add traceponits for interesting error paths
Date: Wed, 21 Mar 2018 03:08:22 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032102-0008-0000-0000-0000097C4BFC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008713; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01006058; UDB=6.00512229; IPR=6.00785341;
 MB=3.00020153; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-21 02:08:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032102-0009-0000-0000-000046795506
Message-Id: <20180321020822.86255-5-bjsdjshi@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210024
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Add some tracepoints so we can inspect what is not working as is should.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/Makefile         |  1 +
 drivers/s390/cio/vfio_ccw_fsm.c   | 13 ++++++
 drivers/s390/cio/vfio_ccw_trace.h | 86 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h

diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index a070ef0efe65..f230516abb96 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -5,6 +5,7 @@
 
 # The following is required for define_trace.h to find ./trace.h
 CFLAGS_trace.o := -I$(src)
+CFLAGS_vfio_ccw_fsm.o := -I$(src)
 
 obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o isc.o \
 	fcx.o itcw.o crw.o ccwreq.o trace.o ioasm.o
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index c30420c517b1..7ed27f90d741 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -13,6 +13,9 @@
 #include "ioasm.h"
 #include "vfio_ccw_private.h"
 
+#define CREATE_TRACE_POINTS
+#include "vfio_ccw_trace.h"
+
 static int fsm_io_helper(struct vfio_ccw_private *private)
 {
 	struct subchannel *sch;
@@ -105,6 +108,10 @@ static void fsm_disabled_irq(struct vfio_ccw_private *private,
 	 */
 	cio_disable_subchannel(sch);
 }
+inline struct subchannel_id get_schid(struct vfio_ccw_private *p)
+{
+	return p->sch->schid;
+}
 
 /*
  * Deal with the ccw command request from the userspace.
@@ -131,6 +138,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 
 		io_region->ret_code = cp_prefetch(&private->cp);
 		if (io_region->ret_code) {
+			trace_vfio_ccw_cp_prefetch_failed(get_schid(private),
+							  io_region->ret_code);
 			cp_free(&private->cp);
 			goto err_out;
 		}
@@ -138,6 +147,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 		/* Start channel program and wait for I/O interrupt. */
 		io_region->ret_code = fsm_io_helper(private);
 		if (io_region->ret_code) {
+			trace_vfio_ccw_ssch_failed(get_schid(private),
+						   io_region->ret_code);
 			cp_free(&private->cp);
 			goto err_out;
 		}
@@ -145,10 +156,12 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		/* XXX: Handle halt. */
 		io_region->ret_code = -EOPNOTSUPP;
+		trace_vfio_ccw_halt(get_schid(private));
 		goto err_out;
 	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
 		/* XXX: Handle clear. */
 		io_region->ret_code = -EOPNOTSUPP;
+		trace_vfio_ccw_clear(get_schid(private));
 		goto err_out;
 	}
 
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
new file mode 100644
index 000000000000..edd3321cd919
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Tracepoints for vfio_ccw driver
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Halil Pasic <pasic@linux.vnet.ibm.com>
+ */
+
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vfio_ccw
+
+#if !defined(_VFIO_CCW_TRACE_) || defined(TRACE_HEADER_MULTI_READ)
+#define _VFIO_CCW_TRACE_
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(vfio_ccw_cp_prefetch_failed,
+	TP_PROTO(struct subchannel_id schid, int errno),
+	TP_ARGS(schid, errno),
+
+	TP_STRUCT__entry(
+		__field_struct(struct subchannel_id, schid)
+		__field(int, errno)
+	),
+
+	TP_fast_assign(
+		__entry->schid = schid;
+		__entry->errno = errno;
+	),
+
+	TP_printk("(schid 0.%x.%04X) translation failed (errno: %d)",
+		__entry->schid.ssid, __entry->schid.sch_no, __entry->errno)
+);
+
+TRACE_EVENT(vfio_ccw_ssch_failed,
+	TP_PROTO(struct subchannel_id schid, int errno),
+	TP_ARGS(schid, errno),
+
+	TP_STRUCT__entry(
+		__field_struct(struct subchannel_id, schid)
+		__field(int, errno)
+	),
+
+	TP_fast_assign(
+		__entry->schid = schid;
+		__entry->errno = errno;
+	),
+
+	TP_printk("(schid 0.%x.%04X) ssch failed (errno: %d)",
+		__entry->schid.ssid, __entry->schid.sch_no, __entry->errno)
+);
+
+DECLARE_EVENT_CLASS(vfio_ccw_notsupp,
+	TP_PROTO(struct subchannel_id schid),
+	TP_ARGS(schid),
+
+	TP_STRUCT__entry(
+		__field_struct(struct subchannel_id, schid)
+	),
+
+	TP_fast_assign(
+		__entry->schid = schid;
+	),
+
+	TP_printk("(schid 0.%x.%04X) request not supported",
+		__entry->schid.ssid, __entry->schid.sch_no)
+);
+
+DEFINE_EVENT(vfio_ccw_notsupp, vfio_ccw_clear,
+        TP_PROTO(struct subchannel_id schid), TP_ARGS(schid));
+
+DEFINE_EVENT(vfio_ccw_notsupp, vfio_ccw_halt,
+	TP_PROTO(struct subchannel_id schid), TP_ARGS(schid));
+
+#endif /* _VFIO_CCW_TRACE_ */
+
+/* This part must be outside protection */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE vfio_ccw_trace
+
+#include <trace/define_trace.h>
-- 
2.13.5

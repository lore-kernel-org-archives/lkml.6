Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeBJDtn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 22:49:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751277AbeBJDtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 22:49:39 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
        hbabu@us.ibm.com, linuxppc-dev@ozlabs.org,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] powerpc/vas: Add a couple of trace points
Date: Fri,  9 Feb 2018 19:49:27 -0800
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021003-0040-0000-0000-000003F1910D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008507; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000251; SDB=6.00987497; UDB=6.00501244; IPR=6.00766855;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019472; XFM=3.00000015;
 UTC=2018-02-10 03:49:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021003-0041-0000-0000-000007E706E5
Message-Id: <1518234567-24869-4-git-send-email-sukadev@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802100047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of trace points in the VAS driver

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog [v2]
	- Make TRACE_INCLUDE_PATH relative to <trace/define_trace.h>
---
 arch/powerpc/platforms/powernv/vas-trace.h  | 112 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas-window.c |   9 +++
 2 files changed, 121 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/vas-trace.h

diff --git a/arch/powerpc/platforms/powernv/vas-trace.h b/arch/powerpc/platforms/powernv/vas-trace.h
new file mode 100644
index 0000000..939d85d
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas-trace.h
@@ -0,0 +1,112 @@
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	vas
+
+#if !defined(_VAS_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+
+#define _VAS_TRACE_H
+#include <linux/tracepoint.h>
+#include <linux/sched.h>
+#include <asm/vas.h>
+
+TRACE_EVENT(	vas_rx_win_open,
+
+		TP_PROTO(struct task_struct *tsk,
+			 int vasid,
+			 int cop,
+			 struct vas_rx_win_attr *rxattr),
+
+		TP_ARGS(tsk, vasid, cop, rxattr),
+
+		TP_STRUCT__entry(
+			__field(struct task_struct *, tsk)
+			__field(int, pid)
+			__field(int, cop)
+			__field(int, vasid)
+			__field(struct vas_rx_win_attr *, rxattr)
+			__field(int, lnotify_lpid)
+			__field(int, lnotify_pid)
+			__field(int, lnotify_tid)
+		),
+
+		TP_fast_assign(
+			__entry->pid = tsk->pid;
+			__entry->vasid = vasid;
+			__entry->cop = cop;
+			__entry->lnotify_lpid = rxattr->lnotify_lpid;
+			__entry->lnotify_pid = rxattr->lnotify_pid;
+			__entry->lnotify_tid = rxattr->lnotify_tid;
+		),
+
+		TP_printk("pid=%d, vasid=%d, cop=%d, lpid=%d, pid=%d, tid=%d",
+			__entry->pid, __entry->vasid, __entry->cop,
+			__entry->lnotify_lpid, __entry->lnotify_pid,
+			__entry->lnotify_tid)
+);
+
+TRACE_EVENT(	vas_tx_win_open,
+
+		TP_PROTO(struct task_struct *tsk,
+			 int vasid,
+			 int cop,
+			 struct vas_tx_win_attr *txattr),
+
+		TP_ARGS(tsk, vasid, cop, txattr),
+
+		TP_STRUCT__entry(
+			__field(struct task_struct *, tsk)
+			__field(int, pid)
+			__field(int, cop)
+			__field(int, vasid)
+			__field(struct vas_tx_win_attr *, txattr)
+			__field(int, lpid)
+			__field(int, pidr)
+		),
+
+		TP_fast_assign(
+			__entry->pid = tsk->pid;
+			__entry->vasid = vasid;
+			__entry->cop = cop;
+			__entry->lpid = txattr->lpid;
+			__entry->pidr = txattr->pidr;
+		),
+
+		TP_printk("pid=%d, vasid=%d, cop=%d, lpid=%d, pidr=%d",
+			__entry->pid, __entry->vasid, __entry->cop,
+			__entry->lpid, __entry->pidr)
+);
+
+TRACE_EVENT(	vas_paste_crb,
+
+		TP_PROTO(struct task_struct *tsk,
+			struct vas_window *win),
+
+		TP_ARGS(tsk, win),
+
+		TP_STRUCT__entry(
+			__field(struct task_struct *, tsk)
+			__field(struct vas_window *, win)
+			__field(int, pid)
+			__field(int, vasid)
+			__field(int, winid)
+			__field(unsigned long, paste_kaddr)
+		),
+
+		TP_fast_assign(
+			__entry->pid = tsk->pid;
+			__entry->vasid = win->vinst->vas_id;
+			__entry->winid = win->winid;
+			__entry->paste_kaddr = (unsigned long)win->paste_kaddr
+		),
+
+		TP_printk("pid=%d, vasid=%d, winid=%d, paste_kaddr=0x%016lx\n",
+			__entry->pid, __entry->vasid, __entry->winid,
+			__entry->paste_kaddr)
+);
+
+#endif /* _VAS_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../arch/powerpc/platforms/powernv
+#define TRACE_INCLUDE_FILE vas-trace
+#include <trace/define_trace.h>
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 2b3eb01..6b2de9e 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -21,6 +21,9 @@
 #include "vas.h"
 #include "copy-paste.h"
 
+#define CREATE_TRACE_POINTS
+#include "vas-trace.h"
+
 /*
  * Compute the paste address region for the window @window using the
  * ->paste_base_addr and ->paste_win_id_shift we got from device tree.
@@ -880,6 +883,8 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 	struct vas_winctx winctx;
 	struct vas_instance *vinst;
 
+	trace_vas_rx_win_open(current, vasid, cop, rxattr);
+
 	if (!rx_win_args_valid(cop, rxattr))
 		return ERR_PTR(-EINVAL);
 
@@ -1008,6 +1013,8 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 	struct vas_winctx winctx;
 	struct vas_instance *vinst;
 
+	trace_vas_tx_win_open(current, vasid, cop, attr);
+
 	if (!tx_win_args_valid(cop, attr))
 		return ERR_PTR(-EINVAL);
 
@@ -1100,6 +1107,8 @@ int vas_paste_crb(struct vas_window *txwin, int offset, bool re)
 	void *addr;
 	uint64_t val;
 
+	trace_vas_paste_crb(current, txwin);
+
 	/*
 	 * Only NX windows are supported for now and hardware assumes
 	 * report-enable flag is set for NX windows. Ensure software
-- 
2.7.4

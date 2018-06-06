Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B954605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeFFIfT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:35:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932590AbeFFIeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:34:19 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 4/7] trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
Date: Wed,  6 Jun 2018 14:03:41 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060608-0016-0000-0000-000001D8A5D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060608-0017-0000-0000-0000322BB0D4
Message-Id: <20180606083344.31320-5-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060098
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rightnow, there can be multiple trace_uprobes with same inode+offset
but internally they all points to same uprobe. To allow user to
specify multiple ref_ctr_offset for single inode+offset combo, core
uprobe logic has to be changed. It's also unlikely to have more than
one reference counter for single uprobe. Restrict it.

Ex,
  # echo "p:sdt_tick/loop2 /home/ravi/tick:0x6e4(0x10036) > uprobe_events
  # echo "p:sdt_tick/loop2_1 /home/ravi/tick:0x6e4(0x10030) >> uprobe_events
  bash: echo: write error: Invalid argument

  # dmesg | tail -1
  trace_kprobe: Reference counter offset mismatch.

One exception to this is when user is trying to replace the old entry
with the new one. We allow this if the new entry does not conflict with
any other existing entry.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/trace/trace_uprobe.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index d5b6ca9..e8914f7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -324,6 +324,34 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 	return 0;
 }
 
+/*
+ * Uprobe with multiple reference counter is not allowed. i.e.
+ * If inode and offset matches, reference counter offset *must*
+ * match as well. Only one exception to this is when we are
+ * replacing old trace_uprobe with new one(same group/event).
+ */
+static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
+{
+	struct trace_uprobe *tmp, *old = NULL;
+	struct inode *new_inode = d_real_inode(new->path.dentry);
+
+	old = find_probe_event(trace_event_name(&new->tp.call),
+				new->tp.call.class->system);
+	if (!new->ref_ctr_offset)
+		return old;
+
+	list_for_each_entry(tmp, &uprobe_list, list) {
+		if (new_inode == d_real_inode(tmp->path.dentry) &&
+		    new->offset == tmp->offset &&
+		    new->ref_ctr_offset != tmp->ref_ctr_offset &&
+		    tmp != old) {
+			pr_warn("Reference counter offset mismatch.");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+	return old;
+}
+
 /* Register a trace_uprobe and probe_event */
 static int register_trace_uprobe(struct trace_uprobe *tu)
 {
@@ -333,8 +361,12 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	mutex_lock(&uprobe_lock);
 
 	/* register as an event */
-	old_tu = find_probe_event(trace_event_name(&tu->tp.call),
-			tu->tp.call.class->system);
+	old_tu = find_old_trace_uprobe(tu);
+	if (IS_ERR(old_tu)) {
+		ret = PTR_ERR(old_tu);
+		goto end;
+	}
+
 	if (old_tu) {
 		/* delete old event */
 		ret = unregister_trace_uprobe(old_tu);
-- 
1.8.3.1

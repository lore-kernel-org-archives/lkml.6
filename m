Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754025AbeDWDNF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:13:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753909AbeDWDM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:12:59 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 1/6] torture: Add a script to edit output from failed runs
Date: Sun, 22 Apr 2018 20:14:00 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423031346.GA28371@linux.vnet.ibm.com>
References: <20180423031346.GA28371@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0040-0000-0000-0000042074D8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021902; UDB=6.00521544; IPR=6.00801137;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:12:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0041-0000-0000-000008267E52
Message-Id: <1524453245-29299-1-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230033
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a script that allows viewing the build and/or
console output from failed rcutorture, locktorture, or rcuperf runs.
This replaces a time-honored but inefficient manual procedure that uses
cut and paste.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../selftests/rcutorture/bin/kvm-find-errors.sh    | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
new file mode 100755
index 000000000000..7742fac44781
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Invoke a text editor on all console.log files for all runs with diagnostics,
+# that is, on all such files having a console.log.diags counterpart.
+# Note that both console.log.diags and console.log are passed to the
+# editor (currently defaulting to "vi"), allowing the user to get an
+# idea of what to search for in the console.log file.
+#
+# Usage: kvm-find-errors.sh directory
+#
+# The "directory" above should end with the date/time directory, for example,
+# "tools/testing/selftests/rcutorture/res/2018.02.25-14:27:27".
+
+rundir="${1}"
+if test -z "$rundir" -o ! -d "$rundir"
+then
+	echo Usage: $0 directory
+fi
+editor=${EDITOR-vi}
+
+# Find builds with errors
+files=
+for i in ${rundir}/*/Make.out
+do
+	if grep -q "error:" < $i
+	then
+		files="$files $i"
+	fi
+done
+if test -n "$files"
+then
+	$editor $files
+else
+	echo No build errors.
+fi
+if grep -q -e "--buildonly" < ${rundir}/log
+then
+	echo Build-only run, no console logs to check.
+fi
+
+# Find console logs with errors
+files=
+for i in ${rundir}/*/console.log
+do
+	if test -r $i.diags
+	then
+		files="$files $i.diags $i"
+	fi
+done
+if test -n "$files"
+then
+	$editor $files
+else
+	echo No errors in console logs.
+fi
-- 
2.5.2

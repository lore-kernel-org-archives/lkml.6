Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeDWDNY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:13:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754043AbeDWDNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:13:08 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 2/6] torture: Fold parse-torture.sh into parse-console.sh
Date: Sun, 22 Apr 2018 20:14:01 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423031346.GA28371@linux.vnet.ibm.com>
References: <20180423031346.GA28371@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0048-0000-0000-000002618D00
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021902; UDB=6.00521544; IPR=6.00801137;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:12:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0049-0000-0000-000044DF89D7
Message-Id: <1524453245-29299-2-git-send-email-paulmck@linux.vnet.ibm.com>
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

The rcutorture scripting scans the console output twice, once to look
for various sorts of hangs and again to find warnings and panics.
Unfortunately, only the output of the second scan gets written to the
console.log.diags file, which can cause hangs to be overlooked.
This commit therefore folds the parse-torture.sh script (which looks
for hangs) into the parse-console.sh script (which looks for warnings
and panics).  This allows both types of failure information to be
added to console.log.diags, while still reliably removing this file
when it proves to be empty.

This also fixes a long-standing bug where rcuperf log files would
unconditionally complain about a hang.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   4 -
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |   1 -
 .../selftests/rcutorture/bin/parse-console.sh      | 115 ++++++++++++++++++---
 .../selftests/rcutorture/bin/parse-torture.sh      | 105 -------------------
 4 files changed, 102 insertions(+), 123 deletions(-)
 delete mode 100755 tools/testing/selftests/rcutorture/bin/parse-torture.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index f7e988f369dd..c27e97824163 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -48,10 +48,6 @@ do
 				cat $i/Make.oldconfig.err
 			fi
 			parse-build.sh $i/Make.out $configfile
-			if test "$TORTURE_SUITE" != rcuperf
-			then
-				parse-torture.sh $i/console.log $configfile
-			fi
 			parse-console.sh $i/console.log $configfile
 			if test -r $i/Warnings
 			then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 5f8fbb0d7c17..c5b0f94341d9 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -267,5 +267,4 @@ then
 	echo Unknown PID, cannot kill qemu command
 fi
 
-parse-torture.sh $resdir/console.log $title
 parse-console.sh $resdir/console.log $title
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 08aa7d50ae0e..17293436f551 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -24,57 +24,146 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
 
+T=${TMPDIR-/tmp}/parse-console.sh.$$
 file="$1"
 title="$2"
 
+trap 'rm -f $T.seq $T.diags' 0
+
 . functions.sh
 
+# Check for presence and readability of console output file
+if test -f "$file" -a -r "$file"
+then
+	:
+else
+	echo $title unreadable console output file: $file
+	exit 1
+fi
 if grep -Pq '\x00' < $file
 then
 	print_warning Console output contains nul bytes, old qemu still running?
 fi
-egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for' < $file | grep -v 'ODEBUG: ' | grep -v 'Warning: unable to open an initial console' > $1.diags
-if test -s $1.diags
+cat /dev/null > $file.diags
+
+# Check for proper termination, except that rcuperf runs don't indicate this.
+if test "$TORTURE_SUITE" != rcuperf
 then
-	print_warning Assertion failure in $file $title
-	# cat $1.diags
+	# check for abject failure
+
+	if grep -q FAILURE $file || grep -q -e '-torture.*!!!' $file
+	then
+		nerrs=`grep --binary-files=text '!!!' $file |
+		tail -1 |
+		awk '
+		{
+			for (i=NF-8;i<=NF;i++)
+				sum+=$i;
+		}
+		END { print sum }'`
+		print_bug $title FAILURE, $nerrs instances
+		exit
+	fi
+
+	grep --binary-files=text 'torture:.*ver:' $file |
+	egrep --binary-files=text -v '\(null\)|rtc: 000000000* ' |
+	sed -e 's/^(initramfs)[^]]*] //' -e 's/^\[[^]]*] //' |
+	awk '
+	BEGIN	{
+		ver = 0;
+		badseq = 0;
+		}
+
+		{
+		if (!badseq && ($5 + 0 != $5 || $5 <= ver)) {
+			badseqno1 = ver;
+			badseqno2 = $5;
+			badseqnr = NR;
+			badseq = 1;
+		}
+		ver = $5
+		}
+
+	END	{
+		if (badseq) {
+			if (badseqno1 == badseqno2 && badseqno2 == ver)
+				print "GP HANG at " ver " torture stat " badseqnr;
+			else
+				print "BAD SEQ " badseqno1 ":" badseqno2 " last:" ver " version " badseqnr;
+		}
+		}' > $T.seq
+
+	if grep -q SUCCESS $file
+	then
+		if test -s $T.seq
+		then
+			print_warning $title `cat $T.seq`
+			echo "   " $file
+			exit 2
+		fi
+	else
+		if grep -q "_HOTPLUG:" $file
+		then
+			print_warning HOTPLUG FAILURES $title `cat $T.seq`
+			echo "   " $file
+			exit 3
+		fi
+		echo $title no success message, `grep --binary-files=text 'ver:' $file | wc -l` successful version messages
+		if test -s $T.seq
+		then
+			print_warning $title `cat $T.seq`
+		fi
+		exit 2
+	fi
+fi | tee -a $file.diags
+
+egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for' < $file |
+grep -v 'ODEBUG: ' |
+grep -v 'Warning: unable to open an initial console' > $T.diags
+if test -s $T.diags
+then
+	print_warning "Assertion failure in $file $title"
+	# cat $T.diags
 	summary=""
-	n_badness=`grep -c Badness $1`
+	n_badness=`grep -c Badness $file`
 	if test "$n_badness" -ne 0
 	then
 		summary="$summary  Badness: $n_badness"
 	fi
-	n_warn=`grep -v 'Warning: unable to open an initial console' $1 | egrep -c 'WARNING:|Warn'`
+	n_warn=`grep -v 'Warning: unable to open an initial console' $file | egrep -c 'WARNING:|Warn'`
 	if test "$n_warn" -ne 0
 	then
 		summary="$summary  Warnings: $n_warn"
 	fi
-	n_bugs=`egrep -c 'BUG|Oops:' $1`
+	n_bugs=`egrep -c 'BUG|Oops:' $file`
 	if test "$n_bugs" -ne 0
 	then
 		summary="$summary  Bugs: $n_bugs"
 	fi
-	n_calltrace=`grep -c 'Call Trace:' $1`
+	n_calltrace=`grep -c 'Call Trace:' $file`
 	if test "$n_calltrace" -ne 0
 	then
 		summary="$summary  Call Traces: $n_calltrace"
 	fi
-	n_lockdep=`grep -c =========== $1`
+	n_lockdep=`grep -c =========== $file`
 	if test "$n_badness" -ne 0
 	then
 		summary="$summary  lockdep: $n_badness"
 	fi
-	n_stalls=`egrep -c 'detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state' $1`
+	n_stalls=`egrep -c 'detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state' $file`
 	if test "$n_stalls" -ne 0
 	then
 		summary="$summary  Stalls: $n_stalls"
 	fi
-	n_starves=`grep -c 'rcu_.*kthread starved for' $1`
+	n_starves=`grep -c 'rcu_.*kthread starved for' $file`
 	if test "$n_starves" -ne 0
 	then
 		summary="$summary  Starves: $n_starves"
 	fi
 	print_warning Summary: $summary
-else
-	rm $1.diags
+	cat $T.diags >> $file.diags
+fi
+if ! test -s $file.diags
+then
+	rm -f $file.diags
 fi
diff --git a/tools/testing/selftests/rcutorture/bin/parse-torture.sh b/tools/testing/selftests/rcutorture/bin/parse-torture.sh
deleted file mode 100755
index 5987e50cfeb4..000000000000
--- a/tools/testing/selftests/rcutorture/bin/parse-torture.sh
+++ /dev/null
@@ -1,105 +0,0 @@
-#!/bin/bash
-#
-# Check the console output from a torture run for goodness.
-# The "file" is a pathname on the local system, and "title" is
-# a text string for error-message purposes.
-#
-# The file must contain torture output, but can be interspersed
-# with other dmesg text, as in console-log output.
-#
-# Usage: parse-torture.sh file title
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, you can access it online at
-# http://www.gnu.org/licenses/gpl-2.0.html.
-#
-# Copyright (C) IBM Corporation, 2011
-#
-# Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
-
-T=${TMPDIR-/tmp}/parse-torture.sh.$$
-file="$1"
-title="$2"
-
-trap 'rm -f $T.seq' 0
-
-. functions.sh
-
-# check for presence of torture output file.
-
-if test -f "$file" -a -r "$file"
-then
-	:
-else
-	echo $title unreadable torture output file: $file
-	exit 1
-fi
-
-# check for abject failure
-
-if grep -q FAILURE $file || grep -q -e '-torture.*!!!' $file
-then
-	nerrs=`grep --binary-files=text '!!!' $file | tail -1 | awk '{for (i=NF-8;i<=NF;i++) sum+=$i; } END {print sum}'`
-	print_bug $title FAILURE, $nerrs instances
-	echo "   " $url
-	exit
-fi
-
-grep --binary-files=text 'torture:.*ver:' $file | egrep --binary-files=text -v '\(null\)|rtc: 000000000* ' | sed -e 's/^(initramfs)[^]]*] //' -e 's/^\[[^]]*] //' |
-awk '
-BEGIN	{
-	ver = 0;
-	badseq = 0;
-	}
-
-	{
-	if (!badseq && ($5 + 0 != $5 || $5 <= ver)) {
-		badseqno1 = ver;
-		badseqno2 = $5;
-		badseqnr = NR;
-		badseq = 1;
-	}
-	ver = $5
-	}
-
-END	{
-	if (badseq) {
-		if (badseqno1 == badseqno2 && badseqno2 == ver)
-			print "GP HANG at " ver " torture stat " badseqnr;
-		else
-			print "BAD SEQ " badseqno1 ":" badseqno2 " last:" ver " version " badseqnr;
-	}
-	}' > $T.seq
-
-if grep -q SUCCESS $file
-then
-	if test -s $T.seq
-	then
-		print_warning $title $title `cat $T.seq`
-		echo "   " $file
-		exit 2
-	fi
-else
-	if grep -q "_HOTPLUG:" $file
-	then
-		print_warning HOTPLUG FAILURES $title `cat $T.seq`
-		echo "   " $file
-		exit 3
-	fi
-	echo $title no success message, `grep --binary-files=text 'ver:' $file | wc -l` successful version messages
-	if test -s $T.seq
-	then
-		print_warning $title `cat $T.seq`
-	fi
-	exit 2
-fi
-- 
2.5.2

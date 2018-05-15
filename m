Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeEOGbu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:31:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbeEOGbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:31:48 -0400
Date: Mon, 14 May 2018 23:31:15 -0700
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-2fb6ae162f25a9c3bc45663c479a2b15fb69e768@git.kernel.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com,
        hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org
Reply-To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
        hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org
In-Reply-To: <1526340837-12222-9-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-9-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Add scripts to test memory
 model
Git-Commit-ID: 2fb6ae162f25a9c3bc45663c479a2b15fb69e768
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

Commit-ID:  2fb6ae162f25a9c3bc45663c479a2b15fb69e768
Gitweb:     https://git.kernel.org/tip/2fb6ae162f25a9c3bc45663c479a2b15fb69e768
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 14 May 2018 16:33:47 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:17 +0200

tools/memory-model: Add scripts to test memory model

This commit adds a pair of scripts that run the memory model on litmus
tests, checking that the verification result of each litmus test matches
the result flagged in the litmus test itself.  These scripts permit easier
checking of changes to the memory model against preconceived notions.

To run the scripts, go to the tools/memory-model directory and type
"scripts/checkalllitmus.sh".  If all is well, the last line printed will
be "All litmus tests verified as was expected."

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526340837-12222-9-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/litmus-tests/.gitignore   |  1 +
 tools/memory-model/scripts/checkalllitmus.sh | 73 +++++++++++++++++++++++
 tools/memory-model/scripts/checklitmus.sh    | 86 ++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/tools/memory-model/litmus-tests/.gitignore b/tools/memory-model/litmus-tests/.gitignore
new file mode 100644
index 000000000000..6e2ddc54152f
--- /dev/null
+++ b/tools/memory-model/litmus-tests/.gitignore
@@ -0,0 +1 @@
+*.litmus.out
diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
new file mode 100644
index 000000000000..af0aa15ab84e
--- /dev/null
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+#
+# Run herd tests on all .litmus files in the specified directory (which
+# defaults to litmus-tests) and check each file's result against a "Result:"
+# comment within that litmus test.  If the verification result does not
+# match that specified in the litmus test, this script prints an error
+# message prefixed with "^^^".  It also outputs verification results to
+# a file whose name is that of the specified litmus test, but with ".out"
+# appended.
+#
+# Usage:
+#	sh checkalllitmus.sh [ directory ]
+#
+# The LINUX_HERD_OPTIONS environment variable may be used to specify
+# arguments to herd, whose default is defined by the checklitmus.sh script.
+# Thus, one would normally run this in the directory containing the memory
+# model, specifying the pathname of the litmus test to check.
+#
+# This script makes no attempt to run the litmus tests concurrently.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, you can access it online at
+# http://www.gnu.org/licenses/gpl-2.0.html.
+#
+# Copyright IBM Corporation, 2018
+#
+# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+
+litmusdir=${1-litmus-tests}
+if test -d "$litmusdir" -a -r "$litmusdir" -a -x "$litmusdir"
+then
+	:
+else
+	echo ' --- ' error: $litmusdir is not an accessible directory
+	exit 255
+fi
+
+# Find the checklitmus script.  If it is not where we expect it, then
+# assume that the caller has the PATH environment variable set
+# appropriately.
+if test -x scripts/checklitmus.sh
+then
+	clscript=scripts/checklitmus.sh
+else
+	clscript=checklitmus.sh
+fi
+
+# Run the script on all the litmus tests in the specified directory
+ret=0
+for i in litmus-tests/*.litmus
+do
+	if ! $clscript $i
+	then
+		ret=1
+	fi
+done
+if test "$ret" -ne 0
+then
+	echo " ^^^ VERIFICATION MISMATCHES"
+else
+	echo All litmus tests verified as was expected.
+fi
+exit $ret
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
new file mode 100644
index 000000000000..e2e477472844
--- /dev/null
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+#
+# Run a herd test and check the result against a "Result:" comment within
+# the litmus test.  If the verification result does not match that specified
+# in the litmus test, this script prints an error message prefixed with
+# "^^^" and exits with a non-zero status.  It also outputs verification
+# results to a file whose name is that of the specified litmus test, but
+# with ".out" appended.
+#
+# Usage:
+#	sh checklitmus.sh file.litmus
+#
+# The LINUX_HERD_OPTIONS environment variable may be used to specify
+# arguments to herd, which default to "-conf linux-kernel.cfg".  Thus,
+# one would normally run this in the directory containing the memory model,
+# specifying the pathname of the litmus test to check.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, you can access it online at
+# http://www.gnu.org/licenses/gpl-2.0.html.
+#
+# Copyright IBM Corporation, 2018
+#
+# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+
+litmus=$1
+herdoptions=${LINUX_HERD_OPTIONS--conf linux-kernel.cfg}
+
+if test -f "$litmus" -a -r "$litmus"
+then
+	:
+else
+	echo ' --- ' error: \"$litmus\" is not a readable file
+	exit 255
+fi
+if grep -q '^ \* Result: ' $litmus
+then
+	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
+else
+	outcome=specified
+fi
+
+echo Herd options: $herdoptions > $litmus.out
+/usr/bin/time herd7 -o ~/tmp $herdoptions $litmus >> $litmus.out 2>&1
+grep "Herd options:" $litmus.out
+grep '^Observation' $litmus.out
+if grep -q '^Observation' $litmus.out
+then
+	:
+else
+	cat $litmus.out
+	echo ' ^^^ Verification error'
+	echo ' ^^^ Verification error' >> $litmus.out 2>&1
+	exit 255
+fi
+if test "$outcome" = DEADLOCK
+then
+	echo grep 3 and 4
+	if grep '^Observation' $litmus.out | grep -q 'Never 0 0$'
+	then
+		ret=0
+	else
+		echo " ^^^ Unexpected non-$outcome verification"
+		echo " ^^^ Unexpected non-$outcome verification" >> $litmus.out 2>&1
+		ret=1
+	fi
+elif grep '^Observation' $litmus.out | grep -q $outcome || test "$outcome" = Maybe
+then
+	ret=0
+else
+	echo " ^^^ Unexpected non-$outcome verification"
+	echo " ^^^ Unexpected non-$outcome verification" >> $litmus.out 2>&1
+	ret=1
+fi
+tail -2 $litmus.out | head -1
+exit $ret

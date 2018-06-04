Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeFDSsg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:48:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751104AbeFDSsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:48:35 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 1/2] scripts/faddr2line: make the new code listing format optional
Date: Mon,  4 Jun 2018 13:48:31 -0500
Message-Id: <2a5b6cd8203675ed0c2d9d26cdd8684a120256e8.1528137452.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1528137452.git.jpoimboe@redhat.com>
References: <cover.1528137452.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Commit 6870c0165feaa5 ("scripts/faddr2line: show the code context")
radically altered the output format of the faddr2line tool. And while
the new list output format might have merit it broke my vim usage and
was hard to read.

Make the new format optional; using a '--list' argument and attempt to
make the output slightly easier to read by adding a little whitespace to
separate the different files and explicitly mark the line in question.

Cc: Changbin Du <changbin.du@intel.com>
Fixes: 6870c0165feaa5 ("scripts/faddr2line: show the code context")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/faddr2line | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 1876a741087c..a0149db00be7 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -56,7 +56,7 @@ command -v ${SIZE} >/dev/null 2>&1 || die "size isn't installed"
 command -v ${NM} >/dev/null 2>&1 || die "nm isn't installed"
 
 usage() {
-	echo "usage: faddr2line <object file> <func+offset> <func+offset>..." >&2
+	echo "usage: faddr2line [--list] <object file> <func+offset> <func+offset>..." >&2
 	exit 1
 }
 
@@ -166,15 +166,25 @@ __faddr2line() {
 		local file_lines=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
 		[[ -z $file_lines ]] && return
 
+		if [[ $LIST = 0 ]]; then
+			echo "$file_lines" | while read -r line
+			do
+				echo $line
+			done
+			DONE=1;
+			return
+		fi
+
 		# show each line with context
 		echo "$file_lines" | while read -r line
 		do
+			echo
 			echo $line
 			n=$(echo $line | sed 's/.*:\([0-9]\+\).*/\1/g')
 			n1=$[$n-5]
 			n2=$[$n+5]
 			f=$(echo $line | sed 's/.*at \(.\+\):.*/\1/g')
-			awk 'NR>=strtonum("'$n1'") && NR<=strtonum("'$n2'") {printf("%d\t%s\n", NR, $0)}' $f
+			awk 'NR>=strtonum("'$n1'") && NR<=strtonum("'$n2'") { if (NR=='$n') printf(">%d<", NR); else printf(" %d ", NR); printf("\t%s\n", $0)}' $f
 		done
 
 		DONE=1
@@ -185,6 +195,10 @@ __faddr2line() {
 [[ $# -lt 2 ]] && usage
 
 objfile=$1
+
+LIST=0
+[[ "$objfile" == "--list" ]] && LIST=1 && shift && objfile=$1
+
 [[ ! -f $objfile ]] && die "can't find objfile $objfile"
 shift
 
-- 
2.17.0

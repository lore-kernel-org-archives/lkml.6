Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeDWDNw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:13:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753995AbeDWDNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:13:01 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 6/6] torture: Make kvm-find-errors.sh find build warnings
Date: Sun, 22 Apr 2018 20:14:05 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423031346.GA28371@linux.vnet.ibm.com>
References: <20180423031346.GA28371@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0044-0000-0000-000004097539
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021902; UDB=6.00521544; IPR=6.00801137;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:12:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0045-0000-0000-0000083B7E3B
Message-Id: <1524453245-29299-6-git-send-email-paulmck@linux.vnet.ibm.com>
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

Currently, kvm-find-errors.sh looks only for build errors ("error:"),
so this commit makes it also locate build warnings ("warning:").

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 7742fac44781..98f650c9bf54 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -22,9 +22,10 @@ editor=${EDITOR-vi}
 files=
 for i in ${rundir}/*/Make.out
 do
-	if grep -q "error:" < $i
+	if egrep -q "error:|warning:" < $i
 	then
-		files="$files $i"
+		egrep "error:|warning:" < $i > $i.diags
+		files="$files $i.diags $i"
 	fi
 done
 if test -n "$files"
-- 
2.5.2

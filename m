Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeDPQLu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:11:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752662AbeDPQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:45 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 07/17] kokr/doc: READ_ONCE() now implies smp_barrier_depends()
Date: Mon, 16 Apr 2018 09:12:35 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041616-0044-0000-0000-00000404B80B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018801; UDB=6.00519703; IPR=6.00798043;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:11:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0045-0000-0000-00000836BB70
Message-Id: <1523895165-17576-7-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj38.park@gmail.com>

This commit applies an upstream change, commit 40555946447a ("doc:
READ_ONCE() now implies smp_barrier_depends()") to the Korean version
document.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 0a0930ab4156..edef154d77b2 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -255,17 +255,20 @@ CPU 에게 기대할 수 있는 최소한의 보장사항 몇가지가 있습니
  (*) 어떤 CPU 든, 의존성이 존재하는 메모리 액세스들은 해당 CPU 자신에게
      있어서는 순서대로 메모리 시스템에 수행 요청됩니다. 즉, 다음에 대해서:
 
-	Q = READ_ONCE(P); smp_read_barrier_depends(); D = READ_ONCE(*Q);
+	Q = READ_ONCE(P); D = READ_ONCE(*Q);
 
      CPU 는 다음과 같은 메모리 오퍼레이션 시퀀스를 수행 요청합니다:
 
 	Q = LOAD P, D = LOAD *Q
 
-     그리고 그 시퀀스 내에서의 순서는 항상 지켜집니다.  대부분의 시스템에서
-     smp_read_barrier_depends() 는 아무일도 안하지만 DEC Alpha 에서는
-     명시적으로 사용되어야 합니다.  보통의 경우에는 smp_read_barrier_depends()
-     를 직접 사용하는 대신 rcu_dereference() 같은 것들을 사용해야 함을
-     알아두세요.
+     그리고 그 시퀀스 내에서의 순서는 항상 지켜집니다.  하지만, DEC Alpha 에서
+     READ_ONCE() 는 메모리 배리어 명령도 내게 되어 있어서, DEC Alpha CPU 는
+     다음과 같은 메모리 오퍼레이션들을 내놓게 됩니다:
+
+	Q = LOAD P, MEMORY_BARRIER, D = LOAD *Q, MEMORY_BARRIER
+
+     DEC Alpha 에서 수행되든 아니든, READ_ONCE() 는 컴파일러로부터의 악영향
+     또한 제거합니다.
 
  (*) 특정 CPU 내에서 겹치는 영역의 메모리에 행해지는 로드와 스토어 들은 해당
      CPU 안에서는 순서가 바뀌지 않은 것으로 보여집니다.  즉, 다음에 대해서:
-- 
2.5.2

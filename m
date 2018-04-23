Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeDWCTm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:19:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753613AbeDWCTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:19:40 -0400
Date: Sun, 22 Apr 2018 19:20:47 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com
Subject: [PATCH tip/core/rcu 0/3] Parallelize expedited grace periods for
 v4.18
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042302-0048-0000-0000-000002618923
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021884; UDB=6.00521533; IPR=6.00801119;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:19:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0049-0000-0000-000044DF7273
Message-Id: <20180423022047.GA20189@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230024
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series parallelizes grace-period initialization for expedited
grace periods and adds a couple of fixes:

1.	Parallelize expedited grace-period initialization in order to
	reduce the growth of latency with increasing numbers of CPUs.

2.	Updates comments on which locks are to be held to match the
	code, courtesy of Boqun Feng.

3.	Protect all calls to sync_rcu_preempt_exp_done() with the
	corresponding rcu_node structure's ->lock held, courtesy of
	Boqun Feng.

							Thanx, Paul

------------------------------------------------------------------------

 rcu.h      |    1 
 tree.c     |    3 
 tree.h     |   10 ++
 tree_exp.h |  222 ++++++++++++++++++++++++++++++++++++-------------------------
 4 files changed, 148 insertions(+), 88 deletions(-)

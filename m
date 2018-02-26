Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeBZVwB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:52:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751165AbeBZVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:51:58 -0500
Date: Mon, 26 Feb 2018 13:52:19 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: [PATCH tip/core/rcu 0/20] Miscellaneous fixes
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022621-0040-0000-0000-000003FD5BD3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995529; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:51:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0041-0000-0000-000007FE65E2
Message-Id: <20180226215219.GA27379@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides miscellaneous fixes:

1.	Remove unnecessary spinlock in rcu_boot_init_percpu_data(),
	courtesy of Lihao Liang.

2.	Eliminate NO_HZ_FULL_ALL, instead relying on the nohz_full
	kernel boot parameter.

3.	Fix CPU offload boot message when no CPUs are offloaded.

4.	Fix typo in rcutorture documentation, courtesy of Lihao Liang.

5.	Fix typo in the rcu_head structure's comments,courtesy of Lihao
	Liang.

6.	Call touch_nmi_watchdog() while printing stall warnings,
	courtesy of Tejun Heo.

7.	Remove obsolete boost statistics for debugfs.

8-10.	Remove obsolete statistics for debugfs.

11.	More clearly identify grace-period kthread stack dump.

12.	Consolidate rcu.h #ifdefs.

13.	Remove redundant nxttail index macro define, courtesy of
	Liu Changcheng.

14.	Use wrapper for lockdep asserts, courtesy of Matthew Wilcox.

15.	Fix init_rcu_head() comment.

16.	Fix misprint in srcu_funnel_exp_start, courtesy of Ildar Ismagilov.

17.	Add more tracing of expedited grace periods.

18.	Trace expedited GP delays due to transitioning CPUs.

19.	Make expedited RCU CPU selection avoid unnecessary stores.

20.	Create RCU-specific workqueues with rescuers.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/timers/NO_HZ.txt                              |    7 -
 include/linux/rcupdate.h                                    |   10 +
 include/linux/types.h                                       |    2 
 include/trace/events/rcu.h                                  |    4 
 kernel/rcu/rcu.h                                            |   38 ++++--
 kernel/rcu/srcutree.c                                       |   12 --
 kernel/rcu/tree.c                                           |   72 ++++--------
 kernel/rcu/tree.h                                           |   36 ------
 kernel/rcu/tree_exp.h                                       |   38 ++++--
 kernel/rcu/tree_plugin.h                                    |   34 +++--
 kernel/time/Kconfig                                         |   10 -
 kernel/time/tick-sched.c                                    |   22 ---
 tools/testing/selftests/rcutorture/configs/rcu/TASKS03      |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TASKS03.boot |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE04       |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot  |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE07       |    1 
 tools/testing/selftests/rcutorture/doc/rcu-test-image.txt   |    2 
 18 files changed, 128 insertions(+), 166 deletions(-)

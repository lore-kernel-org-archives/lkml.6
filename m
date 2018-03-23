Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeCWPKJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:10:09 -0400
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:44696
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751825AbeCWPKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:10:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com;
Date: Fri, 23 Mar 2018 11:09:59 -0400
From: joe.korty@concurrent-rt.com
To: bigeasy@linutronix.de
Cc: mingo@redhat.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RT] Defer migrate_enable migration while task state !=
 TASK_RUNNING
Message-ID: <20180323150959.GA16131@zipoli.concurrent-rt.com>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: BN6PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:405:2::12) To DM6PR11MB2571.namprd11.prod.outlook.com
 (2603:10b6:5:c6::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4325c7-aab4-421e-4efd-08d590d027c7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2571;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2571;3:bbxzUqdJiDal6JMt6f80EVrj+qI7ETnGD7qd5JRK6IITTSs3YO7aVY9C5Shhmn8gZbCxqWMln5Td+SbgJczUL/pf2B9ju0DFLIZmW8DnlsUagxDUqv8NoWirlfwT0Gj1vrK4TQ07XzvvuS0CZ7SbBDwflBt3bG/hBf+3SkA/94pqRslKrf3OQlEGN65O1Mmk9Raj0ctPVCJe/a9roDqUABg4AnU4GsIfFipNbAdy7Pd/bRUYA+LxN2BtBbGprb34;25:IAOPFnCWxUye2tG3VbjRYAaRZx9BvM/B77iGvam/MPsi85MPXskUFOwQ8Pdq4ezxp7JSvEpNLuQS+lhN11b94qnyiPriE/eoaHK/cTNezPsN9q3WEHeQRD4VB/7CiJRWF8B2TZjbNemFlpMjWPq0nmiVeh+zqtiu2csew/MZ01CqscNtJg0tl/kA8EN30k4SZg02g5c/P4pAyqjT+at5PZH9BakOBMZg8w7O04/Ii0ibg7rwIvCcqqG5+2Akug5z03sGQyfew4L1wHXg/KCC5uXT1HYbOLmRgzVeMReJlHVIRKvJ74A+zyz4STjxW3DGUIxhnIHX4d8KyqA8pWiOFg==;31:5DvjLbdS3l0pzMkctH857mzP6KrFE+0fvH09lgS20DIOKiL3rZTLtketVnmeYqIRjc5Tug6SPhFb4YEDu850zoMJbyuLULy6QStZziJZjX5ATKDjgMlHpzget7KyYVLKPcqPDR9znxU+aA+o6xjtGFOsipw7BbfVxHJYck+nUcnlm0aWnX2BY55jlNCoYHcHXyjWHBO7QsWeiImFbulzax5XOIUv7mT30BW+lAKpWFw=
X-MS-TrafficTypeDiagnostic: DM6PR11MB2571:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2571;20:Jw3DIoOtiBwuQx9tIuhGUaaHyaE0hI4UQom2CP2WsUz/PRbdUMto/UxTc2VGvmYU5rYkbmDARo2JTOakpq4rKya1fMu0l/B7jVHR/re+7M3rwDFCYFna8MO+POz3/bJUMjf/G2Xqegwv5DFQDUC7H0F+jNRx4zLC4ygUsJcOScKroO9tSbETwn4jA2mDn8GKxTIQBumz1kEklH/39o7PtvrEWypyvq/ot/hZHbh/oBIKnS3mO53Ahhh3AvqWVfII+oa2g3p5Fa10nDol+ek6yikd52IaNmSTLaMJ+GHV71OJOsqEVtmHuvfNETk85sP6hR7uWL0D3D66k+VSvgkmEg==;4:mjvEWI4e5ePaH9y/Ock2ibq2Vls1OXRpCSzqDo0AmDEEaN+SoVRMtribKPFR0zAgVOFxmF1XapxPv2Qv7mKh1Cbrjr7+UlGeNoe+oPwU3LAFsVJVvX9Sztk7mbJ/loyXOBrPy6q5uOkVDZq5IP3Vfr/PcAWVxmw9mgWcb0svFHnWvLVfsFZTH8DlSLC9IUAG5OwLdKIql9v8Knv0i+a6RWXegZo5xD96slYHxD4qTmd1iQ2uuO1XSW2riHqP5tDLm2HIIt0wXEHD/8ziD0YT4A==
X-Microsoft-Antispam-PRVS: <DM6PR11MB2571592F9BD20EDE085E917AA0A80@DM6PR11MB2571.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM6PR11MB2571;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2571;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(39380400002)(376002)(366004)(346002)(199004)(189003)(86362001)(72206003)(4326008)(26005)(55016002)(9686003)(3846002)(6116002)(23726003)(69596002)(8676002)(2361001)(81166006)(186003)(33656002)(81156014)(25786009)(2351001)(316002)(97736004)(16526019)(106356001)(8936002)(6666003)(6916009)(66066001)(105586002)(68736007)(47776003)(386003)(53936002)(58126008)(85782001)(1076002)(5660300001)(59450400001)(7696005)(7736002)(16586007)(50466002)(43066004)(305945005)(2906002)(478600001)(52116002)(53416004)(18370500001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2571;H:zipoli.concurrent-rt.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR11MB2571;23:HhVEdKfDMNtfZOv+IlD7mcDx+kvrRGlhHM82kY06v?=
 =?us-ascii?Q?ar0r78wixwL+DdDWHgwITDfq06LvqSa1tJ01Xo/lOw7kh6SLBx5SOP16/rg3?=
 =?us-ascii?Q?/AGXaAXr1mCw3AWFw5fcDuroyh8uyqJfThOf+1ltF0gQeJsBM1K6ITU42tea?=
 =?us-ascii?Q?P133L5PQihIXsPAcOzyZ897GGBgEoNakNbbUbyKVOM3AohYbJfFa5S4PRt+A?=
 =?us-ascii?Q?4YHcwuhuFB5+REzHK3M/bPUe2c/SQAq42QAvsNST3fm2RcXCbKZs1JzPkr6w?=
 =?us-ascii?Q?Nz8XOET9Madf0CFX6rwsRQrHR0bEPnPSZqi+AK4qbXeMBqFuIlwWelus517b?=
 =?us-ascii?Q?lAkszwzMkX448Y3ZD3KNI1E3f+y7ykYPp9fQ5fNmx5qzvD85W5jr0yRuDQGJ?=
 =?us-ascii?Q?/LWmTnmcvKb3ZINWSkkJUwfWyBwo5C2H5a0k/3v9+NBbfuU253IYPU3GVgt4?=
 =?us-ascii?Q?g0tmdOSZRx+IDV5jiaF6Nry3iO/lCzXcAirT5k69GLbeFiY5AqZkoATdCUCf?=
 =?us-ascii?Q?TVDFwDjgWhau2pZ9SCTjMH3XQZPnDZyWPKgEonKpcCxOrde1CRsV5yb382XT?=
 =?us-ascii?Q?wiL6R8UfBLFgdn2yJbfM3VuT7CyiG4h+4a2RKePnAva06eoSZxwgdi6fhI//?=
 =?us-ascii?Q?j14ddbKTuLq8hiUz5PwT0cnig7ZjTbB0Pog2OalXuRpj5q4jb8nizHKsFQpp?=
 =?us-ascii?Q?fHawkb8072R6XCCdd27Ll6z6VSp+jS7l1Ea6Y3ampOvpx07O5SH4ST1kC5w7?=
 =?us-ascii?Q?NjiqYVvnGA8NEKZH/ylkYw7GhALfd8yuWPXVYbC/CRTtLRXqxpRpTePuyd/1?=
 =?us-ascii?Q?APi+aR+EfB9FbOHS9hVfSmcj5GrWbbTUfBCCbl5YsMlqFFssJNDUdxrHCBKF?=
 =?us-ascii?Q?+7TdKU8UlL7uLcM4S02NaPVNKfO/e93Lkua3M2lT3ICWTBgrNzPGVWB37hx9?=
 =?us-ascii?Q?xyYod6+UbrY/KFJtW5OZGGoH0mDaBZfPxqiiwhTIa8FjKG8qbg+xLyI2feP8?=
 =?us-ascii?Q?c2wIY44joNz8dRueZ1ADafNow4X0Fkp0EnYdCTdA9UaWiOKQNHFC3yJmuzXA?=
 =?us-ascii?Q?ha6jWL6pqV4WIaPXPYHdxQ+Txw2zT1ILC02+FHd57iy7jUrxkIdSI3SnSVVt?=
 =?us-ascii?Q?fLoVSq59g+Thhzzx5o0qSZSFXOkd5feiRTYQgtNsdyeBJXsabkkIcOjGnmZd?=
 =?us-ascii?Q?XV59hjAiK3MAjBQ0G2F5A75f+8e4praizejpJHbDjToIB+HMxBzwYXY6fiuZ?=
 =?us-ascii?Q?0AY3Hh3GsqZwEjGtAMPLHN1liOvCk1ut9e5fgHq?=
X-Microsoft-Antispam-Message-Info: Te7sHsxr9+A11DDArDVlEpfel7jScVQSH56Cgl0tQOYMwtx8szSPftNzm91CAy+OfIOcpYKf+1/bCskhBY1Xi6Ly+eKZXDirdgro/B8PpWJc5jFCeXiQMhpRF/pkv4p70ORTFWKOvNGKE0mr2VDvp8Fv7+s0AO8ddrH3P9ly4Z+q6aseN1M2RSnPEZT856Uf
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2571;6:S6ndhOtgTmnGsUUn3zoH9xLby8pdDrDCuMXHE9tNMlbHeE4kLmJ9LslQrATVnabUMUaSVsU3O9HU+tQQGoAD2jxJZGVw2n2IczgImUbAUvZmcP/JRTvMofHVTNKwRSlgXNwlGSGT3CT9bnmRC+EPHNvoxXv4MBwy8G7ospUue0NWUFaFtRsY3Z29jOJZcvazx4ppI8NSg+ZYZzWjeEdOAF3CQkQaNld2kx1lPuCT69WHbXDJWb0vdWdP0HYTG0XdKaC52voLZw74LVIAehFYmL7okRHdRW51hO2MO8J/jC29PURKwFr5TT4hUNffWp1rOKrALFy88VFC0uAEdP8KrIYV9IRgsigCQQbVhNUJthI=;5:yD3vAW6PIyn9XBMfLY+bPuYfJaHCJkBc7eetxemrwEhEU9RTAbnoFtG33PV8eXytJxhCBTSlBCPpsTb++7bXO8mZHdwcXIy5gktNsploVgTSCxhfAIt44+BW8C6LCnAinA+ytbqQHpzKZzE/yhxB6Ve8ZLKZhPhkokFqVMJ40Vs=;24:L9PWgat5OHCJWDImdQUbPElZobKUxX5a37VI+hZAUXYS17El/nTkn/+iokrHUuUFixUlSWScEfv2XLdxmvY6O57F2LcefG+ZZelBO9ryWhE=;7:ZD7MqN4uSX4h8jlJvAzlP1MgkDJpyfr3oWPRxETpZTsQiwqh+iY3nRRR4vZdNZLgmRpUavAl/R1FJEJoMcRz+tnTY94z43sFXBWt4LDq9t1xhplZkIkTtjgXLZmofLTIggZHRpiez7MHFb8HK5YwkRWH3oy5sji8imytlULzSp7Gktlvbe/kd8KmNQ47HndfKzlfRQkWsvKkWQBL4DjrRiwxezW7hxeKCUPrpT4a81TfOYIPLgVdx8w/XuiD3aCQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:10:03.1982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4325c7-aab4-421e-4efd-08d590d027c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2571
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see the below kernel splat in 4.9-rt when I run a test program that
continually changes the affinity of some set of running pids:

   do not call blocking ops when !TASK_RUNNING; state=2 set at ...
      ...
      stop_one_cpu+0x60/0x80
      migrate_enable+0x21f/0x3e0
      rt_spin_unlock+0x2f/0x40
      prepare_to_wait+0x5c/0x80
      ...

The reason is that spin_unlock, write_unlock, and read_unlock call
migrate_enable, and since 4.4-rt, migrate_enable will sleep if it discovers
that a migration is in order.  But sleeping in the unlock services is not
expected by most kernel developers, and where that counts most is in code
sequences like the following:

  set_current_state(TASK_UNINTERRUPIBLE);
  spin_unlock(&s);
  schedule();

Rather than try to fix up such expectations, this patch merely restores
the non-sleeping nature of unlocking by the simple expediate of deferring,
to a future migrate_enable, and actual migration-with-sleep operation,
for as long as migrate_enable sees task state != TASK_RUNNING.  This works
well as the kernel is littered with lock/unlock sequences, so if the
current unlock cannot migrate, another unlock will come along shortly
and it will do the deferred migration for us.

With this patch and a debug harness applied to 4.9.84-rt62, I get the
following results when a set of stress(1) threads have their affinities
randomly changes as fast as possible:

   [  111.331805] 6229(stress): migrate_enable() deferred.
   [  111.332112] 6229(stress): migrate_enable() deferral APPLIED.
   [  111.977399] 6231(stress): migrate_enable() deferred.
   [  111.977833] 6231(stress): migrate_enable() deferral APPLIED.
   [  135.240704] 6231(stress): migrate_enable() deferred.
   [  135.241164] 6231(stress): migrate_enable() deferral APPLIED.
   [  139.734616] 6229(stress): migrate_enable() deferred.
   [  139.736553] 6229(stress): migrate_enable() deferral APPLIED.
   [  156.441660] 6229(stress): migrate_enable() deferred.
   [  156.441709] 6229(stress): migrate_enable() deferral APPLIED.
   [  163.600191] 6231(stress): migrate_enable() deferred.
   [  163.600561] 6231(stress): migrate_enable() deferral APPLIED.
   [  181.593035] 6231(stress): migrate_enable() deferred.
   [  181.593136] 6231(stress): migrate_enable() deferral APPLIED.
   [  198.376387] 6229(stress): migrate_enable() deferred.
   [  198.376591] 6229(stress): migrate_enable() deferral APPLIED.
   [  202.355940] 6231(stress): migrate_enable() deferred.
   [  202.356939] 6231(stress): migrate_enable() deferral APPLIED.
   [  203.773164] 6229(stress): migrate_enable() deferred.
   [  203.773243] 6229(stress): migrate_enable() deferral APPLIED.
   ...

The test sequence used:

   stress --cpu 8 --io 1 --vm 2 &
   ./rotate $(ps -eLotid,comm | fgrep stress | awk '{print $1}')

The test program used:

cat <<EOF >rotate.c
/*
 * rotate.c
 * Randomly and rapidly change the affinity of some set of processes.
 * Does not return.
 * Limitations: Hard coded to use cpus 0-7.  May not work on systems
 * with more than 64 cpus.
 *
 * Usage: rotate pid pid ...
 *
 * Algorithm: In a loop, for each pid given, randomly select 2 of
 * the 8 cpus 37.5% of the time; otherwise, randomly select a
 * single cpu from that same set.
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sched.h>
#include <errno.h>

int pids[100000];
int npids;
int ncpus = 8;

int main(int argc, char **argv)
{
	int pid, cpu, status;
	unsigned long mask = 0;
	int i;

	setbuf(stdout, NULL);

	argc--,argv++;
	npids = argc;
	for(i=0; i<npids; i++) {
		pids[i] = atoi(argv[i]);
		if (!pids[i]) {
			fprintf(stderr, "tid #%d is bad\n", i);
			return 1;
		}
	}

	for(;;) {
		for(i=0; i<npids; i++) {
			cpu = (unsigned long long)rand() * ncpus / RAND_MAX;
			mask = 1U << cpu;
			if (rand() & 0x400) {
				cpu = (unsigned long long)rand() * ncpus / RAND_MAX;
				mask |= 1U << cpu;
			}
			pid = pids[i];
			status = sched_setaffinity(pid, sizeof(mask), (cpu_set_t *)&mask);
			if (status == -1) {
				fprintf(stderr, "sched_setaffinity(%d, 8, %016lx) failed\n", pid, mask);
				perror("sched_setaffinity");
				return 1;
			}
		}
	}
	return 0;
}
EOF

The debug patch used:

cat patches/debug <<EOF
    1	XXXXXXXX--- a/include/linux/sched.h
    2	XXXXXXXX+++ b/include/linux/sched.h
    3	XXXXXXXX@@ -1558,6 +1558,7 @@ struct task_struct {
    4	XXXXXXXX #ifdef CONFIG_PREEMPT_RT_FULL
    5	XXXXXXXX	int migrate_disable;
    6	XXXXXXXX	int migrate_disable_update;
    7	XXXXXXXX+	int migrate_enable_deferred;
    8	XXXXXXXX # ifdef CONFIG_SCHED_DEBUG
    9	XXXXXXXX	int migrate_disable_atomic;
   10	XXXXXXXX # endif
   11	XXXXXXXX--- a/kernel/sched/core.c
   12	XXXXXXXX+++ b/kernel/sched/core.c
   13	XXXXXXXX@@ -3468,6 +3468,12 @@ void migrate_enable(void)
   14	XXXXXXXX		struct rq *rq;
   15	XXXXXXXX		struct rq_flags rf;
   16	XXXXXXXX 
   17	XXXXXXXX+		if (p->migrate_enable_deferred) {
   18	XXXXXXXX+			p->migrate_enable_deferred = 0;
   19	XXXXXXXX+			pr_info("%d(%s): migrate_enable() deferral APPLIED.\n",
   20	XXXXXXXX+				p->pid, p->comm);
   21	XXXXXXXX+		}
   22	XXXXXXXX+
   23	XXXXXXXX		rq = task_rq_lock(p, &rf);
   24	XXXXXXXX		update_rq_clock(rq);
   25	XXXXXXXX 
   26	XXXXXXXX@@ -3499,6 +3505,15 @@ void migrate_enable(void)
   27	XXXXXXXX			tlb_migrate_finish(p->mm);
   28	XXXXXXXX			return;
   29	XXXXXXXX		}
   30	XXXXXXXX+	} else if (p->migrate_disable_update && p->state != TASK_RUNNING) {
   31	XXXXXXXX+		if (p->migrate_enable_deferred)
   32	XXXXXXXX+			pr_info("%d(%s): migrate_enable() deferred (again).\n",
   33	XXXXXXXX+				p->pid, p->comm);
   34	XXXXXXXX+		else {
   35	XXXXXXXX+			pr_info("%d(%s): migrate_enable() deferred.\n",
   36	XXXXXXXX+				p->pid, p->comm);
   37	XXXXXXXX+			p->migrate_enable_deferred = 1;
   38	XXXXXXXX+		}
   39	XXXXXXXX	}
   40	XXXXXXXX 
   41	XXXXXXXX	unpin_current_cpu();
EOF

The rt patch sched-migrate-disable-handle-updated-task-mask-mg-di.patch
appears to have introduced this issue, around the 4.4-rt timeframe.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>

Index: b/kernel/sched/core.c
===================================================================
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3457,7 +3457,14 @@ void migrate_enable(void)
 	 */
 	p->migrate_disable = 0;
 
-	if (p->migrate_disable_update) {
+	/*
+	 * Do not apply affinity update on this migrate_enable if task
+	 * is preparing to go to sleep for some other reason (eg, task
+	 * state == TASK_INTERRUPTIBLE).  Instead defer update to a
+	 * future migate_enable that is called when task state is again
+	 * == TASK_RUNNING.
+	 */
+	if (p->migrate_disable_update && p->state == TASK_RUNNING) {
 		struct rq *rq;
 		struct rq_flags rf;
 

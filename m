Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCBFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37792633D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37792633D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934483AbeFZATG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:19:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754682AbeFZATE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:19:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0J3kg022727
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:19:04 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96r3172-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:19:04 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:18:53 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:18:48 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0Im4i35520690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:18:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98558B206E;
        Mon, 25 Jun 2018 20:18:42 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 826C2B206B;
        Mon, 25 Jun 2018 20:18:42 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:18:42 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F316A16C9E80; Mon, 25 Jun 2018 17:20:52 -0700 (PDT)
Date:   Mon, 25 Jun 2018 17:20:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/22] Grace-period fixes for v4.19
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062600-0040-0000-0000-000004451882
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052332; UDB=6.00539466; IPR=6.00830257;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:18:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0041-0000-0000-0000084B2E2F
Message-Id: <20180626002052.GA24146@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series includes grace-period-related fixes that suppress false-positive
warnings and add forward-progress fixes that would otherwise have resulted
in grace-period hangs when the failsafes were removed.  The reason for
wanting to remove the failsafes is that they result in lock contention,
which needs to be reduced in preparation for consolidation of the three
flavors of RCU into one flavor to rule them all.

1.	Clean up handling of tasks blocked across full-rcu_node offline.

2.	Fix an obsolete ->qsmaskinit comment.

3.	Make rcu_init_new_rnp() stop upon already-set bit.

4.	Make rcu_report_unblock_qs_rnp() warn on violated preconditions.

5.	Fix typo and add additional debug in code warning of task
	blocked on the current grace period before it has started.

6.	Replace smp_wmb() with smp_store_release() for stall check
	in order to improve readability (no change in ordering).

7.	Prevent useless FQS scan after all CPUs have checked in.

8.	Suppress false-positive offline-CPU lockdep-RCU splat.

9.	Suppress false-positive preempted-task splats.

10.	Suppress more involved false-positive preempted-task splats.

11.	Suppress false-positive splats from mid-init task resume.

12.	Fix grace-period hangs from mid-init task resume.  (Well, they
	would be hangs without the failsafes, anyway.)

13.	Fix grace-period hangs due to race with CPU offline.  (Again,
	they would be hangs without the failsafes.)

14.	Add RCU-preempt check for waiting on newly onlined CPU.

15.	Move grace-period pre-init delay after pre-init.

16.	Remove failsafe check for lost quiescent state.

17.	Change units of onoff_interval to jiffies in order to allow more
	intensive testing of CPU-hotplug interactions with RCU.

18.	Remove CPU-hotplug failsafe from force-quiescent-state code path.

19.	Add up-tree information to dump_blkd_tasks() diagnostics.

20.	Add CPU online/offline state to dump_blkd_tasks().

21.	Record ->gp_state for both phases of grace-period initialization.

22.	Add diagnostics for offline CPUs failing to report QS.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt                 |    4 
 include/trace/events/rcu.h                                      |   10 
 kernel/rcu/rcutorture.c                                         |    4 
 kernel/rcu/tree.c                                               |  202 ++++++----
 kernel/rcu/tree.h                                               |   30 +
 kernel/rcu/tree_plugin.h                                        |   51 +-
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot      |    4 
 tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh |    2 
 8 files changed, 203 insertions(+), 104 deletions(-)


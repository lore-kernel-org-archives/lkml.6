Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FBFC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCEE2412C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCEE2412C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934543AbeFZAcw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:32:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934094AbeFZAcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:32:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0Sc7m094191
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:32:51 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96uummp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:32:51 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:32:48 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:32:44 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0Whkl9437600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:32:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5979EB206E;
        Mon, 25 Jun 2018 20:32:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 434EEB2066;
        Mon, 25 Jun 2018 20:32:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:32:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BA69116C9ED2; Mon, 25 Jun 2018 17:34:48 -0700 (PDT)
Date:   Mon, 25 Jun 2018 17:34:48 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/27] Post-gp_seq miscellaneous fixes for v4.19
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062600-0040-0000-0000-00000445288F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052336; UDB=6.00539469; IPR=6.00830262;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:32:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0041-0000-0000-0000084B3E52
Message-Id: <20180626003448.GA26209@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains miscellaneous fixes that are sequenced after the
infamous ->gp_seq conversion:

1.	Make rcu_read_unlock_special() static.

2.	Improve rcu_note_voluntary_context_switch() reporting, courtesy of
	Byungchul Park.

3.	Get rid of Sphinx warnings at rcu_pointer_handoff(), courtesy of
	Mauro Carvalho Chehab.

4.	Use pr_fmt to prefix "rcu: " to logging output, courtesy of
	Joe Perches.

5.	Improve RCU-tasks naming and comments.

6.	Mark task as .need_qs less aggressively.

7-14.	Inline, remove "inline", remove __maybe_unused, remove unused
	variables, remove unused functions, and fix comments.

15.	Use RCU CPU stall timeout for rcu_check_gp_start_stall().

16.	Add comment documenting how rcu_seq_snap() works, courtesy of
	Joel Fernandes.

17.	Speed up calling of RCU tasks callbacks, courtesy of Steven Rostedt.

18.	Add comment to the last sleep in the rcu tasks loop, also courtesy
	of Steven Rostedt.

19.	Add diagnostics for rcutorture writer stall warning.

20.	Check the range of jiffies_till_{first,next}_fqs when setting them,
	courtesy of Byungchul Park.

21.	Update synchronize_rcu() definition in whatisRCU.txt, courtesy
	of Andrea Parri.

22.	Make rcu_seq_diff() more exact, which in turn allows more exact
	rcutorture diagnostics of busted RCU implementations.

23.	Update RCU, SRCU, and TORTURE-TEST entries in MAINTAINERS file.

24.	Print stall-warning NMI dyntick state in hexadecimal.

25.	Add grace-period number to rcutorture statistics printout.

26.	Improve documentation for list_for_each_entry_from_rcu(), courtesy
	of NeilBrown.

27.	Assign higher prio to RCU threads if rcutorture is built-in,
	courtesy of Joel Fernandes.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/whatisRCU.txt |   18 +++--
 MAINTAINERS                     |    9 +-
 include/linux/rculist.h         |   19 +++++
 include/linux/rcupdate.h        |   22 +++---
 include/linux/rcutiny.h         |    2 
 kernel/rcu/rcu.h                |   49 ++++++++++++++
 kernel/rcu/rcuperf.c            |    9 +-
 kernel/rcu/rcutorture.c         |    6 -
 kernel/rcu/srcutree.c           |    8 +-
 kernel/rcu/tiny.c               |    4 -
 kernel/rcu/tree.c               |  132 +++++++++++++++++++++++++---------------
 kernel/rcu/tree.h               |    1 
 kernel/rcu/tree_plugin.h        |   55 ++++++----------
 kernel/rcu/update.c             |   45 +++++++++----
 14 files changed, 245 insertions(+), 134 deletions(-)


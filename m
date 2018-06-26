Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A99C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AEF262ED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AEF262ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934212AbeFZAGp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:06:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932073AbeFZAGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:06:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04jXo029970
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:06:43 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju975aqtb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:06:43 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:06:41 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06bZC15729028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB0FBB2067;
        Mon, 25 Jun 2018 20:06:31 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79626B205F;
        Mon, 25 Jun 2018 20:06:31 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:31 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E368C16CA092; Mon, 25 Jun 2018 17:08:41 -0700 (PDT)
Date:   Mon, 25 Jun 2018 17:08:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/40] RCU ->gp_seq conversion for v4.19
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062600-0072-0000-0000-000003746050
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:06:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0073-0000-0000-0000487C51B3
Message-Id: <20180626000841.GA15696@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=749 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series moves from the two-variable ->gpnum and ->completed to
a single-variable ->gp_seq approach.  The key point is that ->gpnum
and ->completed are either identical or ->gpnum is only one greater,
which means that we are using a full unsigned long were a single bit
would do.  This series therefore applies the pre-existing grace-period
sequence-number code used by expedited grace periods, _rcu_barrier(),
and SRCU.  This change also has the beneficial effect of allowing the
grace-period state to be sampled with a single load, which will be used
to improve the grace-period start code.  The individual commits are
as follows:

1.	Introduce grace-period sequence numbers (->gp_seq) to normal RCU.

2-17.	Make core RCU code use ->gp_seq instead of ->gpnum and ->completed.

18.	Move from ->need_future_gp[] to ->gp_seq_needed, which allows
	simpler grace-period-already-requested checks.

19.	Use the new ->gp_seq_needed to make rcu_nocb_wait_gp() check if
	a given grace has already been requested, thus reducing overhead
	for no-CBs CPUs.

20-26.	Move RCU tracepoints to ->gp_seq.

27.	Remove ->gpnum and ->completed.

28.	Make simple callback acceleration refer to rdp->gp_seq_needed.

29-31.	Update documentation to reflect ->gp_seq.

32.	Don't funnel-lock above the leaf rcu_node structure if a grace period
	is in progress, thus saving an upper-level rcu_node ->lock
	acquisition.

33.	Produce the last CleanupMore trace only if the corresponding
	grace-period request was quite recent, courtesy of Joel Fernandes.

34.	Fix cpustart tracepoint ->gp_seq number, courtesy of Joel Fernandes.

35.	Make rcu_start_this_gp() check for grace period already started.

36.	Correctly handle grace-period sequence (->gp_seq) wrap in
	rcutorture.

37.	Regularize resetting of rcu_data wrap indicator.

38-39.	Rename grace-period-request variables and parameters, courtesy
	of Joel Fernandes.

40.	Check current node rather than leaf node for requested grace
	period already being in progress.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Data-Structures/Data-Structures.html          |  118 -
 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html |   22 
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-cleanup.svg        |  123 -
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-1.svg         |   16 
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-3.svg         |   56 
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg                |  237 +--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg                |   12 
 Documentation/RCU/stallwarn.txt                                        |   24 
 include/trace/events/rcu.h                                             |  114 -
 kernel/rcu/rcu.h                                                       |   70 -
 kernel/rcu/rcuperf.c                                                   |   44 
 kernel/rcu/rcutorture.c                                                |   93 -
 kernel/rcu/srcutree.c                                                  |    5 
 kernel/rcu/tree.c                                                      |  678 ++++------
 kernel/rcu/tree.h                                                      |   40 
 kernel/rcu/tree_plugin.h                                               |   54 
 16 files changed, 832 insertions(+), 874 deletions(-)


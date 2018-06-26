Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2161C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7227B26EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7227B26EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754908AbeFZSBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:01:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751448AbeFZSBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:01:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QHsY3q122552
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:01:05 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juqcps0w7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:01:04 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 14:01:03 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 14:00:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QI0wQT19005926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 18:00:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94273B206B;
        Tue, 26 Jun 2018 14:00:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 739B9B2064;
        Tue, 26 Jun 2018 14:00:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 14:00:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6615316C15BE; Tue, 26 Jun 2018 11:03:03 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:03:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 06/27] rcu: Mark task as .need_qs less
 aggressively
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-6-paulmck@linux.vnet.ibm.com>
 <20180626170812.GH2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626170812.GH2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062618-0060-0000-0000-00000282D2C9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052686; UDB=6.00539679; IPR=6.00830610;
 MB=3.00021865; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 18:01:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062618-0061-0000-0000-0000459572C0
Message-Id: <20180626180303.GD3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:08:12PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 25, 2018 at 05:34:52PM -0700, Paul E. McKenney wrote:
> > If any scheduling-clock interrupt interrupts an RCU-preempt read-side
> > critical section, the interrupted task's ->rcu_read_unlock_special.b.need_qs
> > field is set.  This causes the outermost rcu_read_unlock() to incur the
> > extra overhead of calling into rcu_read_unlock_special().  This commit
> > reduces that overhead by setting ->rcu_read_unlock_special.b.need_qs only
> > if the grace period has been in effect for more than one second.
> 
> Even less agressive is never setting it at all.

True, but if the CPU has been in an RCU read-side critical section for
a full second (which is the case with high probability when .b.need_qs
is set after this change), we might want to respond to the end of that
critical section sooner rather than later.

> Changelog fails to explain why not setting it every tick is correct, nor
> why 1s is a 'safe' value to use.

The RCU CPU stall warning cannot be set to less than 3s, so 1s is
reasonable.  It is a tradeoff -- setting it lower causes a greater
fraction of RCU read-side critical sections to incur extra overhead at
rcu_read_unlock() time, while setting it higher keeps a lazy approach
to reporting the quiescent state to core RCU for longer critical sections.

The upcoming RCU-bh/RCU-preempt/RCU-sched consolidation will raise
contention and overhead, so this is one of several things done to
lower overhead and contention to compensate for that.

							Thanx, Paul


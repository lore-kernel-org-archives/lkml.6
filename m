Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2729ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A7220846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A7220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbeGWMRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:17:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387936AbeGWMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:17:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NBFkp1114139
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:16:30 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdaueyk8a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:16:29 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 23 Jul 2018 12:16:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 12:16:24 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NBGNBh35717248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 11:16:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CFE0A4057;
        Mon, 23 Jul 2018 14:16:39 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E13EEA4051;
        Mon, 23 Jul 2018 14:16:37 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 23 Jul 2018 14:16:37 +0100 (BST)
Date:   Mon, 23 Jul 2018 04:16:22 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 11/19] sched/numa: Restrict migrating in parallel to
 the same node.
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1529514181-9842-12-git-send-email-srikar@linux.vnet.ibm.com>
 <20180723103830.GC2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180723103830.GC2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18072311-0012-0000-0000-0000028D88D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072311-0013-0000-0000-000020BF6413
Message-Id: <20180723111622.GG30345@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-07-23 12:38:30]:

> On Wed, Jun 20, 2018 at 10:32:52PM +0530, Srikar Dronamraju wrote:
> > Since task migration under numa balancing can happen in parallel, more
> > than one task might choose to move to the same node at the same time.
> > This can cause load imbalances at the node level.
> > 
> > The problem is more likely if there are more cores per node or more
> > nodes in system.
> > 
> > Use a per-node variable to indicate if task migration
> > to the node under numa balance is currently active.
> > This per-node variable will not track swapping of tasks.
> 
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 50c7727..87fb20e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1478,11 +1478,22 @@ struct task_numa_env {
> >  static void task_numa_assign(struct task_numa_env *env,
> >  			     struct task_struct *p, long imp)
> >  {
> > +	pg_data_t *pgdat = NODE_DATA(cpu_to_node(env->dst_cpu));
> >  	struct rq *rq = cpu_rq(env->dst_cpu);
> >  
> >  	if (xchg(&rq->numa_migrate_on, 1))
> >  		return;
> >  
> > +	if (!env->best_task && env->best_cpu != -1)
> > +		WRITE_ONCE(pgdat->active_node_migrate, 0);
> > +
> > +	if (!p) {
> > +		if (xchg(&pgdat->active_node_migrate, 1)) {
> > +			WRITE_ONCE(rq->numa_migrate_on, 0);
> > +			return;
> > +		}
> > +	}
> > +
> >  	if (env->best_cpu != -1) {
> >  		rq = cpu_rq(env->best_cpu);
> >  		WRITE_ONCE(rq->numa_migrate_on, 0);
> 
> 
> Urgh, that's prertty magical code. And it doesn't even have a comment.
> 
> For isntance, I cannot tell why we clear that active_node_migrate thing
> right there.
> 

active_node_migrate doesn't track swaps, it only tracks task movement to
a node. Here a task finds a first cpu which is idle.  So it would have
set pgdat->active_node_migrate. Here env->best_task is NULL but
env->best_cpu is set.

Next the task might find another cpu where it finds swap to be
beneficial than a move. i.e there is a pair of tasks to be swapped. Now
we have to reset pgdat->active_node_migrate. The test for best_task and
best_cpu will tell us if we had set active_node_migrate.

-- 
Thanks and Regards
Srikar Dronamraju


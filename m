Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeFED40 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 23:56:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751348AbeFED4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 23:56:25 -0400
Date: Mon, 4 Jun 2018 20:56:16 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Rik van Riel <riel@surriel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 16/19] sched/numa: Detect if node actively handling
 migration
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-17-git-send-email-srikar@linux.vnet.ibm.com>
 <1528142755.7898.122.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1528142755.7898.122.camel@surriel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060503-0008-0000-0000-000002442D4D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060503-0009-0000-0000-000021AA2F3E
Message-Id: <20180605035616.GD30328@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel <riel@surriel.com> [2018-06-04 16:05:55]:

> On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> 
> > @@ -1554,6 +1562,9 @@ static void task_numa_compare(struct
> > task_numa_env *env,
> >  	if (READ_ONCE(dst_rq->numa_migrate_on))
> >  		return;
> >  
> > +	if (*move && READ_ONCE(pgdat->active_node_migrate))
> > +		*move = false;
> 
> Why not do this check in task_numa_find_cpu?
> 
> That way you won't have to pass this in as a
> pointer, and you also will not have to recalculate
> NODE_DATA(cpu_to_node(env->dst_cpu)) for every CPU.
> 

I thought about this. Lets say we evaluated that destination node can
allow movement. While we iterate through the list of cpus trying to find
the best cpu node, we find a idle cpu towards the end of the list.
However if another task as already raced with us to move a task to this
node, then we should bail out. Keeping the check in task_numa_compare
will allow us to do this.

> >  	/*
> > +	 * If the numa importance is less than SMALLIMP,
> 
>               ^^^ numa improvement
> 

okay

> > +	 * task migration might only result in ping pong
> > +	 * of tasks and also hurt performance due to cache
> > +	 * misses.
> > +	 */
> > +	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
> > +		goto unlock;
> 
> I can see a use for the first test, but why limit the
> search for the best score once you are past the
> threshold?
> 
> I don't understand the use for that second test.
> 

Lets say few threads are racing with each other to find a cpu on the
node. The first thread has already found a task/cpu 'A' to swap and
finds another task/cpu 'B' thats slightly better than the current
best_cpu which is 'A'. Currently we allow the second task/cpu 'B' to be
set as best_cpu. However the second or subsequent threads cannot find
the first task/cpu A because its suppose to be in active migration. By
the time it reaches task/cpu B even that may look to be in active
migration. It may never know that task/cpu A was cleared. In this way,
the second and subsequent threads may not get a task/cpu in the
preferred node to swap just because the first task kept hopping task/cpu
as its choice of migration.

While we can't complete avoid this, the second check will try to make
sure we don't hop on/hop off just for small incremental numa
improvement.



> What workload benefits from it?

> 
> -- 
> All Rights Reversed.

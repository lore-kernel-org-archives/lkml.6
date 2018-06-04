Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeFDP42 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:56:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751005AbeFDP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:56:26 -0400
Date: Mon, 4 Jun 2018 08:56:18 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/19] sched/numa: Set preferred_node based on best_cpu
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-5-git-send-email-srikar@linux.vnet.ibm.com>
 <20180604122336.GS12217@hirez.programming.kicks-ass.net>
 <20180604125939.GB38574@linux.vnet.ibm.com>
 <1528123050.7898.99.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1528123050.7898.99.camel@surriel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060415-4275-0000-0000-0000028A0221
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060415-4276-0000-0000-00003791020E
Message-Id: <20180604155618.GC30328@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel <riel@surriel.com> [2018-06-04 10:37:30]:

> On Mon, 2018-06-04 at 05:59 -0700, Srikar Dronamraju wrote:
> > * Peter Zijlstra <peterz@infradead.org> [2018-06-04 14:23:36]:
> > 
> > > > -		if (ng->active_nodes > 1 &&
> > > > numa_is_active_node(env.dst_nid, ng))
> > > > -			sched_setnuma(p, env.dst_nid);
> > > > +		if (nid != p->numa_preferred_nid)
> > > > +			sched_setnuma(p, nid);
> > > >  	}
> > > 
> > 
> > I think checking for active_nodes before calling sched_setnuma was a
> > mistake.
> > 
> > Before this change, we may be retaining numa_preferred_nid to be the
> > source node while we select another node with better numa affinity to
> > run on. 
> 
> Sometimes workloads are so large they get spread
> around to multiple NUMA nodes.
> 
> In that case, you do NOT want all the tasks of
> that workload (numa group) to try squeezing onto
> the same load, only to have the load balancer
> randomly move tasks off of that node again later.
> 
> How do you keep that from happening?

Infact we are exactly doing this now in all cases. We are not changing
anything in the ng->active_node > 1 case. (which is the workload spread
across multiple nodes).

Earlier we would not set the numa_preferred_nid if there is only one
active node. However its not certain that the src node is the active
node. Infact its most likely not going to be src node because we
wouldn't have reached here if the task was running on the source node.
Keeping the numa_preferred_nid as the source node increases the chances
of the regular load balancer randomly moving tasks from the node.  Now
we are making sure task_node(p) and numa_preferred_nid. Hence we would
reduce the risk of moving to a random node.

Hope this is clear.

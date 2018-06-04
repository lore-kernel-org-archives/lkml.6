Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeFDMx2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:53:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752478AbeFDMx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:53:27 -0400
Date: Mon, 4 Jun 2018 05:53:18 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/19] sched/numa: Set preferred_node based on best_cpu
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-5-git-send-email-srikar@linux.vnet.ibm.com>
 <20180604121800.GR12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180604121800.GR12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060412-0020-0000-0000-0000029682BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060412-0021-0000-0000-000020E21809
Message-Id: <20180604125318.GA38574@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-06-04 14:18:00]:

> On Mon, Jun 04, 2018 at 03:30:13PM +0530, Srikar Dronamraju wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ea32a66..94091e6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1725,8 +1725,9 @@ static int task_numa_migrate(struct task_struct *p)
> >  	 * Tasks that are "trapped" in such domains cannot be migrated
> >  	 * elsewhere, so there is no point in (re)trying.
> >  	 */
> > -	if (unlikely(!sd)) {
> > -		p->numa_preferred_nid = task_node(p);
> > +	if (unlikely(!sd) && p->numa_preferred_nid != task_node(p)) {
> > +		/* Set the new preferred node */
> > +		sched_setnuma(p, task_node(p));
> >  		return -EINVAL;
> >  	}
> >  
> 
> That looks dodgy.. this would allow things to continue with !sd.

Okay so are we suggesting something like the below?

if (unlikely(!sd)) {
	/* Set the new preferred node */
	sched_setnuma(p, task_node(p));
  		return -EINVAL;
  	}

The reason for using sched_setnuma was to make sure we account numa
tasks correctly.

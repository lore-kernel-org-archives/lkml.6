Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeFEHYt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:24:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751409AbeFEHYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:24:48 -0400
Date: Tue, 5 Jun 2018 00:24:39 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 13/19] mm/migrate: Use xchg instead of spinlock
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-14-git-send-email-srikar@linux.vnet.ibm.com>
 <20180604192821.GB12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180604192821.GB12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060507-0012-0000-0000-0000027B4096
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060507-0013-0000-0000-000020AC438E
Message-Id: <20180605072439.GE30328@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=559 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050089
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-06-04 21:28:21]:

> >  	if (time_after(jiffies, pgdat->numabalancing_migrate_next_window)) {
> > -		spin_lock(&pgdat->numabalancing_migrate_lock);
> > -		pgdat->numabalancing_migrate_nr_pages = 0;
> > -		pgdat->numabalancing_migrate_next_window = jiffies +
> > -			msecs_to_jiffies(migrate_interval_millisecs);
> > -		spin_unlock(&pgdat->numabalancing_migrate_lock);
> > +		if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0))
> > +			pgdat->numabalancing_migrate_next_window = jiffies +
> > +				msecs_to_jiffies(migrate_interval_millisecs);
>
> Note that both are in fact wrong. That wants to be something like:
>
> 	pgdat->numabalancing_migrate_next_window += interval;
>
> Otherwise you stretch every interval by 'jiffies - numabalancing_migrate_next_window'.

Okay, I get your point.


>
> Also, that all wants READ_ONCE/WRITE_ONCE, irrespective of the
> spinlock/xchg.
>
> I suppose the problem here is that PPC has a very nasty test-and-set
> spinlock with fwd progress issues while xchg maps to a fairly simple
> ll/sc that (hopefully) has some hardware fairness.
>
> And pgdata being a rather course data structure (per node?) there could
> be a lot of CPUs stomping on this here thing.
>
> So simpler not really, but better for PPC.
>

unsigned long interval = READ_ONCE(pgdat->numabalancing_migrate_next_window);

if (time_after(jiffies, interval)) {
	interval += msecs_to_jiffies(migrate_interval_millisecs));
	if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0))
		WRITE_ONCE(pgdat->numabalancing_migrate_next_window, interval);
}

Something like this?

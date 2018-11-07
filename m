Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C23C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E6020827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wjan71rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E6020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeKHGxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:53:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46560 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeKHGxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:53:11 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA7LJHBn026197;
        Wed, 7 Nov 2018 21:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0wXbyvHvxnjwCKoziUWh73cbxf7raaHmbKmlQEu720c=;
 b=Wjan71rxEKb8P1KQxWK/VGHYoXLAka/bKmfuoU2cuScbWaaf0bddfgtJzu9ysMdwkuAx
 6jDr4FHhcR+Dy4Q6IeTjLxjB82+NvYZq1NCwi7WlMv6ie+YmZJChydHknzaObgWbqeWE
 rl1oIC3CXaOBAH3x2WyDKl9/Ih+iElbmwdouXYp2mi/RuTjECqOZBQY1Ax7HggkjKOm1
 S+6HrPz2g9x9mj7f3IdTqLd+U1emJHXEAaWjPZ4R8O7U3LRFdOyQCrze9+LK+RcnfUHD
 Vixjv68ngJwCBy/iuuQZBHP8wxSpweVRDd4+rbx/i3xVd7sx6sdWuPROI4Fv561KbPKF ow== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nh4aqwxfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 21:20:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA7LKOlt027617
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 21:20:24 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA7LKMbu003572;
        Wed, 7 Nov 2018 21:20:22 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Nov 2018 13:20:22 -0800
Date:   Wed, 7 Nov 2018 13:20:29 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz,
        dhaval.giani@oracle.com
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181107212029.sqf56bbkd7ld6jav@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181106084911.GA22504@hirez.programming.kicks-ass.net>
 <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
 <20181107103554.GL9781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107103554.GL9781@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9070 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:35:54AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 06, 2018 at 12:34:11PM -0800, Daniel Jordan wrote:
> > On Tue, Nov 06, 2018 at 09:49:11AM +0100, Peter Zijlstra wrote:
> > > On Mon, Nov 05, 2018 at 11:55:46AM -0500, Daniel Jordan wrote:
> > > > +Concept
> > > > +=======
> > > > +
> > > > +ktask is built on unbound workqueues to take advantage of the thread management
> > > > +facilities it provides: creation, destruction, flushing, priority setting, and
> > > > +NUMA affinity.
> > > > +
> > > > +A little terminology up front:  A 'task' is the total work there is to do and a
> > > > +'chunk' is a unit of work given to a thread.
> > > 
> > > So I hate on the task naming. We already have a task, lets not overload
> > > that name.
> > 
> > Ok, agreed, it's a crowded field with 'task', 'work', 'thread'...
> > 
> > Maybe 'job', since nothing seems to have taken that in kernel/.
> 
> Do we want to somehow convey the fundamentally parallel nature of the
> thing?

Ok, I've consulted my thesaurus and everything.  Best I can come up with is
just 'parallel', so for example parallel_run would be the interface.  Or
para_run.

Going to think about this more, and I'm open to suggestions.

> 
> > > I see no mention of padata anywhere; I also don't see mention of the
> > > async init stuff. Both appear to me to share, at least in part, the same
> > > reason for existence.
> > 
> > padata is news to me.  From reading its doc, it comes with some special
> > requirements of its own, like softirqs disabled during the parallel callback,
> > and some ktask users need to sleep.  I'll check whether it could be reworked to
> > handle this.
> 
> Right, padata is something that came from the network stack I think.
> It's a bit of an odd thing, but it would be nice if we can fold it into
> something larger.

Sure, I'll see how it goes.

> > And yes, async shares the same basic infrastructure, but ktask callers need to
> > wait, so the two seem fundamentally at odds.  I'll add this explanation in.
> 
> Why does ktask have to be fundamentally async?

Assuming you mean sync.  It doesn't have to be synchronous always, but some
users need that.  A caller that clears a page shouldn't return to userland
before the job is done.

Anyway, sure, it may come out clean to encapsulate the async parts of async.c
into their own paths and then find a new name for that file.  I'll see how this
goes too.

>
> > > > +Scheduler Interaction
> > > > +=====================
> > ...
> > > > +It is possible for a helper thread to start running and then be forced off-CPU
> > > > +by a higher priority thread.  With the helper's CPU time curtailed by MAX_NICE,
> > > > +the main thread may wait longer for the task to finish than it would have had
> > > > +it not started any helpers, so to ensure forward progress at a single-threaded
> > > > +pace, once the main thread is finished with all outstanding work in the task,
> > > > +the main thread wills its priority to one helper thread at a time.  At least
> > > > +one thread will then always be running at the priority of the calling thread.
> > > 
> > > What isn't clear is if this calling thread is waiting or not. Only do
> > > this inheritance trick if it is actually waiting on the work. If it is
> > > not, nobody cares.
> > 
> > The calling thread waits.  Even if it didn't though, the inheritance trick
> > would still be desirable for timely completion of the job.
> 
> No, if nobody is waiting on it, it really doesn't matter.

Ok, I (think) I see what you meant.  If nobody is waiting on it, as in, it's
not desirable from a performance POV.  Agree.

> 
> > > > +Power Management
> > > > +================
> > > > +
> > > > +Starting additional helper threads may cause the system to consume more energy,
> > > > +which is undesirable on energy-conscious devices.  Therefore ktask needs to be
> > > > +aware of cpufreq policies and scaling governors.
> > > > +
> > > > +If an energy-conscious policy is in use (e.g. powersave, conservative) on any
> > > > +part of the system, that is a signal that the user has strong power management
> > > > +preferences, in which case ktask is disabled.
> > > > +
> > > > +TODO: Implement this.
> > > 
> > > No, don't do that, its broken. Also, we're trying to move to a single
> > > cpufreq governor for all.
> > >
> > > Sure we'll retain 'performance', but powersave and conservative and all
> > > that nonsense should go away eventually.
> > 
> > Ok, good to know.
> > 
> > > That's not saying you don't need a knob for this; but don't look at
> > > cpufreq for this.
> > 
> > Ok, I'll dig through power management to see what else is there.  Maybe there's
> > some way to ask "is this machine energy conscious?"
> 
> IIRC you're presenting at LPC, drop by the Power Management and
> Energy-awareness MC.

Will do.

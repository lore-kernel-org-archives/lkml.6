Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809B7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321102086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZAD3bo1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321102086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbeKGGBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:01:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59220 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeKGGBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:01:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA6KXqox071078;
        Tue, 6 Nov 2018 20:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=pakjZxNjY8FspfN/WewezMEyTCNsl+lL8udzgwjAL6Q=;
 b=ZAD3bo1nzxr5ZWIl7RiFHdmYWaojiw0R7PrdVz48+oVwZX/oxHTay/ceyhdNXbbuKkME
 z8tQzjs22Hr5+U4sOthzRDC/OK4E28PelZGN+ua0UpjFD7qGQHJSbHR4teubArx18SSr
 Vd//UUBGBOP0TQI8WpuZpJylw4TDJFMj0aG++UIyyk+J7cxRGbyN51Fd4wtWioL+1euV
 tcMtBxO+94eh1KIodoiRQNXdncToSK76vfdw+msNP1NBrKIoWefuFpCMUXUqeQUdC5Qt
 aT+FeJNfN7Y3U0WRZIN5x17Wcf2mJ9bHvMblEpaeJB9Qt5K9W0lipcgXAKV5W0n+ed8T tg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nh33tys84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 20:34:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA6KY5AL017032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 20:34:05 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA6KY4Z1020874;
        Tue, 6 Nov 2018 20:34:04 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 12:34:04 -0800
Date:   Tue, 6 Nov 2018 12:34:11 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181106084911.GA22504@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106084911.GA22504@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 09:49:11AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 05, 2018 at 11:55:46AM -0500, Daniel Jordan wrote:
> > +Concept
> > +=======
> > +
> > +ktask is built on unbound workqueues to take advantage of the thread management
> > +facilities it provides: creation, destruction, flushing, priority setting, and
> > +NUMA affinity.
> > +
> > +A little terminology up front:  A 'task' is the total work there is to do and a
> > +'chunk' is a unit of work given to a thread.
> 
> So I hate on the task naming. We already have a task, lets not overload
> that name.

Ok, agreed, it's a crowded field with 'task', 'work', 'thread'...

Maybe 'job', since nothing seems to have taken that in kernel/.

> I see no mention of padata anywhere; I also don't see mention of the
> async init stuff. Both appear to me to share, at least in part, the same
> reason for existence.

padata is news to me.  From reading its doc, it comes with some special
requirements of its own, like softirqs disabled during the parallel callback,
and some ktask users need to sleep.  I'll check whether it could be reworked to
handle this.

And yes, async shares the same basic infrastructure, but ktask callers need to
wait, so the two seem fundamentally at odds.  I'll add this explanation in.

> 
> > +Scheduler Interaction
> > +=====================
...
> > +It is possible for a helper thread to start running and then be forced off-CPU
> > +by a higher priority thread.  With the helper's CPU time curtailed by MAX_NICE,
> > +the main thread may wait longer for the task to finish than it would have had
> > +it not started any helpers, so to ensure forward progress at a single-threaded
> > +pace, once the main thread is finished with all outstanding work in the task,
> > +the main thread wills its priority to one helper thread at a time.  At least
> > +one thread will then always be running at the priority of the calling thread.
> 
> What isn't clear is if this calling thread is waiting or not. Only do
> this inheritance trick if it is actually waiting on the work. If it is
> not, nobody cares.

The calling thread waits.  Even if it didn't though, the inheritance trick
would still be desirable for timely completion of the job.

> 
> > +Cgroup Awareness
> > +================
> > +
> > +Given the potentially large amount of CPU time ktask threads may consume, they
> > +should be aware of the cgroup of the task that called into ktask and
> > +appropriately throttled.
> > +
> > +TODO: Implement cgroup-awareness in unbound workqueues.
> 
> Yes.. that needs done.

Great.

> 
> > +Power Management
> > +================
> > +
> > +Starting additional helper threads may cause the system to consume more energy,
> > +which is undesirable on energy-conscious devices.  Therefore ktask needs to be
> > +aware of cpufreq policies and scaling governors.
> > +
> > +If an energy-conscious policy is in use (e.g. powersave, conservative) on any
> > +part of the system, that is a signal that the user has strong power management
> > +preferences, in which case ktask is disabled.
> > +
> > +TODO: Implement this.
> 
> No, don't do that, its broken. Also, we're trying to move to a single
> cpufreq governor for all.
>
> Sure we'll retain 'performance', but powersave and conservative and all
> that nonsense should go away eventually.

Ok, good to know.

> That's not saying you don't need a knob for this; but don't look at
> cpufreq for this.

Ok, I'll dig through power management to see what else is there.  Maybe there's
some way to ask "is this machine energy conscious?"

Thanks for looking through this!

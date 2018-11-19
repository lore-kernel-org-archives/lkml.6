Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30A1206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eaqD/x3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30A1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbeKTDLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:11:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47122 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbeKTDLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:11:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAJGiEB5140956;
        Mon, 19 Nov 2018 16:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=QVpNxCdRrTkzT/YiFruIcmxY+LQ14Mbhsv5I5cebKVo=;
 b=eaqD/x3vKjJoG+DEwMCBvkRRfRuk+kPHUkFtjRVYZU7JXeIZOh7bYqwGKNJHogPcvhqo
 bJxdcjUeMwQ4BcVGIIuCxLAuDmN5mInYkCWjj7Bl2+E9t+gZ+ojqkfr3LP2/Q+UeGJSk
 ZvSUk7tCwOBtB6VXx+LTSR3w96uFw6FyNJHSryp1z9ul+TzlUAdwgh9DFc/dI6UTVgGl
 jkpviPEcqRCvyl7l/IBywGhi0VS//Zo5aRU8OspYh0M4xzd0mXl+5pmYETMyhBKK57KF
 UrJvOkqhkjlDHsHmX9fugG256yBelaQRqBNOJmnlwuDb5lZPJW9a1dOsLHmjG5pR0kRv yQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ntbmqf3r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 16:45:48 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAJGjlMn010944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 16:45:47 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAJGjj5Q014005;
        Mon, 19 Nov 2018 16:45:45 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Nov 2018 08:45:45 -0800
Date:   Mon, 19 Nov 2018 08:45:54 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 05/13] workqueue, ktask: renice helper threads to
 prevent starvation
Message-ID: <20181119164554.axobolrufu26kfah@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-6-daniel.m.jordan@oracle.com>
 <20181113163400.GK2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113163400.GK2509588@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=825
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811190153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 08:34:00AM -0800, Tejun Heo wrote:
> Hello, Daniel.

Hi Tejun, sorry for the delay.  Plumbers...

> On Mon, Nov 05, 2018 at 11:55:50AM -0500, Daniel Jordan wrote:
> >  static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
> > -			     bool from_cancel)
> > +			     struct nice_work *nice_work, int flags)
> >  {
> >  	struct worker *worker = NULL;
> >  	struct worker_pool *pool;
> > @@ -2868,11 +2926,19 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
> >  	if (pwq) {
> >  		if (unlikely(pwq->pool != pool))
> >  			goto already_gone;
> > +
> > +		/* not yet started, insert linked work before work */
> > +		if (unlikely(flags & WORK_FLUSH_AT_NICE))
> > +			insert_nice_work(pwq, nice_work, work);
> 
> So, I'm not sure this works that well.  e.g. what if the work item is
> waiting for other work items which are at lower priority?  Also, in
> this case, it'd be a lot simpler to simply dequeue the work item and
> execute it synchronously.

Good idea, that is much simpler (and shorter).

So doing it this way, the current task's nice level would be adjusted while
running the work synchronously.

> 
> >  	} else {
> >  		worker = find_worker_executing_work(pool, work);
> >  		if (!worker)
> >  			goto already_gone;
> >  		pwq = worker->current_pwq;
> > +		if (unlikely(flags & WORK_FLUSH_AT_NICE)) {
> > +			set_user_nice(worker->task, nice_work->nice);
> > +			worker->flags |= WORKER_NICED;
> > +		}
> >  	}
> 
> I'm not sure about this.  Can you see whether canceling & executing
> synchronously is enough to address the latency regression?

In my testing, canceling was practically never successful because these are
long running jobs, so by the time the main ktask thread gets around to
flushing/nice'ing the works, worker threads have already started running them.
I had to write a no-op ktask to hit the first path where you suggest
dequeueing.  So adjusting the priority of a running worker seems required to
address the latency issue.

So instead of flush_work_at_nice, how about this?:

void renice_work_sync(work_struct *work, long nice);

If a worker is running the work, renice the worker to 'nice' and wait for it to
finish (what this patch does now), and if the work isn't running, dequeue it
and run in the current thread, again at 'nice'.


Thanks for taking a look.

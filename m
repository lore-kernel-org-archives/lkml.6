Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE534C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8866720862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pMVKyySm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8866720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeKGGoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:44:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58602 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeKGGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:44:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA6Is5t6188439;
        Tue, 6 Nov 2018 19:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=KGb9NUxsKsh7FP4BpMAi0pNNtqYdI2Z+ZsN/Wb85+7Q=;
 b=pMVKyySmsDtN/sZdL8cn0t1yl0fj3ZYzR6R6ZBojPnG94TmcTHOydTmsVnBmcP+JhX0P
 VJYdWEVTBznBjAVBGZDrSUSkAUudhnmtNowGSnr6ALnZzkV1XdsFAoX9m/nTLCmcyBze
 HRI0rV95lh9BQUrBWdKoqbc0U0v6qDE5p5KnKzHUwndgiHJy4/OOm9iIl9svB1fSU8O2
 YuCA+XfXDNgxpp1cBhCb1wY+Fz76PGjArq+zqm5mdWYeP88EktTZSN+kqGqFEoAmq+o+
 mJVynwvf0LQ0XYrHNyNxrtstP3oH8wL4+RXuQCzDtj0eEGsCtGodQZXnEV415gk/Qc4Z Zg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nh3mpq7sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 19:00:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA6J0RiV030496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 19:00:27 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA6J0NNG008027;
        Tue, 6 Nov 2018 19:00:23 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 11:00:22 -0800
Date:   Tue, 6 Nov 2018 11:00:29 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 00/13] ktask: multithread CPU-intensive kernel work
Message-ID: <20181106190029.epktpxhimrca4f4a@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <FC2EB02D-3D05-4A13-A92E-4171B37B15BA@cs.rutgers.edu>
 <20181106022024.ndn377ze6xljsxkb@ca-dmjordan1.us.oracle.com>
 <7E53DD63-4955-480D-8C0D-EB07E4FF011B@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E53DD63-4955-480D-8C0D-EB07E4FF011B@cs.rutgers.edu>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 09:48:56PM -0500, Zi Yan wrote:
> On 5 Nov 2018, at 21:20, Daniel Jordan wrote:
> 
> > Hi Zi,
> >
> > On Mon, Nov 05, 2018 at 01:49:14PM -0500, Zi Yan wrote:
> >> On 5 Nov 2018, at 11:55, Daniel Jordan wrote:
> >>
> >> Do you think if it makes sense to use ktask for huge page migration (the data
> >> copy part)?
> >
> > It certainly could.
> >
> >> I did some experiments back in 2016[1], which showed that migrating one 2MB page
> >> with 8 threads could achieve 2.8x throughput of the existing single-threaded method.
> >> The problem with my parallel page migration patchset at that time was that it
> >> has no CPU-utilization awareness, which is solved by your patches now.
> >
> > Did you run with fewer than 8 threads?  I'd want a bigger speedup than 2.8x for
> > 8, and a smaller thread count might improve thread utilization.
> 
> Yes. When migrating one 2MB THP with migrate_pages() system call on a two-socket server
> with 2 E5-2650 v3 CPUs (10 cores per socket) across two sockets, here are the page migration
> throughput numbers:
> 
>              throughput       factor
> 1 thread      2.15 GB/s         1x
> 2 threads     3.05 GB/s         1.42x
> 4 threads     4.50 GB/s         2.09x
> 8 threads     5.98 GB/s         2.78x

Thanks.  Looks like in your patches you start a worker for every piece of the
huge page copy and have the main thread wait.  I'm curious what the workqueue
overhead is like on your machine.  On a newer Xeon it's ~50usec from queueing a
work to starting to execute it and another ~20usec to flush a work
(barrier_func), which could happen after the work is already done.  A pretty
significant piece of the copy time for part of a THP.

            bash 60728 [087] 155865.157116:                   probe:ktask_run: (ffffffffb7ee7a80)
            bash 60728 [087] 155865.157119:    workqueue:workqueue_queue_work: work struct=0xffff95fb73276000
            bash 60728 [087] 155865.157119: workqueue:workqueue_activate_work: work struct 0xffff95fb73276000
 kworker/u194:3- 86730 [095] 155865.157168: workqueue:workqueue_execute_start: work struct 0xffff95fb73276000: function ktask_thread
 kworker/u194:3- 86730 [095] 155865.157170:   workqueue:workqueue_execute_end: work struct 0xffff95fb73276000
 kworker/u194:3- 86730 [095] 155865.157171: workqueue:workqueue_execute_start: work struct 0xffffa676995bfb90: function wq_barrier_func
 kworker/u194:3- 86730 [095] 155865.157190:   workqueue:workqueue_execute_end: work struct 0xffffa676995bfb90
            bash 60728 [087] 155865.157207:       probe:ktask_run_ret__return: (ffffffffb7ee7a80 <- ffffffffb7ee7b7b)

> >
> > It would be nice to multithread at a higher granularity than 2M, too: a range
> > of THPs might also perform better than a single page.
> 
> Sure. But the kernel currently does not copy multiple pages altogether even if a range
> of THPs is migrated. Page copy function is interleaved with page table operations
> for every single page.
> 
> I also did some study and modified the kernel to improve this, which I called
> concurrent page migration in https://lwn.net/Articles/714991/. It further
> improves page migration throughput.

Ok, over 4x with 8 threads for 16 THPs.  Is 16 a typical number for migration,
or does it get larger?  What workloads do you have in mind with this change?

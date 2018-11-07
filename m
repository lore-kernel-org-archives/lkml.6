Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23732C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D582081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DRzVpzG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D582081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeKHFyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:54:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42316 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeKHFyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:54:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA7KIuYY024448;
        Wed, 7 Nov 2018 20:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=g81bR2VFriFbSeNQT3NitCx+/9tD4imkdee1NLEu8Ek=;
 b=DRzVpzG9d6VfjlY7k/kTiBuT/dnqi2uMQMT6ZJThVhRFFD+F4Ny1YwwPl7+0sKaqYrTh
 jlucHOpEsPV5DRspwnohxZKswiOO4rvdBUfceoOonls0TJHCIo+bOk5tW7Sb4V62l0JL
 nBRH7B6amJ/bluoV3pnVLZEH0/iE5M7HTETaLHrd7BrwdWsh6/9K3gE/LjOPCtVySdrt
 zSJrauhTVY7KdyN2+xuadW3RP2UZ8vPi97W0AxIip5gRG3seJ1/bczCDjoyckRscZdsQ
 CA2ULtIsrSNZ4n4T9nOZ/ud/WiEIKjbHYFFqB7TzRRX8eFqTrq1J3uDj4i3MuVnL8YJJ IQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nh33u5thc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 20:21:41 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA7KLeoj013863
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 20:21:40 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA7KLcq5014294;
        Wed, 7 Nov 2018 20:21:38 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Nov 2018 12:21:38 -0800
Date:   Wed, 7 Nov 2018 12:21:45 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "bsd@redhat.com" <bsd@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jwadams@google.com" <jwadams@google.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Pavel.Tatashin@microsoft.com" <Pavel.Tatashin@microsoft.com>,
        "prasad.singamsetty@oracle.com" <prasad.singamsetty@oracle.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "tim.c.chen@intel.com" <tim.c.chen@intel.com>,
        "tj@kernel.org" <tj@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181107202145.xvaq3pmqbzyekfan@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181106084911.GA22504@hirez.programming.kicks-ass.net>
 <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
 <20181106205146.GB30490@mellanox.com>
 <20181107102752.GK9781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107102752.GK9781@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9070 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=535
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:27:52AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 06, 2018 at 08:51:54PM +0000, Jason Gunthorpe wrote:
> > On Tue, Nov 06, 2018 at 12:34:11PM -0800, Daniel Jordan wrote:
> > 
> > > > What isn't clear is if this calling thread is waiting or not. Only do
> > > > this inheritance trick if it is actually waiting on the work. If it is
> > > > not, nobody cares.
> > > 
> > > The calling thread waits.  Even if it didn't though, the inheritance trick
> > > would still be desirable for timely completion of the job.
> > 
> > Can you make lockdep aware that this is synchronous?
> > 
> > ie if I do
> > 
> >   mutex_lock()
> >   ktask_run()
> >   mutex_lock()
> > 
> > Can lockdep know that all the workers are running under that lock?
> > 
> > I'm thinking particularly about rtnl_lock as a possible case, but
> > there could also make some sense to hold the read side of the mm_sem
> > or similar like the above.
> 
> Yes, the normal trick is adding a fake lock to ktask_run and holding
> that over the actual job. See lock_map* in flush_workqueue() vs
> process_one_work().

I'll add that for the next version.

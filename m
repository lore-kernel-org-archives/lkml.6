Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8625C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761C120831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NWF3nCcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761C120831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbeKTC1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:27:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55804 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbeKTC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:27:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAJG13iV102580;
        Mon, 19 Nov 2018 16:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FR1Ju5T6Kl+vtDHsjn1cF6Ljr0xtJ7H19F3y4bxNI4w=;
 b=NWF3nCcObxpVOpWHNrNQxvlw1ovYazQpci3ILD44fo7QtdDN1qEPLoUgWIjqvNWeMbMO
 i0oDrisMv2EksFbCP+WXsm8bfN6IcMll09YbtgkYUTBvITx2URQCft1orL1E085y9JPP
 pd9P5qGWBNkyWZnVog1i0GTDtiJWjDT6YIDcGcL+/cMX8W9s+dTVzxjjccVJMY7A5Sy4
 pgg5lCBtHIAXVvya9b6ACfvgqFPPMSsK4hYZiauBe2QXGsf1Ab9OLGzcrV3Ox9ELz71e
 K7XZC9QPUkjp4EL4mVwhJVBMmYz/VDZ9pnEskzDqOIwsWRSGJyOrRje0/McFgVtMOniu dw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2ntbmqetys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 16:01:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAJG1VJI011920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 16:01:31 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAJG1Tcm018930;
        Mon, 19 Nov 2018 16:01:29 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Nov 2018 08:01:29 -0800
Date:   Mon, 19 Nov 2018 08:01:38 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
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
        "jgg@mellanox.com" <jgg@mellanox.com>,
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
Subject: Re: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
 initialization within each node
Message-ID: <20181119160137.72zha7dbsr3adkfs@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-12-daniel.m.jordan@oracle.com>
 <AT5PR8401MB1169798EBEF1EE5EBA3ABFFFABC70@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <20181112165412.vizeiv6oimsuxkbk@ca-dmjordan1.us.oracle.com>
 <AT5PR8401MB1169B05F889BCF8EF113E053ABC10@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB1169B05F889BCF8EF113E053ABC10@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811190147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 10:15:46PM +0000, Elliott, Robert (Persistent Memory) wrote:
> 
> 
> > -----Original Message-----
> > From: Daniel Jordan <daniel.m.jordan@oracle.com>
> > Sent: Monday, November 12, 2018 11:54 AM
> > To: Elliott, Robert (Persistent Memory) <elliott@hpe.com>
> > Cc: Daniel Jordan <daniel.m.jordan@oracle.com>; linux-mm@kvack.org;
> > kvm@vger.kernel.org; linux-kernel@vger.kernel.org; aarcange@redhat.com;
> > aaron.lu@intel.com; akpm@linux-foundation.org; alex.williamson@redhat.com;
> > bsd@redhat.com; darrick.wong@oracle.com; dave.hansen@linux.intel.com;
> > jgg@mellanox.com; jwadams@google.com; jiangshanlai@gmail.com;
> > mhocko@kernel.org; mike.kravetz@oracle.com; Pavel.Tatashin@microsoft.com;
> > prasad.singamsetty@oracle.com; rdunlap@infradead.org;
> > steven.sistare@oracle.com; tim.c.chen@intel.com; tj@kernel.org;
> > vbabka@suse.cz
> > Subject: Re: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
> > initialization within each node
> > 
> > On Sat, Nov 10, 2018 at 03:48:14AM +0000, Elliott, Robert (Persistent
> > Memory) wrote:
> > > > -----Original Message-----
> > > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > > owner@vger.kernel.org> On Behalf Of Daniel Jordan
> > > > Sent: Monday, November 05, 2018 10:56 AM
> > > > Subject: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
> > > > initialization within each node
> > > >
> ...
> > > > In testing, a reasonable value turned out to be about a quarter of the
> > > > CPUs on the node.
> > > ...
> > > > +	/*
> > > > +	 * We'd like to know the memory bandwidth of the chip to
> > > >         calculate the
> > > > +	 * most efficient number of threads to start, but we can't.
> > > > +	 * In testing, a good value for a variety of systems was a
> > > >         quarter of the CPUs on the node.
> > > > +	 */
> > > > +	nr_node_cpus = DIV_ROUND_UP(cpumask_weight(cpumask), 4);
> > >
> > >
> > > You might want to base that calculation on and limit the threads to
> > > physical cores, not hyperthreaded cores.
> > 
> > Why?  Hyperthreads can be beneficial when waiting on memory.  That said, I
> > don't have data that shows that in this case.
> 
> I think that's only if there are some register-based calculations to do while
> waiting. If both threads are just doing memory accesses, they'll both stall, and
> there doesn't seem to be any benefit in having two contexts generate the IOs
> rather than one (at least on the systems I've used). I think it takes longer
> to switch contexts than to just turnaround the next IO.

(Sorry for the delay, Plumbers is over now...)

I guess we're both just waving our hands without data.  I've only got x86, so
using a quarter of the CPUs rules out HT on my end.  Do you have a system that
you can test this on, where using a quarter of the CPUs will involve HT?

Thanks,
Daniel

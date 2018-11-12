Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53613C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1904B22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZXlTDlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1904B22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbeKMCsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:48:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeKMCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:48:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wACGs7Q9051431;
        Mon, 12 Nov 2018 16:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=4CXtc7phf7AOqv+BDqaOZkb3mLV0A7j8oEgmpc86S4E=;
 b=NZXlTDlDfqCouB+tfazby0ximc9f9FBog3YmTFOwl0NWbfOyqS7+q3gNNRGD82kNbri9
 MB27g50Pri9BV6vJsnw4rFGVuC4XfGth+gjeg54Tm1RZWA4oqR21AJ63B3kFITKvcQgZ
 /f2viQO/yc2LxnUkBf9gQfJZdJXmrjpT6g4GQMtalxbrkzk3sq9wMXgm0TYA3w2ORIjh
 YHE6wd4mO51QCDBE65F77rJits6rrQ1FsCRg3GvNKWu//6Vn60bUv4haJjgHz0u38B8k
 au0z1kPaQVGaKUvAsKScNBmDS0xbKpdjboC0dFZcZ5R/r2XbJicHk8jv43EPaY9MIGIi jQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nnwc0eb0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 16:54:07 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wACGs5Va032019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 16:54:06 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wACGs43r001514;
        Mon, 12 Nov 2018 16:54:04 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Nov 2018 08:54:04 -0800
Date:   Mon, 12 Nov 2018 08:54:12 -0800
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
Message-ID: <20181112165412.vizeiv6oimsuxkbk@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-12-daniel.m.jordan@oracle.com>
 <AT5PR8401MB1169798EBEF1EE5EBA3ABFFFABC70@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB1169798EBEF1EE5EBA3ABFFFABC70@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9075 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811120148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 03:48:14AM +0000, Elliott, Robert (Persistent Memory) wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > owner@vger.kernel.org> On Behalf Of Daniel Jordan
> > Sent: Monday, November 05, 2018 10:56 AM
> > Subject: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
> > initialization within each node
> > 
> > ...  The kernel doesn't
> > know the memory bandwidth of a given system to get the most efficient
> > number of threads, so there's some guesswork involved.  
> 
> The ACPI HMAT (Heterogeneous Memory Attribute Table) is designed to report
> that kind of information, and could facilitate automatic tuning.
> 
> There was discussion last year about kernel support for it:
> https://lore.kernel.org/lkml/20171214021019.13579-1-ross.zwisler@linux.intel.com/

Thanks for bringing this up.  I'm traveling but will take a closer look when I
get back.

> > In testing, a reasonable value turned out to be about a quarter of the
> > CPUs on the node.
> ...
> > +	/*
> > +	 * We'd like to know the memory bandwidth of the chip to
> >         calculate the
> > +	 * most efficient number of threads to start, but we can't.
> > +	 * In testing, a good value for a variety of systems was a
> >         quarter of the CPUs on the node.
> > +	 */
> > +	nr_node_cpus = DIV_ROUND_UP(cpumask_weight(cpumask), 4);
> 
> 
> You might want to base that calculation on and limit the threads to
> physical cores, not hyperthreaded cores.

Why?  Hyperthreads can be beneficial when waiting on memory.  That said, I
don't have data that shows that in this case.

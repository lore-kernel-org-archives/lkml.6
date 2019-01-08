Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AEDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46E721019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfAHPtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:49:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727906AbfAHPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:49:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08FfZh2013566
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 10:49:07 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvvwgpqax-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:49:06 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 8 Jan 2019 15:49:03 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 15:48:56 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08FmtNF27656282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 15:48:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6DE952057;
        Tue,  8 Jan 2019 15:48:55 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.241])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2796C5204E;
        Tue,  8 Jan 2019 15:48:54 +0000 (GMT)
Date:   Tue, 8 Jan 2019 17:48:52 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org,
        kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
References: <1546848299-23628-1-git-send-email-kernelfans@gmail.com>
 <20190108080538.GB4396@rapoport-lnx>
 <20190108090138.GB18718@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108090138.GB18718@MiWiFi-R3L-srv>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19010815-0020-0000-0000-000003030B9B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010815-0021-0000-0000-000021541D92
Message-Id: <20190108154852.GC14063@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 05:01:38PM +0800, Baoquan He wrote:
> Hi Mike,
> 
> On 01/08/19 at 10:05am, Mike Rapoport wrote:
> > I'm not thrilled by duplicating this code (yet again).
> > I liked the v3 of this patch [1] more, assuming we allow bottom-up mode to
> > allocate [0, kernel_start) unconditionally. 
> > I'd just replace you first patch in v3 [2] with something like:
> 
> In initmem_init(), we will restore the top-down allocation style anyway.
> While reserve_crashkernel() is called after initmem_init(), it's not
> appropriate to adjust memblock_find_in_range_node(), and we really want
> to find region bottom up for crashkernel reservation, no matter where
> kernel is loaded, better call __memblock_find_range_bottom_up().
> 
> Create a wrapper to do the necessary handling, then call
> __memblock_find_range_bottom_up() directly, looks better.

What bothers me is 'the necessary handling' which is already done in
several places in memblock in a similar, but yet slightly different way.

memblock_find_in_range() and memblock_phys_alloc_nid() retry with different
MEMBLOCK_MIRROR, but memblock_phys_alloc_try_nid() does that only when
allocating from the specified node and does not retry when it falls back to
any node. And memblock_alloc_internal() has yet another set of fallbacks. 

So what should be the necessary handling in the wrapper for
__memblock_find_range_bottom_up() ?

BTW, even without any memblock modifications, retrying allocation in
reserve_crashkerenel() for different ranges, like the proposal at [1] would
also work, wouldn't it?

[1] http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
 
> Thanks
> Baoquan
> 
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 7df468c..d1b30b9 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -274,24 +274,14 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
> >  	 * try bottom-up allocation only when bottom-up mode
> >  	 * is set and @end is above the kernel image.
> >  	 */
> > -	if (memblock_bottom_up() && end > kernel_end) {
> > -		phys_addr_t bottom_up_start;
> > -
> > -		/* make sure we will allocate above the kernel */
> > -		bottom_up_start = max(start, kernel_end);
> > -
> > +	if (memblock_bottom_up()) {
> >  		/* ok, try bottom-up allocation first */
> > -		ret = __memblock_find_range_bottom_up(bottom_up_start, end,
> > +		ret = __memblock_find_range_bottom_up(start, end,
> >  						      size, align, nid, flags);
> >  		if (ret)
> >  			return ret;
> >  
> >  		/*
> > -		 * we always limit bottom-up allocation above the kernel,
> > -		 * but top-down allocation doesn't have the limit, so
> > -		 * retrying top-down allocation may succeed when bottom-up
> > -		 * allocation failed.
> > -		 *
> >  		 * bottom-up allocation is expected to be fail very rarely,
> >  		 * so we use WARN_ONCE() here to see the stack trace if
> >  		 * fail happens.
> > 
> > [1] https://lore.kernel.org/lkml/1545966002-3075-3-git-send-email-kernelfans@gmail.com/
> > [2] https://lore.kernel.org/lkml/1545966002-3075-2-git-send-email-kernelfans@gmail.com/
> > 
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  /**
> > >   * __memblock_find_range_top_down - find free area utility, in top-down
> > >   * @start: start of candidate range
> > > -- 
> > > 2.7.4
> > > 
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> > 
> 

-- 
Sincerely yours,
Mike.


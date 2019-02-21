Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B9E20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LKQiBzvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBUW6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:58:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60604 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBUW6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:58:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LMsQuS039998;
        Thu, 21 Feb 2019 22:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=R36KJKYkI+XeO5y2M/BarkvhDc6qEC6qBgMCjbDeY2A=;
 b=LKQiBzvhvTb9uIopbEAwULVGyu6QmvstAp7zCQyyKETNhF1OOVhJonkeYn6qn8DeCBI2
 08gqc87+bCzKpo5/3rEvdrCBInHB064IKWsvYNH20G0JAhV/gDUE8ByZ+l8Nu57M2Nti
 bSwaTiydBGaDLld42xiLDrSlmrdp155A360QdurKQr41GjubZXq+NQmjtv01svUzzulp
 3sKjMB6jeGPejeWJ6q/IWaAKEU1fXRnkDi0e1WAQ4d9zIKHMEohGpAMPs+PY+gzdAGju
 l6Yyf3iApm81wURDSKLUbtZhWMLkr0fAKVowNSGSJMXzwMzt0ut59Km1HvqT/H48mOac Wg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xubb6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 22:58:41 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LMwaSa014176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 22:58:36 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LMwZ17027803;
        Thu, 21 Feb 2019 22:58:36 GMT
Received: from ubuette (/75.80.107.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 14:58:35 -0800
Date:   Thu, 21 Feb 2019 14:58:27 -0800
From:   Larry Bassel <larry.bassel@oracle.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Larry Bassel <larry.bassel@oracle.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: question about page tables in DAX/FS/PMEM case
Message-ID: <20190221225827.GA2764@ubuette>
References: <20190220230622.GI19341@ubuette>
 <20190221204141.GB5201@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221204141.GB5201@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=980 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-mm]

On 21 Feb 19 15:41, Jerome Glisse wrote:
> On Wed, Feb 20, 2019 at 03:06:22PM -0800, Larry Bassel wrote:
> > I'm working on sharing page tables in the DAX/XFS/PMEM/PMD case.
> > 
> > If multiple processes would use the identical page of PMDs corresponding
> > to a 1 GiB address range of DAX/XFS/PMEM/PMDs, presumably one can instead
> > of populating a new PUD, just atomically increment a refcount and point
> > to the same PUD in the next level above.

Thanks for your feedback. Some comments/clarification below.

> 
> I think page table sharing was discuss several time in the past and
> the complexity involve versus the benefit were not clear. For 1GB
> of virtual address you need:
>     #pte pages = 1G/(512 * 2^12)       = 512 pte pages
>     #pmd pages = 1G/(512 * 512 * 2^12) = 1   pmd pages
> 
> So if we were to share the pmd directory page we would be saving a
> total of 513 pages for every page table or ~2MB. This goes up with
> the number of process that map the same range ie if 10 process map
> the same range and share the same pmd than you are saving 9 * 2MB
> 18MB of memory. This seems relatively modest saving.

The file blocksize = page size in what I am working on would
be 2 MiB (sharing puds/pages of pmds), I'm not trying to
support sharing pmds/pages of ptes. And yes, the savings in this
case is actually even less than in your example (but see my example below).

> 
> AFAIK there is no hardware benefit from sharing the page table
> directory within different page table. So the only benefit is the
> amount of memory we save.

Yes, in our use case (high end Oracle database using DAX/XFS/PMEM/PMD)
the main benefit would be memory savings:

A future system might have 6 TiB of PMEM on it and
there might be 10000 processes each mapping all of this 6 TiB.
Here the savings would be approximately
(6 TiB / 2 MiB) * 8 bytes (page table size) * 10000 = 240 GiB
(and these page tables themselves would be in non-PMEM (ordinary RAM)).

> 
> See below for comments on complexity to achieve this.
> 
[trim]
> > 
> > If I have a mmap of a DAX/FS/PMEM file and I take
> > a page (either pte or PMD sized) fault on access to this file,
> > the page table(s) are set up in dax_iomap_fault() in fs/dax.c (correct?).
> 
> Not exactly the page table are allocated long before dax_iomap_fault()
> get calls. They are allocated by the handle_mm_fault() and its childs
> functions.

Yes, I misstated this, the fault is handled there which may well
alter the PUD (in my case), but the original page tables are set up earlier.

> 
> > 
> > If the process later munmaps this file or exits but there are still
> > other users of the shared page of PMDs, I would need to
> > detect that this has happened and act accordingly (#3 above)
> > 
> > Where will these page table entries be torn down?
> > In the same code where any other page table is torn down?
> > If this is the case, what would the cleanest way of telling that these
> > page tables (PMDs, etc.) correspond to a DAX/FS/PMEM mapping
> > (look at the physical address pointed to?) so that
> > I could do the right thing here.
> > 
> > I understand that I may have missed something obvious here.
> > 
> 
> They are many issues here are the one i can think of:
>     - finding a pmd/pud to share, you need to walk the reverse mapping
>       of the range you are mapping and to find if any process or other
>       virtual address already as a pud or pmd you can reuse. This can
>       take more time than allocating page directory pages.
>     - if one process munmap some portion of a share pud you need to
>       break the sharing this means that munmap (or mremap) would need
>       to handle this page table directory sharing case first
>     - many code path in the kernel might need update to understand this
>       share page table thing (mprotect, userfaultfd, ...)
>     - the locking rules is bound to be painfull
>     - this might not work on all architecture as some architecture do
>       associate information with page table directory and that can not
>       always be share (it would need to be enabled arch by arch)

Yes, some architectures don't support DAX at all (note again that
I'm not trying to share non-DAX page table here).

> 
> The nice thing:
>     - unmapping for migration, when you unmap a share pud/pmd you can
>       decrement mapcount by share pud/pmd count this could speedup
>       migration

A followup question: the kernel does sharing of page tables for hugetlbfs
(also 2 MiB pages), why aren't the above issues relevant there as well
(or are they but we support it anyhow)?

> 
> This is what i could think of on the top of my head but there might be
> other thing. I believe the question is really a benefit versus cost and
> to me at least the complexity cost outweight the benefit one for now.
> Kirill Shutemov proposed rework on how we do page table and this kind of
> rework might tip the balance the other way. So my suggestion would be to
> look into how the page table management can be change in a beneficial
> way that could also achieve the page table sharing.
> 
> Cheers,
> Jérôme

Thanks.

Larry

Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5119FC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167E8217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfBZGoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:44:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbfBZGoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:44:02 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q6hb0L140782
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:44:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qvykq2e0x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:44:00 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 26 Feb 2019 06:43:58 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 06:43:52 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1Q6hoQX25296898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 06:43:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E114011C04A;
        Tue, 26 Feb 2019 06:43:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BF4511C052;
        Tue, 26 Feb 2019 06:43:49 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Feb 2019 06:43:49 +0000 (GMT)
Date:   Tue, 26 Feb 2019 08:43:47 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v2 20/26] userfaultfd: wp: support write protection for
 userfault vma range
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-21-peterx@redhat.com>
 <20190225205233.GC10454@rapoport-lnx>
 <20190226060627.GG13653@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226060627.GG13653@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022606-0028-0000-0000-0000034D0EEF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022606-0029-0000-0000-0000240B6098
Message-Id: <20190226064347.GB5873@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 02:06:27PM +0800, Peter Xu wrote:
> On Mon, Feb 25, 2019 at 10:52:34PM +0200, Mike Rapoport wrote:
> > On Tue, Feb 12, 2019 at 10:56:26AM +0800, Peter Xu wrote:
> > > From: Shaohua Li <shli@fb.com>
> > > 
> > > Add API to enable/disable writeprotect a vma range. Unlike mprotect,
> > > this doesn't split/merge vmas.
> > > 
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Cc: Rik van Riel <riel@redhat.com>
> > > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > > Cc: Mel Gorman <mgorman@suse.de>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Shaohua Li <shli@fb.com>
> > > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > > [peterx:
> > >  - use the helper to find VMA;
> > >  - return -ENOENT if not found to match mcopy case;
> > >  - use the new MM_CP_UFFD_WP* flags for change_protection
> > >  - check against mmap_changing for failures]
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/linux/userfaultfd_k.h |  3 ++
> > >  mm/userfaultfd.c              | 54 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 57 insertions(+)
> > > 
> > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > > index 765ce884cec0..8f6e6ed544fb 100644
> > > --- a/include/linux/userfaultfd_k.h
> > > +++ b/include/linux/userfaultfd_k.h
> > > @@ -39,6 +39,9 @@ extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
> > >  			      unsigned long dst_start,
> > >  			      unsigned long len,
> > >  			      bool *mmap_changing);
> > > +extern int mwriteprotect_range(struct mm_struct *dst_mm,
> > > +			       unsigned long start, unsigned long len,
> > > +			       bool enable_wp, bool *mmap_changing);
> > > 
> > >  /* mm helpers */
> > >  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index fefa81c301b7..529d180bb4d7 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -639,3 +639,57 @@ ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
> > >  {
> > >  	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing, 0);
> > >  }
> > > +
> > > +int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> > > +			unsigned long len, bool enable_wp, bool *mmap_changing)
> > > +{
> > > +	struct vm_area_struct *dst_vma;
> > > +	pgprot_t newprot;
> > > +	int err;
> > > +
> > > +	/*
> > > +	 * Sanitize the command parameters:
> > > +	 */
> > > +	BUG_ON(start & ~PAGE_MASK);
> > > +	BUG_ON(len & ~PAGE_MASK);
> > > +
> > > +	/* Does the address range wrap, or is the span zero-sized? */
> > > +	BUG_ON(start + len <= start);
> > 
> > I'd replace these BUG_ON()s with
> > 
> > 	if (WARN_ON())
> > 		 return -EINVAL;
> 
> I believe BUG_ON() is used because these parameters should have been
> checked in userfaultfd_writeprotect() already by the common
> validate_range() even before calling mwriteprotect_range().  So I'm
> fine with the WARN_ON() approach but I'd slightly prefer to simply
> keep the patch as is to keep Jerome's r-b if you won't disagree. :)

Right, userfaultfd_writeprotect() should check these parameters and if it
didn't it was a bug indeed. But still, it's not severe enough to crash the
kernel.

I hope Jerome wouldn't mind to keep his r-b with s/BUG_ON/WARN_ON ;-)

With this change you can also add 

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
 
> Thanks,
> 
> -- 
> Peter Xu
> 

-- 
Sincerely yours,
Mike.


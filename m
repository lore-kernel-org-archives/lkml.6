Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CAAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724E42146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfBYVPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:15:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729109AbfBYVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PL4muX136847
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:15:43 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qvqsu0xus-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:15:43 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Feb 2019 21:15:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Feb 2019 21:15:34 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1PLFXV332243892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 21:15:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC04CA4062;
        Mon, 25 Feb 2019 21:15:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BDA3A4054;
        Mon, 25 Feb 2019 21:15:31 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.243])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Feb 2019 21:15:30 +0000 (GMT)
Date:   Mon, 25 Feb 2019 23:15:28 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
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
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 23/26] userfaultfd: wp: don't wake up when doing write
 protect
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-24-peterx@redhat.com>
 <20190221183653.GV2813@redhat.com>
 <20190225085846.GE13653@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225085846.GE13653@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022521-0016-0000-0000-0000025AC7EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022521-0017-0000-0000-000032B5271F
Message-Id: <20190225211528.GF10454@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=848 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:58:46PM +0800, Peter Xu wrote:
> On Thu, Feb 21, 2019 at 01:36:54PM -0500, Jerome Glisse wrote:
> > On Tue, Feb 12, 2019 at 10:56:29AM +0800, Peter Xu wrote:
> > > It does not make sense to try to wake up any waiting thread when we're
> > > write-protecting a memory region.  Only wake up when resolving a write
> > > protected page fault.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > I am bit confuse here, see below.
> > 
> > > ---
> > >  fs/userfaultfd.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index 81962d62520c..f1f61a0278c2 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1771,6 +1771,7 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
> > >  	struct uffdio_writeprotect uffdio_wp;
> > >  	struct uffdio_writeprotect __user *user_uffdio_wp;
> > >  	struct userfaultfd_wake_range range;
> > > +	bool mode_wp, mode_dontwake;
> > >  
> > >  	if (READ_ONCE(ctx->mmap_changing))
> > >  		return -EAGAIN;
> > > @@ -1789,18 +1790,20 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
> > >  	if (uffdio_wp.mode & ~(UFFDIO_WRITEPROTECT_MODE_DONTWAKE |
> > >  			       UFFDIO_WRITEPROTECT_MODE_WP))
> > >  		return -EINVAL;
> > > -	if ((uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP) &&
> > > -	     (uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE))
> 
> [1]
> 
> > > +
> > > +	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
> > > +	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
> > > +
> > > +	if (mode_wp && mode_dontwake)
> 
> [2]
> 
> > >  		return -EINVAL;
> > 
> > I am confuse by the logic here. DONTWAKE means do not wake any waiting
> > thread right ? So if the patch header it seems to me the logic should
> > be:
> >     if (mode_wp && !mode_dontwake)
> >         return -EINVAL;
> 
> This should be the most common case when we want to write protect a
> page (or a set of pages).  I'll explain more details below...
> 
> > 
> > At very least this part does seems to mean the opposite of what the
> > commit message says.
> 
> Let me paste the matrix to be clear on these flags:
> 
>   |------+-------------------------+------------------------------|
>   |      | dontwake=0              | dontwake=1                   |
>   |------+-------------------------+------------------------------|
>   | wp=0 | (a) resolve pf, do wake | (b) resolve pf only, no wake |
>   | wp=1 | (c) wp page range       | (d) invalid                  |
>   |------+-------------------------+------------------------------|
> 
> Above check at [1] was checking against case (d) in the matrix.  It is
> indeed an invalid condition because when we want to write protect a
> page we should not try to wake up any thread, so the donewake
> parameter is actually useless (we'll always do that).  And above [2]
> is simply rewritting [1] with the new variables.

I think (c) is "wp range and wake the thread", and (d) is "wp and DONT
wake".

 
> > 
> > >  
> > >  	ret = mwriteprotect_range(ctx->mm, uffdio_wp.range.start,
> > > -				  uffdio_wp.range.len, uffdio_wp.mode &
> > > -				  UFFDIO_WRITEPROTECT_MODE_WP,
> > > +				  uffdio_wp.range.len, mode_wp,
> > >  				  &ctx->mmap_changing);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	if (!(uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE)) {
> > > +	if (!mode_wp && !mode_dontwake) {
> > 
> > This part match the commit message :)
> 
> Here is what the patch really want to change: before this patch we'll
> even call wake_userfault() below for case (c) while it doesn't really
> make too much sense IMHO.  After this patch we'll only do the wakeup
> for (a,b).

Waking up the thread after the last region is write-protected would make
sense. Not much savings for lots of ranges, though.
 
> > 
> > >  		range.start = uffdio_wp.range.start;
> > >  		range.len = uffdio_wp.range.len;
> > >  		wake_userfault(ctx, &range);
> 
> Thanks,
> 
> -- 
> Peter Xu
> 

-- 
Sincerely yours,
Mike.


Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB759C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8162D24736
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hjyxwdlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8162D24736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeGCVka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:40:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33740 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeGCVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:40:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63Ldlf9162860;
        Tue, 3 Jul 2018 21:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=XBLPPmf2n4+SJC4R+NSPphFjDQzSlsT5RVtDfoLFWuI=;
 b=hjyxwdlNDyOTEYiimKSNNrjIBzhQrd9pgH/hCQpqZy1pX+Iqtee3Lp7pAmIy7CXKaxHR
 U+Rbtn3OFHTukzlaOFDnKl7QwxNyyhNnQYGUM0xMMSdHFahT+mxpkjzOtr0hOmv09lT9
 sKS7VmvH2062jf/eVnxKN+WHh088rrRX4LoG2Varajvy5ZM7zRYFTp2G4Pf23+YRUTGe
 hDZbIzdPawjamEKslaUxffD7CK6e6BgL/jVdv7ODkJSWsd7dyTuMYmRu55EwoOb6b4ei
 cnAkS/EXZYBf7MI2WvKb258zEsoOgL0HY97VtV5d2YP3knPGd0pDsAqkooH943kbk5Pu cQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k0dnjgkm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 21:39:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w63Ldks1013798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 21:39:46 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w63LdjlK031752;
        Tue, 3 Jul 2018 21:39:45 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 14:39:44 -0700
Date:   Tue, 3 Jul 2018 14:39:43 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bob Peterson <rpeterso@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, willy@infradead.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs: iomap: Change return type to vm_fault_t
Message-ID: <20180703213943.GU32415@magnolia>
References: <20180702154354.GA3919@jordon-HP-15-Notebook-PC>
 <CAHc6FU6CVaT3W15n4jSiy6F4cZEFa9HdrZ8NRrU2GppTXr7p8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6CVaT3W15n4jSiy6F4cZEFa9HdrZ8NRrU2GppTXr7p8A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 07:52:41PM +0200, Andreas Gruenbacher wrote:
> On 2 July 2018 at 17:43, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > Return type has been changed to vm_fault_t type for
> > iomap_page_mkwrite().
> >
> > see commit 1c8f422059ae ("mm: change return type to
> > vm_fault_t") for reference.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

I don't recall Christoph [now cc'd] rescinding his NAK of the previous
version of this patch[1].  Has he changed his mind since May?

[1] https://spinics.net/lists/linux-fsdevel/msg126032.html

Now granted I didn't have a problem with the code (and applied the xfs
version to 4.18 after monitoring to satisfy myself that nothing
particularly weird happened during 4.17) but seeing as most of the iomap
changes have gone through hch's review and landed via the xfs tree...

> > ---
> >  fs/iomap.c            | 2 +-
> >  include/linux/iomap.h | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/iomap.c b/fs/iomap.c
> > index afd1635..58477ee 100644
> > --- a/fs/iomap.c
> > +++ b/fs/iomap.c
> > @@ -443,7 +443,7 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
> >         return length;
> >  }
> >
> > -int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
> > +vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
> >  {
> >         struct page *page = vmf->page;
> >         struct inode *inode = file_inode(vmf->vma->vm_file);
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 19a07de..666b717 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -3,6 +3,7 @@
> >  #define LINUX_IOMAP_H 1
> >
> >  #include <linux/types.h>
> > +#include <linux/mm_types.h>
> >
> >  struct fiemap_extent_info;
> >  struct inode;
> > @@ -88,7 +89,8 @@ int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
> >                 bool *did_zero, const struct iomap_ops *ops);
> >  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> >                 const struct iomap_ops *ops);
> > -int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops);
> > +vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
> > +                       const struct iomap_ops *ops);
> >  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >                 loff_t start, loff_t len, const struct iomap_ops *ops);
> >  loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
> > --
> > 1.9.1
> >
> 
> Added to for-next, thanks.

...this part caused me to sit up and say "Hey what?" :)

Which tree is this? gfs2?

--D

> 
> Andreas

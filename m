Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031566AbeCAOrj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:47:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031450AbeCAOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:47:37 -0500
Date: Thu, 1 Mar 2018 15:47:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Split page_type out from mapcount
In-Reply-To: <20180301124412.gm6jxwzyfskzxspa@node.shutemov.name>
References: <20180228223157.9281-1-willy@infradead.org>
        <20180301081750.42b135c3@mschwideX1>
        <20180301124412.gm6jxwzyfskzxspa@node.shutemov.name>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030114-0040-0000-0000-000004397E56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030114-0041-0000-0000-000020DC82F8
Message-Id: <20180301154730.3bfeaf03@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 15:44:12 +0300
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> On Thu, Mar 01, 2018 at 08:17:50AM +0100, Martin Schwidefsky wrote:
> > On Wed, 28 Feb 2018 14:31:53 -0800
> > Matthew Wilcox <willy@infradead.org> wrote:
> >   
> > > From: Matthew Wilcox <mawilcox@microsoft.com>
> > > 
> > > I want to use the _mapcount field to record what a page is in use as.
> > > This can help with debugging and we can also expose that information to
> > > userspace through /proc/kpageflags to help diagnose memory usage (not
> > > included as part of this patch set).
> > > 
> > > First, we need s390 to stop using _mapcount for its own purposes;
> > > Martin, I hope you have time to look at this patch.  I must confess I
> > > don't quite understand what the different bits are used for in the upper
> > > nybble of the _mapcount, but I tried to replicate what you were doing
> > > faithfully.  
> > 
> > Yeah, that is a nasty bit of code. On s390 we have 2K page tables (pte)
> > but 4K pages. If we use full pages for the pte tables we waste 2K of
> > memory for each of the tables. So we allocate 4K and split it into two
> > 2K pieces. Now we have to keep track of the pieces to be able to free
> > them again.  
> 
> Have you considered to use slab for page table allocation instead?
> IIRC some architectures practice this already.

Well there is a complication with KVM and the page table management for
gmaps. If mm_alloc_pgste(mm) == true then a 4K page page table has to be
allocated. For the gmap I need a place to store an 8 byte value, currently
we use page->index. But the slab/slub code uses page->index for its own
purpose. This creates a conflict, but maybe doing a get_free_page for
mm_alloc_pgste(mm) == true and using a slab cache for normal page tables
might work.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

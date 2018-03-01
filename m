Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031635AbeCAPDX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:03:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031531AbeCAPDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:03:21 -0500
Date: Thu, 1 Mar 2018 16:02:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Split page_type out from mapcount
In-Reply-To: <20180301145058.GA19662@bombadil.infradead.org>
References: <20180228223157.9281-1-willy@infradead.org>
        <20180301081750.42b135c3@mschwideX1>
        <20180301124412.gm6jxwzyfskzxspa@node.shutemov.name>
        <20180301145058.GA19662@bombadil.infradead.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030115-0020-0000-0000-000003FD61EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030115-0021-0000-0000-000042919085
Message-Id: <20180301160258.6a619212@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=2
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 06:50:58 -0800
Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Mar 01, 2018 at 03:44:12PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Mar 01, 2018 at 08:17:50AM +0100, Martin Schwidefsky wrote:  
> > > Yeah, that is a nasty bit of code. On s390 we have 2K page tables (pte)
> > > but 4K pages. If we use full pages for the pte tables we waste 2K of
> > > memory for each of the tables. So we allocate 4K and split it into two
> > > 2K pieces. Now we have to keep track of the pieces to be able to free
> > > them again.  
> > 
> > Have you considered to use slab for page table allocation instead?
> > IIRC some architectures practice this already.  
> 
> You're not allowed to do that any more.  Look at pgtable_page_ctor(),
> or rather ptlock_init().

Oh yes, I forgot about the ptl. This takes up some fields in struct page
which the slab/slub cache want to use as well.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

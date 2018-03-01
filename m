Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031475AbeCAOkC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:40:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031055AbeCAOkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:40:01 -0500
Date: Thu, 1 Mar 2018 15:39:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] s390: Use _refcount for pgtables
In-Reply-To: <20180301142855.emaa5x65oj2hkwsm@node.shutemov.name>
References: <20180228223157.9281-1-willy@infradead.org>
        <20180228223157.9281-2-willy@infradead.org>
        <20180301125310.jx6c5dypk5axrmum@node.shutemov.name>
        <20180301150420.19a14fd3@mschwideX1>
        <20180301142855.emaa5x65oj2hkwsm@node.shutemov.name>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030114-0020-0000-0000-000003FD5F6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030114-0021-0000-0000-000042918DE4
Message-Id: <20180301153952.668bfdc7@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010185
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 17:28:55 +0300
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> On Thu, Mar 01, 2018 at 03:04:20PM +0100, Martin Schwidefsky wrote:
> > On Thu, 1 Mar 2018 15:53:10 +0300
> > "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> >   
> > > On Wed, Feb 28, 2018 at 02:31:54PM -0800, Matthew Wilcox wrote:  
> > > > From: Matthew Wilcox <mawilcox@microsoft.com>
> > > > 
> > > > s390 borrows the storage used for _mapcount in struct page in order to
> > > > account whether the bottom or top half is being used for 2kB page
> > > > tables.  I want to use that for something else, so use the top byte of
> > > > _refcount instead of the bottom byte of _mapcount.  _refcount may
> > > > temporarily be incremented by other CPUs that see a stale pointer to
> > > > this page in the page cache, but each CPU can only increment it by one,
> > > > and there are no systems with 2^24 CPUs today, so they will not change
> > > > the upper byte of _refcount.  We do have to be a little careful not to
> > > > lose any of their writes (as they will subsequently decrement the
> > > > counter).    
> > > 
> > > Hm. I'm more worried about false-negative put_page_testzero().
> > > Are you sure it won't lead to leaks. I cannot say from the code changes.
> > > 
> > > And for page-table pages should have planty space in other fields.
> > > IIRC page->mapping is unused there.  
> >  
> > 2^^24 put_page_testzero calls for page table pages? I don't think so.  
> 
> No, I mean oposite: we don't free the page when we should. 2^24 is not
> zero and page won't be freed if the acctual refcount (without the flag in
> upper bits) drops to zero.

Ah, ok. But this is not a problem as the page is freed after both bits for
the two 2K pieces havbe been set to zero.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

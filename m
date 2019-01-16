Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E58C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5921206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393722AbfAPOuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:50:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbfAPOuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:50:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 278DF2CD80F;
        Wed, 16 Jan 2019 14:50:22 +0000 (UTC)
Received: from redhat.com (ovpn-122-22.rdu2.redhat.com [10.10.122.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B55D860FC8;
        Wed, 16 Jan 2019 14:50:18 +0000 (UTC)
Date:   Wed, 16 Jan 2019 09:50:16 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20190116145016.GB3617@redhat.com>
References: <20190114172124.GA3702@redhat.com>
 <20190115080759.GC29524@quack2.suse.cz>
 <20190115171557.GB3696@redhat.com>
 <752839e6-6cb3-a6aa-94cb-63d3d4265934@nvidia.com>
 <20190115221205.GD3696@redhat.com>
 <99110c19-3168-f6a9-fbde-0a0e57f67279@nvidia.com>
 <20190116015610.GH3696@redhat.com>
 <CAPcyv4h2hX_CJ=Ffzip4YzryOX0NPo9yy+yDsSPnyp20xat94Q@mail.gmail.com>
 <20190116022312.GJ3696@redhat.com>
 <20190116043455.GP4205@dastard>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116043455.GP4205@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 16 Jan 2019 14:50:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 16, 2019 at 03:34:55PM +1100, Dave Chinner wrote:
> On Tue, Jan 15, 2019 at 09:23:12PM -0500, Jerome Glisse wrote:
> > On Tue, Jan 15, 2019 at 06:01:09PM -0800, Dan Williams wrote:
> > > On Tue, Jan 15, 2019 at 5:56 PM Jerome Glisse <jglisse@redhat.com> wrote:
> > > > On Tue, Jan 15, 2019 at 04:44:41PM -0800, John Hubbard wrote:
> > > [..]
> > > > To make it clear.
> > > >
> > > > Lock code:
> > > >     GUP()
> > > >         ...
> > > >         lock_page(page);
> > > >         if (PageWriteback(page)) {
> > > >             unlock_page(page);
> > > >             wait_stable_page(page);
> > > >             goto retry;
> > > >         }
> > > >         atomic_add(page->refcount, PAGE_PIN_BIAS);
> > > >         unlock_page(page);
> > > >
> > > >     test_set_page_writeback()
> > > >         bool pinned = false;
> > > >         ...
> > > >         pinned = page_is_pin(page); // could be after TestSetPageWriteback
> > > >         TestSetPageWriteback(page);
> > > >         ...
> > > >         return pinned;
> > > >
> > > > Memory barrier:
> > > >     GUP()
> > > >         ...
> > > >         atomic_add(page->refcount, PAGE_PIN_BIAS);
> > > >         smp_mb();
> > > >         if (PageWriteback(page)) {
> > > >             atomic_add(page->refcount, -PAGE_PIN_BIAS);
> > > >             wait_stable_page(page);
> > > >             goto retry;
> > > >         }
> > > >
> > > >     test_set_page_writeback()
> > > >         bool pinned = false;
> > > >         ...
> > > >         TestSetPageWriteback(page);
> > > >         smp_wmb();
> > > >         pinned = page_is_pin(page);
> > > >         ...
> > > >         return pinned;
> > > >
> > > >
> > > > One is not more complex than the other. One can contend, the other
> > > > will _never_ contend.
> > > 
> > > The complexity is in the validation of lockless algorithms. It's
> > > easier to reason about locks than barriers for the long term
> > > maintainability of this code. I'm with Jan and John on wanting to
> > > explore lock_page() before a barrier-based scheme.
> > 
> > How is the above hard to validate ?
> 
> Well, if you think it's so easy, then please write the test cases so
> we can add them to fstests and make sure that we don't break it in
> future.
> 
> If you can't write filesystem test cases that exercise these race
> conditions reliably, then the answer to your question is "it is
> extremely hard to validate" and the correct thing to do is to start
> with the simple lock_page() based algorithm.
> 
> Premature optimisation in code this complex is something we really,
> really need to avoid.

Litmus test shows that this never happens, i am attaching 2 litmus
test one with barrier and one without. Without barrier we can see
the double negative !PageWriteback in GUP and !page_pinned() in
test_set_page_writeback() (0:EAX = 0; 1:EAX = 0; below)


    ~/local/bin/litmus7 -r 100 gup.litmus

    ...

    Histogram (3 states)
    2     *>0:EAX=0; 1:EAX=0; x=1; y=1;
    4999999:>0:EAX=1; 1:EAX=0; x=1; y=1;
    4999999:>0:EAX=0; 1:EAX=1; x=1; y=1;
    Ok

    Witnesses
    Positive: 2, Negative: 9999998
    Condition exists (0:EAX=0 /\ 1:EAX=0) is validated
    Hash=2d53e83cd627ba17ab11c875525e078b
    Observation SB Sometimes 2 9999998
    Time SB 3.24



With the barrier this never happens:
    ~/local/bin/litmus7 -r 10000 gup-mb.litmus

    ...

    Histogram (3 states)
    499579828:>0:EAX=1; 1:EAX=0; x=1; y=1;
    499540152:>0:EAX=0; 1:EAX=1; x=1; y=1;
    880020:>0:EAX=1; 1:EAX=1; x=1; y=1;
    No

    Witnesses
    Positive: 0, Negative: 1000000000
    Condition exists (0:EAX=0 /\ 1:EAX=0) is NOT validated
    Hash=0dd48258687c8f737921f907c093c316
    Observation SB Never 0 1000000000


I do not know any better test than litmus for this kind of thing.

Cheers,
Jérôme

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gup.litmus"

X86 SB
"GUP"
{ x=0; y=0; }
 P0          | P1          ;
 MOV [x],$1  | MOV [y],$1  ;
 MOV EAX,[y] | MOV EAX,[x] ;
locations [x;y;]
exists (0:EAX=0 /\ 1:EAX=0)

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gup-mb.litmus"

X86 SB
"GUP with barrier"
{ x=0; y=0; }
 P0          | P1          ;
 MOV [x],$1  | MOV [y],$1  ;
 MFENCE      | MFENCE      ;
 MOV EAX,[y] | MOV EAX,[x] ;
locations [x;y;]
exists (0:EAX=0 /\ 1:EAX=0)

--7AUc2qLy4jB3hD7Z--

Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034D9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DF12145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DF12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbeK1Dze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:55:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:36058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730080AbeK1Dzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:55:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AEE9AF86;
        Tue, 27 Nov 2018 16:57:00 +0000 (UTC)
Date:   Tue, 27 Nov 2018 17:56:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is
 migrated
Message-ID: <20181127165659.GC6923@dhcp22.suse.cz>
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils>
 <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
 <alpine.LSU.2.11.1811251900300.1278@eggly.anvils>
 <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
 <20181126205351.GM3065@bombadil.infradead.org>
 <20181127105602.GC16502@rapoport-lnx>
 <010001675613a406-89de05df-ccf6-4bfa-ae3b-6f94148d514a-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001675613a406-89de05df-ccf6-4bfa-ae3b-6f94148d514a-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-11-18 16:49:47, Cristopher Lameter wrote:
> On Tue, 27 Nov 2018, Mike Rapoport wrote:
> 
> > >  * @page: The page to wait for.
> > >  *
> > >  * The caller should hold a reference on @page.  They expect the page to
> > >  * become unlocked relatively soon, but do not wish to hold up migration
> > >  * (for example) by holding the reference while waiting for the page to
> > >  * come unlocked.  After this function returns, the caller should not
> > >  * dereference @page.
> > >  */
> >
> > How about:
> >
> > They expect the page to become unlocked relatively soon, but they can wait
> > for the page to come unlocked without holding the reference, to allow
> > other users of the @page (for example migration) to continue.
> 
> All of this seems a bit strange and it seems unnecessary? Maybe we need a
> better explanation?
> 
> A process has no refcount on a page struct and is waiting for it to become
> unlocked? Why? Should it not simply ignore that page and continue? It
> cannot possibly do anything with the page since it does not hold a
> refcount.

So do you suggest busy waiting on the page under migration?
-- 
Michal Hocko
SUSE Labs

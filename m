Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12486C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3FA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Frb3vTyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3FA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbeK1DsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:48:17 -0500
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:58582 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729321AbeK1DsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1543337387;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=F1BHzZ5aX6F/cjHQOy9JOoTV5AqgXTRV8TX/oyCxgEM=;
        b=Frb3vTygO3nJKf5UEWUGLn1kdK9I85MCdX95jMYkEf9epLFu+3FdOU7yAxKIpF80
        Vpy+NusMrad+1kO4Axx3jmb1aJ4NlbNzIOfb1D9N6cRzrT6Vocpdx/y3H8R+ab/iAL7
        C2Y+LkARC19RJ21r2RP0eLn3NJ0xbwnISstSlQv0=
Date:   Tue, 27 Nov 2018 16:49:47 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Mike Rapoport <rppt@linux.ibm.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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
In-Reply-To: <20181127105602.GC16502@rapoport-lnx>
Message-ID: <010001675613a406-89de05df-ccf6-4bfa-ae3b-6f94148d514a-000000@email.amazonses.com>
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils> <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com> <alpine.LSU.2.11.1811251900300.1278@eggly.anvils> <alpine.LSU.2.11.1811261121330.1116@eggly.anvils> <20181126205351.GM3065@bombadil.infradead.org>
 <20181127105602.GC16502@rapoport-lnx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.11.27-54.240.9.35
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Mike Rapoport wrote:

> >  * @page: The page to wait for.
> >  *
> >  * The caller should hold a reference on @page.  They expect the page to
> >  * become unlocked relatively soon, but do not wish to hold up migration
> >  * (for example) by holding the reference while waiting for the page to
> >  * come unlocked.  After this function returns, the caller should not
> >  * dereference @page.
> >  */
>
> How about:
>
> They expect the page to become unlocked relatively soon, but they can wait
> for the page to come unlocked without holding the reference, to allow
> other users of the @page (for example migration) to continue.

All of this seems a bit strange and it seems unnecessary? Maybe we need a
better explanation?

A process has no refcount on a page struct and is waiting for it to become
unlocked? Why? Should it not simply ignore that page and continue? It
cannot possibly do anything with the page since it does not hold a
refcount.

In order to do anything with the page struct it would have to obtain a
refcount and possibly lock the page. That would already wait for the
page to become unlocked.




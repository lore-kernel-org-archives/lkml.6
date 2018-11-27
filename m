Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DD1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94102086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kI9KMl33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94102086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeK1FJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:09:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeK1FJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RKrob1IKXllljtP901kTqdVePcgUxEq8tg19bjgaUgs=; b=kI9KMl33+XTB9FTJWvkl7e2up
        OQdGV+vn+Y+zXhyDbLGvvKnzIJ4a1KMOCvYbH5eIp0WIR4SCOclkvwiXa4QLpJXFL3xsVu17d8rtK
        wf6AuVOdtK5s6fgVGI20YAP9rqDYvq1gktqEjScLggvt6s3uqutIPHjxxpO7J6xOigC6YaqEEeFwZ
        f57uiqrNNujL8xta16rdbOHH69z0VJHj3E4KIUINdTKwKPZjo6e9jpyeKEVLQ6r4Y1mDaNVVPEd+t
        HpmNG1dVrQr5xUH+QGsAxxl8NGx/9GMRm8JhyUOrt4V36PLXYXk5nlSCBW886yO/1cuar+/NmVdPd
        V+NxBBMFw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRhoy-0003Yg-4D; Tue, 27 Nov 2018 18:10:52 +0000
Date:   Tue, 27 Nov 2018 10:10:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Hugh Dickins <hughd@google.com>,
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
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is
 migrated
Message-ID: <20181127181051.GD10377@bombadil.infradead.org>
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils>
 <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
 <alpine.LSU.2.11.1811251900300.1278@eggly.anvils>
 <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
 <20181127105848.GD16502@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127105848.GD16502@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:58:48PM +0200, Mike Rapoport wrote:
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 81adec8ee02c..575e16c037ca 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1049,25 +1056,44 @@ static void wake_up_page(struct page *page, int bit)
> >  	wake_up_page_bit(page, bit);
> >  }
> > 
> > +/*
> > + * A choice of three behaviors for wait_on_page_bit_common():
> > + */
> > +enum behavior {
> > +	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
> > +			 * __lock_page() waiting on then setting PG_locked.
> > +			 */
> > +	SHARED,		/* Hold ref to page and check the bit when woken, like
> > +			 * wait_on_page_writeback() waiting on PG_writeback.
> > +			 */
> > +	DROP,		/* Drop ref to page before wait, no check when woken,
> > +			 * like put_and_wait_on_page_locked() on PG_locked.
> > +			 */
> > +};
> 
> Can we please make it:
> 
> /**
>  * enum behavior - a choice of three behaviors for wait_on_page_bit_common()
>  */

The enum isn't used outside mm/filemap.c, so I'm not entirely sure that
including kernel-doc for it is a good idea.


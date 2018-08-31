Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C26BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF4A20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF4A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeHaUUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:20:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728502AbeHaUUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:20:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54F7D2E9BF;
        Fri, 31 Aug 2018 16:12:32 +0000 (UTC)
Received: from redhat.com (ovpn-123-69.rdu2.redhat.com [10.10.123.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0A2F2027EA0;
        Fri, 31 Aug 2018 16:12:31 +0000 (UTC)
Date:   Fri, 31 Aug 2018 12:12:30 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 5/7] mm/hmm: use a structure for update callback
 parameters
Message-ID: <20180831161230.GA4111@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-6-jglisse@redhat.com>
 <20180830231148.GC28695@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830231148.GC28695@350D>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 31 Aug 2018 16:12:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 31 Aug 2018 16:12:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 09:11:48AM +1000, Balbir Singh wrote:
> On Fri, Aug 24, 2018 at 03:25:47PM -0400, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > Use a structure to gather all the parameters for the update callback.
> > This make it easier when adding new parameters by avoiding having to
> > update all callback function signature.
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  include/linux/hmm.h | 25 +++++++++++++++++--------
> >  mm/hmm.c            | 27 ++++++++++++++-------------
> >  2 files changed, 31 insertions(+), 21 deletions(-)
> > 
> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index 1ff4bae7ada7..a7f7600b6bb0 100644
> > --- a/include/linux/hmm.h
> > +++ b/include/linux/hmm.h
> > @@ -274,13 +274,26 @@ static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
> >  struct hmm_mirror;
> >  
> >  /*
> > - * enum hmm_update_type - type of update
> > + * enum hmm_update_event - type of update
> >   * @HMM_UPDATE_INVALIDATE: invalidate range (no indication as to why)
> >   */
> > -enum hmm_update_type {
> > +enum hmm_update_event {
> >  	HMM_UPDATE_INVALIDATE,
> >  };
> >  
> > +/*
> > + * struct hmm_update - HMM update informations for callback
> > + *
> > + * @start: virtual start address of the range to update
> > + * @end: virtual end address of the range to update
> > + * @event: event triggering the update (what is happening)
> > + */
> > +struct hmm_update {
> > +	unsigned long start;
> > +	unsigned long end;
> > +	enum hmm_update_event event;
> > +};
> > +
> 
> I wonder if you want to add further information about the range,
> like page_size, I guess the other side does not care about the
> size. Do we care about sending multiple discontig ranges in
> hmm_update? Should it be an array?
> 
> Balbir Singh

This is a range of virtual address if a huge page is fully unmapped
then the range will cover the full huge page. It mirror mmu notifier
range callback because 99% of the time it is just use to pass down
mmu notifier invalidation. So we don't care about multi range at
least not yet.

Nor do we care about page size as it might vary in the range (range
can have a mix of THP and regular page) moreover the device driver
usualy ignore the page size.


Cheers,
Jérôme

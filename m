Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70370C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472F82086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBTWTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:19:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfBTWTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:19:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4210D8552A;
        Wed, 20 Feb 2019 22:19:36 +0000 (UTC)
Received: from redhat.com (ovpn-121-220.rdu2.redhat.com [10.10.121.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8256F5D9D2;
        Wed, 20 Feb 2019 22:19:35 +0000 (UTC)
Date:   Wed, 20 Feb 2019 17:19:33 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 10/10] mm/hmm: add helpers for driver to safely take the
 mmap_sem
Message-ID: <20190220221933.GB29398@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-11-jglisse@redhat.com>
 <16e62992-c937-6b05-ae37-a287294c0005@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e62992-c937-6b05-ae37-a287294c0005@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 20 Feb 2019 22:19:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 01:59:13PM -0800, John Hubbard wrote:
> On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > The device driver context which holds reference to mirror and thus to
> > core hmm struct might outlive the mm against which it was created. To
> > avoid every driver to check for that case provide an helper that check
> > if mm is still alive and take the mmap_sem in read mode if so. If the
> > mm have been destroy (mmu_notifier release call back did happen) then
> > we return -EINVAL so that calling code knows that it is trying to do
> > something against a mm that is no longer valid.
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> >   include/linux/hmm.h | 50 ++++++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 47 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index b3850297352f..4a1454e3efba 100644
> > --- a/include/linux/hmm.h
> > +++ b/include/linux/hmm.h
> > @@ -438,6 +438,50 @@ struct hmm_mirror {
> >   int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
> >   void hmm_mirror_unregister(struct hmm_mirror *mirror);
> > +/*
> > + * hmm_mirror_mm_down_read() - lock the mmap_sem in read mode
> > + * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
> > + * Returns: -EINVAL if the mm is dead, 0 otherwise (lock taken).
> > + *
> > + * The device driver context which holds reference to mirror and thus to core
> > + * hmm struct might outlive the mm against which it was created. To avoid every
> > + * driver to check for that case provide an helper that check if mm is still
> > + * alive and take the mmap_sem in read mode if so. If the mm have been destroy
> > + * (mmu_notifier release call back did happen) then we return -EINVAL so that
> > + * calling code knows that it is trying to do something against a mm that is
> > + * no longer valid.
> > + */
> 
> Hi Jerome,
> 
> Are you thinking that, throughout the HMM API, there is a problem that
> the mm may have gone away, and so driver code needs to be littered with
> checks to ensure that mm is non-NULL? If so, why doesn't HMM take a
> reference on mm->count?
> 
> This solution here cannot work. I think you'd need refcounting in order
> to avoid this kind of problem. Just doing a check will always be open to
> races (see below).
> 
> 
> > +static inline int hmm_mirror_mm_down_read(struct hmm_mirror *mirror)
> > +{
> > +	struct mm_struct *mm;
> > +
> > +	/* Sanity check ... */
> > +	if (!mirror || !mirror->hmm)
> > +		return -EINVAL;
> > +	/*
> > +	 * Before trying to take the mmap_sem make sure the mm is still
> > +	 * alive as device driver context might outlive the mm lifetime.
> > +	 *
> > +	 * FIXME: should we also check for mm that outlive its owning
> > +	 * task ?
> > +	 */
> > +	mm = READ_ONCE(mirror->hmm->mm);
> > +	if (mirror->hmm->dead || !mm)
> > +		return -EINVAL;
> > +
> 
> Nothing really prevents mirror->hmm->mm from changing to NULL right here.

This is really just to catch driver mistake, if driver does not call
hmm_mirror_unregister() then the !mm will never be true ie the
mirror->hmm->mm can not go NULL until the last reference to hmm_mirror
is gone.

> 
> > +	down_read(&mm->mmap_sem);
> > +	return 0;
> > +}
> > +
> 
> ...maybe better to just drop this patch from the series, until we see a
> pattern of uses in the calling code.

It use by nouveau now.

Cheers,
Jérôme

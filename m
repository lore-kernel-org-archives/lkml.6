Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeCUSMk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:12:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751416AbeCUSMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:12:38 -0400
Date: Wed, 21 Mar 2018 14:12:36 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 04/15] mm/hmm: unregister mmu_notifier when last HMM
 client quit
Message-ID: <20180321181235.GF3214@redhat.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-5-jglisse@redhat.com>
 <55b8cf9f-2a81-19f3-ff4f-70d5a411baaa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55b8cf9f-2a81-19f3-ff4f-70d5a411baaa@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 09:24:41PM -0700, John Hubbard wrote:
> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > This code was lost in translation at one point. This properly call
> > mmu_notifier_unregister_no_release() once last user is gone. This
> > fix the zombie mm_struct as without this patch we do not drop the
> > refcount we have on it.
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  mm/hmm.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 6088fa6ed137..667944630dc9 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -244,10 +244,29 @@ EXPORT_SYMBOL(hmm_mirror_register);
> >  void hmm_mirror_unregister(struct hmm_mirror *mirror)
> >  {
> >  	struct hmm *hmm = mirror->hmm;
> > +	struct mm_struct *mm = NULL;
> > +	bool unregister = false;
> >  
> >  	down_write(&hmm->mirrors_sem);
> >  	list_del_init(&mirror->list);
> > +	unregister = list_empty(&hmm->mirrors);
> 
> Hi Jerome,
> 
> This first minor point may be irrelevant, depending on how you fix 
> the other problem below, but: tiny naming idea: rename unregister 
> to either "should_unregister", or "mirror_snapshot_empty"...the 
> latter helps show that this is stale information, once the lock is 
> dropped. 

First name make sense, second doesn't (at least to me), mirror is dead
at this point, it does not have any implication respective to snapshot
(the mm might still be very well alive and in active use).


> >  	up_write(&hmm->mirrors_sem);
> > +
> > +	if (!unregister)
> > +		return;
> 
> Whee, here I am, lock-free, in the middle of a race condition
> window. :)  Right here, someone (hmm_mirror_register) could be adding
> another mirror.
> 
> It's not immediately clear to me what the best solution is.
> I'd be happier if we didn't have to drop one lock and take
> another like this, but if we do, then maybe rechecking that
> the list hasn't changed...safely, somehow, is a way forward here.
> 

First i want to stress this is very unlikely race, it can only happens
if one hmm_mirror unregister and is last one while another new one try
to register. Highly unlikely but i am sending a v2 which fix that any-
way better safe than sorry. It makes the register side a bit ugly.

Cheers,
Jérôme

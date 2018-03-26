Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeCZM2p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 08:28:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751141AbeCZM2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 08:28:44 -0400
Date: Mon, 26 Mar 2018 14:28:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: Re: [PATCH 1/4] vfio: ccw: fix cleanup if cp_prefetch fails
Message-ID: <20180326142839.23bfc4f6.cohuck@redhat.com>
In-Reply-To: <54fd02cd-bd0b-889b-c40f-f9a32aa25d77@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
        <20180321020822.86255-2-bjsdjshi@linux.vnet.ibm.com>
        <682d8b1c-5aca-7015-043b-a3f1446bf378@linux.vnet.ibm.com>
        <20180322022248.GB12194@bjsdjshi@linux.vnet.ibm.com>
        <54fd02cd-bd0b-889b-c40f-f9a32aa25d77@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018 10:37:36 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 22/03/2018 03:22, Dong Jia Shi wrote:
> > * Halil Pasic <pasic@linux.vnet.ibm.com> [2018-03-21 13:49:54 +0100]:
> >  
> >>
> >> On 03/21/2018 03:08 AM, Dong Jia Shi wrote:  
> >>> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>>
> >>> If the translation of a channel program fails, we may end up attempting
> >>> to clean up (free, unpin) stuff that never got translated (and allocated,
> >>> pinned) in the first place.
> >>>
> >>> By adjusting the lengths of the chains accordingly (so the element that
> >>> failed, and all subsequent elements are excluded) cleanup activities
> >>> based on false assumptions can be avoided.
> >>>
> >>> Let's make sure cp_free works properly after cp_prefetch returns with an
> >>> error by setting ch_len to 0 for the ccw chains those are not prefetched.  
> >> This sentence used to be:
> >>
> >> Let's make sure cp_free works properly after cp_prefetch returns with an
> >> error.
> >>
> >> @Dong Jia
> >> I find the 'by setting ch_len to 0 for the ccw chains those are not prefetched'
> >> you added for clarification (I guess) somewhat problematic.
> >> The chain in which the translation failure occurred
> >> +	chain->ch_len = idx;  
> > I made a mistake. When rewording the message, I missed this part...
> > Sorry for the problem!
> >  
> >> is shortened so that only the translated elements (ccws) are going to
> >> get cleaned up (on a per element basis) by cp_free. This may or may
> >> not be the first ccw. Subsequent chains are shortened to 0 as there
> >> no translation took place.
> >>
> >> So as a result of this change only properly translated ccws are going
> >> to get (re)visited by cp_free as only those may have resources bound
> >> to them which need to be released.
> >>
> >> I'm not against improving the commit message. But this ain't
> >> an improvement to me.  
> > You are right. How about:
> > Let's make sure cp_free works properly after cp_prefetch returns with an
> > error by setting ch_len of a ccw chain to the number of the translated
> > ccws on that chain.  
> 
> By the way, since you will propose a new version,
> you have a long description of the cp_prefetch function in the code.
> I think you should modify it according to the changes and describe how and
> why the ch_len field of each chain is used and changed by this function.
> 
> Something like:
> 
> "
> For each chain composing the channel program:
> On entry ch_len hold the count of CCW to be translated.

s/hold/holds/ ?

> On exit ch_len is adjusted to the count of successfully translated CCW.
> 
> This allows cp_free to find in ch_len the count of CCW to free in a chain.
> "
> 
> Could also be inside the commit message.
> 
> Pierre
> 
> 
> >  
> >>> Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> >>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> >>> ---
> >>>   drivers/s390/cio/vfio_ccw_cp.c | 9 ++++++++-
> >>>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> >>> index d9a2fffd034b..2be114db02f9 100644
> >>> --- a/drivers/s390/cio/vfio_ccw_cp.c
> >>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> >>> @@ -749,11 +749,18 @@ int cp_prefetch(struct channel_program *cp)
> >>>   		for (idx = 0; idx < len; idx++) {
> >>>   			ret = ccwchain_fetch_one(chain, idx, cp);
> >>>   			if (ret)
> >>> -				return ret;
> >>> +				goto out_err;
> >>>   		}
> >>>   	}
> >>>
> >>>   	return 0;
> >>> +out_err:
> >>> +	/* Only cleanup the chain elements that where actually translated. */

s/where/were/

> >>> +	chain->ch_len = idx;
> >>> +	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
> >>> +		chain->ch_len = 0;
> >>> +	}
> >>> +	return ret;
> >>>   }
> >>>
> >>>   /**
> >>>  
> 

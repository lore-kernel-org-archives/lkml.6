Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeDTLgU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:36:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754549AbeDTLgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:36:18 -0400
Date: Fri, 20 Apr 2018 13:36:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: Re: [PATCH 1/4] vfio: ccw: fix cleanup if cp_prefetch fails
Message-ID: <20180420133614.20e3c6ae.cohuck@redhat.com>
In-Reply-To: <59687ed1-befb-a861-7b91-40859ac00bb7@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
        <20180321020822.86255-2-bjsdjshi@linux.vnet.ibm.com>
        <682d8b1c-5aca-7015-043b-a3f1446bf378@linux.vnet.ibm.com>
        <20180322022248.GB12194@bjsdjshi@linux.vnet.ibm.com>
        <54fd02cd-bd0b-889b-c40f-f9a32aa25d77@linux.vnet.ibm.com>
        <20180326142839.23bfc4f6.cohuck@redhat.com>
        <20180327014200.GH12194@bjsdjshi@linux.vnet.ibm.com>
        <59687ed1-befb-a861-7b91-40859ac00bb7@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 12:54:26 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> ping
> 
> I think get this fixed. Better sooner than later.
> 
> On 03/27/2018 03:42 AM, Dong Jia Shi wrote:
> > * Cornelia Huck <cohuck@redhat.com> [2018-03-26 14:28:39 +0200]:
> > 
> > [...]
> >   
> >>> By the way, since you will propose a new version,
> >>> you have a long description of the cp_prefetch function in the code.
> >>> I think you should modify it according to the changes and describe how and
> >>> why the ch_len field of each chain is used and changed by this function.
> >>>
> >>> Something like:
> >>>
> >>> "
> >>> For each chain composing the channel program:
> >>> On entry ch_len hold the count of CCW to be translated.  
> >>
> >> s/hold/holds/ ?
> >>  
> > Sure.
> >   
> >>> On exit ch_len is adjusted to the count of successfully translated CCW.
> >>>
> >>> This allows cp_free to find in ch_len the count of CCW to free in a chain.
> >>> "
> >>>
> >>> Could also be inside the commit message.
> >>>
> >>> Pierre
> >>>
> >>>  
> >>>>     
> >>>>>> Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >>>>>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> >>>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>>>>> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> >>>>>> ---
> >>>>>>    drivers/s390/cio/vfio_ccw_cp.c | 9 ++++++++-
> >>>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> >>>>>> index d9a2fffd034b..2be114db02f9 100644
> >>>>>> --- a/drivers/s390/cio/vfio_ccw_cp.c
> >>>>>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> >>>>>> @@ -749,11 +749,18 @@ int cp_prefetch(struct channel_program *cp)
> >>>>>>    		for (idx = 0; idx < len; idx++) {
> >>>>>>    			ret = ccwchain_fetch_one(chain, idx, cp);
> >>>>>>    			if (ret)
> >>>>>> -				return ret;
> >>>>>> +				goto out_err;
> >>>>>>    		}
> >>>>>>    	}
> >>>>>>
> >>>>>>    	return 0;
> >>>>>> +out_err:
> >>>>>> +	/* Only cleanup the chain elements that where actually translated. */  
> >>
> >> s/where/were/  
> > Ok.
> >   
> >>  
> >>>>>> +	chain->ch_len = idx;
> >>>>>> +	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
> >>>>>> +		chain->ch_len = 0;
> >>>>>> +	}
> >>>>>> +	return ret;
> >>>>>>    }
> >>>>>>
> >>>>>>    /**
> >>>>>>     
> >>>  
> >>  
> >   
> 

Hm, it seems that drowned in other patches... can I get a re-send,
please?

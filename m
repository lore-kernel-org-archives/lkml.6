Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797A4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5085221A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbeLVQ76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:59:58 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:59165 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732597AbeLVQ75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:59:57 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id B9FF05C075C; Sat, 22 Dec 2018 09:04:21 +0100 (CET)
Date:   Sat, 22 Dec 2018 09:04:21 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     David Rientjes <rientjes@google.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Arun KS <arunks@codeaurora.org>, Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] mm: vmalloc: do not allow kzalloc to fail
Message-ID: <20181222080421.GB26155@osadl.at>
References: <1545337437-673-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.21.1812211356040.219499@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1812211356040.219499@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 01:58:39PM -0800, David Rientjes wrote:
> On Thu, 20 Dec 2018, Nicholas Mc Guire wrote:
> 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 871e41c..1c118d7 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1258,7 +1258,7 @@ void __init vmalloc_init(void)
> >  
> >  	/* Import existing vmlist entries. */
> >  	for (tmp = vmlist; tmp; tmp = tmp->next) {
> > -		va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
> > +		va = kzalloc(sizeof(*va), GFP_NOWAIT | __GFP_NOFAIL);
> >  		va->flags = VM_VM_AREA;
> >  		va->va_start = (unsigned long)tmp->addr;
> >  		va->va_end = va->va_start + tmp->size;
> 
> Hi Nicholas,
> 
> You're right that this looks wrong because there's no guarantee that va is 
> actually non-NULL.  __GFP_NOFAIL won't help in init, unfortunately, since 
> we're not giving the page allocator a chance to reclaim so this would 
> likely just end up looping forever instead of crashing with a NULL pointer 
> dereference, which would actually be the better result.
>
tried tracing the __GFP_NOFAIL path and had concluded that it would
end in out_of_memory() -> panic("System is deadlocked on memory\n");
which also should point cleanly to the cause - but I´m actually not
that sure if that trace was correct in all cases.
 
> You could do
> 
> 	BUG_ON(!va);
> 
> to make it obvious why we crashed, however.  It makes it obvious that the 
> crash is intentional rather than some error in the kernel code.

makes sense - that atleast makes it imediately clear from the code
that there is no way out from here.

thx!
hofrat

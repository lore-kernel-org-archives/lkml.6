Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CFDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0146920862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0146920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390162AbeHASIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:08:34 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:45459 "EHLO
        6.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389854AbeHASId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:08:33 -0400
X-Greylist: delayed 2410 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Aug 2018 14:08:32 EDT
Received: from player697.ha.ovh.net (unknown [10.109.146.1])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id D3692C23C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 17:03:51 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player697.ha.ovh.net (Postfix) with ESMTPSA id 2D6E34800B1;
        Wed,  1 Aug 2018 17:03:45 +0200 (CEST)
Date:   Wed, 1 Aug 2018 17:03:44 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH 1/2] net/9p: embed fcall in req to
 round down buffer allocs
Message-ID: <20180801170344.2ce3a762@bahia.lan>
In-Reply-To: <20180801143840.GA21463@nautica>
References: <20180730093101.GA7894@nautica>
        <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
        <20180801161413.0523a821@bahia.lan>
        <20180801143840.GA21463@nautica>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14688208713122158848
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrledvgdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 16:38:40 +0200
Dominique Martinet <asmadeus@codewreck.org> wrote:

> Greg Kurz wrote on Wed, Aug 01, 2018:
> > > @@ -263,13 +261,13 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
> > >  	if (!req)
> > >  		return NULL;
> > >  
> > > +	if (p9_fcall_alloc(&req->tc, alloc_msize))
> > > +		goto free;
> > > +	if (p9_fcall_alloc(&req->rc, alloc_msize))
> > >  		goto free;  
> > 
> > Hmm... if the first allocation fails, we will kfree() req->rc.sdata.
> > 
> > Are we sure we won't have a stale pointer or uninitialized data in
> > there ?  
> 
> Yeah, Jun pointed that out and I have a v2 that only frees as needed
> with an extra goto (I sent an incremental diff in my reply to his
> comment here[1])
> 
> [1] https://lkml.kernel.org/r/20180731011256.GA30388@nautica
> 
> > And even if we don't with the current code base, this is fragile and
> > could be easily broken.
> > 
> > I think you should drop this hunk and rather rename p9_fcall_alloc() to
> > p9_fcall_alloc_sdata() instead, since this is what the function is
> > actually doing with this patch applied.  
> 
> Hmm. I agree the naming isn't accurate, but even if we rename it we'll
> need to pass a pointer to fcall as argument as it inits its capacity.
> p9_fcall_init(fc, msize) might be simpler?
> 

Ah yes you're right... alloc is a bit misleading then. I agree that
p9_fcall_init() is more appropriate in this case.

And maybe you should introduce p9_fcall_fini() or _release() for
completeness. It would only do kfree() for a start, but it would
then evolve to be like the p9_fcall_kfree() function from patch 2.

> (I'm not sure I follow what you mean by 'drop this hunk', to be honest,
> did you want a single function call to init both maybe?)
> 

I was meaning "keep the same logic in p9_tag_alloc()", something like:

	req->tc.sdata = p9_fcall_alloc_sdata(&req->tc, alloc_msize);
	req->rc.sdata = p9_fcall_alloc_sdata(&req->tc, alloc_msize);
	if (!req->tc.sdata || !req->rc.sdata)

But I agree the way you did is cleaner.

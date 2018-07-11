Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D55C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1A62084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1A62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbeGKNCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:02:43 -0400
Received: from nautica.notk.org ([91.121.71.147]:44202 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbeGKNCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:02:42 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D9864C009; Wed, 11 Jul 2018 14:58:27 +0200 (CEST)
Date:   Wed, 11 Jul 2018 14:58:12 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 2/6] 9p: Replace the fidlist with an IDR
Message-ID: <20180711125812.GA9691@nautica>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-3-willy@infradead.org>
 <20180711124038.GB835@nautica>
 <20180711125219.GA23640@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711125219.GA23640@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Wed, Jul 11, 2018:
> On Wed, Jul 11, 2018 at 02:40:38PM +0200, Dominique Martinet wrote:
> > > +	idr_preload(GFP_KERNEL);
> > > +	spin_lock_irq(&clnt->lock);
> > > +	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, UINT_MAX, GFP_NOWAIT);
> > 
> > There's also a P9_NOFID that we shouldn't use, so the max here should be
> > P9_NOFID - 1
> 
> Happy to fix that.  It shouldn't actually happen, of course.  I can't
> imagine us having 4 billion FIDs in use at once.

Oh, I said that assuming that it was random.. But I guess we might as
well fix it.

> > That aside this introduces a change of behaviour that fid used to be
> > alloc'd linearily from 0 which no longer holds true, that breaks one
> > serveur (nfs-ganesha just returns ERANGE) but others seem to handle this
> > just fine so they'll just need to fix that server.
> > max aside this looks good.
> 
> I don't understand your assertion that this is a change of behaviour.
> The implementation of p9_idpool_get() uses idr_alloc(), not
> idr_alloc_cyclic(), so I don't believe I've changed which FID would
> be allocated.

Hmm, I just tried mounting something with ganesha and that broke because
it received fid=1730858632 in a TATTACH request, so something in the
patch series made some big fid happens.

If you say this isn't intented though this needs debugging, I'm glad I
brought this up :P

(Note that it really should be fine if it is random within the pool, I
have notified the current developpers of the problem)
-- 
Dominique

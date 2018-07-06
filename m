Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A2FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6498824079
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wSis1HEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6498824079
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753809AbeGFBgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:36:21 -0400
Received: from casper.infradead.org ([85.118.1.10]:44418 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753577AbeGFBgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5fOqsnfj6iqE09j0kpwKJq41zTtSndK4BWcEEPYmfN8=; b=wSis1HExyMr/s4fzJU5sNJxZv
        gwigfkXxhDCNvDGTX3buxl2CLItXnobamTmC7iw+aCzs0Je7m+nNYJPnFaBkzr//lNiENAbEHbsQb
        a/x6rhJ0cqRcNK9yTKADkecJtJ7y79CC/9e3k5JgBTxgDuNhuxyGsOoXEmDgjBDA7cIzxtWm+cgoL
        HQHE6yPYQoROLPzfbn2vRpfU4a51Ow8BOjrWNcdbKCyOdbegczZ27ZHlq1/y5m8OJVtOwaOh7evoz
        +Eugqb8iveLPE1JtwAfTs1Hpt7xDBNCWrNuDo0YD/pNXtQAGJLylwGapAEK0MahXuH33bkY22s5mA
        5qVMdp28g==;
Received: from jsimmons (helo=localhost)
        by casper.infradead.org with local-esmtp (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbFfK-0005Jg-Sc; Fri, 06 Jul 2018 01:36:09 +0000
Date:   Fri, 6 Jul 2018 02:36:06 +0100 (BST)
From:   James Simmons <jsimmons@infradead.org>
To:     NeilBrown <neilb@suse.com>
cc:     Oleg Drokin <green@linuxhacker.ru>,
        Andreas Dilger <andreas.dilger@whamcloud.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 01/11] staging: lustre: simplify use of interval-tree.
In-Reply-To: <87sh5mfit7.fsf@notabene.neil.brown.name>
Message-ID: <alpine.LFD.2.21.1807060235330.12665@casper.infradead.org>
References: <152826510267.16761.14361003167157833896.stgit@noble> <152826511890.16761.16115276596203531205.stgit@noble> <alpine.LFD.2.21.1806160344210.6450@casper.infradead.org> <87sh5mfit7.fsf@notabene.neil.brown.name>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180706_023607_132699_9477DD2A 
X-CRM114-Status: GOOD (  30.88  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >> Lustre has a private interval-tree implementation.  This
> >> implementation (inexplicably) refuses to insert an interval if an
> >> identical interval already exists.  It is OK with all sorts of
> >> overlapping intervals, but identical intervals are rejected.
> >
> > I talked to Oleg about this since this changes the behavior. He is worried
> > about having identical items that would end up being merged.  If we can 
> > guarantee by some other means there are no identical nodes, we are 
> > probably fine with the interval tree code allowing this. Oleg can explain 
> > better than me in this case.
> 
> I don't think this is a change in behaviour.
> In the driver/staging client code, interval tree is being used in two
> places and both of them have clumsy work-arounds for the fact that they
> cannot insert duplicates in the interval tree.
> The patch just cleans his up.
> 
> However if I have missed something, please provide details.
> What "identical items" might get merged?

Oleg could you fill in detail what your concerns are?
 
> >  
> >> Both users of interval-tree in lustre would be simpler if this was not
> >> the case.  They need to store all intervals, even if some are
> >> identical.
> >> 
> >> llite/range_lock.c add a rl_next_lock list_head to each lock.
> >> If it cannot insert a new lock because the range is in use, it
> >> attached the new lock to the existing lock using rl_next_lock.
> >> This requires extra code to iterate over the rl_next_lock lists when
> >> iterating over locks, and to update the list when deleting a lock from
> >> the tree.
> >> 
> >> ldlm_extend allocates a separate ldlm_interval which as a list of
> >> ldlm_locks which share the same interval.  This is linked together
> >> by over-loading the l_sl_policy which, for non-extent locks, is used
> >> for linking together locks with the same policy.
> >> This doesn't only require extra code, but also an extra memory
> >> allocation.
> >> 
> >> This patch removes all that complexity.
> >> - interval_insert() now never fails.
> >
> > Its not really a failure. What it does is if it finds a already existing
> > node with the range requested it returns the already existing node 
> > pointer. If not it just creates a new node and returns NULL. Sometimes
> > identical request can happen. A good example of this is with HSM request
> > on the MDS server. In that case sometimes we get identical progress
> > reports which we want to filter out so not add the same data.
> 
> This example is server-side code which is not a focus at present.
> Having a quick look, it looks like it would be easy enough to do a
> lookup first and then only insert if the lookup failed.
> I think this is a much nicer approach than never allowing duplicates in
> the interval tree.
> 
> Thanks,
> NeilBrown
> 

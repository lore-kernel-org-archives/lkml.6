Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97271C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E6020851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LL2gSny3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E6020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeLMOZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:25:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeLMOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RNdAwpOpjcEw5gyuU3aQftdjop2zfLzob/Tq26DDJHw=; b=LL2gSny39IbnWdLneMuNTDPVd
        4QMA8s4nvuxWbjA5v+KtHBy4QSYzu3QwpPJjeBP2GktX8pQMxI0QMZ/2P4yTFObHDOWKnrwe7xwGo
        Yg/PYVrtsBODwZEiP/6m+v4iYiLRKIF1OczVGhCKaH0nU3WnPAf/OZZKJjleTyS9VNVQFHMh/CVZC
        zaAGkjnSrIOLLzlcSxut7PdRoRaB2unXhUXgfdeBBASLVQbRibHfEl4ULqbskDfUhreO2dng/f1fI
        4owRphFHDMHwaut8TKcT9KrKa22gOySIvyLl5SbNq5MvDAjmIH7m3UOUvC78vmWYOim8LARSf8Htt
        Tp20i7YLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXRvx-00033Q-9b; Thu, 13 Dec 2018 14:25:49 +0000
Date:   Thu, 13 Dec 2018 06:25:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, david@fromorbit.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [GIT PULL] xfs: fixes for v4.20-rc6
Message-ID: <20181213142549.GA6708@infradead.org>
References: <20181208163639.GR24487@magnolia>
 <CAHk-=who9EqvvGaazise-dh7_DH6rLOULWXzysinyAPnHS4B0A@mail.gmail.com>
 <20181211135818.GA29626@infradead.org>
 <20181212181658.GA24487@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212181658.GA24487@magnolia>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:16:58AM -0800, Darrick J. Wong wrote:
> On Tue, Dec 11, 2018 at 05:58:18AM -0800, Christoph Hellwig wrote:
> > On Sat, Dec 08, 2018 at 11:24:48AM -0800, Linus Torvalds wrote:
> > > Honestly, I really wish you simply wouldn't send me "xfs" fixes that
> > > aren't really xfs-specific at all.
> > > 
> > > All the splice patches (and honestly, I feel some of the iomap ones
> > > too) that have come in through the xfs tree should have been handled
> > > separately as actual VFS patches. Or at least had acks from Al or
> > > something.
> > 
> > iomap came in through the XFS tree originally, and has been very much
> > maintained in combo, even though we now have another user with gfs.
> > 
> > Maybe we just need to make that official in MAINTAINERS?
> 
> Yes, though who should be the official maintainer?  You wrote most of
> the iomap code; do you want to maintain it yourself?  Or have people
> funnel them wherever XFS patches go? :)

Well, the original version is from Dave, although I'm not sure if much
of that code is left.  I think just maintaining it with XFS is a good
idea.  But if we need an explicit maintainer I can do it.

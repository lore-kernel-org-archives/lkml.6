Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 759A0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A9E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTx05+TK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A9E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933377AbeFLTqZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:46:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbeFLTqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GvV/DJtcfeUvcJNr9HvAcI80OVaVJW1r42Wln8X5UQg=; b=LTx05+TKCDRG/2mHIr7twBDlm
        5z+AK0Y3ONE3t2QJBb0hjTd7MnfOLrj+6UOlAzLtnMYTv9GKBnYvKpd92hrEv+sN4ijQyUsPfIixR
        e3CdSNzX0f4YuyR+TP2ftS81yrj4JGmsFADmZJhIHVYjgZ1tqx6OSwFEPYipB/HwSWiwlj5VAA9wM
        Woqpog8zUUidl1XSs55qiTb8AP4V+ZqRYZsdoIyQltcM99/ppOj8UOJHJGqJmvh56Vajcv6NhdYd/
        2Kbo3fB6/TNOeCUqTzX3ZfHLzPdiHnZEg+OtqxnWSYy6gS2ikANGNcn6tQn85Ow/4cz4g1yEqy51s
        PHvRsdz7A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSpFD-000190-Dw; Tue, 12 Jun 2018 19:46:19 +0000
Date:   Tue, 12 Jun 2018 12:46:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>, dsterba@suse.cz,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v13 00/72] Convert page cache to XArray
Message-ID: <20180612194619.GH19433@bombadil.infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
 <20180612104041.GB24375@twin.jikos.cz>
 <20180612113122.GA19433@bombadil.infradead.org>
 <20180612193741.GC28436@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612193741.GC28436@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 01:37:41PM -0600, Ross Zwisler wrote:
> On Tue, Jun 12, 2018 at 04:31:22AM -0700, Matthew Wilcox wrote:
> > On Tue, Jun 12, 2018 at 12:40:41PM +0200, David Sterba wrote:
> > > [ 9875.174796] kernel BUG at fs/inode.c:513!
> > 
> > What the ...
> > 
> > Somehow the fix for that got dropped.  I spent most of last week chasing
> > that problem!  This is the correct code:
> > 
> > http://git.infradead.org/users/willy/linux-dax.git/commitdiff/01177bb06761539af8a6c872416109e2c8b64559
> > 
> > I'll check over the patchset and see if anything else got dropped!
> 
> Can you please repost when you have this sorted?
> 
> I think the commit you've pointed to is in your xarray-20180601 branch, but I
> see two more recent xarray branches in your tree (xarray-20180608 and
> xarray-20180612).
> 
> Basically, I don't know what is stable and what's not, and what I should be
> reviewing/testing.

Yup, I shall.  The xarray-20180612 is the most recent thing I've
published, but I'm still going over the 0601 patchset looking for other
little pieces I may have dropped.  I've found a couple, and I'm updating
the 0612 branch each time I find another one.

If you want to start looking at the DAX patches on the 0612 branch,
that wouldn't be a waste of your time.  Neither would testing; I don't
think I dropped anything from the DAX patches.

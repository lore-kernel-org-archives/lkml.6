Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67A32C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1A0208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LC0v2tgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1A0208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeFLLb1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:31:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754048AbeFLLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kCJ7AWirobGh2Zm8TEC48kzMvT41UnudiQ0reX4UUcI=; b=LC0v2tgjJerxdiJ825b9lMbb6
        52Z1i98sLxNo/AOLPu+39+JOUKRJ3h8W9KzyIxK4RJLigW3O9iVe+VqNgoxkuvgpZ5XZP/exV3S0O
        OxtbzEcByp5HdUZMQfetJ7iEAKZQZOS3QS9KgY7wB10OVdOXjIRSWFqUYkVpqv1XnjSXe1XgoYjjS
        4Wg4BF2rLGRHxAfKQEx/jkfloM3Ri8usxdDMnJTJoMtAcU0sUgVhXZZ7CRmL8jlrrF6V7v060SafP
        jPfTrEZa5vG6ow4S96SYLZNjIQlKi8dK5dXCW47zXwcegIbYWUEn4HgY9ymqhRUkdsDTa5UQmsb6R
        oAjsAEiNA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fShWF-0007Yy-DL; Tue, 12 Jun 2018 11:31:23 +0000
Date:   Tue, 12 Jun 2018 04:31:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     dsterba@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v13 00/72] Convert page cache to XArray
Message-ID: <20180612113122.GA19433@bombadil.infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
 <20180612104041.GB24375@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612104041.GB24375@twin.jikos.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 12:40:41PM +0200, David Sterba wrote:
> [ 9875.174796] kernel BUG at fs/inode.c:513!

What the ...

Somehow the fix for that got dropped.  I spent most of last week chasing
that problem!  This is the correct code:

http://git.infradead.org/users/willy/linux-dax.git/commitdiff/01177bb06761539af8a6c872416109e2c8b64559

I'll check over the patchset and see if anything else got dropped!


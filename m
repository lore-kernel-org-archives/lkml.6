Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91960C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEF021841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FKUYdz2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeLSHLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:11:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLSHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GbFsH92F8LYgPzCETeldoQ5SjmPUN4loEk5ARz1d5Lo=; b=FKUYdz2A7lD/wcAmN4VQB7ReZ
        Lgl8H/8o3qxyTy4Qrd0kzjFNfZgwEW/4A17spUy06+j1ZmKiCMGm/JqEVzULLFNVD6YgyV6A/T/wC
        fwJ14RzGklfd0d/VUx0k4aci1UnU9BMsLzEb6kvjWEKQqQ1Zf5xIb+E7pMp0xx6hs54HEmL8DbQHE
        1KnXMPVGy4uoDSAMMFLpNVzxA6VH3qL69thOxAepoM9kB++VCMw9vauMuCiVtxdbYi/upISDr6vgt
        2210gFBDEKBLzEst+J+w5wsWB+JVGqQlzfrwuOxPJT03+uI6708Oj4/J3MYcFl400o/mCRvvjJHF0
        SyntpkbtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZW1F-0002i2-MI; Wed, 19 Dec 2018 07:11:49 +0000
Date:   Tue, 18 Dec 2018 23:11:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181219071149.GB2628@infradead.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214044802.GA681@sol.localdomain>
 <20181217200039.GD8111@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217200039.GD8111@magnolia>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:00:39PM -0800, Darrick J. Wong wrote:
> FWIW, if I were (hypothetically) working on an xfs implementation, I
> likely would have settled on passing a reference to a merkle tree
> through a (fd, length) pair, because that allows us plenty of options
> on the back end:
> 
> b) we could remap the tree into a new inode fork for merkle trees, or
> a) remap it as posteof blocks like ext4/f2fs does, or
> c) remap the blocks into the attribute fork as an (unusually large)
> extended attribute value.
>
> If the merkle_fd isn't on the same filesystem as the fd we could at
> least use generic_copy_file_range (i.e. page cache copying) to land the
> merkle tree wherever we want.

I think the fd would have to be on the same fs for this interface to
make sense. But it could be an O_TMPFILE one.  And given that ext4
already supports a variant of swapext this interface should also work
with the existing ext4 on disk format.

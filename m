Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B595C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E6521841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fzX09TCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeLSHJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:09:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeLSHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/KC9DHMjwbOpXhQULiC+bGxJFMoZGP8G7cGQ95/QabA=; b=fzX09TCdB0RNQPNuytVszcw2o
        xWE3VbUouxsxmIxZxo3vpW8mbznVEpBRKBFZcOewcZYd/VkwzaboqfyRXUTW8vfgQIaXJdrBk6bN6
        9BJxOVZA2ybK3tuF0x9xh4KDqSRZnbCpz84l/HoexuiDoL6H9AS+u3IPiq39ZtEG3fUXQn/ExLgNM
        YlG/9Xvq9k7YZtK39Q7lwKh2lJ792HzjtbR16QQqu7za3h4i93w9VXm/IxQ8npru46Pab7jbB7xJJ
        AW0ivDlPKgEo/FwDVNtvG1Q6cji6gfBgoQILMd9cwVygsBOHnEwEfVfgQ7T1XKwasLfTrjWo6mzqP
        lUizwtyCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZVym-0001Ic-2e; Wed, 19 Dec 2018 07:09:16 +0000
Date:   Tue, 18 Dec 2018 23:09:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181219070915.GA2628@infradead.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214044802.GA681@sol.localdomain>
 <20181217164949.GA18626@infradead.org>
 <20181217183205.GA141684@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217183205.GA141684@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:32:06AM -0800, Eric Biggers wrote:
> I don't see how that helps.  The Merkle tree can still be too large to fit in
> memory.  In the worst case, it might not even fit in the address space.  And I
> don't see how get_user_pages() helps either over just copy_from_user(); what are
> you proposing to do with the pages after getting them, exactly?

Write them out to a file system specific area on the media.  Note
that get_user_pages is indeed not going to work if you run out of
address space, but that seems like an odd use case.  Out of of memory
is not an issue as we generally iterate over a small number of pages
for each individual get_user_pages call.

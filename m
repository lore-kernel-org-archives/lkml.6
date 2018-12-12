Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1BAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6AE20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nlC+p7qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6AE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeLLJOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:14:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cyvfG977++0v85COWokyHPWFctjF9dnRReeN8YCr/Eg=; b=nlC+p7qhDd/wgENLWKBV/YFLj
        BRmgoZVWt9IGQkh70JwuWH9RplN1P5OTGFBn8sM6t7vnFdQmYmeCSCuZ26nJeoQ7aQUD7LTtPUs0x
        JSpn7b1LzgJczXb4foNgN19OXisDB6z1vObwsUdlbSAULegj7d5T/5Iqwv7sftHUpxuQZeQA65/RU
        pAbdjuTgzbcJlxPyMN483T83qxS7dm2OUTfo6njYmMozUhiLCh+tlSLVQfz2iQE6HjebWVZ2lG+5z
        9YxFY5yHMMp+MLMZ2jUl7jbV0BSzLp5mgIhHV+Uz9G1Y93QhJzL1x1ajscMsymgaAb7a+dJedyxG9
        9uf3IsPrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX0ak-00020g-NQ; Wed, 12 Dec 2018 09:14:06 +0000
Date:   Wed, 12 Dec 2018 01:14:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181212091406.GA31723@infradead.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101225230.88058-2-ebiggers@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As this apparently got merged despite no proper reviews from VFS
level persons:

NAK - the ioctl format that expects the verifycation hash in the file
data data with padding after the real data is simply not acceptable,
we can't just transform the data in the file itself based on a magic
calls like this.

Also the core code should not depend on this as a storage format,
which is a rather bad idea.  In any modern file system you can
store data like this out of line in something like the attr fork
in XFS, or the attr items in btrfs.

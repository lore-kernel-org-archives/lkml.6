Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B2C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D466D208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mc7Zmobc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D466D208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeGHO7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 10:59:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbeGHO7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w7n5xn2KVh+d/2zY0JJzWYROVUuzFb38z7RyoiaPrZA=; b=Mc7ZmobcWevqEmjQbHIEDH1ly
        0kJsgmeAzPlQ8/RADkqxC4ETr7eFC5032gfnaZM7kHOHSEX6qn1V5EaThh40nBGHf0bPgHMYlXPr9
        WB5G2Ua5R5geERiSbjnXD+DqxFiNRil7lUFn8hrtpjw2Eey4v7GkoO6yT0aziINONh3rW60SyLLQF
        oHWpv0wx5KTFwJEcD2uKTG31HhC4tbRjW9Fa0ZQF7bsz/YvCkgDsZntdDOYDf3VfCWvy38Noqip+Z
        dgzyPWXil4WJIyDE0sq8eOoyIA0p7ZBcSIXcHwc1uqIr6QT5xistmYapzmtCWc9SNOx4Z/f1rotkN
        5edKck2Cw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcB96-0008S9-Kk; Sun, 08 Jul 2018 14:58:40 +0000
Date:   Sun, 8 Jul 2018 07:58:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, dgilbert@interlog.com,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        security@kernel.org
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
Message-ID: <20180708145840.GA22949@infradead.org>
References: <20180615152335.208202-1-jannh@google.com>
 <20180615164009.GD30522@ZenIV.linux.org.uk>
 <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com>
 <813e817b-bb2f-4a47-6225-9e39f19be278@kernel.dk>
 <20180621123431.GA558@infradead.org>
 <36a641db-fb1d-6c4c-7f1b-172f2b1cde32@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a641db-fb1d-6c4c-7f1b-172f2b1cde32@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 08:07:23AM -0600, Jens Axboe wrote:
> I'd be fine with that, if we knew that nobody uses it. But that's
> really hard to figure out. I did see Jann's source code scan, which
> even if non-exhaustive, still shows at least one user of it.

One is an example, and the other looks very close to an example,
as far as I can tell it was Nic doing a bsg read/write WIP for a
tgt module without anyone every picking up on it.  I did add the tgt
list to Cc and no one seemed to care about the bsg read/write support.
Adding the tgt list back, but I doubt anyone ever actually used it.

> How about we just make the write interface sync? Then any copy can
> happen while the we block the task, and the read side is just
> copying the header info back, or dumping it if the task didn't
> read it before it went away.

How is that going to work?  As far as I can tell each I/O using
bsg read/write needs a write and a read, so they need to pair
and thus can't be a purely sync interface.

It also doesn't help with the issue that bsg_write may possible
write to user memory, which is highly unusal and asking for security
issues itself.

Either way, we should probably at very least apply a respun version
of the patch from Jann to 4.18-rc and -stable while we keep discussing
this.

Jann, can you respin the bsg patch with the same changes as the now
included sg one?

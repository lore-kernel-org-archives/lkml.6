Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F332BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA32208E8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="owxGzm3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA32208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeGKGgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:36:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeGKGgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n9fuoTQCZZ/FwexcXMPwdNHqbnFoiAGACfsbLUzM5E8=; b=owxGzm3BJVvWweIF7A+CuIegu
        yYQ+8KlQM07lDknvB/XGIWCX7nyN1HPltcjDQ8aSjAiiUnj31IKH9YFLl1FjSDKm9+ALBzVORIk8y
        gsrSp34bzq675A9DAOpHDJK7urKA8DkFqN8ogpDR9BILvJAv80rXyEcfD2EY7nynrMb249WLQdZtv
        XpcBFc9KHyV/uBejdKfRqDWtD+u+/Fj5yrg2SfMUgJMufWdT+iXWwLewY6w5MJPe5/LIkw2uPKftI
        bR4yASqvo5Zo2iIsn1SDcf2mWY/2HSwoDU2D0FIz+d0x9fgSz46kDWuja3YWrLqZ5SgQ+9Rl1d0CY
        OEnTWeF6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fd8gV-000618-BI; Wed, 11 Jul 2018 06:33:07 +0000
Date:   Tue, 10 Jul 2018 23:33:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        Douglas Gilbert <dgilbert@interlog.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        fujita.tomonori@lab.ntt.co.jp, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
Message-ID: <20180711063307.GA31127@infradead.org>
References: <20180615152335.208202-1-jannh@google.com>
 <20180615164009.GD30522@ZenIV.linux.org.uk>
 <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com>
 <813e817b-bb2f-4a47-6225-9e39f19be278@kernel.dk>
 <20180621123431.GA558@infradead.org>
 <36a641db-fb1d-6c4c-7f1b-172f2b1cde32@kernel.dk>
 <20180708145840.GA22949@infradead.org>
 <CAG48ez0ahgHZAEYHt_J_MAanRNX+PXN+2MwtR-VM=gm8Ym30kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0ahgHZAEYHt_J_MAanRNX+PXN+2MwtR-VM=gm8Ym30kg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 01:53:02PM -0700, Jann Horn wrote:
> With the error messages like in my sg patch or like with Linus'
> proposed patch (https://lore.kernel.org/lkml/CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com/)
> applied?

I guess we should follows Linus' suggestions.

Note that he also seems to agree with me to just remove the read/write
interface.  Compared to sg bsg really is unused for the read/write
interface.  But lets get your fix in first..

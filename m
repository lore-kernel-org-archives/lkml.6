Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C81EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F6720846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RwTAzJ1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F6720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbeGKNNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:13:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeGKNNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZUltF0npA//UKgQtzhT8p2kjr6/3movVZVA23/V/nSI=; b=RwTAzJ1/4oq3FaSbbxRvvNG/E
        2Wpomiy/Fc+9ANekliG0j9ft6fv7IYXOiPGvGrQq+Rjn1LAE8rrk0vA5e1emJf2h5NkEzBoL9jtkT
        zyF5Nw7cExT4WHGeYqh87u55agkekZSGWzRQmckiHSIJEStp6sAeuPXYB5wfnBIw2zVf7/Mm49pGx
        YPKyFOeo+2aVbE8D4ujXz8XAi0qXaYdoWagRMw24OLoFrIwFmqxo/sRObennJGapEN7tWWOhgDqCS
        nmANxPeR92C+4+F2jxRpkKBIRtncvq3AC4BujMBCZOW0yW9KZWulCFoxPeh33O/xlxzTrQ/3IFhxW
        1MLYehNag==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdErX-0002h9-Ix; Wed, 11 Jul 2018 13:08:55 +0000
Date:   Wed, 11 Jul 2018 06:08:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 2/6] 9p: Replace the fidlist with an IDR
Message-ID: <20180711130854.GB23640@bombadil.infradead.org>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-3-willy@infradead.org>
 <20180711124038.GB835@nautica>
 <20180711125219.GA23640@bombadil.infradead.org>
 <20180711125812.GA9691@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711125812.GA9691@nautica>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 02:58:12PM +0200, Dominique Martinet wrote:
> > I don't understand your assertion that this is a change of behaviour.
> > The implementation of p9_idpool_get() uses idr_alloc(), not
> > idr_alloc_cyclic(), so I don't believe I've changed which FID would
> > be allocated.
> 
> Hmm, I just tried mounting something with ganesha and that broke because
> it received fid=1730858632 in a TATTACH request, so something in the
> patch series made some big fid happens.
> 
> If you say this isn't intented though this needs debugging, I'm glad I
> brought this up :P
> 
> (Note that it really should be fine if it is random within the pool, I
> have notified the current developpers of the problem)

Heh, unintended protocol fuzzing ;-)

I see the problem; need to initialise fid->fid to 0 before calling
idr_alloc_u32.  I'd misread:

        memset(&fid->qid, 0, sizeof(struct p9_qid));
as
        memset(fid, 0, sizeof(struct p9_fid));

so I thought fid->fid was already 0.  I'll fix that up, thanks!

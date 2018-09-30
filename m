Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4811EC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D324A20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J6lHNB2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D324A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeI3Tna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 15:43:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49521 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728380AbeI3Tna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 15:43:30 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 340A120F1D;
        Sun, 30 Sep 2018 09:10:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 30 Sep 2018 09:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=hDriGazQUFLgqv3w1IgbRO0Yx/XYq
        VB8Yj6dNq6gxKs=; b=J6lHNB2P4n2sXO/AJXRs45dwrMDqiJ1NKkuO3Skfg45W0
        Jg2w5n538nMVFqyQfdxDJDMAxJa4+ycJzhCR0IXfcQ+Ip+vnw7QlCXtnyvrZELaP
        uIyHOD8u6gex/9nP+vVyBtLRbzx2byzXSeCzoPd0reZLbFqfF/+q+TyTNOZAdlJB
        a1Gq9n6MDm4S8hvY9MBJ2e0ynMM5FPYIgoq2IlbjQl5HrHyNXXZce791OqSD9M2P
        2G54XgAe078nHiOjKqPVLopQ5JQSvHY9Qu09qZCnjMfLgG4QrLFqfsfj/o+jNu0B
        PLLUE/wR10OcBPnr/f2cev2ay2wFswSOO7bbALQ1A==
X-ME-Proxy: <xmx:RMuwWzPZAVi1IglDOn-G9tvw-nRRDX5LieN-lq-G1T43K_l5XFhjGA>
    <xmx:RMuwW7xaEXCJ8IyT8HZKPPgYHPgWpWacQ2ueef74BqVhzdQmEtrL2Q>
    <xmx:RMuwW8u_ealkuykrtiI94f5gY4yAkYRFYgE-1GgZOukaW29uSsSuYg>
    <xmx:RMuwW05Z4bIQFKDjD12ywjenmGoyrABUZC271OG-kxsg6oEiu7v2Pg>
    <xmx:RMuwW7QtAiCT00PwnOmBUdLpEXs2GmJAtGwxQB8vr5h-Fe_H6TjcBA>
    <xmx:R8uwWwDHAwBp3sbYogUUwGXLg3W_gJ9sj3EwlONdw-Cmo-bC0LWq6g>
X-ME-Sender: <xms:RMuwWxLs-zSHS4XSCdhBqDwzFhEJ1yUOskKRO_66Fv7Z2u16OuAVIA>
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.messagingengine.com (Postfix) with ESMTPA id C4D1E102A0;
        Sun, 30 Sep 2018 09:10:27 -0400 (EDT)
Date:   Sun, 30 Sep 2018 06:10:26 -0700
From:   Greg KH <gregkh@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     zhong jiang <zhongjiang@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, mhocko@kernel.org, mgorman@suse.de,
        vbabka@suse.cz, andrea@kernel.org, kirill@shutemov.name,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [STABLE PATCH] slub: make ->cpu_partial unsigned int
Message-ID: <20180930131026.GA25677@kroah.com>
References: <1538303301-61784-1-git-send-email-zhongjiang@huawei.com>
 <20180930125038.GA2533@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930125038.GA2533@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 05:50:38AM -0700, Matthew Wilcox wrote:
> On Sun, Sep 30, 2018 at 06:28:21PM +0800, zhong jiang wrote:
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > 
> > [ Upstream commit e5d9998f3e09359b372a037a6ac55ba235d95d57 ]
> > 
> >         /*
> >          * cpu_partial determined the maximum number of objects
> >          * kept in the per cpu partial lists of a processor.
> >          */
> > 
> > Can't be negative.
> > 
> > I hit a real issue that it will result in a large number of memory leak.
> > Becuase Freeing slabs are in interrupt context. So it can trigger this issue.
> > put_cpu_partial can be interrupted more than once.
> > due to a union struct of lru and pobjects in struct page, when other core handles
> > page->lru list, for eaxmple, remove_partial in freeing slab code flow, It will
> > result in pobjects being a negative value(0xdead0000). Therefore, a large number
> > of slabs will be added to per_cpu partial list.
> > 
> > I had posted the issue to community before. The detailed issue description is as follows.
> > 
> > https://www.spinics.net/lists/kernel/msg2870979.html
> > 
> > After applying the patch, The issue is fixed. So the patch is a effective bugfix.
> > It should go into stable.
> > 
> > Link: http://lkml.kernel.org/r/20180305200730.15812-15-adobriyan@gmail.com
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > Acked-by: Christoph Lameter <cl@linux.com>
> 
> Hang on.  Christoph acked the _original_ patch going into upstream.
> When he reviewed this patch for _stable_ last week, he asked for more
> investigation.  Including this patch in stable is misleading.

But the original patch has been in upstream for a long time now (it went
into 4.17-rc1).  If there was a real problem here, whouldn't it have
been resolved already?

And the patch in mainline has Christoph's ack...

thanks,

greg k-h

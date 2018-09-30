Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BADCC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F082F20685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DbwemmyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F082F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeI3T4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 15:56:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeI3T4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 15:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LA3wp2p9sTmjk5CKex50fKXJR9gaR9FgWxcIJ+QlSho=; b=DbwemmyL72toc+Dxr4jqsHzNZ
        AuZx/76tVSdFft1/rHMHA4/Mb39lCRBq2kohS6D5MCkOuaa2UVUSgga3TyWCtPh2X70oeEQ6CbIyD
        oiYyd78LnOazlygB+R+L4GWixqajnrLuiEHxjqqjYH0ex4PmGWlzdz0yWpGxQgikJ1X2QzQx3rESQ
        O4JGDxEveq4m2snjN8CxeNogbUp5+Gys3bdKXldtjTL5SJ0MX79p6TqExDxpZ2Xh0i3gVU6weAytz
        qh0bmiy74nyT+kQ03UuPpBQgeJktbHTMa9SSDmMo2GwuzTmrgN9H+DJbh7B/dJ46/BS1V9Aj2A1OK
        uwh+8M5VQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g6bh7-0002vH-DL; Sun, 30 Sep 2018 13:23:33 +0000
Date:   Sun, 30 Sep 2018 06:23:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg KH <gregkh@linux-foundation.org>
Cc:     zhong jiang <zhongjiang@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, mhocko@kernel.org, mgorman@suse.de,
        vbabka@suse.cz, andrea@kernel.org, kirill@shutemov.name,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [STABLE PATCH] slub: make ->cpu_partial unsigned int
Message-ID: <20180930132333.GA10872@bombadil.infradead.org>
References: <1538303301-61784-1-git-send-email-zhongjiang@huawei.com>
 <20180930125038.GA2533@bombadil.infradead.org>
 <20180930131026.GA25677@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930131026.GA25677@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 06:10:26AM -0700, Greg KH wrote:
> On Sun, Sep 30, 2018 at 05:50:38AM -0700, Matthew Wilcox wrote:
> > On Sun, Sep 30, 2018 at 06:28:21PM +0800, zhong jiang wrote:
> > > From: Alexey Dobriyan <adobriyan@gmail.com>
> > > 
> > > [ Upstream commit e5d9998f3e09359b372a037a6ac55ba235d95d57 ]
> > > 
> > >         /*
> > >          * cpu_partial determined the maximum number of objects
> > >          * kept in the per cpu partial lists of a processor.
> > >          */
> > > 
> > > Can't be negative.
> > > 
> > > I hit a real issue that it will result in a large number of memory leak.
> > > Becuase Freeing slabs are in interrupt context. So it can trigger this issue.
> > > put_cpu_partial can be interrupted more than once.
> > > due to a union struct of lru and pobjects in struct page, when other core handles
> > > page->lru list, for eaxmple, remove_partial in freeing slab code flow, It will
> > > result in pobjects being a negative value(0xdead0000). Therefore, a large number
> > > of slabs will be added to per_cpu partial list.
> > > 
> > > I had posted the issue to community before. The detailed issue description is as follows.
> > > 
> > > https://www.spinics.net/lists/kernel/msg2870979.html
> > > 
> > > After applying the patch, The issue is fixed. So the patch is a effective bugfix.
> > > It should go into stable.
> > > 
> > > Link: http://lkml.kernel.org/r/20180305200730.15812-15-adobriyan@gmail.com
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > Acked-by: Christoph Lameter <cl@linux.com>
> > 
> > Hang on.  Christoph acked the _original_ patch going into upstream.
> > When he reviewed this patch for _stable_ last week, he asked for more
> > investigation.  Including this patch in stable is misleading.
> 
> But the original patch has been in upstream for a long time now (it went
> into 4.17-rc1).  If there was a real problem here, whouldn't it have
> been resolved already?
> 
> And the patch in mainline has Christoph's ack...

I'm not saying there's a problem with the patch.  It's that the rationale
for backporting doesn't make any damned sense.  There's something going
on that nobody understands.  This patch is probably masking an underlying
problem that will pop back up and bite us again someday.

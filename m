Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E29C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F29120869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lLHUi3LP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbeLTPhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:37:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbeLTPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IiiofMg/qq/P4WdP5kU2046zbu8hrB+SzVmheSXfIsc=; b=lLHUi3LPlLPMZYiEGuP5gYOOdZ
        lQDs+TwTfXpGoWKQj98M0d4cMWATjB7HFd/GXDAhdRSM2KLclfGQSLwKpofeTyOXm9Z4g5QSRqZQK
        CGuiRUXw0Gvr6I0xjlXqdY5lyqw9NhxNDMGzuqdDYR75+sZMyCe6kO6O7axyCXnax64T08Mbj47Fp
        Xy4IEylXmSmA65qOulsUsvccEnEijI0ZjKtEhede8pB8NtTftFaVc/J0SAx5xcvx8lmrfMIacQuip
        d+M6kBp/Kc2cxKjWufPAfzeinH72IYJgKPVQZRTm5Vu7zxCunJI2CrjdyqldZ+/zi4mqNfaXdPBZE
        J74y71SQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga0Nz-0008RN-Og; Thu, 20 Dec 2018 15:37:19 +0000
Date:   Thu, 20 Dec 2018 07:37:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
Message-ID: <20181220153719.GB22997@infradead.org>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <c5fa494c-2ead-e190-6e8c-43478275f789@gmail.com>
 <20181219131452.cehks3kabcwuuk7i@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181219131452.cehks3kabcwuuk7i@sirius.home.kraxel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:14:52PM +0100, Gerd Hoffmann wrote:
> 
> > > > +    if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> > > > +            DMA_BIDIRECTIONAL)) {
> > > 
> > > 
> > > Are you using the DMA streaming API as a way to flush the caches?
> > Yes
> > > Does this mean that GFP_USER isn't making the buffer coherent?
> > 
> > No, it didn't help. I had a question [1] if there are any other better way
> > to achieve the same, but didn't have any response yet. So, I implemented
> > it via DMA API which helped.
> 
> set_pages_array_*() ?
> 
> See arch/x86/include/asm/set_memory.h

That sounds even more bogus, don't go there.

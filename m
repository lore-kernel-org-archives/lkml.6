Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E741C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD58E20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+C0N8SN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfAPGgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:36:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbfAPGgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y3Cfd4hD9ItjyLiX9AKzSPaNAJ0TUVsQI0XwBuOzzUU=; b=r+C0N8SNJQksJTXIEK8l1jSU7
        0ZU7Qe5WFurFX8kdHS8yN/Vx+NZ80+UiHMFNwl8AmyUsTBd+Ki1jU+UbhPzN7K57IA220tDAB3Fa6
        opy9l1gUmg8Mc9NqBXiZghu+UBFOLVIaAMoWsNr8cFHwFqmzUxk1aSYQaKr4U0JsLj8ijU43+aaAf
        RipQxP0294S2bIxwB122e05L8j46kCLTqtK31PqdXEsjoC+pUoOqWfNloRuaQlDnlaAP3/91k6MeT
        vVZMwz0D/AiQiAUbdEJRQO9mx14sZ41aEsoc4fht43sGluYmS73B8jGD1maExYifyuhEvBpie8ACW
        ICA4SxnfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjeoR-0004Ct-AY; Wed, 16 Jan 2019 06:36:31 +0000
Date:   Tue, 15 Jan 2019 22:36:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com, noralf@tronnes.org,
        hch@infradead.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH v2] drm/xen-front: Make shmem backed display buffer
 coherent
Message-ID: <20190116063631.GA10881@infradead.org>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 07:30:02AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> > +			DMA_BIDIRECTIONAL)) {
> > +		ret = -EFAULT;
> > +		goto fail_free_sgt;
> > +	}
> 
> Hmm, so it seems the arm guys could not come up with a suggestion how to
> solve that one in a better way.  Ok, lets go with this then.
> 
> But didn't we agree that this deserves a comment exmplaining the purpose
> of the dma_map_sg() call is to flush caches and that there is no actual
> DMA happening here?

Using a dma mapping call to flush caches is complete no-go.  But the
real question is why you'd even want to flush cashes if you do not
want a dma mapping?

This whole issue keeps getting more and more confusing.

Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E4EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52EC2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bz4gkBEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52EC2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeJBTiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:38:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeJBTiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yRkJmIazn0Pxa57rUuVTP+uzc8ILMtLVAUKpdHgRC8U=; b=bz4gkBEozBNi1WERuOx+VlKZV
        e42QmG1bAkCUixRdKCwgHMaNe1S+Y1WOCl4gFsngSmlXEu+SOoDcbWNJD+Qt02NzrR9JsewPohhb7
        45yBnR3Nl7x/cl3ufsSqiKiYu1VAQqsEKz2IlLamiWPwc35LTjJkUTjBariZdYMKUNJM/NT6eBLbg
        Y4Cb4PTBM6OqnJ9R0IMAa49pUrQbGz5fX5O0wSIWSjUTRxhyryv0fGQP6asmZbQ/j6wdvFUH+kIXq
        ab8aPToSLSVaMuz2ViaIEhhZHhAfuwvOsN8CB9pUFukztxis5Juhw0gpamJSIsZUYE7/8Gx5GpQug
        yxbqQAJoQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7KDC-0007H2-0y; Tue, 02 Oct 2018 12:55:38 +0000
Date:   Tue, 2 Oct 2018 05:55:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/virtio: Use IDAs more efficiently
Message-ID: <20181002125537.GA15740@bombadil.infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
 <20180926160031.15721-5-willy@infradead.org>
 <20180926160455.GA20337@bombadil.infradead.org>
 <20181002114328.kltyrjlojzrhzwgl@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002114328.kltyrjlojzrhzwgl@sirius.home.kraxel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 01:43:28PM +0200, Gerd Hoffmann wrote:
> On Wed, Sep 26, 2018 at 09:04:55AM -0700, Matthew Wilcox wrote:
> > On Wed, Sep 26, 2018 at 09:00:31AM -0700, Matthew Wilcox wrote:
> > > @@ -59,6 +59,7 @@ static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
> > >  
> > >  	if (handle < 0)
> > >  		return handle;
> > > +	handle++;
> > >  	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
> > >  	return handle;
> > >  }
> > 
> > Uh.  This line is missing.
> > 
> > -       int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
> > +       int handle = ida_alloc(&vgdev->ctx_id_ida, GFP_KERNEL);
> > 
> > It'll be there in v2 ;-)
> 
> I've touched the resource/object id handling too, see my "drm/virtio:
> rework ttm resource handling" patch series
> (https://patchwork.freedesktop.org/series/50382/).  Which still needs a
> review btw.

Um, according to patchwork, you only posted it yesterday.  Does DRM
normally expect a review within 24 hours?

> I think that series obsoletes patch 3/4 (object id fixes) of your
> series.  The other patches should rebase without too much trouble, you
> could do that as well when preparing v2 ...

It seems a little odd to me to expect a drive-by contributor (ie me) to
rebase their patches on top of a patch series which wasn't even posted
at the time they contributed their original patch.  If it was already
in -next, that'd be a reasonable request.

Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EF8C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D02206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D02206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJBS0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:26:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3371 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJBS0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:26:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BC78C04AC54;
        Tue,  2 Oct 2018 11:43:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09B3A60BD4;
        Tue,  2 Oct 2018 11:43:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EB74D982BC; Tue,  2 Oct 2018 13:43:28 +0200 (CEST)
Date:   Tue, 2 Oct 2018 13:43:28 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/virtio: Use IDAs more efficiently
Message-ID: <20181002114328.kltyrjlojzrhzwgl@sirius.home.kraxel.org>
References: <20180926160031.15721-1-willy@infradead.org>
 <20180926160031.15721-5-willy@infradead.org>
 <20180926160455.GA20337@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926160455.GA20337@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 02 Oct 2018 11:43:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 09:04:55AM -0700, Matthew Wilcox wrote:
> On Wed, Sep 26, 2018 at 09:00:31AM -0700, Matthew Wilcox wrote:
> > @@ -59,6 +59,7 @@ static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
> >  
> >  	if (handle < 0)
> >  		return handle;
> > +	handle++;
> >  	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
> >  	return handle;
> >  }
> 
> Uh.  This line is missing.
> 
> -       int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
> +       int handle = ida_alloc(&vgdev->ctx_id_ida, GFP_KERNEL);
> 
> It'll be there in v2 ;-)

I've touched the resource/object id handling too, see my "drm/virtio:
rework ttm resource handling" patch series
(https://patchwork.freedesktop.org/series/50382/).  Which still needs a
review btw.

I think that series obsoletes patch 3/4 (object id fixes) of your
series.  The other patches should rebase without too much trouble, you
could do that as well when preparing v2 ...

cheers,
  Gerd


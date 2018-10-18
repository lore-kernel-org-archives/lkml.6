Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136FFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AA52145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AA52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJRO7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:59:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeJRO7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:59:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B622A3001DB1;
        Thu, 18 Oct 2018 07:00:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-238.ams2.redhat.com [10.36.116.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51E0660C66;
        Thu, 18 Oct 2018 07:00:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 95B356C7; Thu, 18 Oct 2018 09:00:04 +0200 (CEST)
Date:   Thu, 18 Oct 2018 09:00:04 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 7/8] drm/virtio: move virtio_gpu_object_{attach, detach}
 calls.
Message-ID: <20181018070004.mplea3ozamph6uzu@sirius.home.kraxel.org>
References: <20181001103222.11924-1-kraxel@redhat.com>
 <20181001103222.11924-8-kraxel@redhat.com>
 <CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com>
 <20181018061059.d32xhg6ijlvpqyvi@sirius.home.kraxel.org>
 <CAPM=9tzwcPtOfNuoKdbSY0=EBsbsKgM04HZpzAazPEmDbQOXSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzwcPtOfNuoKdbSY0=EBsbsKgM04HZpzAazPEmDbQOXSw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 18 Oct 2018 07:00:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This to me feels more like a bind/unbind operation rather than a
> > > populate/unpopulate operation,
> > >
> > > bind is " Bind the backend pages into the aperture in the location"
> > >
> > > whereas populate is
> > >
> > > allocate pages for a ttm.
> >
> > I ran into that trap too ;)
> >
> > My first attempt was to map this to bind/unbind.  But this is not
> > correct and therefore didn't work very well.
> >
> > virtio_gpu_object_attach() will send a scatter list of the pages
> > allocated for the object to the host (so the host knows where to
> > copy from/to when processing the transfer_from/to calls).  So IMO
> > it should be done on population not when binding.
> 
> Well bind on AGP is the same thing, we'd fill the AGP GART table on
> bind, so that the AGP GPU could access the pages.

> So I'm interested in why using bind/unbind failed if you have some more info?

Need to try again to be sure, but IIRC I saw multiple bind/unbind calls
for the same object.  ttm probably does it to not waste AGB GART address
space for objects not in use.  But for virtio it is pointless overhead.
But maybe it is just a matter of taking a reference and keeping it for
the whole lifetime of the object to make the binding permanent ...

cheers,
  Gerd


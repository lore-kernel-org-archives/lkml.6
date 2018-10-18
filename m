Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D67C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21F42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21F42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJROKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbeJROKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:10:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCF955F7AA;
        Thu, 18 Oct 2018 06:11:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-238.ams2.redhat.com [10.36.116.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88C525C6DC;
        Thu, 18 Oct 2018 06:11:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CE3BC9D367; Thu, 18 Oct 2018 08:10:59 +0200 (CEST)
Date:   Thu, 18 Oct 2018 08:10:59 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 7/8] drm/virtio: move virtio_gpu_object_{attach, detach}
 calls.
Message-ID: <20181018061059.d32xhg6ijlvpqyvi@sirius.home.kraxel.org>
References: <20181001103222.11924-1-kraxel@redhat.com>
 <20181001103222.11924-8-kraxel@redhat.com>
 <CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 18 Oct 2018 06:11:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:41:52AM +1000, Dave Airlie wrote:
> On Mon, 1 Oct 2018 at 20:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Remove the virtio_gpu_object_{attach,detach} calls from move_notify()
> > callback.  Add them to the ttm_tt_{populate,unpopulate} callbacks, which
> > is the correct place to handle this.
> >
> > The new ttm_tt_{populate,unpopulate} callbacks call the
> > ttm_pool_populate()/unpopulate() functions (which are the default
> > implementation in case the callbacks not present) for the actual ttm
> > work.  Additionally virtio_gpu_object_{attach,detach} is called to
> > update the state on the host.
> 
> This to me feels more like a bind/unbind operation rather than a
> populate/unpopulate operation,
> 
> bind is " Bind the backend pages into the aperture in the location"
> 
> whereas populate is
> 
> allocate pages for a ttm.

I ran into that trap too ;)

My first attempt was to map this to bind/unbind.  But this is not
correct and therefore didn't work very well.

virtio_gpu_object_attach() will send a scatter list of the pages
allocated for the object to the host (so the host knows where to
copy from/to when processing the transfer_from/to calls).  So IMO
it should be done on population not when binding.

cheers,
  Gerd


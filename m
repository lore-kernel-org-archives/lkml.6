Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72494C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D7D21C3B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D7D21C3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbeGDIAK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:00:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934034AbeGDIAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:00:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC525C07EFD4;
        Wed,  4 Jul 2018 08:00:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-220.phx2.redhat.com [10.3.116.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31BE860C4E;
        Wed,  4 Jul 2018 08:00:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1753F17445; Wed,  4 Jul 2018 10:00:05 +0200 (CEST)
Date:   Wed, 4 Jul 2018 10:00:05 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Zach Reizner <zachr@google.com>,
        Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v6] Add udmabuf misc device
Message-ID: <20180704080005.juutrwri4kxm7yim@sirius.home.kraxel.org>
References: <20180703075359.30349-1-kraxel@redhat.com>
 <20180703083757.GG7880@phenom.ffwll.local>
 <20180704055338.n3b7oexltaejqmcd@sirius.home.kraxel.org>
 <9818b301-9c9d-c703-d4fe-7c2d4d43ed66@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9818b301-9c9d-c703-d4fe-7c2d4d43ed66@collabora.com>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 04 Jul 2018 08:00:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 09:26:39AM +0200, Tomeu Vizoso wrote:
> On 07/04/2018 07:53 AM, Gerd Hoffmann wrote:
> > On Tue, Jul 03, 2018 at 10:37:57AM +0200, Daniel Vetter wrote:
> > > On Tue, Jul 03, 2018 at 09:53:58AM +0200, Gerd Hoffmann wrote:
> > > > A driver to let userspace turn memfd regions into dma-bufs.
> > > > 
> > > > Use case:  Allows qemu create dmabufs for the vga framebuffer or
> > > > virtio-gpu ressources.  Then they can be passed around to display
> > > > those guest things on the host.  To spice client for classic full
> > > > framebuffer display, and hopefully some day to wayland server for
> > > > seamless guest window display.
> > > > 
> > > > qemu test branch:
> > > >    https://git.kraxel.org/cgit/qemu/log/?h=sirius/udmabuf
> > > > 
> > > > Cc: David Airlie <airlied@linux.ie>
> > > > Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > 
> > > I think some ack for a 2nd use-case, like virtio-wl or whatever would be
> > > really cool. To give us some assurance that this is generically useful.
> > 
> > Tomeu?  Laurent?
> 
> Sorry, but I think I will need some help to understand how this could help
> in the virtio-wl case [adding Zach Reizner to CC].
> 
> Any graphics buffers that are allocated with memfd will be shared with the
> compositor via wl_shm, without need for dmabufs.

Within one machine, yes.  Once virtualization is added to the mix things
become more complicated ...

When using virtio-gpu the guest will allocate graphics buffers from
normal (guest) ram, then register these buffers (which are allowed to be
scattered) with the host as resource.

qemu can use memfd to allocate guest ram.  Now, with the help of
udmabuf, qemu can create a *host* dma-buf for the *guest* graphics
buffer.

That dma-buf can be used by qemu internally (mmap it to get a linear
mapping of the resource, to avoid copying).  It can be passed on to
spice-client, to display the guest framebuffer.

And I think it could also be quite useful to pass guest wayland windows
to the host compositor, without mapping host-allocated buffers into the
guest, so we don't have do deal with the "find some address space for
the mapping" issue in the first place.  There are more things needed to
complete this of course, but it's a building block ...

cheers,
  Gerd


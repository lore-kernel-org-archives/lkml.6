Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A372B2184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfBAHXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:23:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfBAHXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:23:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4409AAC60B;
        Fri,  1 Feb 2019 07:23:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-249.ams2.redhat.com [10.36.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE6B95C225;
        Fri,  1 Feb 2019 07:23:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EB556A1E8; Fri,  1 Feb 2019 08:23:41 +0100 (CET)
Date:   Fri, 1 Feb 2019 08:23:41 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Gurchetan Singh <gurchetansingh@chromium.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 5/6] drm/virtio: drop fencing in
 virtio_gpu_resource_create_ioctl
Message-ID: <20190201072341.nujqrkxbq3fg7djd@sirius.home.kraxel.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-6-kraxel@redhat.com>
 <CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 01 Feb 2019 07:23:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:04:31AM -0800, Gurchetan Singh wrote:
> On Wed, Jan 30, 2019 at 1:43 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > There is no need to wait for completion here.
> >
> > The host will process commands in submit order, so commands can
> > reference the new resource just fine even when queued up before
> > completion.
> 
> Does virtio_gpu_execbuffer_ioctl also wait for completion for a host response?

No.

But you pass in a list of objects (drm_virtgpu_execbuffer->bo_handles)
used.  They will all get reserved, so you can use DRM_IOCTL_VIRTGPU_WAIT
on any of these objects to wait for completion.

Recently the driver got support for returning a fence fd for the
execbuffer, which you can also use to wait for completion in case your
kernel is new enough.

> From the guest driver perspective, a fence is just implemented has a
> virtio 3D resource.
> 
> https://gitlab.freedesktop.org/mesa/mesa/blob/master/src/gallium/winsys/virgl/drm/virgl_drm_winsys.c#L787
> 
> The DRM_IOCTL_VIRTGPU_WAIT ioctl essentially waits for the reservation
> objects associated with that fence resource to become available.  So
> the flow is:
> 
> virtio_gpu_execbuffer_ioctl
> virtio_gpu_resource_create_ioctl with fence resource
> virtio_gpu_wait_ioctl with that fence resource --> associated with a
> GL wait on the host side

Oh.  /me looks surprised.
Wasn't aware that userspace is doing *that*.

> Does this change modify this sequence of events?

Yes.  DRM_IOCTL_VIRTGPU_WAIT will not wait any more.  Guess I have to
scratch the patch then ...

cheers,
  Gerd


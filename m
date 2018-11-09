Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21798C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D927120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D927120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeKITxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:53:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeKITxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:53:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFA9E307DAB5;
        Fri,  9 Nov 2018 10:13:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CCE45C219;
        Fri,  9 Nov 2018 10:13:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 86A748FC0; Fri,  9 Nov 2018 11:13:54 +0100 (CET)
Date:   Fri, 9 Nov 2018 11:13:54 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Robert Foss <robert.foss@collabora.com>,
        David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH v4 3/4] drm/virtio: add in/out fence support for explicit
 synchronization
Message-ID: <20181109101354.dc7cv4i4etu3bkhh@sirius.home.kraxel.org>
References: <20181105114152.2088-1-robert.foss@collabora.com>
 <20181105114152.2088-4-robert.foss@collabora.com>
 <CACvgo53vCBbgmu4OV4e0WeOYQSXNk=3qwyRBtPx+XAcCSZO8aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgo53vCBbgmu4OV4e0WeOYQSXNk=3qwyRBtPx+XAcCSZO8aQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 09 Nov 2018 10:13:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:25:05PM +0000, Emil Velikov wrote:
> On Mon, 5 Nov 2018 at 11:42, Robert Foss <robert.foss@collabora.com> wrote:
> >
> > When the execbuf call receives an in-fence it will get the dma_fence
> > related to that fence fd and wait on it before submitting the draw call.
> >
> > On the out-fence side we get fence returned by the submitted draw call
> > and attach it to a sync_file and send the sync_file fd to userspace. On
> > error -1 is returned to userspace.
> >
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> > Signed-off-by: Robert Foss <robert.foss@collabora.com>
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> > ---
> >
> > Changes since v3:
> >  - Move all in_fence handling to the same VIRTGPU_EXECBUF_FENCE_FD_IN block
> Fwiw my suggestion was to explicitly document whether the IOCTL can
> support, simultaneously, IN and OUT fence.

Yes, that would be good.  Code looks like it is supposed to work, but
explicitly saying so in the commit message would be nice.

Also: should we use separate fields for in/out fds?

cheers,
  Gerd


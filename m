Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2046CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E206B223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E206B223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbeKLTCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:02:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10833 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbeKLTCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:02:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 739B63001571;
        Mon, 12 Nov 2018 09:10:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E120F600C1;
        Mon, 12 Nov 2018 09:10:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0ADEB541DE; Mon, 12 Nov 2018 10:10:27 +0100 (CET)
Date:   Mon, 12 Nov 2018 10:10:27 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Robert Foss <robert.foss@collabora.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH v4 3/4] drm/virtio: add in/out fence support for explicit
 synchronization
Message-ID: <20181112091027.3bh4gi5mvu73tcqh@sirius.home.kraxel.org>
References: <20181105114152.2088-1-robert.foss@collabora.com>
 <20181105114152.2088-4-robert.foss@collabora.com>
 <CACvgo53vCBbgmu4OV4e0WeOYQSXNk=3qwyRBtPx+XAcCSZO8aQ@mail.gmail.com>
 <20181109101354.dc7cv4i4etu3bkhh@sirius.home.kraxel.org>
 <f5143d56-3e11-51f7-a07a-9106aa8bda49@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5143d56-3e11-51f7-a07a-9106aa8bda49@collabora.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 12 Nov 2018 09:10:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 06:13:52PM +0100, Robert Foss wrote:
> Hey Gerd,
> 
> On 2018-11-09 11:13, Gerd Hoffmann wrote:
> > On Mon, Nov 05, 2018 at 05:25:05PM +0000, Emil Velikov wrote:
> > > On Mon, 5 Nov 2018 at 11:42, Robert Foss <robert.foss@collabora.com> wrote:
> > > > 
> > > > When the execbuf call receives an in-fence it will get the dma_fence
> > > > related to that fence fd and wait on it before submitting the draw call.
> > > > 
> > > > On the out-fence side we get fence returned by the submitted draw call
> > > > and attach it to a sync_file and send the sync_file fd to userspace. On
> > > > error -1 is returned to userspace.
> > > > 
> > > > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> > > > Signed-off-by: Robert Foss <robert.foss@collabora.com>
> > > > Suggested-by: Rob Herring <robh@kernel.org>
> > > > Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> > > > ---
> > > > 
> > > > Changes since v3:
> > > >   - Move all in_fence handling to the same VIRTGPU_EXECBUF_FENCE_FD_IN block
> > > Fwiw my suggestion was to explicitly document whether the IOCTL can
> > > support, simultaneously, IN and OUT fence.
> > 
> > Yes, that would be good.  Code looks like it is supposed to work, but
> > explicitly saying so in the commit message would be nice.
> 
> On it! Will send out a v5.
> 
> > 
> > Also: should we use separate fields for in/out fds?
> 
> I'm not sure I understand which fields you're referring to.

fence_in_fd & fence_out_fd in the ioctl struct (patch #2).

cheers,
  Gerd

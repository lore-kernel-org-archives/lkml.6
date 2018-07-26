Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D9CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B22D20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B22D20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbeGZQ3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:29:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbeGZQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:29:23 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0AC1ACE8;
        Thu, 26 Jul 2018 15:12:05 +0000 (UTC)
Date:   Thu, 26 Jul 2018 17:12:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     bskeggs@redhat.com, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: Set DRIVER_ATOMIC cap earlier to fix debugfs
Message-ID: <20180726151202.GE27305@kroah.com>
References: <153227752119282@kroah.com>
 <20180723171322.9677-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723171322.9677-1-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 01:13:20PM -0400, Lyude Paul wrote:
> commit eb493fbc150f4a28151ae1ee84f24395989f3600 upstream
> 
> Currently nouveau doesn't actually expose the state debugfs file that's
> usually provided for any modesetting driver that supports atomic, even
> if nouveau is loaded with atomic=1. This is due to the fact that the
> standard debugfs files that DRM creates for atomic drivers is called
> when drm_get_pci_dev() is called from nouveau_drm.c. This happens well
> before we've initialized the display core, which is currently
> responsible for setting the DRIVER_ATOMIC cap.
> 
> So, move the atomic option into nouveau_drm.c and just add the
> DRIVER_ATOMIC cap whenever it's enabled on the kernel commandline. This
> shouldn't cause any actual issues, as the atomic ioctl will still fail
> as expected even if the display core doesn't disable it until later in
> the init sequence. This also provides the added benefit of being able to
> use the state debugfs file to check the current display state even if
> clients aren't allowed to modify it through anything other than the
> legacy ioctls.
> 
> Additionally, disable the DRIVER_ATOMIC cap in nv04's display core, as
> this was already disabled there previously.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/disp.c | 3 +++
>  drivers/gpu/drm/nouveau/nouveau_drm.c   | 7 +++++++
>  drivers/gpu/drm/nouveau/nv50_display.c  | 6 ------
>  3 files changed, 10 insertions(+), 6 deletions(-)

Please give me a hint as to what kernel versions you want the patches to
be applied to, otherwise I just have to guess :)

thanks,

greg k-h

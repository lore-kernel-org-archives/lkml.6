Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C68C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8022147D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="M1Ne70Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8022147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lekensteyn.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJBDNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:13:07 -0400
Received: from lekensteyn.nl ([178.21.112.251]:40409 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeJBDNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Y6YtAD6ADXrdmCPvMzc9LbfDtmn7HgMxAsgO2DjahEs=;
        b=M1Ne70Sf688pUnhNcO5yzE8jpqN+eE7fMAkuELBwkNVgnHNPKpf5J6S0ODrpzFKUae3Ib2pmkAM2dt1o7za1HkD4k9MUVfI9gB0FtCFCebXskeSBJkPWjlzbjyyu5FIUDtVf5IONSn6kCG2o9wNyXDOhBBGM67R/lb3I1IyzHE89Me25ohhWSrjxLSEFNgJ0xnUjhW5KTmUIRbU/O6wYaxS+VO4q+BhAHeVkTS/0hMj1jHCqFhsrRltmti5KfZ+i+o83iXJ3P5g73IQXU2OeElj+sWsZojgEAqbeMYyjLFlI8W6RdLbpT6BoPeU4hoN5x4V+o7rgJyJWeUw6zaJnPA==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1g74sf-0006MY-9R; Mon, 01 Oct 2018 22:33:26 +0200
Date:   Mon, 1 Oct 2018 22:33:22 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Fubo Chen <fubo.chen@gmail.com>
Cc:     airlied@redhat.com, kraxel@redhat.com,
        alan.christopher.jenkins@gmail.com,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] qxl: fix null-pointer crash during suspend
Message-ID: <20181001203322.GA13696@al>
References: <20180904202747.14968-1-peter@lekensteyn.nl>
 <CAJAFBLBhAjEtoCegy7QzG65PoxM-DZA2xki9SwfrZ6af=0fvUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJAFBLBhAjEtoCegy7QzG65PoxM-DZA2xki9SwfrZ6af=0fvUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 01:13:59PM -0700, Fubo Chen wrote:
> On Tue, Sep 4, 2018 at 2:10 PM Peter Wu <peter@lekensteyn.nl> wrote:
> >
> > "crtc->helper_private" is not initialized by the QXL driver and thus the
> > "crtc_funcs->disable" call would crash (resulting in suspend failure).
> > Fix this by converting the suspend/resume functions to use the
> > drm_mode_config_helper_* helpers.
> >
> > Tested system sleep with QEMU 3.0 using "echo mem > /sys/power/state".
> > During suspend the following message is visible from QEMU:
> >
> >     spice/server/display-channel.c:2425:display_channel_validate_surface: canvas address is 0x7fd05da68308 for 0 (and is NULL)
> >     spice/server/display-channel.c:2426:display_channel_validate_surface: failed on 0
> >
> > This seems to be triggered by QXL_IO_NOTIFY_CMD after
> > QXL_IO_DESTROY_PRIMARY_ASYNC, but aside from the warning things still
> > seem to work (tested with both the GTK and -spice options).
> >
> > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> 
> Is this a new issue or something that was introduced a long time ago?
> In the latter case, please consider adding a "Cc:
> <stable@vger.kernel.org>" tag to this patch.

I am not sure exactly when the issue was introduced, but the original
code was added in v3.10-rc7-800-gd84300bf7934 while the new
drm_mode_config_helper_suspend API was added in 4.16.

The intended call chain to initialize the private object seems to be:
drm_crtc_helper_add
<- qdev_crtc_init
<- qxl_modeset_init
<- qxl_pci_probe

If any error occurs along the callchain, then the helper_private pointer
will remain NULL. Or if the crtc is obtained in a different way (not
sure how).

Not sure if it is worth backporting, suspend/resume does not seem an
important use case for VMs using QXL and the fix was not validated for
older kernels.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl

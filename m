Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019EDECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ED420858
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ED420858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeGQIFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:05:08 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:57783 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeGQIFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:05:07 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id BA97F2801088B;
        Tue, 17 Jul 2018 09:33:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 655726F3B3; Tue, 17 Jul 2018 09:33:52 +0200 (CEST)
Date:   Tue, 17 Jul 2018 09:33:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: [Nouveau] [PATCH v2 2/3] drm/nouveau: Fix runtime PM leak in
 nv50_disp_atomic_commit()
Message-ID: <20180717073352.GA17459@wunner.de>
References: <20180712170256.13018-1-lyude@redhat.com>
 <20180712170256.13018-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712170256.13018-3-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:02:53PM -0400, Lyude Paul wrote:
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1878,7 +1878,7 @@ nv50_disp_atomic_commit(struct drm_device *dev,
>  		nv50_disp_atomic_commit_tail(state);
>  
>  	drm_for_each_crtc(crtc, dev) {
> -		if (crtc->state->enable) {
> +		if (crtc->state->active) {
>  			if (!drm->have_disp_power_ref) {
>  				drm->have_disp_power_ref = true;
>  				return 0;

Somewhat tangential comment on this older patch, since you
continue to dig around in the runtime PM area:

Whenever a crtc is activated or deactivated in nouveau, we iterate
over all crtcs and acquire a runtime PM if a crtc is active and
previously there was no active one, or we drop a ref if none is
active and previously there was an active one.

For a while now I've been thinking that it would be more straightforward
to acquire a ref whenever a crtc is activated and drop one when a crtc
is deactivated, i.e. hold one ref for every active crtc.  That way the
have_disp_power_ref variable as well as the iteration logic could be
removed, leading to a simplification.  Just a suggestion anyway.

Thanks,

Lukas

Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E089EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1C721582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1C721582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbeKPCvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:51:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48971 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387839AbeKPCvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:51:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4803C207AD; Thu, 15 Nov 2018 17:42:57 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 849262074D;
        Thu, 15 Nov 2018 17:42:39 +0100 (CET)
Date:   Thu, 15 Nov 2018 17:42:39 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] drm/fb-helper: Blacklist writeback when adding
 connectors to fbdev
Message-ID: <20181115174239.773b71e9@bbrezillon>
In-Reply-To: <20181115163248.21168-1-paul.kocialkowski@bootlin.com>
References: <20181115163248.21168-1-paul.kocialkowski@bootlin.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 17:32:48 +0100
Paul Kocialkowski <paul.kocialkowski@bootlin.com> wrote:

> Writeback connectors do not produce any on-screen output and require
> special care for use. Such connectors are hidden from enumeration in
> DRM resources by default, but they are still picked-up by fbdev.
> This makes rather little sense since fbdev is not really adapted for
> dealing with writeback.
> 
> Moreover, this is also a source of issues when userspace disables the
> CRTC (and associated plane) without detaching the CRTC from the
> connector (which is hidden by default). In this case, the connector is
> still using the CRTC, leading to am "enabled/connectors mismatch" and

				   ^an

> eventually the failure of the associated atomic commit. This situation
> happens with VC4 testing under IGT GPU Tools.
> 
> Filter out writeback connectors in the fbdev helper to solve this.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index a502f3e519fd..dd852a25d375 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -219,6 +219,9 @@ int drm_fb_helper_single_add_all_connectors(struct drm_fb_helper *fb_helper)
>  	mutex_lock(&fb_helper->lock);
>  	drm_connector_list_iter_begin(dev, &conn_iter);
>  	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>  		ret = __drm_fb_helper_add_one_connector(fb_helper, connector);
>  		if (ret)
>  			goto fail;


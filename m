Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A3AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40AC20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40AC20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeLKNMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:12:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48339 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeLKNMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:12:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2DE4620711; Tue, 11 Dec 2018 14:12:35 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id E1B992039F;
        Tue, 11 Dec 2018 14:12:34 +0100 (CET)
Date:   Tue, 11 Dec 2018 14:12:33 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3] drm/vc4: Add a debugfs entry to disable/enable the
 load tracker
Message-ID: <20181211141233.79709688@bbrezillon>
In-Reply-To: <20181207134757.32437-1-paul.kocialkowski@bootlin.com>
References: <20181207134757.32437-1-paul.kocialkowski@bootlin.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Dec 2018 14:47:57 +0100
Paul Kocialkowski <paul.kocialkowski@bootlin.com> wrote:


> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index f3fd34faa812..e80b1ad5c938 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -479,6 +479,7 @@ static const struct drm_private_state_funcs vc4_load_tracker_state_funcs = {
>  static int
>  vc4_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
>  {
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
>  	int ret;
>  
>  	ret = vc4_ctm_atomic_check(dev, state);
> @@ -489,7 +490,10 @@ vc4_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
>  	if (ret)
>  		return ret;
>  
> -	return vc4_load_tracker_atomic_check(state);
> +	if (vc4->load_tracker_enabled)
> +		return vc4_load_tracker_atomic_check(state);

Even if we don't return an error when ->load_tracker_enabled is false,
we should keep updating the ->{hvs,membus}_load state, otherwise those
fields will contain bad values if we activate the load tracker after
the planes have been enabled.

I suggest moving this test in vc4_load_tracker_atomic_check() just
before

	if (load_state->membus_load > SZ_1G + SZ_512M)

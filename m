Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCE0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FDD214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547142516;
	bh=xYOCS96HW86Q+ESJdvapp7SjBLQTTrQ+OilUo7KtzFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cOtsQ+SPw4rbzV9gdoseBCfxm9yd+AIfOWoC7C3ctOAZuAxSq2pq2SkJmczL15lNN
	 v47by/Ob1J6thsfMXJYiT8k1PizREvRajx395OGOaiXKIynt5YbxBNL7+FgPnmzNGN
	 8aitD9OsujYYbOKKZtQKgI9PLNIfV6flxxHjJoQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfAJRsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729480AbfAJRsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:48:35 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8EF20685;
        Thu, 10 Jan 2019 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547142514;
        bh=xYOCS96HW86Q+ESJdvapp7SjBLQTTrQ+OilUo7KtzFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tqHxnX1Lfk9eQmtwFJQK0PTsjuSmXKFG0qZ/8i2JAJPtRVLn+RUe0PC1q9YnxrY7I
         kIjJ4XL8YZR/tJcljC07osZtaDbyTpAuceVhi1d6yEMrKXMbR6RWo+Ss6TpzIXSq40
         EJJTUjd6gAkBCZyvoNHWKcdUaV30UWJ6OGEh7Qhg=
Date:   Thu, 10 Jan 2019 18:48:25 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Message-ID: <20190110184816.63350396@bbrezillon>
In-Reply-To: <20190110151020.30468-3-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
        <20190110151020.30468-3-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 15:10:39 +0000
Peter Rosin <peda@axentia.se> wrote:

> The destination crtc rectangle is independent of source plane rotation.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index ea8fc0deb814..d6f93f029020 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -642,9 +642,6 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>  	 * Swap width and size in case of 90 or 270 degrees rotation
>  	 */
>  	if (drm_rotation_90_or_270(state->base.rotation)) {
> -		tmp = state->crtc_w;
> -		state->crtc_w = state->crtc_h;
> -		state->crtc_h = tmp;

Again, I guess I assumed ->crtc_h/w were the width and height before
rotation when I initially added rotation support. This change might
break users too.

>  		tmp = state->src_w;
>  		state->src_w = state->src_h;
>  		state->src_h = tmp;


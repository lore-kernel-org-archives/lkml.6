Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CD3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D702084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="YNoT2R+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D702084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeJBCm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:42:57 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:51844 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBCm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:42:57 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 52C2D5C0172;
        Mon,  1 Oct 2018 22:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1538424208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSGCg2NQwBUgoZQEZeuf3kgRarYbEWK6dyFbj4d5MNs=;
        b=YNoT2R+TeE3QK56DhKVke28Nbu1GECXDQgXed1CJ61JbKaWWlZdQ0BzVHZ+0hn/xzCbTwY
        qHBWlN1WsCzVY1VT3NDNw6zfPEWxgDxdn/gpcBKUQmM5MnrUYc8m3I+0G0ki8jWW6HDXVH
        ooSj33FLpVL6v+JAJBwVsnaiU/z7NVM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Oct 2018 22:03:28 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Stefan Agner <stefan@agner.ch>
Cc:     alison.wang@nxp.com, airlied@linux.ie,
        Madhur Verma <madhur.verma@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hemanshu Srivastava <hemanshu.s@samsung.com>,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 2/2] drm/fsl-dcu: use drm_display_mode_to_videomode to
 calculate timing parameters
In-Reply-To: <20181001075702.GS11082@phenom.ffwll.local>
References: <20180926204150.29829-1-stefan@agner.ch>
 <20180926204150.29829-2-stefan@agner.ch>
 <20181001075702.GS11082@phenom.ffwll.local>
Message-ID: <56170905672e17e6bd9bf0ef45c10ef6@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.2018 09:57, Daniel Vetter wrote:
> On Wed, Sep 26, 2018 at 10:41:50PM +0200, Stefan Agner wrote:
>> From: Satendra Singh Thakur <satendra.t@samsung.com>
>>
>> Use the drm_display_mode_to_videomode function to calculate front/
>> back porches and sync length.
>>
>> Cc: Madhur Verma <madhur.verma@samsung.com>
>> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
>> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> I think if lots of people want this (iirc yours not the only driver that
> wants front/back-porch) we should extend the computed crtc_* fields with
> this. Kinda silly we force people to go through v4l videomode in drm
> drivers. But then, this gets the job done, so maybe an idea for todo.rst?

Hm, I see, yeah seems rather straight forward to calculate this
information in drm_mode_set_crtcinfo().

> 
> On both patches:
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks, applied both.

--
Stefan

>> ---
>>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 32 ++++++++++------------
>>  1 file changed, 14 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
>> index 05d1c9977395..18afc94e4dff 100644
>> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
>> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
>> @@ -17,6 +17,7 @@
>>  #include <drm/drm_atomic_helper.h>
>>  #include <drm/drm_crtc.h>
>>  #include <drm/drm_crtc_helper.h>
>> +#include <video/videomode.h>
>>
>>  #include "fsl_dcu_drm_crtc.h"
>>  #include "fsl_dcu_drm_drv.h"
>> @@ -85,39 +86,34 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
>>  	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
>>  	struct drm_connector *con = &fsl_dev->connector.base;
>>  	struct drm_display_mode *mode = &crtc->state->mode;
>> -	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, pol = 0;
>> +	unsigned int pol = 0;
>> +	struct videomode vm;
>>
>>  	clk_set_rate(fsl_dev->pix_clk, mode->clock * 1000);
>>
>> -	/* Configure timings: */
>> -	hbp = mode->htotal - mode->hsync_end;
>> -	hfp = mode->hsync_start - mode->hdisplay;
>> -	hsw = mode->hsync_end - mode->hsync_start;
>> -	vbp = mode->vtotal - mode->vsync_end;
>> -	vfp = mode->vsync_start - mode->vdisplay;
>> -	vsw = mode->vsync_end - mode->vsync_start;
>> +	drm_display_mode_to_videomode(mode, &vm);
>>
>>  	/* INV_PXCK as default (most display sample data on rising edge) */
>>  	if (!(con->display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE))
>>  		pol |= DCU_SYN_POL_INV_PXCK;
>>
>> -	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
>> +	if (vm.flags & DISPLAY_FLAGS_HSYNC_LOW)
>>  		pol |= DCU_SYN_POL_INV_HS_LOW;
>>
>> -	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
>> +	if (vm.flags & DISPLAY_FLAGS_VSYNC_LOW)
>>  		pol |= DCU_SYN_POL_INV_VS_LOW;
>>
>>  	regmap_write(fsl_dev->regmap, DCU_HSYN_PARA,
>> -		     DCU_HSYN_PARA_BP(hbp) |
>> -		     DCU_HSYN_PARA_PW(hsw) |
>> -		     DCU_HSYN_PARA_FP(hfp));
>> +		     DCU_HSYN_PARA_BP(vm.hback_porch) |
>> +		     DCU_HSYN_PARA_PW(vm.hsync_len) |
>> +		     DCU_HSYN_PARA_FP(vm.hfront_porch));
>>  	regmap_write(fsl_dev->regmap, DCU_VSYN_PARA,
>> -		     DCU_VSYN_PARA_BP(vbp) |
>> -		     DCU_VSYN_PARA_PW(vsw) |
>> -		     DCU_VSYN_PARA_FP(vfp));
>> +		     DCU_VSYN_PARA_BP(vm.vback_porch) |
>> +		     DCU_VSYN_PARA_PW(vm.vsync_len) |
>> +		     DCU_VSYN_PARA_FP(vm.vfront_porch));
>>  	regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
>> -		     DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
>> -		     DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
>> +		     DCU_DISP_SIZE_DELTA_Y(vm.vactive) |
>> +		     DCU_DISP_SIZE_DELTA_X(vm.hactive));
>>  	regmap_write(fsl_dev->regmap, DCU_SYN_POL, pol);
>>  	regmap_write(fsl_dev->regmap, DCU_BGND, DCU_BGND_R(0) |
>>  		     DCU_BGND_G(0) | DCU_BGND_B(0));
>> --
>> 2.19.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

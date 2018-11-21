Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409F0C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6F921479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LUB0ST//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6F921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeKUUmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:42:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39041 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeKUUmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:42:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so4394838edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AfvgCFNYesIrR4FwndVJ6dU3iCyBnSJCt/OpXSST4xw=;
        b=LUB0ST//8a28b7o5yOj+cNJ/lrfZ05GNtkDZdVKm044YS2vLV1fguzEA3ad4x0n/B1
         yig7Iw9ej6vuF5Knf/0HCbuOEqc+WDQRgZDPFA1gNnuIWAcowJA0RDfdefo2fTqpV+4P
         uDPyeo4mxWCuk62zeauRu6CoS2zw3+fXXfSg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AfvgCFNYesIrR4FwndVJ6dU3iCyBnSJCt/OpXSST4xw=;
        b=O4PSTOKiLmV+S+O3CVM0QMOL0MftGVJhjcyDTKljKkQ1xb/6HQbTuTA9pbRgq9wqeE
         ZT6n4+g2MSlaG9BrFuO/rEGvU444ZhIBHlL1Vd8x9KCfzjUfYPUgH9HeIolELsr/9SA9
         z9wWlUD0fLLLekXhQ+1Slg+9Z86Pe/CawAqbCZhwheuNsKyIjt7tvDRLpQT+s27TFlBd
         XCtcNA1Uq30Q96EfVUCNc1wTn8s4Ggs7g1RTTVjAZJEInwkKdr1jx8ofr+3xJjC/K85O
         Gm7cojcEt7ic3vRizlynA7iK1CFW8xgfTE9YMAA46SH7WAMM4OCnhEMrK6iBuAF8vBTP
         NvPQ==
X-Gm-Message-State: AGRZ1gKaw3cwtgy994M7aU2ARpa/3wYwMoQD838g6SlIFVaajPHARM0m
        yj5WM2+LBZbIaUZ/JgtKHo8IJA==
X-Google-Smtp-Source: AJdET5f+zlv/22UKlBRRwkCTsUo/vhzqMhCSCCT/o/6Mvxbss48shUCOIIFnTbqJO3ke5wTl7ul5CQ==
X-Received: by 2002:a17:906:4944:: with SMTP id f4-v6mr4674861ejt.72.1542794932831;
        Wed, 21 Nov 2018 02:08:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm7744290ejb.4.2018.11.21.02.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 02:08:52 -0800 (PST)
Date:   Wed, 21 Nov 2018 11:08:50 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/qxl: add spice-devel list to MAINTAINERS
Message-ID: <20181121100850.GS4266@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
References: <20181121090129.23506-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121090129.23506-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:01:29AM +0100, Gerd Hoffmann wrote:
> So qxl kernel patches are sent to the spice-devel list for review.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Makes sense. Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4caac2f6b0..d9945d57eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4728,6 +4728,7 @@ DRM DRIVER FOR QXL VIRTUAL GPU
>  M:	Dave Airlie <airlied@redhat.com>
>  M:	Gerd Hoffmann <kraxel@redhat.com>
>  L:	virtualization@lists.linux-foundation.org
> +L:	spice-devel@lists.freedesktop.org
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  S:	Maintained
>  F:	drivers/gpu/drm/qxl/
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

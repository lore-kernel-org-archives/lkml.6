Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019DFC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9232089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TNbfYxoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9232089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJCXCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:02:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33102 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeJCXCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:02:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id g26-v6so5910189edp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=y9z2L/YR0HnDa8+159MpAlj0YU3wX/cPhxab2l7e6+0=;
        b=TNbfYxoG8xfz5Zv5RwkCAfSuNZpTa8lHL75pIR/xpL6lFhAvAYqsiu1l9miGcxzKPU
         P4sNGI73HDY++o+2T7ykOEWynswEvBwNE7wDgrsZG41vCI5b3tUOBgCD8JLUidvijRog
         v53QIM2FwdLlwK/LvrNvTOCtUUGJJCsfGkvOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=y9z2L/YR0HnDa8+159MpAlj0YU3wX/cPhxab2l7e6+0=;
        b=gD7KJlQ6uAbUyPTI9LmDvfaEA+HekrS70Ymsw678qxtkSuCcF3bKC2+VPcTUdAP+yv
         tKKL/dop8cFfozeTAdrMJCkWQHVei56I8sXiQ0zHtYPORnAZcm0rp7odpNQXp6HTlq0K
         h6tA7NPy77kQPGB+VReWkMqoYiPMRz3PUb4Q1FjClJ/2fFKFykNeckhUlWhcdxGWjxBi
         6NyznepKMA6FtrqI32tuk5AgBuDfiqrfxn6MtBC3hiOlXJ/4+qHc5YcrItzwa5tSSV1n
         FaTgwKl011Hqa2Ho5CjidZFqxdk3+3iCAsXh9FODusB/L4QbhMXqspH9jr0sXLIseQIg
         PveA==
X-Gm-Message-State: ABuFfojLxq/G2EabUQmP/FZIoz/FyFNtopCnov/DKUy4csDjMZ/JEKWK
        FO9g/OwjW5qoTGToS+hluXLS9w==
X-Google-Smtp-Source: ACcGV61rZnO6SF8S/ntQhs5kzovyxlKHLKHCSU/usRU65jHr9smsGVGn49YndB7uldTABNNZ6DZZRQ==
X-Received: by 2002:a17:906:30d3:: with SMTP id b19-v6mr2722942ejb.42.1538583209714;
        Wed, 03 Oct 2018 09:13:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x53-v6sm754291edx.63.2018.10.03.09.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 09:13:28 -0700 (PDT)
Date:   Wed, 3 Oct 2018 18:13:26 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/imx: move 'legacyfb_depth' definition out of #ifdef
Message-ID: <20181003161326.GD31561@phenom.ffwll.local>
Mail-Followup-To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20181002205836.2323084-1-arnd@arndb.de>
 <123f7e1c-8f2b-5797-de16-650ec01d0b24@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <123f7e1c-8f2b-5797-de16-650ec01d0b24@tronnes.org>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 05:49:32PM +0200, Noralf Trønnes wrote:
> 
> 
> Den 02.10.2018 22.58, skrev Arnd Bergmann:
> > The variable is now referenced unconditionally, but still
> > declared in an #ifdef:
> > 
> > drivers/gpu/drm/imx/imx-drm-core.c: In function 'imx_drm_bind':
> > drivers/gpu/drm/imx/imx-drm-core.c:264:6: error: 'legacyfb_depth' undeclared (first use in this function); did you mean 'lockdep_depth'?
> > 
> > Remove the #ifdef so it can always be accessed.
> > 
> > Fixes: f53705fd9803 ("drm/imx: Use drm_fbdev_generic_setup()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> 
> I've already applied the previous one you sent:
> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=064b06bbf117f8b5e64a5143e970d5a1cf602fd6
> 
> Not sure when it reaches linux-next now that we are past rc6.

Only once we're past -rc1.
-Daniel

> 
> Noralf.
> 
> >   drivers/gpu/drm/imx/imx-drm-core.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
> > index a70f3131a377..0e6942f21a4e 100644
> > --- a/drivers/gpu/drm/imx/imx-drm-core.c
> > +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> > @@ -35,10 +35,8 @@
> >   #define MAX_CRTC	4
> > -#if IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION)
> >   static int legacyfb_depth = 16;
> >   module_param(legacyfb_depth, int, 0444);
> > -#endif
> >   DEFINE_DRM_GEM_CMA_FOPS(imx_drm_driver_fops);
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

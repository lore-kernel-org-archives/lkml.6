Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C31C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4A02086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="M2WfIDc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4A02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbeKGHyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:54:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35691 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeKGHyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:54:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id e18-v6so474444eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 14:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iSgntf/ex8PW0DAiqc3ukD9GaUJfZ+xXcJuBJuPvczU=;
        b=M2WfIDc9j3K/1aITjHkERO5pPqsL+ftKKa5o+x2IZW2x8hOOeV7S9kqCDRj/uVzbWb
         9D649DNo9/21hqOav/HUzCbrlPZH5lK+VQ+oJ7JrSNKUS70NupsQRTOOucgQPFo1+J7C
         UcOX/hd8ji7lb8X++lb1tr1rLR9Z248BEfKRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=iSgntf/ex8PW0DAiqc3ukD9GaUJfZ+xXcJuBJuPvczU=;
        b=NdrAAq1SMLmE2ETFkA+LSNTvxwkeHNLB0DQlYbmOc+QBxiPkId/hvduPy5nv7xby/6
         sJmi8VAMh8c8uU1Csqk7yM+m13EIgnUTO9tRMD8qmP4x5TqJDniVZxdkv7kdkfHttDAM
         tVuDZLNin5utVu8ONaY7ndDEDwbsYrnkA1eUcaO4lksVISB35ctbsliXfpli2ec6XRJa
         SZ3KhUCin1mqCXBaXKa//2hSapHhwc2r3iJ5eoMRamQsbuedu1CXQRVzokRU4Uiw1MuB
         vSuYYkU2ozHK0n859NfwiQhR06eznKcm/lXwTaVvhAMe+GaOFe33v2UOv0SoEsfA8zda
         ThkA==
X-Gm-Message-State: AGRZ1gKw1V/6YpoD700Xmyjs8SX7cB7Gux2Hyl+Qd7/DCwZn+SFo89h/
        gyFJB5hRyHC8z0XgylONNCKKtA==
X-Google-Smtp-Source: AJdET5c1MwieNk7ehoCo3rJWIXRamHNXAM4PzgunLj5uz1twDCajWH0FdW6B7dz+cP0XDD8GzZYejA==
X-Received: by 2002:a17:906:828b:: with SMTP id h11-v6mr17940701ejx.115.1541543198450;
        Tue, 06 Nov 2018 14:26:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r17-v6sm2325133ejr.41.2018.11.06.14.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 14:26:37 -0800 (PST)
Date:   Tue, 6 Nov 2018 23:26:35 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Herring <robh@kernel.org>
Cc:     Sean Paul <sean@poorly.run>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20181106222635.GU21967@phenom.ffwll.local>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20180928225044.20132-1-robh@kernel.org>
 <20181001081659.GW11082@phenom.ffwll.local>
 <CAL_JsqJaoXd5xhhi1kvLHrRiMh1BTbnQ=p8Oz9893uVMJ1UpEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJaoXd5xhhi1kvLHrRiMh1BTbnQ=p8Oz9893uVMJ1UpEQ@mail.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 03:57:16PM -0600, Rob Herring wrote:
> On Mon, Oct 1, 2018 at 3:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Fri, Sep 28, 2018 at 05:50:44PM -0500, Rob Herring wrote:
> > > In preparation to remove the node name pointer from struct device_node,
> > > convert printf users to use the %pOFn format specifier.
> > >
> > > For drm_modes.c, the full node path is already printed out, so printing
> > > just the node name a 2nd time is redundant and can be removed.
> > >
> > > Cc: Gustavo Padovan <gustavo@padovan.org>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Sean Paul <sean@poorly.run>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Acked-by: Rob Clark <robdclark@gmail.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-arm-msm@vger.kernel.org
> > > Cc: freedreno@lists.freedesktop.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v2:
> > > - Add to commit msg that we're dropping redundant printing of node name.
> >
> > Applied, thanks for the patch.
> 
> It appears this hasn't been.

It is, just not yet in linux-next. I'll kick the drm-misc maintainers to
roll the trees forward.
-Daniel

> 
> > Aside, still don't want drm-misc commit rights so you can offload these
> > yourself?
> 
> No thanks.
> 
> Rob
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

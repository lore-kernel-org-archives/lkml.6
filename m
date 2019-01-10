Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEB0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF68220665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MF6Z/e8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfAJUCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:02:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46550 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfAJUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:02:30 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so11194530edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jrR7MN3zWtTOEAlREM10G1K8GL1YyZtNgrncxhm6R/A=;
        b=MF6Z/e8vyuyt3PZWmhubBZvsoDGV8udz/9JB9n1Wa8tk8Rot8D3Tprb7lewlEEba96
         6XR68EF8ElKcjjmoKF5GmqtAeyQfJL0xJ2ujsI6Cj+XWV/0h3pNWbaV1GWemf3wrPvJT
         BKlj4qE76qf5+xcV/avF8kNovPx4huZrQdeeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jrR7MN3zWtTOEAlREM10G1K8GL1YyZtNgrncxhm6R/A=;
        b=PZWWnnmOzqDyow/VIq659iCyEn/IFous8OjNo2cjL6Ikv9ogzPeqqC3biZ0onUcNbI
         jm+fNeCtgjeTdLyuMhh8mHaTqgPK0iGMrlxGEUrzLnxUiznAtsPgVsxkdtUbhPOMYA0q
         LwDYyp0ijsytaxNx1fopFuvelFsOs9G1AWI5OlexfOcRryjHPTApdt/f9kFlf2vQ/cYa
         5IM8jpBkTKyDRqJdz90Bd22LkHgLJNbP59VKUrx+T67jMgFsz4pQIZwIShdVRlmb6gBd
         RXqMNq7wZuoBcioDhEdVe9Dhxvrh+NsgDL98gL74xxhm5wLe2dbnTLk4q6LXa8RZY4Cb
         Gh3w==
X-Gm-Message-State: AJcUukcGHpCOknfvOs1y1OgaOu3xpxUefhGNp0uwgUDsSGQvSaSU0IUe
        lwAY3x2Qvz5DYaIO9ToI2EGYfw==
X-Google-Smtp-Source: ALg8bN4ghh7FfiwCL04u7h0DHffsPEYyFSFMnK/w05EGbuocyRoLMP0SFemKJXl0ZmaVw/yLr33Heg==
X-Received: by 2002:a50:9724:: with SMTP id c33mr10876479edb.288.1547150548360;
        Thu, 10 Jan 2019 12:02:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c23-v6sm1230019ejb.62.2019.01.10.12.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 12:02:27 -0800 (PST)
Date:   Thu, 10 Jan 2019 21:02:25 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alexander Ryabchenko <d3adme4t@gmail.com>
Subject: Re: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
Message-ID: <20190110200225.GN21184@phenom.ffwll.local>
Mail-Followup-To: Frank Wunderlich <frank-w@public-files.de>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
        Alexander Ryabchenko <d3adme4t@gmail.com>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
 <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:01:37PM +0100, Frank Wunderlich wrote:
> Hi Daniel,
> 
> > > Would be good to use the new generic fbdev emulation code here, for even
> > > less code. Or at least know why this isn't possible to use for mtk (and
> > > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > > needed anymore.
> > 
> > Back on the mailing list, no private replies please:
> 
> i don't wanted to spam all people with dumb questions ;)

There's no dumb questions, only insufficient documentation :-)

> > For examples please grep for drm_fbdev_generic_setup(). There's also a
> > still in-flight series from Gerd Hoffmann to convert over bochs. That,
> > plus all the kerneldoc linked from there should get you started.
> > -Daniel
> 
> this is one of google best founds if i search for drm_fbdev_generic_setup:
> 
> https://lkml.org/lkml/2018/12/19/305
> 
> not very helpful...
> 
> so i tried kernel-doc
> 
> https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup
> 
> which is nice function-reference but i've found no generic workflow
> 
> as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
> Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?
> 
> i personally make my first steps as spare-time kernel-developer :)

There's a ton of in-kernel users of that function already, I meant you can
use those to serve as examples ... If those + the kerneldoc aren't
good enough, then we need to improve them.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

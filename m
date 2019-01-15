Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0828EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE82620861
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BAm485aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfAOLuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:50:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42751 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfAOLuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:50:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so2284468edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 03:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVuxywLN+hWEFqBjPujx3b2tZlMigafVMeZjipOROPY=;
        b=BAm485aPBpi6LOUpU2/JyszSSBj6GbV5gZz2fWeV7xJId5HlUAqL5tstmZYEIMtCdy
         wMfnj5Isrp/UHPVqXkYfkzE7PA746FvOkgEGqqtrmft5+XHGgxrP7shLMRlAPZSPk/xb
         kgsevCthfCO1+TxvW8OnRGCHYKLyQ9AvNnujE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fVuxywLN+hWEFqBjPujx3b2tZlMigafVMeZjipOROPY=;
        b=pS/0L6IcDYQT2jXA5HN2I+O97hd+yQJjoDgaMXDZIr2kEEVxWhttDKJrQK0Zg9sgNr
         TqPP3ZcA/mxsVqS/GkGPBGfyX+TzZ0JNgSmgh+euWhjzKn6chtvdZ0Um+mmzJilbZzDb
         DbB6OjUw65kDd0jXpqoRgWB4V1GzcsqMqORuCEtJXRQR3srQZ1JtmVOHuSvT4IGhRYiK
         4JwChDtxyku2Zu4c2+OessLTRnpHswSorKpk5JpG/1mVKrknYw7qQv34Xd0ipWYFq8xL
         IxgkSTfQxmjv5/CINhcIUz0uzAAyR0mYpEChv2svS+eLp8gJ8VU0RMlDIG3yoBPwLPLe
         Jo7w==
X-Gm-Message-State: AJcUukdPfU8w844S2DRkjNOHR+6UKtdDX8jBnAOr5FRtMW+D0GAivCJe
        anaumpACSF4XuF2ci76y4uorYg==
X-Google-Smtp-Source: ALg8bN6EXwXCz5ljb27foesQQh1wF8UVvsKCPp9B72ou2Wwpo8QTJPHu4RsO9pl5Nrp5f77YoWrvdA==
X-Received: by 2002:a50:8ad9:: with SMTP id k25mr3118584edk.189.1547553019301;
        Tue, 15 Jan 2019 03:50:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k20sm4834955eda.71.2019.01.15.03.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 03:50:18 -0800 (PST)
Date:   Tue, 15 Jan 2019 12:50:16 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/dp: annotate implicit fall throughs
Message-ID: <20190115115016.GK10517@phenom.ffwll.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mathieu Malaterre <malat@debian.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190114202748.15584-1-malat@debian.org>
 <1d2a0c58-2419-9c43-b0d6-a8c1b387c240@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2a0c58-2419-9c43-b0d6-a8c1b387c240@embeddedor.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:13:29PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 1/14/19 2:27 PM, Mathieu Malaterre wrote:
> > There is a plan to build the kernel with -Wimplicit-fallthrough and
> > these places in the code produced warnings (W=1). Fix them up.
> > 
> > This commit remove the following warnings:
> > 
> >    include/linux/compiler.h:77:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    include/asm-generic/bug.h:134:2: note: in expansion of macro 'unlikely'
> >    drivers/gpu/drm/drm_dp_helper.c:155:3: note: in expansion of macro 'WARN'
> >    include/linux/compiler.h:77:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    include/asm-generic/bug.h:134:2: note: in expansion of macro 'unlikely'
> >    drivers/gpu/drm/drm_dp_helper.c:173:3: note: in expansion of macro 'WARN'
> >    drivers/gpu/drm/drm_dp_helper.c:547:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > 
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks for your patch, applied.
-Daniel

> 
> > ---
> >   drivers/gpu/drm/drm_dp_helper.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> > index 516e82d0ed50..26835d174939 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -154,6 +154,7 @@ u8 drm_dp_link_rate_to_bw_code(int link_rate)
> >   	default:
> >   		WARN(1, "unknown DP link rate %d, using %x\n", link_rate,
> >   		     DP_LINK_BW_1_62);
> > +		/* fall through */
> >   	case 162000:
> >   		return DP_LINK_BW_1_62;
> >   	case 270000:
> > @@ -171,6 +172,7 @@ int drm_dp_bw_code_to_link_rate(u8 link_bw)
> >   	switch (link_bw) {
> >   	default:
> >   		WARN(1, "unknown DP link BW code %x, using 162000\n", link_bw);
> > +		/* fall through */
> >   	case DP_LINK_BW_1_62:
> >   		return 162000;
> >   	case DP_LINK_BW_2_7:
> > @@ -552,6 +554,7 @@ int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> >   		case DP_DS_16BPC:
> >   			return 16;
> >   		}
> > +		/* fall through */
> >   	default:
> >   		return 0;
> >   	}
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

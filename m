Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D264C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7BA2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dr63eMG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfAGKdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:33:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37212 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfAGKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:33:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so385418edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vfk3PowwMKp15Tt5YwQln/FnD9UY/ok8kCfjL45nT9U=;
        b=dr63eMG6Z1+qP2Os4nI508i78eLwVaamo6hE7PdkYiisklYPkn+BKfBvb2fApvXDPa
         hyng4M4wsSRW3PAy25KgdKKocBGpltjxGbUpC9GmdwNdhskW3cZ1JnQ0xPI08iFKS8sL
         D2vh+7m3HUZo5NTyPksZTatnJjkL//FoAZBBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vfk3PowwMKp15Tt5YwQln/FnD9UY/ok8kCfjL45nT9U=;
        b=qzt+NiwU0/CK4go88TmyZ6UKSrGorpwelWnhHkDJdKBemW+ByA6VVwhENCkbduwFho
         TSCX0oF2L59NxDTB7hrtOsdx7d2jr+xY2vQ2FlPpidlxUrAMitc1utx/j2OcdKs/Maqh
         Hs3cqWexfpRbrCra8vR0Ib7dRgDImsmFzJnB+HTEM7r9mubKgF0EK24iymAOhsY51hFi
         WF1iMUWKXpCM1uUH3y+K1qYvtog5ij4vV29/efxKmPPDnIZxsKIX3i+ka3l5usGP94jz
         uIOlQUf8Fhty2Df3fuGE7wrmA6AOmU7dDjn2wl0b56U3PyLetP37s3qLutjGmQkn1nW/
         rpCA==
X-Gm-Message-State: AA+aEWZ1AOpL1QTmLgl1rQfYC5u4FDLl/Pfkh8dWkrjmGxa3GsICQMpM
        haBWHZ63pJ2gxrS6e3elEhCBEA==
X-Google-Smtp-Source: AFSGD/Wik8djyjWRkkHGpuZpveVCb/CsGaBSeoutEO3mnT8niriwOdMEj26TESqPTFAvF6jqUI+njw==
X-Received: by 2002:a17:906:4e82:: with SMTP id v2-v6mr46216209eju.149.1546857197184;
        Mon, 07 Jan 2019 02:33:17 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id u7-v6sm17596743ejb.65.2019.01.07.02.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 02:33:16 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:33:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 07/14] drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to
 drm_util.h
Message-ID: <20190107103314.GF21184@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181230174838.32330-8-sam@ravnborg.org>
 <20190103081646.GB31320@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103081646.GB31320@infradead.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 12:16:46AM -0800, Christoph Hellwig wrote:
> On Sun, Dec 30, 2018 at 06:48:31PM +0100, Sam Ravnborg wrote:
> > +/*
> > + * Use EXPORT_SYMBOL_FOR_TESTS_ONLY() for functions that shall
> > + * only be visible for drmselftests.
> > + */
> > +#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
> > +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
> > +#else
> > +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
> > +#endif
> 
> Btw, why isn't this an EXPORT_SYMBOL_GPL if it is only for internal
> tests?

Yeah EXPORT_SYMBOL_GPL makes sense here I think. Well most of drm is still
MIT, so it's a bit hm, but the semantics of _GPL still seem like what we.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

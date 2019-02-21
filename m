Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D369C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1998C20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="G4CzBKpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfBUPvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:51:39 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39108 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfBUPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:51:39 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so15996070edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z0QBM+Nq9PV4DVkwSBP+GPZvEo1vdx/vc+qZnGHCWwA=;
        b=G4CzBKpORXnaJhIBZmmJGTA7miUKT5/d7COl+t3ZUey5GvxmtffsNobVapgUErbx1f
         agsBkhTBvkGwoOFean/My/zzaXy/hSCTit55dCZjEHg1YJ/GZS0Z2LN1BP25dol7XA6T
         9JWNnwbr62cNfiP/d0QzAMTh0Y5hfh2XYpegg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=z0QBM+Nq9PV4DVkwSBP+GPZvEo1vdx/vc+qZnGHCWwA=;
        b=jBb2lbPd8BFmC2dRyAZZans0AMWb/lBM2IoA15u1vaedjc042zjN9gZRLIMprK2DUK
         SEfTqmuyBUp9+XjisfR25027cQc1uFC6bFLMJ4cHjZ7O+6pW25TL5x8okcOP17NKmY1b
         FlFHkMEwK6thp5BydFUUkDtgmtV7BO9bavytinHPuyhpKQ6MuypYcPpZ+8XIypbM8SCS
         t6mpocly/r7iEcKW9eoZTFbwcfsNSoYN01+kls8QLFBsgactqGIXoym9c16t4+bw44cz
         dwS99F5AGoezyuoMimEWiRQNzhNQ+B7nT2VrZFlVv3aQvXNNJVmRrLQnIVrID20ywzku
         Y0iw==
X-Gm-Message-State: AHQUAuZqp/1e7MUXQReQF3VfvBMqVPVi7xagPKUI2BmHmRf7CJJ1qF0x
        8fTKh7V/ZT4SBZCvLk2U32YrYlWXe2XFnA==
X-Google-Smtp-Source: AHgI3IY0IInap4ahPRh2JP9HKzkyltTZJyXpNHvbed/ojstJ97B4EacQCpXqiXlS1XldYiXqFRm1iA==
X-Received: by 2002:a50:c20a:: with SMTP id n10mr32689207edf.60.1550764297219;
        Thu, 21 Feb 2019 07:51:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b11-v6sm4839651ejd.16.2019.02.21.07.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:51:36 -0800 (PST)
Date:   Thu, 21 Feb 2019 16:51:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "open list:INTEL DRM DRIVERS excluding Poulsbo, Moorestow..." 
        <intel-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 1/2] drm: move i915_kick_out_vgacon to drm_fb_helper
Message-ID: <20190221155134.GU2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "open list:INTEL DRM DRIVERS excluding Poulsbo, Moorestow..." <intel-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>
References: <20190221113534.20764-1-kraxel@redhat.com>
 <20190221113534.20764-2-kraxel@redhat.com>
 <64292443-e784-5c15-9e3b-d52afc861991@tronnes.org>
 <20190221150912.yytlcxxwv7qodaf3@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221150912.yytlcxxwv7qodaf3@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:09:12PM +0100, Gerd Hoffmann wrote:
> > > +int drm_fb_helper_kick_out_vgacon(void);
> > > +
> > 
> > Don't you need a dummy version as well for this one, like how it's done
> > for the other functions, to cover the case when DRM_FBDEV_EMULATION is
> > not selected?
> 
> Good question.
> 
> I guess it makes sense to kick out vgacon even with CONFIG_FB=n.
> 
> But when integrating this into
> drm_fb_helper_remove_conflicting_pci_framebuffers() as suggested by
> Daniel this isn't going to fly ...

We need to put it into both versions of that function, or pull that
function out of the #ifdef.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

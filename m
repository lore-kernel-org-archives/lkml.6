Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2167FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B5E2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gXo52Ov6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B5E2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeKUUOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:14:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40792 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbeKUUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:14:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so4317858edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=icQOPER0ybQIipyfCa6dQzK/fVv01EVv422B9EVucP4=;
        b=gXo52Ov6f7XAEPQrV8P7kns9QUOZtlyb4iJSzyH0UMM0ZhqmO7lqpRsqenE9UP1nnr
         ZHgz5Xb4jfYOtBceGTEvdbHka9W14lQbktrBivnpSStwbaZFqLsgLkN7ORSs7tdawBsm
         fqYPAjGCF2Hwe+1yrtCklI3V2tS7QmpOkr9Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=icQOPER0ybQIipyfCa6dQzK/fVv01EVv422B9EVucP4=;
        b=jI70LQPn5Wirb1TQDlUC8qocAfUHT+NsPRLSDpiOv9naL/hGRBHspoSarigYJ/sIJx
         eQg+aHc68EAXCTrdd2bzyi3Qq0Ou8ZivEbZawd3Yn0lnNB1MtaNb87ViHV5egPcIf4ng
         vHuMUJR94/e0Do/OqkExxebymmkAk7wh34wuk9IPgGsML8E1ErYxgKiiLQCPZjRo+lbk
         t4KaENE/CIwF47iz8BCPlK375KTyJB7g2oGNTVKIeEzOj/qF25OLbWCKKglhIxIr17mI
         N2hA5GCM+3onH0yV096tOV6Oi+U+39fc2IhJCZ1c014UvWTRVXPv6nvXNIilstwscTnM
         iLmg==
X-Gm-Message-State: AA+aEWYalMCk3I2mQAu4OWoR1y4Cua/kMGHwIN+zr7cL6zmiGPNmIM0d
        i1bwbta51FNGo32Mokv3DXyFbt8FzZQ=
X-Google-Smtp-Source: AFSGD/VZzxz+krKyi1CCCbar+uHI07UwTj3W7iY/aKCc5T5IJeEFCslUtEajVxU0qs012euece2gpw==
X-Received: by 2002:a50:a663:: with SMTP id d90-v6mr5220847edc.290.1542793221550;
        Wed, 21 Nov 2018 01:40:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a11sm8852131edc.28.2018.11.21.01.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 01:40:19 -0800 (PST)
Date:   Wed, 21 Nov 2018 10:40:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm/fb-helper: Blacklist writeback when adding
 connectors to fbdev
Message-ID: <20181121094017.GM4266@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sean Paul <sean@poorly.run>
References: <20181115163248.21168-1-paul.kocialkowski@bootlin.com>
 <20181119092835.3y2xqfclwlmk4cww@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119092835.3y2xqfclwlmk4cww@flea>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:28:35AM +0100, Maxime Ripard wrote:
> On Thu, Nov 15, 2018 at 05:32:48PM +0100, Paul Kocialkowski wrote:
> > Writeback connectors do not produce any on-screen output and require
> > special care for use. Such connectors are hidden from enumeration in
> > DRM resources by default, but they are still picked-up by fbdev.
> > This makes rather little sense since fbdev is not really adapted for
> > dealing with writeback.
> > 
> > Moreover, this is also a source of issues when userspace disables the
> > CRTC (and associated plane) without detaching the CRTC from the
> > connector (which is hidden by default). In this case, the connector is
> > still using the CRTC, leading to am "enabled/connectors mismatch" and
> > eventually the failure of the associated atomic commit. This situation
> > happens with VC4 testing under IGT GPU Tools.
> > 
> > Filter out writeback connectors in the fbdev helper to solve this.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Tested-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied with a cc: stable to drm-misc-fixes. Btw, 2 r-b from committers,
someone should have pushed this I think :-)

Thanks for patch&review.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

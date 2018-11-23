Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76344C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184F5206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FoBpc3B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184F5206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeKWQSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 11:18:45 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42032 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeKWQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 11:18:44 -0500
Received: by mail-yb1-f193.google.com with SMTP id o204-v6so4319043yba.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 21:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZyzkIy1RBPCxhkkUXXdPnYFEhrbHkpEXb6nhY8b4mY=;
        b=FoBpc3B/Dpxua0st18UxwqH6naGQd+HF7E41Vzon4NNi9GWn1GC69N6PPUOg07TA7J
         jL3v0KpS8NFUTsNHJ3M86jKAbO/0/1cO1SAoHeM9TrkzY4sFndnlrM21HVCanjgqVnbT
         Il7a+iQ1O/cXNgMw6IztK8ZDyly+NH7esSz8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZyzkIy1RBPCxhkkUXXdPnYFEhrbHkpEXb6nhY8b4mY=;
        b=dWRTgzuCX0MhO2RLqR/VgIm4l5dI2qjVOVBa2ZISXyHfZKkXT7S/K2qOCPOD6XixrO
         lypA1sQDSEpzg4UINnxhjl0ziKF1c+mli+RlwqG3R3Bc4bT54O94+HIcXHC33juws4Xb
         q29N17ApnqIF5DlDfTaBHuKSITeNTi2i/DkTqCi3I2SDD8/NW4RXSZcV4WP2cv38z7W/
         KPTAM4mv6Vss/IPLdBMPwnyxyPXJNXFNAC7j9cOnJwPDWYFUwauSWQEMjbjRq8zJnHBV
         wEkkLLZA/CWQQ2+zWVUsuRprujozHJ5LrATWpyIqZNXcqTMzwoY1is4gD9efvTj98TTK
         7U5Q==
X-Gm-Message-State: AGRZ1gIORCDl/UjjghEBtnPByR4BXb3UyOK0sQFQlhTDXdJTZO2WPyKV
        q7vjLjI5O6+34Ja+QzpY9Zq4va0e1q8=
X-Google-Smtp-Source: AFSGD/UMgAzEzpofyGGRHmrwbk2gqYDLwumk9i4C1urTN9XtjJWs8QyO0PGWdcU13Ey3TEjTck7USw==
X-Received: by 2002:a25:cc9:: with SMTP id 192-v6mr14476015ybm.145.1542951363449;
        Thu, 22 Nov 2018 21:36:03 -0800 (PST)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id k192-v6sm16656654ywk.99.2018.11.22.21.36.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 21:36:01 -0800 (PST)
Received: by mail-yw1-f44.google.com with SMTP id l200so4371663ywe.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 21:36:00 -0800 (PST)
X-Received: by 2002:a81:3dc4:: with SMTP id k187-v6mr14802254ywa.415.1542951360072;
 Thu, 22 Nov 2018 21:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20181119190805.19139-1-helen.koike@collabora.com>
 <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
 <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com> <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
 <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
In-Reply-To: <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 23 Nov 2018 14:35:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DAti8Vf+jyLp6nVH5FiesE=jLNoLq3AFaqdm2FfY=v9Q@mail.gmail.com>
Message-ID: <CAAFQd5DAti8Vf+jyLp6nVH5FiesE=jLNoLq3AFaqdm2FfY=v9Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/rockchip: update cursors asynchronously through atomic.
To:     mzoran@crowfest.net
Cc:     helen.koike@collabora.com, Eric Anholt <eric@anholt.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Nov 23, 2018 at 1:58 PM Michael Zoran <mzoran@crowfest.net> wrote:
>
> On Fri, 2018-11-23 at 11:27 +0900, Tomasz Figa wrote:
> >
> > The point here is not about setting and resetting the plane->fb
> > pointer. It's about what happens inside
> > drm_atomic_set_fb_for_plane().
> >
> > It calls drm_framebuffer_get() for the new fb and
> > drm_framebuffer_put() for the old fb. In result, if the fb changes,
> > the old fb, which had its reference count incremented in the atomic
> > commit that set it to the plane before, has its reference count
> > decremented. Moreover, if the new reference count becomes 0,
> > drm_framebuffer_put() will immediately free the buffer.
> >
> > Freeing a buffer when the hardware is still scanning out of it isn't
> > a
> > good idea, is it?
>
> No, it's not.  But the board I submitted the patch for doesn't have
> anything like hot swapable ram.  The ram access is still going to work,
> just it might display something it shouldn't. Say for example if that
> frame buffer got reused by somethig else and filled with new data in
> the very small window.

Thanks for a quick reply!

To clarify, on the Rockchip platform this patch is for (and many other
arm/arm64 SoCs) the display controller is behind an IOMMU. Freeing the
buffer would mean unmapping the related IOVAs from the IOMMU. If the
hardware is still scanning out from the unmapped addresses, it would
cause IOMMU page faults. We don't have any good IOMMU page fault
handling in the kernel, so on most platforms that would likely end up
stalling the display controller completely (on Rockchip it does).

>
> But yes, I agree the best solution would be to not release the buffer
> until the next vblank.
>
> Perhaps a good solution would be for the DRM api to have the concept of
> a deferred release?  Meaning if the put() call just added the frame
> buffer to a list that DRM core could walk during the vblank.  That
> might be better then every single driver trying to work up a custom
> solution.

Agreed.

Best regards,
Tomasz

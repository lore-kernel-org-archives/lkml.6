Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7510DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E426A20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TjlgNHiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E426A20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeIIQxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 12:53:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33175 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeIIQxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 12:53:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id d8-v6so14528084edv.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PSaPteZOwUWCyaJnmW0KjszXblroNbQ036MRoBRas8w=;
        b=TjlgNHizsD/4dwrStI5A3qjFrQnfuzkdHaC7bGn/UPtePgOJKWhVpPA4f5LHaLgI+e
         w+wn3OGaYybRzdgXh52DvS6uHtw0rYPWbA16gOOHcF1TOdVJT5bukIxGA/inTak+dlwB
         clqlf0xAVF9hrddyXGWVt2BcBIM257xRIh0DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=PSaPteZOwUWCyaJnmW0KjszXblroNbQ036MRoBRas8w=;
        b=L8/R6Jec1LuAZVrQ0P7f5uTaCdsO9x5KIBpgJXRkJfHfKpVMgolWC+2aHNy0mMxy3A
         HQmRTPi+g9c3HlPb2XQ+Dbyh7QwTuKsJHsxuRe1cs/OWlZUfivC7Zw1UNF4v/tZYol+j
         YDVKzE9sYIEIuh0KEQwjKU/Bh2nU43pajBVHnpAbtey25nrzyU+xJMIFRuafACp4O2XF
         E/z43BUVjbuJ77sg6how2U8wZQyG8KsAG0TaubqWhjRPneuDElAd9shaAV8RPFoCVXjs
         5SDNANpxQ4m/rdhlPggjddIDEs20jeDwmSECvzSXQoSoCPu7WI98gUkU2AZFWLkuFrQN
         LZ2A==
X-Gm-Message-State: APzg51CN2GPoPP+XTkGohA5DTw58NfNyya4+exI+fiV69tDy9YdD/QK3
        iBbneNaqK0P6WvEML83Sfj+G6w==
X-Google-Smtp-Source: ANB0VdYyWt7zpRhplljUmuu3nfJo9wADUFIRLh+Bar1almy3NXl3P2Ms1PEGOr3fz9/NwTeajgTZbw==
X-Received: by 2002:aa7:d707:: with SMTP id t7-v6mr18327156edq.250.1536494645060;
        Sun, 09 Sep 2018 05:04:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p28-v6sm9351976eda.85.2018.09.09.05.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 05:04:03 -0700 (PDT)
Date:   Sun, 9 Sep 2018 14:03:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Ayan Kumar Halder <ayan.halder@arm.com>, liviu.dudau@arm.com,
        brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v2 0/4] Add support for Arm Framebuffer Compression(AFBC)
Message-ID: <20180909120357.GA19774@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        Ayan Kumar Halder <ayan.halder@arm.com>, liviu.dudau@arm.com,
        brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
References: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
 <0e22e63c-6981-9e5d-ed2d-2ad1dfbccd4f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e22e63c-6981-9e5d-ed2d-2ad1dfbccd4f@baylibre.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 03:58:53PM +0200, Neil Armstrong wrote:
> Hi Ayan,
> 
> On 10/07/2018 15:18, Ayan Kumar Halder wrote:
> > In the current series of patches, we are trying to add support for AFBC
> > modifiers in malidp. AFBC modifiers adds some constraints to framebuffer
> > size, alignment, pitch, formats, etc. Here we are trying to add support
> > for one combination of AFBC modifier ie AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> > AFBC_FORMAT_MOD_SPARSE | AFBC_FORMAT_MOD_YTR.
> > In future, we intend to add support for more combination of AFBC modifiers.
> > Currently, we are trying to enable a basic support of AFBC in malidp.
> 
> Thanks for pushing AFBC support, this will help supporting it on other SoCs implementing support
> like Amlogic, Rockchip or Samsung.
> 
> I have one question, is there a way to generate such AFBC buffers without the Mali GPU ?
> I mean, is there a way to generate some sample buffers with some of the modifier features
> to validate it without having the complete Mali GPU -> DRM chain ?

An igt would be perfect. We've done that for i915 compressed buffers. Note
that it just needs to be an afbc buffer, not actually compressed. Setting
all the bits to indicate "uncompressed" for each block is what we did for
the i915 test. As long as the igt uses DRIVER_GENERIC and kms driver could
then use it to validate the basics of afbc support.
-Daniel

> 
> Thanks in advance,
> Neil
> 
> > 
> > Changes from v2:
> > - Added ack by Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > for patch 1. However, this has been kept in this series in order to help
> > reviewers review the other patches (which are related to patch 1)
> > - For patches 2 and 4, replaced DRM_ERROR() with DRM_DEBUG_KMS()
> > - For patch 3, reworked malidp_de_set_plane_afbc() so as to consolidate
> > all afbc specific register configuration in this.
> > 
> > Ayan Kumar Halder (4):
> >   drm/arm/malidp: Add modifier definitions for describing Arm
> >     Framebuffer Compression (AFBC).
> >   drm/arm/malidp: Implemented the size validation for AFBC framebuffers
> >   drm/arm/malidp: Set the AFBC register bits if the framebuffer has AFBC
> >     modifier
> >   drm/arm/malidp: Added support for AFBC modifiers for all layers except
> >     DE_SMART
> > 
> >  drivers/gpu/drm/arm/malidp_drv.c    | 129 +++++++++++++++++++++++++++++++++++-
> >  drivers/gpu/drm/arm/malidp_hw.c     |  27 +++++---
> >  drivers/gpu/drm/arm/malidp_hw.h     |   7 ++
> >  drivers/gpu/drm/arm/malidp_planes.c | 129 +++++++++++++++++++++++++++++++++---
> >  drivers/gpu/drm/arm/malidp_regs.h   |  20 ++++++
> >  include/uapi/drm/drm_fourcc.h       |  83 +++++++++++++++++++++++
> >  6 files changed, 373 insertions(+), 22 deletions(-)
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

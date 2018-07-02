Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C84CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4E12540D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JURjNdug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4E12540D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964798AbeGBIHM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:07:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45795 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeGBIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:07:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id g15-v6so6675555edr.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mAGPdolyKjJzAHkG5jJRqiXSQgb/qPf/D2HK6kVlSZo=;
        b=JURjNdugKnQ4YbHJbtFxJnol78FR45TJ1EJ8NjJ4JGxtsV5rvrOmP3MudV1WV3n2UO
         kg+XGvXGgZmhVfZTTeC81wS2JbJb0xlLQujdUHPJJHIsSDKlNNmQ29XhKNxEveI7AZMN
         E+6vNWlsFWMEpeRJHJC572sskxE64TsR0VNmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mAGPdolyKjJzAHkG5jJRqiXSQgb/qPf/D2HK6kVlSZo=;
        b=e+uCx5mfOkTvpEvWusDlhGJtMxmBMhFqH8N1vf98ncNvHUSber1OGYcxa2M1YK3Pzy
         lzKaOQ6bCu+38RGcZJQrAIKiHrg4ox19ppYL1V2VW8m7u5oQvPiXC0gUji1tr1i4o1y8
         5XPjmxeFue/yTUZhaLMee0eDryshb0QvAbUq4Ja81e+4bRjpBSyGro2qoryCBjV87F2F
         Wi2txRXgHHF7VGMS2UdiVbMW8Ur/gLJd4MB9iqYZN8yEaI3D4e8qBWFFHMaDq57EbKqr
         SpvvT29imS3FoATHPeQd7feRJt4zUa4zsvsWIEkpx2cX9KyRxI1TDesHO087vG2BcOK7
         5xCA==
X-Gm-Message-State: APt69E3hDjLWwOPiO1wM9wBxCNuHLmSpblqALFiMDoWmPv/+VgyiJTKz
        V0sdxHVpmm5/3KUaArpSqHuD4J3B
X-Google-Smtp-Source: AAOMgpdZbJwrzo95X3XmIeAVNdrGy7Qg2ktAW0zchd1oXlAv1z2gA4U19OFlkvvTxZyMNQhSw9MLXQ==
X-Received: by 2002:a50:9e8a:: with SMTP id a10-v6mr15786640edf.92.1530518827059;
        Mon, 02 Jul 2018 01:07:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id m51-v6sm9306972edc.94.2018.07.02.01.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 01:07:06 -0700 (PDT)
Date:   Mon, 2 Jul 2018 10:07:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Use kvzalloc for allocating blob property memory
Message-ID: <20180702080704.GG13978@phenom.ffwll.local>
Mail-Followup-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20180629142710.2069-1-michel@daenzer.net>
 <20180629161205.GE5565@intel.com>
 <32deece3-b583-ca58-cd41-ba11846240c8@daenzer.net>
 <20180629163832.GF5565@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180629163832.GF5565@intel.com>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 07:38:32PM +0300, Ville Syrjälä wrote:
> On Fri, Jun 29, 2018 at 06:27:28PM +0200, Michel Dänzer wrote:
> > On 2018-06-29 06:12 PM, Ville Syrjälä wrote:
> > > On Fri, Jun 29, 2018 at 04:27:10PM +0200, Michel Dänzer wrote:
> > >> From: Michel Dänzer <michel.daenzer@amd.com>
> > >>
> > >> The property size may be controlled by userspace, can be large (I've
> > >> seen failure with order 4, i.e. 16 pages / 64 KB) and doesn't need to be
> > >> physically contiguous.
> > > 
> > > I wonder if we should enforce some kind of reasonable limit
> > > on the blob size. Looks like we allow anything up to
> > > ULONG_MAX currently. We can't tell at createblob time how
> > > the thing is going to be used, so can't have any kind
> > > of property specific limit unfortunately.
> > 
> > The failure I was seeing was for a gamma LUT, so a size limit alone
> > cannot solve the issue.
> 
> Sure. I was just thinking that maybe we shouldn't allow someone to
> allocate unlimited amounts of kernel memory via this interface. But
> to do that effectively we'd also need to limit the total amount used
> by all blobs.

People with drm master rights are allowed to pin enormous amounts of
memory (through pinning of display buffers) ... I think simply requiring
DRM_MASTER for the ioctl would be good enough. Atm anyone can abuse
createblob to waste memory, which is a bit much.

We haven't marked it with DRM_RENDER_ALLOW, so I think this is just an
oversight really. I'll type a patch.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC7DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1465920833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E924rD4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1465920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIKRLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:11:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41520 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeIKRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:11:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so19025282edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wU0ieasMRzP8a+s1vQ64p57O5pFULg0nmuyD2hlJkHA=;
        b=E924rD4gdG/ap4gFYqkGHTlq1G1rYYMhWL9jNEnu1KDLHocmRs4+J+k7x2QbvckaAo
         pyQP9EDXO7mELLu2k39n6q9dM0OzjiOIIXmQeSMUa11HiOiodZFmWAiMCjGDxLbWWm22
         BYOWAstCBtb/VeSLJ8aHOBxLW0uKSix94QqPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wU0ieasMRzP8a+s1vQ64p57O5pFULg0nmuyD2hlJkHA=;
        b=pUCpW+JTI9L8M//tD0vcYK/HTH45rix0zy9ILL26SshnAaP3/PvhqGTVmRTy7qp2Va
         WFcxGiov05wDMkHMCLTzCm2LHQSb90JGXf9qQVcXeG8Ij2Gq1j2wXEX1107u5tBqBgrA
         ZggETDnyKcMO/1CMMduQht2zCn96dPR2xJLKSWpmUejhm0RoPMNXW9iqnk/mBmcIMg6R
         tFnOo2lyzT9yqTnGDfl91k4gXiPM/ojcKQayXLpIk7p8u0v+aweYEyIKJj5LP7BNssz9
         ap8G6g4RH2f5kElaPXUEO7iWrasZQBdGW01nS+VlMWf7QX6mpNhEys83tIqSy08WMXb5
         5KDw==
X-Gm-Message-State: APzg51CkAt3lnDL0+q86RXVmmn2mBor0QmvCTZM2zzjQJUijoAJ2CT1m
        0/K/60peERWihHW4ucEACqh/WQ==
X-Google-Smtp-Source: ANB0VdYuqxicDMcNOeE25dfk8AMDVyIYc5U5KxkerMzEtXvwlbPRDRbFhD4v/OhxFJcrvd6fRLtQug==
X-Received: by 2002:a50:80e6:: with SMTP id 93-v6mr28261122edb.73.1536667939287;
        Tue, 11 Sep 2018 05:12:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y7-v6sm9808463edd.13.2018.09.11.05.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 05:12:18 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:12:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [Intel-gfx] [PATCH 1/4] fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
Message-ID: <20180911121216.GK19774@phenom.ffwll.local>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, nouveau@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <CGME20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1@epcas5p3.samsung.com>
 <20180822085405.10787-1-daniel.vetter@ffwll.ch>
 <20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18@eucas1p1.samsung.com>
 <20180911074228.GI19774@phenom.ffwll.local>
 <20180911084736eucas1p1e7f98eb3bc4e30bdc1041744fc7fc7a6~TTC14JPXa1980019800eucas1p1O@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911084736eucas1p1e7f98eb3bc4e30bdc1041744fc7fc7a6~TTC14JPXa1980019800eucas1p1O@eucas1p1.samsung.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 10:47:34AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On 09/11/2018 09:42 AM, Daniel Vetter wrote:
> > On Mon, Sep 10, 2018 at 02:48:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >>
> >> On 08/22/2018 10:54 AM, Daniel Vetter wrote:
> >>> This was only added for the drm's fbdev emulation support, so that it
> >>> would try harder to show the Oops.
> >>>
> >>> Unfortunately this never really worked reliably, and in practice ended
> >>> up pushing the real Oops off the screen due to plentyfull locking,
> >>> sleep-while-atomic and other issues. So we removed all that support
> >>> from the fbdev emulation a while back. Aside: We've also removed the
> >>> kgdb support, for similar reasons.
> >>>
> >>> Since it's such a small patch I figured I don't split this up into the
> >>> usual 3-phase removal.
> >>>
> >>> Cc: Ben Skeggs <bskeggs@redhat.com>
> >>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Cc: Hans de Goede <hdegoede@redhat.com>
> >>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> >>> Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> >>> Cc: Kees Cook <keescook@chromium.org>
> >>> Cc: Thierry Reding <treding@nvidia.com>
> >>> Cc: David Lechner <david@lechnology.com>
> >>> Cc: nouveau@lists.freedesktop.org
> >>> Cc: linux-fbdev@vger.kernel.org
> >>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >>
> >> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > 
> > Ack for merging the entire series through drm-misc-next?
> 
> Yes, thanks for taking care of this.

Thanks, all merged into drm-misc-next for 4.20.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

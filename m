Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDEEC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A7820824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ETJ/DBQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A7820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeJXRZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:25:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44509 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeJXRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:25:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id z21-v6so4259383edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O3Cul3mSd4+G/ktVZiMosNjfwO7C986tqXSwvrAXdeo=;
        b=ETJ/DBQ+C8fGR7HJk0vZqARqOfpJZW9o/VdWu6+krf89flgqWlg43oK7MsPvZmB4Mb
         Jj3E3lHBbBywv/PU8VHLFucELihfQ63jaLb09oM9ldeTO8wFgjftrqLBfhCKMoWa2jB0
         SBLMzIJ8/zjIin6jtsWNEhok7V0PYcHvDhFmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=O3Cul3mSd4+G/ktVZiMosNjfwO7C986tqXSwvrAXdeo=;
        b=m6PE7NKDTh4hYyyF3twkw39t8szsB9o7QMn2U0bh5W5bgkqbzh+GjUdHO8c8FuDf47
         CdnbxgWCJ5ohibbwHx0j3dbCuekbaYBdupvVR3uRNs66/XSbAVA0qNz4pUkttCGfo6EB
         Ex91mIUcMW+pUzjuGR04M8ab1r+zXWGaLFSxg3rjqlka/D4UhkWSUsmFDBPo61ueHruY
         WvzZg33X5ZaqI571Z33zYfNr7i3ciqLGE0z9YfZ1kvp0iL/awRVB4nLchPkE/LyMfU+I
         7Zjxu3YwWq4/eJk4ODh3l+LDaYMCvwwN1HoVsuhnSWXKcBeDUJzWRYA31wfMHJhh4JEm
         +CFg==
X-Gm-Message-State: AGRZ1gK+UPNFK8seTuAQtXXm/tsXAHVBq3GGUXwkZVWOMYlSoum+D+jR
        wyPy32yN/Rxr64JTpShxODcGfw==
X-Google-Smtp-Source: AJdET5dlUz1k1ONQeU7cad/XWivWrQcW3g7bcJAoMireXF1mwf8pxLyj9rTWpZU2SpxohjZXEPSrZA==
X-Received: by 2002:a50:8bf6:: with SMTP id n51-v6mr9209758edn.41.1540371472912;
        Wed, 24 Oct 2018 01:57:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 31-v6sm1414744edr.12.2018.10.24.01.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 01:57:52 -0700 (PDT)
Date:   Wed, 24 Oct 2018 10:57:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Juston Li <juston.li@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        mario.limonciello@dell.com, linux-kernel@vger.kernel.org,
        nathan.d.ciobanu@intel.com, jared_dominguez@dell.com
Subject: Re: [Intel-gfx] [RESEND PATCH v2 0/2] Check MST topology change on
 resume
Message-ID: <20181024085750.GK324@phenom.ffwll.local>
Mail-Followup-To: Juston Li <juston.li@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        mario.limonciello@dell.com, linux-kernel@vger.kernel.org,
        nathan.d.ciobanu@intel.com, jared_dominguez@dell.com
References: <20181024021925.27026-1-juston.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024021925.27026-1-juston.li@intel.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 07:19:23PM -0700, Juston Li wrote:
> Updated and resending these patches from Lyude:
> https://lkml.org/lkml/2016/5/19/361
> https://lkml.org/lkml/2016/5/19/360
> 
> As Lyude explains in patch 1/2, we can't rely on MST hubs to handle
> hotplugs during suspend. This patchset will check if any EDID's changed
> upon resume and reset the MST connections if they did.
> 
> This resolves issues with monitors not being detected when hotplugging them
> during suspend.
> 
> Signed-off-by: Juston Li <juston.li@intel.com>

For formality, does this also imply a reviewed-by tag?

For merging propably best we wait for the backmerge and the push these in
through drm-misc-next-fixes.

Well for drm-misc-next-fixes drm-misc maintainers need to roll the tree
forward. Either way needs synchronization. Plus an ack from drm-intel
maintainers.
-Daniel

> 
> Changes since v1:
>  - update functions that have been renamed since the original patch
>  - add a null check for the cached EDID in case a new device was added
>  - checkpatch fixes
> 
> Lyude (2):
>   drm/dp/mst: Reprobe EDID for MST ports on resume
>   drm/i915/mst: Reset MST after resume when necessary
> 
>  drivers/gpu/drm/drm_dp_mst_topology.c | 94 ++++++++++++++++++++++++++-
>  drivers/gpu/drm/i915/intel_dp.c       |  7 +-
>  2 files changed, 99 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.2
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E51C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686AD20844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfBAJUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:20:46 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:50125 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfBAJUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:20:45 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 433A280380;
        Fri,  1 Feb 2019 10:20:40 +0100 (CET)
Date:   Fri, 1 Feb 2019 10:20:37 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
Message-ID: <20190201092037.GA9251@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
 <20190131200723.GZ114153@art_vandelay>
 <20190131210312.GA8947@ravnborg.org>
 <20190131215417.GA13156@mithrandir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131215417.GA13156@mithrandir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=TdsCcFLkx59YcYyte_0A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry.

> 
> I personally like the DRM_DEV_* variants better because of the
> additional information that they provide. That can be useful when
> grepping logs etc.
> 
> I'm slightly on the fence about this patch. The unwritten, and
> admittedly fuzzy, rules that I've been using so far are that dev_*() are
> used or messages that have to do with the panel device itself, whereas
> DRM_* variants are used for things that are actually related to DRM. So
> typically this would mean that roughly everything in ->probe() or
> ->remove() would be dev_*(), while the rest would be DRM_DEV_*().

For a rookie like me it is much simpler if one can use the same
logging primitives all over or at least the rules when to use what is simple.
It is simple to say that everything that exists below drivers/gpu/drm/
relates to drm.

Suggested set of rules to follow:
- If in drm core, use DRM_XXX where XXX represent the core functionality
- If in a driver use DRM_DEV* if a struct device is available
- If in a driver and no struct device, use plain DRM_ERROR/INFO

If there is a need to distingush before/after one has a drm_device,
the best way would be to have a set of logging primitives that
take a drm_device. So we could extend the rule set:
- If in a driver use DRM_DRM* if a struct drm_device is available
  (This rule would take precedence over a struct device)

DRM_DRM*, or DRM_DDEV* or ... But you get the idea.

But this is not where we are today.

Shall I redo the patch-set so we go back to dev_*() in probe() / remove()?

	Sam

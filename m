Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB2FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA3F208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA3F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbeLFOkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbeLFOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:39:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EF353082143;
        Thu,  6 Dec 2018 14:39:54 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF836F428;
        Thu,  6 Dec 2018 14:39:54 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5049B181B9E4;
        Thu,  6 Dec 2018 14:39:54 +0000 (UTC)
Date:   Thu, 6 Dec 2018 09:39:54 -0500 (EST)
From:   Frediano Ziglio <fziglio@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Message-ID: <885772449.48610143.1544107194097.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181206113416.yydgi7ro47vwgf2d@sirius.home.kraxel.org>
References: <20181206104638.23330-1-kraxel@redhat.com> <20181206104638.23330-2-kraxel@redhat.com> <1897496108.48579647.1544093758850.JavaMail.zimbra@redhat.com> <20181206113416.yydgi7ro47vwgf2d@sirius.home.kraxel.org>
Subject: Re: [Spice-devel] [PATCH 1/3] drm/qxl: allow both PRIV and VRAM
 placement for QXL_GEM_DOMAIN_SURFACE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.33.32.16, 10.4.195.20]
Thread-Topic: drm/qxl: allow both PRIV and VRAM placement for QXL_GEM_DOMAIN_SURFACE
Thread-Index: 70b9Vryx2gOTCErvYrqGLMk6Cy/pvg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 06 Dec 2018 14:39:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, Dec 06, 2018 at 05:55:58AM -0500, Frediano Ziglio wrote:
> > 
> > > qxl surfaces (used for framebuffers and gem objects) can live in both
> > > VRAM and PRIV ttm domains.  Update placement setup to include both.  Put
> > > PRIV first in the list so it is preferred, so VRAM will have more room
> > > for objects which must be allocated there.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > I remember these kind of changes in the past made migration
> > fails. I proposed similar patches years ago and they were rejected
> > for these reasons.
> 
> Pointer?
> 

I think is this:
https://patchwork.kernel.org/patch/7374931/

I think all started with Windows where we have:
https://gitlab.freedesktop.org/spice/win32/qxl-wddm-dod/commit/0214d5ceda3f0da94de3813fc902150d497c6b26
https://gitlab.freedesktop.org/spice/win32/qxl-wddm-dod/commit/54a719e14f1204143da2c64f8a2aaee4fe5cd7d6

> > Why now they are safe?
> 
> Well, you have to be careful what object you are allocating.  Surfaces
> can be in both PRIV and VRAM.  Everything else (qxl commands, monitors
> config, ...) must be in VRAM.
> 
> > Looks like we are improving QXL, so that means we are actively working
> > on it.
> 
> Well, I'm just trying make qxl behave better with wayland.
> 

As far as I remember the Linux kernel driver simulates the frame buffer
swap with drawings which cause more memory copies.
Not also sure if this workaround make the server consume more network
bandwidth.
Are we supporting multiple monitors for Wayland?

> > Should we not then thinking about moving feature in the proper
> > places (like spice-server for atomic mode setting instead of implementin
> > work around) ??
> 
> Main advantage is that it doesn't need qxl device changes, so it works
> on old hosts too.  But, yes, we can consider to also modernize spice
> protocol and qxl device.
> 
> cheers,
>   Gerd
> 
> 

On the other hand we faced some bugs due these workarounds so we end up
with a solution that is less optimal than before and potentially
with more bugs to fix.
At the end we sell to customer a worst product.

Frediano

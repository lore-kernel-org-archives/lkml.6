Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5EEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBEF214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBEF214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbeLFLeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:34:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbeLFLeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:34:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF1BE8A15;
        Thu,  6 Dec 2018 11:34:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E8775E1B0;
        Thu,  6 Dec 2018 11:34:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 83D2E99BD; Thu,  6 Dec 2018 12:34:16 +0100 (CET)
Date:   Thu, 6 Dec 2018 12:34:16 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Frediano Ziglio <fziglio@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [Spice-devel] [PATCH 1/3] drm/qxl: allow both PRIV and VRAM
 placement for QXL_GEM_DOMAIN_SURFACE
Message-ID: <20181206113416.yydgi7ro47vwgf2d@sirius.home.kraxel.org>
References: <20181206104638.23330-1-kraxel@redhat.com>
 <20181206104638.23330-2-kraxel@redhat.com>
 <1897496108.48579647.1544093758850.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1897496108.48579647.1544093758850.JavaMail.zimbra@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 06 Dec 2018 11:34:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:55:58AM -0500, Frediano Ziglio wrote:
> 
> > qxl surfaces (used for framebuffers and gem objects) can live in both
> > VRAM and PRIV ttm domains.  Update placement setup to include both.  Put
> > PRIV first in the list so it is preferred, so VRAM will have more room
> > for objects which must be allocated there.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> I remember these kind of changes in the past made migration
> fails. I proposed similar patches years ago and they were rejected
> for these reasons.

Pointer?

> Why now they are safe?

Well, you have to be careful what object you are allocating.  Surfaces
can be in both PRIV and VRAM.  Everything else (qxl commands, monitors
config, ...) must be in VRAM.

> Looks like we are improving QXL, so that means we are actively working
> on it.

Well, I'm just trying make qxl behave better with wayland.

> Should we not then thinking about moving feature in the proper
> places (like spice-server for atomic mode setting instead of implementin
> work around) ??

Main advantage is that it doesn't need qxl device changes, so it works
on old hosts too.  But, yes, we can consider to also modernize spice
protocol and qxl device.

cheers,
  Gerd


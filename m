Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36578C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12ACF2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBTOay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:30:54 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:52875 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBTOay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:30:54 -0500
X-Originating-IP: 90.88.23.190
Received: from aptenodytes (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 75696240006;
        Wed, 20 Feb 2019 14:30:50 +0000 (UTC)
Message-ID: <b6900053c027ea668ea8a23b0dd553fb790f6b7b.camel@bootlin.com>
Subject: Re: [PATCH v4 3/4] drm/vc4: Detect and ignore underruns caused by
 out-of-sync dlists
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>
Date:   Wed, 20 Feb 2019 15:30:49 +0100
In-Reply-To: <875ztwlblt.fsf@anholt.net>
References: <20190206144906.24304-1-paul.kocialkowski@bootlin.com>
         <20190206144906.24304-4-paul.kocialkowski@bootlin.com>
         <875ztwlblt.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-02-06 at 15:51 -0800, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > When the pipeline is reconfigured with a different mode, changes take
> > effect immediately for the CRTC and encoder while the HVS takes some
> > time to switch the active display list. This results in a period of
> > time where the pipeline is out of sync, that is very likely to cause
> > an underrun to be reported. Because the underrun is not related to the
> > new configuration, reporting it to userspace is a false positive.
> 
> This seems like a serious issue.  How are we enabling a CRTC with the
> corresponding HVS still scanning out old contents?  Did we need to wait
> for HVS to finish its old frame when we turned off the CRTC, so it's
> ready to receive the START when it's been set up with the new dlist and
> the CRTC is turned back on?  Or maybe do some sort of reset of that
> dlist when a crtc is being enabled?

Yes this has definitely been quite a burden. I have already tried
waiting for the end of frame before disabling the crtc, as well as
playing with various other bits and FIFO reset (see the "HDMI mode
reconfiguration issue mitigation" thread). Alas, nothing helped and I
moved on to implementing a workaround after you said not to block on
this particular point.

> If we can't sort that out, it feels to me like we should be enabling the
> interrupts from the flip_done path (when we know that the HVS is
> scanning out the new frame) instead of trying to mitigate enabling them
> too early.

Thanks for the hint! I looked into this solution and it seems viable,
although I found out that interrupt masking is not always honored by
the hardware. With some extra care, it seems to be working reliably.

I'll send a new iteration implementing the workaround this way.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


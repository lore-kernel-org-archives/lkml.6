Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B3F218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548940930;
	bh=lFyWlFY3OTw7YfcaS/SfOtQGEx6mDWcLEh4xCRpKnZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VjXu69xK7vWv0XE2+9xT76e8n5Q/vL+xdp0dBiIG0ljlAns1fQdc/jiUaxLcenReT
	 DjaRwRY0qkaJDO9neF2upF5tGPbu+T6RNPvIBHQXphxi90+ciEeyp3gUFGZfCAw8d4
	 quwpj9bySf4QmHJaCbD6kN0mANGMe6MTWxC2qvpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbfAaNWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732647AbfAaNWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:22:07 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E61C218D3;
        Thu, 31 Jan 2019 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548940926;
        bh=lFyWlFY3OTw7YfcaS/SfOtQGEx6mDWcLEh4xCRpKnZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sOveH2jxkiRTBgu/9fR9BcYqjlUKuUrgWFO/CsbYKTkRvtZ5MqnEZtojSfjWiqXex
         zMC5qJhZtvlyd5TACGbr8BP65Z4B72MLyBvo58mi8LWxfHpXz1N88rrhWfzTv4pZEV
         M4+9bx10afpjJ0yq6WnTrmeuVxvoqCuM/lY3tBpg=
Date:   Thu, 31 Jan 2019 14:21:55 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Message-ID: <20190131142155.574d1337@bbrezillon>
In-Reply-To: <d2e24b73-dee1-b31a-dc87-02d2e75b6dd2@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
        <20190127092709.3863c954@bbrezillon>
        <d2e24b73-dee1-b31a-dc87-02d2e75b6dd2@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 13:13:22 +0000
Peter Rosin <peda@axentia.se> wrote:

> On 2019-01-27 09:27, Boris Brezillon wrote:
> > On Thu, 10 Jan 2019 15:10:28 +0000
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> Hi!
> >>
> >> I found an unfortunate issue while recoding plane handling to use
> >> drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
> >> which is not correct. I simply fixed it (patch 1/4), but maybe that
> >> will cause regressions for unsuspecting users who simply assumed
> >> that the clockwise rotation was correct? I don't know what to do
> >> about that? Adding an option to get the old broken behavior seems
> >> useless, wouldn't it be just as easy to just fix whatever app to
> >> rotate the other way instead of adding an option somewhere?
> >>
> >> I have only tested this series on sama5d3, but I did check the docs
> >> for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
> >> and sam9x35) supported by the driver (relevant to patch 4/4).
> >>
> >> Cheers,
> >> Peter
> >>
> >> Peter Rosin (4):
> >>   drm/atmel-hlcdc: rotate planes counterclockwise
> >>   drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
> >>   drm/atmel-hlcdc: fix clipping of planes  
> > 
> > Queued patches 1-3 to drm-misc-next.  
> 
> Great, thanks.
> 
> >>   drm/atmel-hlcdc: do not immediately disable planes, wait for next
> >>     frame  
> > 
> > Still waiting for Nicolas feedback on this one.  
> 
> [Adding back Nicolas, he seems to have gone missing from the list
> recipients.]
> 
> I have done some testing of that patch and for me it's a definite
> improvement. The test I did was removing a white plane from a white
> background. Without the patch, the driver will output black where
> the plane was for the current frame (since the driver does that
> disc-area thing for the largest hidden part of the background).
> With the patch, I get no visual glitches when removing a plane.
> 
> I use a plane to scroll a text, and if you know what to look for,
> the black rectangle that flickers by as the plane with the scrolling
> text is removed is little bit disturbing. Not a significant problem,
> and maybe only geeks notice it, but still...
> 
> Just wanted to say that the resulting "black hole" mentioned in the
> other thread really does exist and that the patch may make sense
> beyond the fact that it removes usage of undocumented features.
> 
> I have not seen any bad side effects fro the patch, but admittedly
> my testing was very limited and I did not try to remove the plane
> while doing other stuff with the driver. So, there might still be
> reasons for removing planes immediately...

Since everything is now synchronized on vsync events thanks to the
atomic modeset infra (including plane/crtc disable requests), I think
the problem I was trying to fix at the time no longer exists (might
re-appear if we start supporting async plane disable requests which is
anyway not supported by the core). So I think I'll just apply your
patch.

Thanks,

Boris

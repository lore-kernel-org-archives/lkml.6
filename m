Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BD1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B6D208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547142313;
	bh=KNQUK2yuRv+Ya/H3gziEtNCNwmfQ58I0jmwXolJkOhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aFz6u319CazWOB9p5HOPhc0s6owu8xMgg97blHPN/IlTy7YTYbYq4oXhVWqgW4M14
	 vGCyBB4WONVO36EdPq9iDzKLet/ggXsO5qOMK8GoU068vN61ASph9stK1XUL51gn8+
	 XFmqukH4W5B7O/XystUqqs29yEGAy7XxoAk/WfCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfAJRpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730024AbfAJRpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:45:11 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0EA020685;
        Thu, 10 Jan 2019 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547142311;
        bh=KNQUK2yuRv+Ya/H3gziEtNCNwmfQ58I0jmwXolJkOhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XBE7ACjkRRimbpr32uswmIQ/aYHa6CFWZf/CHZQGn8Ash+fl1aAA6eUgdSIY6kmSi
         R7yAoEhHkGQ5niFe4zE69kBO5a+HKSpdhPXKlhzNCW2zX2tiGU9CUb+UA3OgD0MS7+
         ZHcxJXYWSgldXY+hj4A9sYupUMEsFB1PdHIbDxqU=
Date:   Thu, 10 Jan 2019 18:45:01 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Message-ID: <20190110184446.75b4350a@bbrezillon>
In-Reply-To: <20190110151020.30468-1-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 15:10:28 +0000
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> I found an unfortunate issue while recoding plane handling to use
> drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
> which is not correct. I simply fixed it (patch 1/4), but maybe that
> will cause regressions for unsuspecting users who simply assumed
> that the clockwise rotation was correct? I don't know what to do
> about that? Adding an option to get the old broken behavior seems
> useless, wouldn't it be just as easy to just fix whatever app to
> rotate the other way instead of adding an option somewhere?

Hm, rotation support has been added before the standard rotation
property was created, and at that time I assumed rotation was clockwise
(which apparently was an unwise choice). Anyway, I don't have a
solution for this problem, so I'll let Nicolas decide if it's
acceptable to change the rotation behavior.

> 
> I have only tested this series on sama5d3, but I did check the docs
> for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
> and sam9x35) supported by the driver (relevant to patch 4/4).

Thanks for addressing those problems.

> 
> Cheers,
> Peter
> 
> Peter Rosin (4):
>   drm/atmel-hlcdc: rotate planes counterclockwise
>   drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
>   drm/atmel-hlcdc: fix clipping of planes
>   drm/atmel-hlcdc: do not immediately disable planes, wait for next
>     frame
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 179 +++++++++---------------
>  1 file changed, 67 insertions(+), 112 deletions(-)
> 


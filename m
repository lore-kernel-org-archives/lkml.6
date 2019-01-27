Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94283C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621FD214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548577680;
	bh=oex/PD4/53qKXoUYp+S5TDZhscZw9hWPV0A+oNZN8n0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fIAZ0GFGaFChnaJBWxRnbpAz/w4KZpWVY1y0Jz8lFLEKMZfv2RdBI2DzWAOH0tzfz
	 novZNOz/I+0xnk6nKhKlz4nFSkG68ncxsGr3UDvRLMGfhenfdrg/NPWhxdzuYVinQL
	 /BRz+fMnr00opQjgYGYVXozJgtn94ZTkmOdsNNTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfA0I1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 03:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfA0I1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 03:27:34 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90241214C6;
        Sun, 27 Jan 2019 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548577654;
        bh=oex/PD4/53qKXoUYp+S5TDZhscZw9hWPV0A+oNZN8n0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YBd8pBbjN3nRwBEx96mw5JFp7sIsyKyToHp4eqBHI1CwW9lsge8QwDwO9FQK3pgNZ
         fzXMxeUC//yw0P1jSGv/UlV+g9LRR/44fe4WBEnrfYLv6ubZzo+YB4NpSQK/GCm/AE
         ipFnhOrZsSzX8vz+jksCeZHipXbHlTP80BEQcyA4=
Date:   Sun, 27 Jan 2019 09:27:24 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Message-ID: <20190127092709.3863c954@bbrezillon>
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
> 
> I have only tested this series on sama5d3, but I did check the docs
> for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
> and sam9x35) supported by the driver (relevant to patch 4/4).
> 
> Cheers,
> Peter
> 
> Peter Rosin (4):
>   drm/atmel-hlcdc: rotate planes counterclockwise
>   drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
>   drm/atmel-hlcdc: fix clipping of planes

Queued patches 1-3 to drm-misc-next.

>   drm/atmel-hlcdc: do not immediately disable planes, wait for next
>     frame

Still waiting for Nicolas feedback on this one.


Thanks,

Boris

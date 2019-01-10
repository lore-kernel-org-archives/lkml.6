Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4DAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2522B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfAJUQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:16:44 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:41857 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbfAJUQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:16:43 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4BC9780538;
        Thu, 10 Jan 2019 21:16:38 +0100 (CET)
Date:   Thu, 10 Jan 2019 21:16:36 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Peter Rosin <peda@axentia.se>
Cc:     Peter Rosin <peda@axentia.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Message-ID: <20190110201636.GA7074@ravnborg.org>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110184446.75b4350a@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110184446.75b4350a@bbrezillon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=cw4OArruGTS2hah8c1kA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

(Hijacking this thread as I lost the orginal mails)

> > 
> > I found an unfortunate issue while recoding plane handling to use
> > drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
> > which is not correct. I simply fixed it (patch 1/4), but maybe that
> > will cause regressions for unsuspecting users who simply assumed
> > that the clockwise rotation was correct? I don't know what to do
> > about that? Adding an option to get the old broken behavior seems
> > useless, wouldn't it be just as easy to just fix whatever app to
> > rotate the other way instead of adding an option somewhere?
> 
> Hm, rotation support has been added before the standard rotation
> property was created, and at that time I assumed rotation was clockwise
> (which apparently was an unwise choice). Anyway, I don't have a
> solution for this problem, so I'll let Nicolas decide if it's
> acceptable to change the rotation behavior.
> 
> > 
> > I have only tested this series on sama5d3, but I did check the docs
> > for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
> > and sam9x35) supported by the driver (relevant to patch 4/4).

I wonder if, when this code path is anyway touched, could benefit
from drm_rect_rotate().

It is obviously not a simple replacement, but could it be used then
I hope the resulting code is simpler.

	Sam

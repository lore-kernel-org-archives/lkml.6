Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D557C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E26321783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547033856;
	bh=FF2vd1Obk2LeuFU+5+bxuooqtBDJR4hsSNBOpm7rfoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=krsqr5+Wwb+JrO5Gx0bhtL3SJOsyQW2sc//uzUvdi3l9E51HBB3TsyGqTyI7rl4u8
	 zUeDAirWRpww7EzlBlhgSsep3JHiZsdKRfVKh/RTtqyqoqG3HrKs4P+R03VkQZtNCV
	 FEUkmI57EX09z88oLl4f80jtlvxg04casRjY9LIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfAILhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730873AbfAILhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:37:35 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C9120652;
        Wed,  9 Jan 2019 11:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547033854;
        bh=FF2vd1Obk2LeuFU+5+bxuooqtBDJR4hsSNBOpm7rfoY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KVjKborKe/gIozUUHRef5iPMjxgX58tnVh3S0ysqkrsVZ75juHeFYuG8fYsWFK/uI
         7EjqXaXHAgoyiqwJq9JoTDxbE3UfmAGxS6BchIPSxOwMC9zbJ3lbCqRbzs10t6mTp6
         bgChlnIcn9CYqDsWvHpsWs2iBOtrlZG8i0UqPj1A=
Date:   Wed, 9 Jan 2019 12:37:24 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Peter Rosin <peda@axentia.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Message-ID: <20190109123449.65742b99@bbrezillon>
In-Reply-To: <20190109101224.GT21184@phenom.ffwll.local>
References: <20190108123129.20031-1-peda@axentia.se>
        <20190109101224.GT21184@phenom.ffwll.local>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 11:12:24 +0100
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Tue, Jan 08, 2019 at 12:31:36PM +0000, Peter Rosin wrote:
> > While trying to temporarily hide a plane, one thing that was attempted
> > was to call (from libdrm)
> > 
> > 	drmModeSetPlane(fd, plane_id, crtc_id, fb_id, 0,
> > 			0, 0, 0, 0, 0, 0, 0, 0);
> > 
> > This call causes a pair of "Division by zero in kernel." messages. Kill
> > those messages, but preserve the current behaviour that also happen to
> > make the plane disappear with the above call.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > Side note, when comparing with drm_atomic_helper_check_plane_state(), I get
> > the feeling that the src rect should be clipped together with the crtc rect
> > if/when clipping is needed. That function calls drm_rect_clip_scaled(), and
> > the equivalent does not seem to happen here. Should clipping be performed
> > on the src rect?  
> 
> Any reasons atmel can't switch over to that helper? Would compute a nice
> ->visible state variable for you ...  

We should definitely use drm_atomic_helper_check_plane_state().

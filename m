Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA80C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C37B206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547035221;
	bh=TwI3gTLhbBNd1cYXCGa3vZ8P336E2Tv4RllKn2O0a5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vBp3MINairlpqtxiFdJ3PWqpu6rZcSUY7DDLWjfXZtMy7YVK8qr2Alc0dXpNeQjhg
	 2GzsUW2FHTYwnbJRccn+gX0t471JbFUBufVy+C7q95wVz643D+qRxQpRDY4KLy5Ju4
	 PqtH/oILqqdOyIW9a6eAajh18s9c1k0VU1Igq8QU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfAIMAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:00:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfAIMAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:00:20 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259CE206B6;
        Wed,  9 Jan 2019 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547035219;
        bh=TwI3gTLhbBNd1cYXCGa3vZ8P336E2Tv4RllKn2O0a5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h2gWqV+Ilp+6yZbP7H4pV+YOZWQNGM0OaA5DRrcRyOB8ax8QxplhOo5uo9kX+pYQx
         kQ85VIt3cmJNGeXwsji2tNiOsWh6hP30mJdYUcZFW411LwzirW7xXD0D9wa41r1/6D
         +bugV8XiOFX/FbOhH/RvQnP1PxTQxSOv1bGRqaT8=
Date:   Wed, 9 Jan 2019 13:00:08 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Message-ID: <20190109125833.0af5dc52@bbrezillon>
In-Reply-To: <9b73f5fa-e5c2-ea55-8d96-be6de8a1f34a@axentia.se>
References: <20190108123129.20031-1-peda@axentia.se>
        <20190109101224.GT21184@phenom.ffwll.local>
        <9b73f5fa-e5c2-ea55-8d96-be6de8a1f34a@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 11:37:19 +0000
Peter Rosin <peda@axentia.se> wrote:

> On 2019-01-09 11:12, Daniel Vetter wrote:
> > On Tue, Jan 08, 2019 at 12:31:36PM +0000, Peter Rosin wrote:  
> >> While trying to temporarily hide a plane, one thing that was attempted
> >> was to call (from libdrm)
> >>
> >> 	drmModeSetPlane(fd, plane_id, crtc_id, fb_id, 0,
> >> 			0, 0, 0, 0, 0, 0, 0, 0);
> >>
> >> This call causes a pair of "Division by zero in kernel." messages. Kill
> >> those messages, but preserve the current behaviour that also happen to
> >> make the plane disappear with the above call.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 14 ++++++++++----
> >>  1 file changed, 10 insertions(+), 4 deletions(-)
> >>
> >> Side note, when comparing with drm_atomic_helper_check_plane_state(), I get
> >> the feeling that the src rect should be clipped together with the crtc rect
> >> if/when clipping is needed. That function calls drm_rect_clip_scaled(), and
> >> the equivalent does not seem to happen here. Should clipping be performed
> >> on the src rect?  
> > 
> > Any reasons atmel can't switch over to that helper? Would compute a nice  
> > ->visible state variable for you ...  
> > -Daniel  
> 
> I have not researched that, and as stated above, I was not sure if that was the
> correct approach to begin with. Boris, any insights?

You can look at vc4_plane.c if you want an example of how this helper
can be used to get clipped dimensions of the plane.

> Does this code predate the
> helper or something?

Yes, and I must admit I'm not actively maintaining the driver, so there
are probably a few other things we could simplify by using generic
helpers.

> 
> Maybe there's some register bit that hides a plane explicitly, matching the
> ->visible state variable? I haven't looked at that either...

I don't think so, but you can simply disable the plane when ->visible
is false.

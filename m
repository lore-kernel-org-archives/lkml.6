Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79802C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D96521A0D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="i8wA79DB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D96521A0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeHHOuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:50:20 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47256 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:50:19 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 38FDA5C0076;
        Wed,  8 Aug 2018 14:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533731448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oe1/ra72lVF/uKvSoP7wPC5FYEjDHD4dgV/hHYcEUD0=;
        b=i8wA79DBII6MqnlY0n6/Afwz34h1qAxTdG+giUV4m/mBdp69ygTihT5cx8/PFcWhorYKtP
        ADro41lP+p+/ygOKSME0rB3AwAPIl19l1Li/RFqOrLBrqgpiaGW4C0TJ9ch7baOah2lF6Z
        8KphhXx+X4e44m+X9EJTZPnOfnlq8Qs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Aug 2018 14:30:48 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "A.s. Dong" <aisheng.dong@nxp.com>, marex@denx.de,
        linux-kernel@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Marius-cristian Vlad <marius-cristian.vlad@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, shawnguo@kernel.org,
        Anson Huang <anson.huang@nxp.com>, kernel@pengutronix.de,
        Mirela Rabulea <mirela.rabulea@nxp.com>
Subject: Re: [PATCH v3 4/4] drm/mxsfb: Switch to
 drm_atomic_helper_commit_tail_rpm
In-Reply-To: <174c00104b40ebe1f6495e679e115948bb561889.camel@nxp.com>
References: <cover.1533583611.git.leonard.crestez@nxp.com>
 <cd938df7516aee05289dc2d7dc17bc85b219be53.1533583611.git.leonard.crestez@nxp.com>
 <da414ab37c3d7c02f059fd3c0470dac9@agner.ch>
 <174c00104b40ebe1f6495e679e115948bb561889.camel@nxp.com>
Message-ID: <7a2ca85d38f0edc4033a426cca31b04b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2018 10:00, Leonard Crestez wrote:
> On Tue, 2018-08-07 at 21:01 +0200, Stefan Agner wrote:
>> On 06.08.2018 21:31, Leonard Crestez wrote:
>> > The lcdif block is only powered on when display is active so plane
>> > updates when not enabled are not valid. Writing to an unpowered IP block
>> > is mostly ignored but can trigger bus errors on some chips.
>> >
>> > Prevent this situation by switching to drm_atomic_helper_commit_tail_rpm
>> > and having the drm core ensure atomic_plane_update is only called while
>> > the crtc is active. This avoids having to keep track of "enabled" bits
>> > inside the mxsfb driver.
>> >
>> > This also requires handling the vblank event for disable from
>> > ~~mxsfb_pipe_update~~ **mxsfb_pipe_disable**.
>>
>> Hm, I don't think this is a new requirement. Simple KMS Helper Reference
>> clearly states that it should be called from update.
>>
>> Probably using drm_atomic_helper_commit_tail_rpm just exacerbates an
>> issue which we haven't seen before...
>>
>> Since I think it is a general fix, I'd rather prefer have it in a
>> separate commit.
> 
> I wrote the commit message wrong, what I meant is that it requires
> handling the vblank event from *disable*.
> 
> Switching to atomic_helper_commit_tail_rpm means atomic_update is no
> longer called when !state->active so nobody dispatches the last vblank
> event for disabling the crtc. This causes a warning in
> drm_atomic_helper_commit_hw_done on disable.

Hm, I see, atomic_helper_commit_tail_rpm() uses
DRM_PLANE_COMMIT_ACTIVE_ONLY, which leads to update() not being called
for Simple KMS (since simple KMS uses the plane atomic_update() hook).

I was looking in other drivers such as
drivers/gpu/drm/pl111/pl111_display.c and was wondering why they do not
need that in disable. But it makes sense since they do not use
atomic_helper_commit_tail_rpm(), update does get called. Also note that
pl111_display_update() uses drm_crtc_send_vblank_event() too if the crtc
gets disabled:

		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0)
			drm_crtc_arm_vblank_event(crtc, event);
		else
			drm_crtc_send_vblank_event(crtc, event);


The other users of atomic_helper_commit_tail_rpm(), exynos and sun4i,
call drm_crtc_send_vblank_event() in the CRTC atomic_disable() hook. The
Simple KMS equivalent of that is the disable hook.

So it is really the change to _rpm() which requires to add
drm_crtc_send_vblank_event() in disable. Having this two changes in a
single commit indeed makes sense and is correct, sorry about the noise!
Just fix the commit, and than I am fine with this.

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> Looking through the docs there seems to be a lot of complexity behind
> vblank events so maybe I'm missing something.

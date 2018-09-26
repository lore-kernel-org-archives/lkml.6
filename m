Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152EBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76F821508
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="NZpwmrIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76F821508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeI0C1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:27:21 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55244 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeI0C1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:27:21 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D47575C1879;
        Wed, 26 Sep 2018 22:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537992761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKA9BJ0wydDjo0ZDrgg5j5fUIqXyAw12tnezPK1Zu6M=;
        b=NZpwmrIxhsVxSVRe8NdkpRhNnVzHeGRo+050OJHT4AZp7ejvuxIIK2pwTjBGOhR5wD7633
        zIYM8jdx9EOTKzQ2v8LdMapsEJqXArmkci5EVfuV4cfTHyVHWFKYxeaFa+TZt/WVQ4Tnzt
        ejqU/0GaCZAVl0jCY1rdDZnKnXdG3KE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Sep 2018 22:12:41 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Sean Paul <seanpaul@chromium.org>, leonard.crestez@nxp.com
Cc:     Gustavo Padovan <gustavo@padovan.org>, Marek Vasut <marex@denx.de>,
        sean@poorly.run,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-imx@nxp.com, Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, robert.chiras@nxp.com,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Shawn Guo <shawnguo@kernel.org>, anson.huang@nxp.com,
        Dave Airlie <airlied@linux.ie>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
In-Reply-To: <CAEqLBRkRRutC7PXSxxx9yo7kURRH6q+vRYFzoE13QLh59gnvbA@mail.gmail.com>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
 <20180917191602.GP188300@art_vandelay>
 <80da134658da77f0d3f8fda6894ab756@agner.ch>
 <74b9b382ea6f9ec47573955d5b64a597b950cb5b.camel@nxp.com>
 <CAEqLBRkRRutC7PXSxxx9yo7kURRH6q+vRYFzoE13QLh59gnvbA@mail.gmail.com>
Message-ID: <5dc72217d8fd99c4d87c76a32c8776d9@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.2018 18:39, Sean Paul wrote:
> On Thu, Sep 20, 2018 at 11:59 AM Leonard Crestez
> <leonard.crestez@nxp.com> wrote:
>>
>> On Mon, 2018-09-17 at 16:37 -0700, Stefan Agner wrote:
>> > On 17.09.2018 12:16, Sean Paul wrote:
>> > > On Mon, Sep 17, 2018 at 04:42:10PM +0300, Leonard Crestez wrote:
>> > > > Adding lcdif nodes to a power domain currently doesn't work, it results
>> > > > in black/corrupted screens or hangs. While the driver does enable
>> > > > runtime pm it does not deal correctly with the block being unpowered.
>> > > >
>> > > > All patches in this series have review tags from a while ago and I
>> > > > tested them again on top of next-20180913. No changes
>> > > >
>> > > > This series stalled so I reached out to Marek on IRC and he was
>> > > > surprised to be listed as maintainer
>> > >
>> > > Hopefully not too surprised since Marek added themself to MAINTAINERS when
>> > > adding the driver :-)
>> >
>> > There have been some confusion about the DRM development processes
>> > around the mxsfb already in the past.
>> >
>> > > I suppose we should probably move this to drm-misc since it qualifies as a
>> > > "small driver" and needs a home. Looking through git history shows the last
>> > > mxsfb-specific change was back in 02/17. Everything else has been drm-wide
>> > > refactors. Thoughts?
>> > >
>> > > Marek/Leonard: Care to sign up to be listed as a reviewers?
>> >
>> > drm-misc seems to make sense. I volunteer to be listed as reviewer or co-maintainer.
>>
>> This gets +1 from me, you were very helpful during review.
>>
>> Next would be for one of the drm-misc maintainers to post a change for
>> the MAINTAINER file and also merge my series?
>>
> 
> I've posted the MAINTAINERS patch here:
> https://lists.freedesktop.org/archives/dri-devel/2018-September/190414.html
> 
> Once I get some Acks, we can merge that and one of Stefan or Marek can apply the
> patchset to drm-misc.

Applied, fixed a white space issue in patch 4 and pushed to drm-misc.

Thanks Sean for helping out here!

And thanks Leonard for working on this and push for its inclusion!

--
Stefan

> 
> Sean
> 
>> --
>> Regards,
>> Leonard

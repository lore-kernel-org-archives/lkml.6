Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED88ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB9C2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ca6Mb8ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB9C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeJYDGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:06:37 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40579 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeJYDGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:06:37 -0400
Received: by mail-ua1-f65.google.com with SMTP id f23so584379uam.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9I/3IGhgfdOQ5peHAv4Bnjrh4dMjCbkUmnUHgevtps=;
        b=Ca6Mb8ht5d7uB2MVxwW2rceZssuwAVzQkPVeX4626+BLD8ba+OyOrD7a2R3ZHDPGSt
         +iTAG95EvgLV6N5B4HAf/IlFOoKbYZ45+F1Hy/3JAnU2K+Wl80PxP4vRhPzmyf4x1OC9
         1vlKZzCi98HHl94iT472cdlSCSRCzUfCnPpP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9I/3IGhgfdOQ5peHAv4Bnjrh4dMjCbkUmnUHgevtps=;
        b=BCJRjUoMSc/V4C/XyV/XaHNJbb/wbxjEc7Eco5kEfASM1DgE3MrkkUtv/rSxzTdYPb
         9Re7TbtncYix8Rjkla/rk54xZSxgAdC0+HRsIQlh50eW60GYpcaqlkiRQ7ZNcNXWbhNU
         zm6d0RUxRZUCVYylsjVMzzs5W5ByCSG2m43kXiq10VbET3RSICfPX/FaWUHDAMhL8fjz
         bYQOpg0+otO/mnkXlq6s7fvGs0M7ib+g9uayjChlvjaQJb6VZguibATvjVrDoYiYaj6i
         iehxXvHurnjG69tL0EG6p3RUWqU/qY3KmicQ+XnBXRgcIjUybEi/ISdVwv10avbwbiM/
         FjQg==
X-Gm-Message-State: AGRZ1gKBqQGHgRPVJppDhxeBoYUPaWvch2oztZkdoAVQwpWbvkCAXADP
        YMQnv/XtUynwIDjp7WVnn7LtF7palOg=
X-Google-Smtp-Source: AJdET5eS1mAaaRidJKYaz0g81tFegCAfNuJcomng0xEtLwyORhu6ImAyOffEN/PVCAFxmqOXOVYjcA==
X-Received: by 2002:a9f:25a8:: with SMTP id 37mr1526285uaf.43.1540406247297;
        Wed, 24 Oct 2018 11:37:27 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id j196sm1617131vkf.16.2018.10.24.11.37.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 11:37:26 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id y5so2260520uap.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:37:25 -0700 (PDT)
X-Received: by 2002:ab0:132a:: with SMTP id g39mr1765378uae.83.1540406245516;
 Wed, 24 Oct 2018 11:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181019201940.138179-1-dianders@chromium.org>
 <20181019201940.138179-2-dianders@chromium.org> <9d5b42b94772fb3adb86e20eff72cd88@codeaurora.org>
In-Reply-To: <9d5b42b94772fb3adb86e20eff72cd88@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Oct 2018 11:37:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJYu6uBcbHVOa=fhMbiCzTwpxB6GZY9A2fgEWPinycwA@mail.gmail.com>
Message-ID: <CAD=FV=UJYu6uBcbHVOa=fhMbiCzTwpxB6GZY9A2fgEWPinycwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: Allow DT to set "HPD delay"
To:     Sandeep Panda <spanda@codeaurora.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        ryandcase@chromium.org, Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 24, 2018 at 11:32 AM <spanda@codeaurora.org> wrote:
>
> On 2018-10-20 01:49, Douglas Anderson wrote:
> > Let's solve the mystery of commit bf1178c98930 ("drm/bridge:
> > ti-sn65dsi86: Add mystery delay to enable()").  Specifically the
> > reason we needed that mystery delay is that we weren't paying
> > attention to HPD.
> >
> > Looking at the datasheet for the same panel that was tested for the
> > original commit, I see there's a timing "t3" that times from power on
> > to the aux channel being operational.  This time is specced as 0 - 200
> > ms.  The datasheet says that the aux channel is operational at exactly
> > the same time that HPD is asserted.
> >
> > Scoping the signals on this board showed that HPD was asserted 84 ms
> > after power was asserted.  That very closely matches the magic 70 ms
> > delay that we had.  ...and actually, in my esting the 70 ms wasn't
> > quite enough of a delay and some percentage of the time the display
> > didn't come up until I bumped it to 100 ms.
> >
> > To solve this, we tried to hook up the HPD signal in the bridge.
> > ...but in doing so we found that that the bridge didn't report that
> > HPD was asserted until ~280 ms after we powered it (!).  This is
> > explained by looking at the sn65dsi86 datasheet section "8.4.5.1 HPD
> > (Hot Plug/Unplug Detection)".  Reading there we see that the bridge
> > isn't even intended to report HPD until 100 ms after it's asserted.
> > ...but that would have left us at 184 ms.  The extra 100 ms
> > (presumably) comes from this part in the datasheet:
> >
> >> The HPD state machine operates off an internal ring oscillator. The
> >> ring oscillator frequency will vary [ ... ]. The min/max range in
> >> the HPD State Diagram refers to the possible times based off
> >> variation in the ring oscillator frequency.
> >
> > Given that the 280 ms we'll end up delaying if we hook up HPD is
> > _slower_ than the 200 ms we could just hardcode, for now we'll solve
> > the problem by just allowing boards to hardcode a value.  If someone
> > using this part finds that they can get things to work more quickly by
> > actually hooking up HPD that can always be a future patch.
> >
> > One last note is that I tried to solve this through another way: In
> > ti_sn_bridge_enable() I tried to use various combinations of
> > dp_dpcd_writeb() and dp_dpcd_readb() to detect when the aux channel
> > was up.  In theory that would let me detect _exactly_ when I could
> > continue and do link training.  Unfortunately even if I did an aux
> > transfer w/out waiting I couldn't see any errors.  Possibly I could
> > keep looping over link training until it came back with success, but
> > that seemed a little overly hacky to me.
> >
>
> Thanks for very detailed explanation.

Note: I already replied to myself and left breadcrumbs, but please
assume that ${SUBJECT} patch is abandoned and see my new series that
moves this delay into the panel.

-Doug

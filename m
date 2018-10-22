Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB751C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34EE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bZDvvawW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34EE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeJWFOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:14:48 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35541 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeJWFOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:14:47 -0400
Received: by mail-ua1-f68.google.com with SMTP id m18so10509600uaq.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBe0nUFTKXNl1wdkj6jYjc/TJUFR4EDZLqNOxMXo7Iw=;
        b=bZDvvawWH0rs5rSI2DvQoEY/aA3736xt2YkBi5pVs+3fI+wnrG4VJPDR/LbE1SkXf9
         aC0kGr11iyYyFri2O4tM5zTPvI/8UNcgL95d4KeU8/csBC4YAHK39TxkfzsActgCblxo
         HvCNJCWIOkFFJ8A4zUYjA+uEmbg+4bJBy4S2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBe0nUFTKXNl1wdkj6jYjc/TJUFR4EDZLqNOxMXo7Iw=;
        b=Db63+5DOOr6diRIIbaW8o+sk8Riqx39pgNYCMTDV7MnIgtJFaJ+H81bG6c6dcW7LlJ
         Vtkgyc54OD2RuXEyk/qxChtbxzxyHYBzJsMlYaVGuR1o6javTWlH13yeWjAFwCZk0ugE
         NjKKbGvi2zRQv8S75rPCHMPjN7K1HQhLjpqDQCY3eH2XjLaQnDDlxYLoucgqr9r1Hwoy
         IM0M0vse0d+HNVPocJNreQ2HTjMQqBKokWwytYVPrdbH+7EbiITZZCpMV8T11M6hVhdH
         Iupt22OVxBD2EFg5yPH6JEgXfjbXV9yCgCdw88j2J0/CrFNHjx2RZOrllmMY1Vrav7Fq
         Y0tA==
X-Gm-Message-State: ABuFfog0HEtTbZA2RikiSJWXcBTqAV1raPWpSkGdg5FAUfEe3tdgk7CQ
        gtAK4ECfgJipywQPNuF/tXAWj95krOU=
X-Google-Smtp-Source: ACcGV62MT271TES+KEdEz21Ipb0r7q2dp0xJO/+9H3vfTw73pEsoc7/hne/ZCOV8qt6wVoH9o3ObQw==
X-Received: by 2002:ab0:15c5:: with SMTP id j5mr12873694uae.50.1540241678778;
        Mon, 22 Oct 2018 13:54:38 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id q62sm2508236vkq.7.2018.10.22.13.54.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:54:38 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id j13so10511556ual.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:54:37 -0700 (PDT)
X-Received: by 2002:a9f:3743:: with SMTP id a3mr21246703uae.86.1540241677375;
 Mon, 22 Oct 2018 13:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181019201940.138179-1-dianders@chromium.org> <20181019201940.138179-2-dianders@chromium.org>
In-Reply-To: <20181019201940.138179-2-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Oct 2018 13:54:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U6bbVMF3CcDWfdQDOiEQyi1Tk76p2LXN5TE1EDv5Fk6Q@mail.gmail.com>
Message-ID: <CAD=FV=U6bbVMF3CcDWfdQDOiEQyi1Tk76p2LXN5TE1EDv5Fk6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: Allow DT to set "HPD delay"
To:     Sandeep Panda <spanda@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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

On Fri, Oct 19, 2018 at 1:20 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Let's solve the mystery of commit bf1178c98930 ("drm/bridge:
> ti-sn65dsi86: Add mystery delay to enable()").  Specifically the
> reason we needed that mystery delay is that we weren't paying
> attention to HPD.
>
> Looking at the datasheet for the same panel that was tested for the
> original commit, I see there's a timing "t3" that times from power on
> to the aux channel being operational.  This time is specced as 0 - 200
> ms.  The datasheet says that the aux channel is operational at exactly
> the same time that HPD is asserted.
>
> Scoping the signals on this board showed that HPD was asserted 84 ms
> after power was asserted.  That very closely matches the magic 70 ms
> delay that we had.  ...and actually, in my esting the 70 ms wasn't
> quite enough of a delay and some percentage of the time the display
> didn't come up until I bumped it to 100 ms.
>
> To solve this, we tried to hook up the HPD signal in the bridge.
> ...but in doing so we found that that the bridge didn't report that
> HPD was asserted until ~280 ms after we powered it (!).  This is
> explained by looking at the sn65dsi86 datasheet section "8.4.5.1 HPD
> (Hot Plug/Unplug Detection)".  Reading there we see that the bridge
> isn't even intended to report HPD until 100 ms after it's asserted.
> ...but that would have left us at 184 ms.  The extra 100 ms
> (presumably) comes from this part in the datasheet:
>
> > The HPD state machine operates off an internal ring oscillator. The
> > ring oscillator frequency will vary [ ... ]. The min/max range in
> > the HPD State Diagram refers to the possible times based off
> > variation in the ring oscillator frequency.
>
> Given that the 280 ms we'll end up delaying if we hook up HPD is
> _slower_ than the 200 ms we could just hardcode, for now we'll solve
> the problem by just allowing boards to hardcode a value.  If someone
> using this part finds that they can get things to work more quickly by
> actually hooking up HPD that can always be a future patch.
>
> One last note is that I tried to solve this through another way: In
> ti_sn_bridge_enable() I tried to use various combinations of
> dp_dpcd_writeb() and dp_dpcd_readb() to detect when the aux channel
> was up.  In theory that would let me detect _exactly_ when I could
> continue and do link training.  Unfortunately even if I did an aux
> transfer w/out waiting I couldn't see any errors.  Possibly I could
> keep looping over link training until it came back with success, but
> that seemed a little overly hacky to me.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 45 ++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 8 deletions(-)

Adding breadcrumbs to point to the new version of this patch at
<https://lore.kernel.org/patchwork/patch/1002549/> AKA ("[4/6]
drm/bridge: ti-sn65dsi86: Remove the mystery delay").  I didn't call
that a v2 since it's a pretty different approach compared to this one,
but (assuming people are OK w/ it) it replaces this patch.

Thanks!

-Doug

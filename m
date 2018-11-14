Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4861CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0638822360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HGw/Nm/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0638822360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbeKNSaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:30:30 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39635 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeKNSa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:30:29 -0500
Received: by mail-yw1-f65.google.com with SMTP id v8-v6so6946582ywh.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 00:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l070MOhbOa7GL+rPprhQKVXutgFk5eCd8u4haEIAtCM=;
        b=HGw/Nm/gJ3MQjN2Sed5S+iEn+dg+rZs6khdhTIB78c0BWiU8xA6xs6VAkymPbdB2OQ
         3XHYDQRqnY+VTELECWCKlzw25/9yLItkzu0j34t+n4stDMd0CPttXZHb2xaziYn5KNB+
         Wh0VueQ1b2C7QETPjhecKUJtJjBxkqX1ieI7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l070MOhbOa7GL+rPprhQKVXutgFk5eCd8u4haEIAtCM=;
        b=qdexcgg9C7nEFQ6xo6r26FPpyA2wkkXhLtZPuypjfbEeUbQl/l0CWqzQ0XxDymA49h
         IOQpUcDV7FioLqIlH37WeDnw0sj9NcyFymzm09iPLhCQP3WULQOoF28Yo0mCCpQ0pdWS
         4kzE/EfPifvmm2eOQs8H1UaPgiwZQIEiFrQClwm5vAGbNqrpNlTzT2Ag3ymykcAmS8Gb
         P9TabPjoEmZsbe9nMJ0v0mZkByNl2iIFI99G8+k9lPNfdN4cHdTEm4mf0XbbL4CAEBAF
         q/YfWHS71XzHcBwO/xdXpC0l3nLV3mV1zeQZ4FYXVN89k3fvG/xWJmifqHDR0JINzvam
         aDKQ==
X-Gm-Message-State: AGRZ1gIKw3HJyZKkozpRfehJGsafK17FnKV4qVNhgmpGyW5yUNzRnuka
        kgGulTSM04LI/yo1koV1e2/oDriDJiY=
X-Google-Smtp-Source: AJdET5foYa8XsbReYVWCyWfn2wxuDBnodaUOBEcOCOSLpbPO0pwyvakYpy5EvBG5NR6RIoabUrnxEw==
X-Received: by 2002:a81:460b:: with SMTP id t11-v6mr653083ywa.441.1542184094527;
        Wed, 14 Nov 2018 00:28:14 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id o1-v6sm735141ywf.81.2018.11.14.00.28.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 00:28:13 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 131-v6so6540033ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 00:28:13 -0800 (PST)
X-Received: by 2002:a25:d64d:: with SMTP id n74-v6mr697235ybg.204.1542184092817;
 Wed, 14 Nov 2018 00:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20180904113018.14428-1-javierm@redhat.com> <0e31ae40-276e-22be-c6aa-b62f8dbea79e@xs4all.nl>
 <20180927071330.1fa3cfdd@coco.lan> <865b545d-3c3a-a2d3-4c1b-2a5b41a7ff37@xs4all.nl>
In-Reply-To: <865b545d-3c3a-a2d3-4c1b-2a5b41a7ff37@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 14 Nov 2018 17:28:00 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C0JfVCakdXDGe_cEoEDH0X-Wwu5Zx3yi0PUNNdCWxRYg@mail.gmail.com>
Message-ID: <CAAFQd5C0JfVCakdXDGe_cEoEDH0X-Wwu5Zx3yi0PUNNdCWxRYg@mail.gmail.com>
Subject: Re: [PATCH 0/2] media: intel-ipu3: allow the media graph to be used
 even if a subdev fails
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        javierm@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Zheng, Jian Xu" <jian.xu.zheng@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Cao Bing Bu <bingbu.cao@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, Sep 27, 2018 at 7:22 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 09/27/2018 12:13 PM, Mauro Carvalho Chehab wrote:
> > Em Thu, 27 Sep 2018 11:52:35 +0200
> > Hans Verkuil <hverkuil@xs4all.nl> escreveu:
> >
> >> Hi Javier,
> >>
> >> On 09/04/2018 01:30 PM, Javier Martinez Canillas wrote:
> >>> Hello,
> >>>
> >>> This series allows the ipu3-cio2 driver to properly expose a subset o=
f the
> >>> media graph even if some drivers for the pending subdevices fail to p=
robe.
> >>>
> >>> Currently the driver exposes a non-functional graph since the pad lin=
ks are
> >>> created and the subdev dev nodes are registered in the v4l2 async .co=
mplete
> >>> callback. Instead, these operations should be done in the .bound call=
back.
> >>>
> >>> Patch #1 just adds a v4l2_device_register_subdev_node() function to a=
llow
> >>> registering a single device node for a subdev of a v4l2 device.
> >>>
> >>> Patch #2 moves the logic of the ipu3-cio2 .complete callback to the .=
bound
> >>> callback. The .complete callback is just removed since is empy after =
that.
> >>
> >> Sorry, I missed this series until you pointed to it on irc just now :-=
)
> >>
> >> I have discussed this topic before with Sakari and Laurent. My main pr=
oblem
> >> with this is how an application can discover that not everything is on=
line?
> >> And which parts are offline?
> >
> > Via the media controller? It should be possible for an application to s=
ee
> > if a videonode is missing using it.
> >
> >> Perhaps a car with 10 cameras can function with 9, but not with 8. How=
 would
> >> userspace know?
> >
> > I guess this is not the only case where someone submitted a patch for
> > a driver that would keep working if some device node registration fails=
.
> >
> > It could be just d=C3=A9j=C3=A0 vu, but I have a vague sensation that I=
 merged something
> > similar to it in the past on another driver, but I can't remember any d=
etails.
> >
> >>
> >> I completely agree that we need to support these advanced scenarios (i=
ncluding
> >> what happens when a camera suddenly fails), but it is the userspace as=
pects
> >> for which I would like to see an RFC first before you can do these thi=
ngs.
> >
> > Dynamic runtime fails should likely rise some signal. Perhaps a sort of
> > media controller event?
>
> See this old discussion: https://patchwork.kernel.org/patch/9849317/
>
> My point is that someone needs to think about this and make a proposal.
> There may well be a simple approach, but it needs to be specced first.

In that thread, you seem to have mentioned that having a Kconfig
option, disabled by default, to allow registering an incomplete media
topology would be an acceptable option. Do you think we could revive
that idea?

Quoting some of the discussion points you mentioned:

Some discussion points:

> 1) What about adding time-out support? Today we wait forever until all co=
mponents
>    are found, but wouldn't it make sense to optionally time-out? And if s=
o, then
>    we can keep most of the code the same and decide in the complete() cal=
lback
>   whether or not we accept missing components. And decide how badly 'impa=
ired'
>   the system is. We can also still bring up all the devices in the comple=
te rather
>   than one-by-one as you proposed (and which I am not sure I like).

It sounds like an interesting extension, not a must have for handling
incomplete topologies.

I can also imagine the timeout handling introducing a lot of confusion
to the userspace, for example, with a long timeout, the whole
initialization would have to wait for the timeout to elapse, which for
a smartphone user could mean that they can't start the camera
application (or it times out on its own and fails) until then.

> 2) This can be hard to test, so perhaps we should support some form of er=
ror
>   injection to easily test what happens if something doesn't come up.

This is a very good point, but I think we should be able to do away
with something simpler, just blacklist particular device from being
bound to a driver. How to do it, is another question, though... (I can
imagine binding a dummy driver to the device as an example solution.)

Best regards,
Tomasz

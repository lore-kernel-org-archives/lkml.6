Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5E1C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA2D21EFB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e5LE6OWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA2D21EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeHJBwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:52:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45218 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHJBwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:52:11 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so3182709pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 16:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=RzEpSjNEphKu5jUBSU+4/lM0f/hwMx5E9QsKt1wvNV8=;
        b=e5LE6OWCZYRgxqH3dGy35yjCOsvKTD+2ZvsKBMKShZ0g9C903NSN9QW6SmEaB7Ioo5
         Y48QrkPRAsRLkeCYiGOLStJl1R+ur1eEF7stcIK5THAol0n0zJ627iDHss+ptKbH14wf
         3e0343ythgBMg6ebnl5uZAtWNwUrUiROnzjDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=RzEpSjNEphKu5jUBSU+4/lM0f/hwMx5E9QsKt1wvNV8=;
        b=XRFYRSrRTrybRV9yWXrO1c7lMFnbMoSMH3We1L0uoJKRaKSbcyqAX+9S1f3aChAdg/
         YtUcllLOr5klQq0hkLQV9Fk3SzKdbRLIVHc37Ief2gh2FYFdLv09IjJtKJEDkx/ZsvkB
         lqpEZM5oVi0boA+jcU+/Fvar9JPbc+N8XXa+ziOGDJp0v0DDpBq5BtxF5+9j8Gpsticv
         4fuh+hDqkMpC+GhdBsw4m/5mIFc1rmBFg07ZeW+1ROEj0CqXnIV0W/3JugpZSvcyAS6d
         HExb0Bg59ZPxBqJPkswNrkSnrehf71+jH8/VFZkeLrHMt04SEQwbBoFUJxaLTfuDLhyg
         D3eQ==
X-Gm-Message-State: AOUpUlEhXeeq/SgR/9pJVlAt/D+ncaY1XhTamn8/YDK14nRxtOM/ojY4
        Y8JaEWdl+tW/qJBYsleImv3vGQ==
X-Google-Smtp-Source: AA+uWPx2MOxNiTIqTNGFKOye+qi6k/+8hkTMpaDnrbSc0RPrFmLYZ21Y5uH4ooV6Qrk5KKlkPbmiFA==
X-Received: by 2002:a17:902:7106:: with SMTP id a6-v6mr3861892pll.28.1533857103854;
        Thu, 09 Aug 2018 16:25:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id g20-v6sm9759319pfo.94.2018.08.09.16.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 16:25:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brian Norris <briannorris@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180809195211.GA137192@ban.mtv.corp.google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-3-swboyd@chromium.org>
 <20180809174936.GC129285@ban.mtv.corp.google.com>
 <153384363124.220756.3747855789935101539@swboyd.mtv.corp.google.com>
 <20180809195211.GA137192@ban.mtv.corp.google.com>
Message-ID: <153385710251.220756.6283092223394491763@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/7] firmware: coreboot: Unmap ioregion on failure
Date:   Thu, 09 Aug 2018 16:25:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Norris (2018-08-09 12:52:13)
> Hi,
> =

> On Thu, Aug 09, 2018 at 12:40:31PM -0700, Stephen Boyd wrote:
> > Quoting Brian Norris (2018-08-09 10:49:38)
> > > On Thu, Aug 09, 2018 at 10:17:17AM -0700, Stephen Boyd wrote:
> > > > Both callers of coreboot_table_init() ioremap the pointer that come=
s in
> > > > but they don't unmap the memory on failure. Both of them also fail =
probe
> > > > immediately with the return value of coreboot_table_init(), leaking=
 a
> > > > mapping when it fails. Plug the leak so the mapping isn't left unus=
ed.
> > > > =

> > > > Cc: Wei-Ning Huang <wnhuang@chromium.org>
> > > > Cc: Julius Werner <jwerner@chromium.org>
> > > > Cc: Brian Norris <briannorris@chromium.org>
> > > > Cc: Samuel Holland <samuel@sholland.org>
> > > > Fixes: 570d30c2823f ("firmware: coreboot: Expose the coreboot table=
 as a bus")
> > > =

> > > I suppose this is fair, since that commit introduced error paths and
> > > didn't clean them up. But one warning below:
> > > =

> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > > ---
> > > >  drivers/firmware/google/coreboot_table.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > =

> > > > diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/fir=
mware/google/coreboot_table.c
> > > > index 19db5709ae28..0d3e140444ae 100644
> > > > --- a/drivers/firmware/google/coreboot_table.c
> > > > +++ b/drivers/firmware/google/coreboot_table.c
> > > > @@ -138,6 +138,9 @@ int coreboot_table_init(struct device *dev, voi=
d __iomem *ptr)
> > > >               ptr_entry +=3D entry.size;
> > > >       }
> > > >  =

> > > > +     if (ret)
> > > > +             iounmap(ptr);
> > > =

> > > This works because no sub-driver is using this mapping any more (i.e.,
> > > because we killed coreboot_table_find()). Otherwise, we'd need to
> > > explicitly kill all the sub-devices first. IOW, if this gets backport=
ed
> > > to older kernels, it would need to go along with this and its other
> > > dependencies:
> > =

> > The memory is copied out of the table. So do the devices actually use
> > the memory that we remap here? I don't see how it's a problem if we
> > unmap the table after we populate devices.
> =

> No, the memory is (or was) copied each time. See:
> =

> int coreboot_table_find(int tag, void *data, size_t data_size)
> {
> ...
>         memcpy_fromio(&header, ptr_header, sizeof(header));
> ...
> =

> (where ptr_header is an alias for 'ptr')
> =

> So before commit b616cf53aa7a and friends, this patch is a bad idea.
> =

> Just to reiterate/clarify: none of this is a criticism of this patch as
> applied to mainline. It's just a criticism of what might happen with the
> 'Fixes' tag if we aren't careful.
> =


Ok. I misread your email. Either way, both of these commits we're
talking about here are only in v4.18-rc series, so backporting for
stable will be fine either way.

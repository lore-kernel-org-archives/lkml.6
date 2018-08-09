Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D3C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A2B21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WisFlvqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A2B21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeHIWGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:06:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45960 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:06:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so3201093pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=GhsNkLOvHOcBXrF6L6DK61XYSklSLF8ro3RgmvIo9no=;
        b=WisFlvqDaj5KbfR2JovaMGqsjjgIvBT4ZfiX/sAruF3iiljv6lVjD0Cdb4zT9G1Pua
         Lvv3CLOMXpkHn/L220lSbiEeo/kGJqxj3iF52/fz4AM7yjWA+rzVnxmgGgvC+QkVvJqd
         QA8ROxA2puTiBgGFS1hHXYJIQ3WWRC6jnmHl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=GhsNkLOvHOcBXrF6L6DK61XYSklSLF8ro3RgmvIo9no=;
        b=L730mWhDtwVBUOiwpfFaRkEwZ2eQHhS5FTLET+1ZXW3KQ50MQZCqG0EcVoRC4e8s6/
         sLJXtPXllCrogMZXqUiV7NN5JH9Ogeerar/sIGD+q/7j1vnenkj+SGTOcbe441UJ7HVR
         WLjv3aREbR1m8tE8t9pHqY1xww+qFjbvJxizdfByZ0enGTq4a9OzqbhtUuEO1gyeOl/E
         BC83ZCTBwfxg7Ihpg+t48p2H84oUKK2kAzBKhh+olYWlrQd67XKo8FajOYwRh+DOl3qR
         5eN3IBIrcwWjG26yScESMCRV18+0XFUM9OZmUPwMVOVfUf2Iq5Qad5S3zKoUd/aOmnRC
         Y9Uw==
X-Gm-Message-State: AOUpUlGoseiFWSuMzjJawcJFXL1X5+7ySPZ7zhHuF0IPENTBUiVSM9HF
        YECcxN2+LIo9G+1ZCqf6MW8NHA==
X-Google-Smtp-Source: AA+uWPyyIZeTa6HNlhtWKG6bBbkwLYRiMWiHXTVo2YgljFLhddZLu32MlE2Und1sd1JMlQhyRQJWNw==
X-Received: by 2002:a62:4fd9:: with SMTP id f86-v6mr3709754pfj.110.1533843632488;
        Thu, 09 Aug 2018 12:40:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id c4-v6sm13343899pfb.71.2018.08.09.12.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 12:40:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brian Norris <briannorris@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180809174936.GC129285@ban.mtv.corp.google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-3-swboyd@chromium.org>
 <20180809174936.GC129285@ban.mtv.corp.google.com>
Message-ID: <153384363124.220756.3747855789935101539@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/7] firmware: coreboot: Unmap ioregion on failure
Date:   Thu, 09 Aug 2018 12:40:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Norris (2018-08-09 10:49:38)
> On Thu, Aug 09, 2018 at 10:17:17AM -0700, Stephen Boyd wrote:
> > Both callers of coreboot_table_init() ioremap the pointer that comes in
> > but they don't unmap the memory on failure. Both of them also fail probe
> > immediately with the return value of coreboot_table_init(), leaking a
> > mapping when it fails. Plug the leak so the mapping isn't left unused.
> > =

> > Cc: Wei-Ning Huang <wnhuang@chromium.org>
> > Cc: Julius Werner <jwerner@chromium.org>
> > Cc: Brian Norris <briannorris@chromium.org>
> > Cc: Samuel Holland <samuel@sholland.org>
> > Fixes: 570d30c2823f ("firmware: coreboot: Expose the coreboot table as =
a bus")
> =

> I suppose this is fair, since that commit introduced error paths and
> didn't clean them up. But one warning below:
> =

> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/firmware/google/coreboot_table.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > =

> > diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmwar=
e/google/coreboot_table.c
> > index 19db5709ae28..0d3e140444ae 100644
> > --- a/drivers/firmware/google/coreboot_table.c
> > +++ b/drivers/firmware/google/coreboot_table.c
> > @@ -138,6 +138,9 @@ int coreboot_table_init(struct device *dev, void __=
iomem *ptr)
> >               ptr_entry +=3D entry.size;
> >       }
> >  =

> > +     if (ret)
> > +             iounmap(ptr);
> =

> This works because no sub-driver is using this mapping any more (i.e.,
> because we killed coreboot_table_find()). Otherwise, we'd need to
> explicitly kill all the sub-devices first. IOW, if this gets backported
> to older kernels, it would need to go along with this and its other
> dependencies:

The memory is copied out of the table. So do the devices actually use
the memory that we remap here? I don't see how it's a problem if we
unmap the table after we populate devices.

> =

> b616cf53aa7a firmware: coreboot: Remove unused coreboot_table_find
> =

> But I guess that's a question for -stable. Or, we remove the 'Fixes'
> tag? Or add another tag, to list other dependencies? Or just ignore it.
> =

> But for this change as applied to mainline:
> =

> Reviewed-by: Brian Norris <briannorris@chromium.org>
> =


Thanks!


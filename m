Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA98C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D0B2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kCaichJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D0B2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404317AbeHPTaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:30:12 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35871 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeHPTaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:30:11 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so7494085itp.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RdJMMoJaOhGxExMQgCjhAYjsATfPlV/oePVcJar9G8o=;
        b=kCaichJBf3TyO0JPDsn173CGutoNuMoVciz8ijBb1BY9iRhNGxG6+al1EAMqRDBaX2
         wL83JRfvTtUjk1sFV3Khi0Ny/NNwTf/evPnLzhMidp6eQzMXZY+heh+aJjALsTGbtM8n
         c6ZuzgjicbtIKTfWtAQGJDACQa2EOvMEaW1Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RdJMMoJaOhGxExMQgCjhAYjsATfPlV/oePVcJar9G8o=;
        b=BxZPzhwpP/5mWzKemLc0iE78McvkPhgt6pB75pScTYNG624Xj2GWJVd2Twi1KREYvU
         2B0e9fGXRc3C4Bn1O5jOoLyNanGK0T/zYVBEz269qcYfAIfnp7K+8/NEm02YqmjUio1X
         qtMJlawozP2R8mqaxfKDARduQQLZMvHCBRMd2BIHWMZ9pdWXUZ43AiX6gniZVAMJdAwt
         REQsNAN2ZH/ccmtv9LsrT6E1RkNv3WJ+KcQJ0z7Wg1UcqHGPI6KpscLxh1svQWJFzhqX
         kOIt0wQAwQzZVSsthbNZ7UQKADmJy7nR11v1+DgJzYbHoJ0MPonY8FZegc//7/8J4dEI
         8MBQ==
X-Gm-Message-State: AOUpUlHe18k1/QKvNANzMZS6xAYcvNeDBc9CQ8dzTtq7sB7rUCRwwtxv
        4Dy3B09PB9Sf/g4GdOAaRIZIjlTVfzC678EfvnhDHQ==
X-Google-Smtp-Source: AA+uWPziYBw2XDo+smWo8Z9JJNV/GrkvE52++0tShrTW8xZ8wkiwkgqxG1bcgHhxD7EAjy48jbXEavPihczYyRaSBGw=
X-Received: by 2002:a24:6e0f:: with SMTP id w15-v6mr22612520itc.77.1534437040298;
 Thu, 16 Aug 2018 09:30:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e502:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 09:30:39
 -0700 (PDT)
X-Originating-IP: [212.51.149.109]
In-Reply-To: <20180816155538.GR164269@art_vandelay>
References: <20180815153604.90152-1-sean@poorly.run> <20180816073248.GZ21634@phenom.ffwll.local>
 <20180816155538.GR164269@art_vandelay>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 16 Aug 2018 18:30:39 +0200
X-Google-Sender-Auth: ho1PG4D2uTwYUP0HwouammMJSzI
Message-ID: <CAKMK7uGpT428FnT_7zwbDovLNHk8GMuOzf9gW9wiBkyiOLSw3w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drm-misc: Change seanpaul's email address
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 5:55 PM, Sean Paul <sean@poorly.run> wrote:
> On Thu, Aug 16, 2018 at 09:32:48AM +0200, Daniel Vetter wrote:
>> On Wed, Aug 15, 2018 at 11:35:29AM -0400, Sean Paul wrote:
>> > Since chromium.org is now enforcing DMARC, my mails are going to
>> > people's spam folders. While this development might be desirable
>> > for people I communicate with, it's undesirable for me :-)
>> >
>> > Cc: Dave Airlie <airlied@linux.ie>
>> > Cc: Gustavo Padovan <gustavo@padovan.org>
>> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > Signed-off-by: Sean Paul <sean@poorly.run>
>> > ---
>> >  MAINTAINERS | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 93f189f0d60d..5eaa1c91d4a4 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -4662,7 +4662,7 @@ F:    include/linux/vga*
>> >  DRM DRIVERS AND MISC GPU PATCHES
>> >  M: Gustavo Padovan <gustavo@padovan.org>
>> >  M: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > -M: Sean Paul <seanpaul@chromium.org>
>> > +M: Sean Paul <sean@poorly.run>
>>
>> Glorious domain :-)
>>
>> Aside: ffwll.ch has been running with dkim since a while, seems to work
>> correctly. You just need non-strict dkim enforcement, which at least for
>> gapps is the default.
>>
>> But even then Linus' gmail inbox throws my mails away every once in a
>> while, so email clearly doesn't work.
>
> My (completely incorrect, i'm sure) understanding is that DKIM is fine, but
> DMARC is the problem.
>
> It seems Mailman was altering some (or all) of my messages which caused DMARC
> to fail. At the very least the "Prevent duplicate messages" setting in mailman
> strips users cc from the headers. So if any one of the recipients has this
> setting enabled, the headers are munged, DMARC fails, and emails go to spam.

Hm tbh I didn't know about DMARC yet. Sounds like it just tells the
recipient how your domain would like SPF/DKIM failures to be handled.
One of these (if configured correctly) should survive mailing lists. I
did crawl dri-devel a bit, and there's mails that passed through with
full dmarc enforcement. So it's not impossible.

But hey in practice it doesn't even work for gmail->gmail when the
moon howling is too bad :-)
-Daniel


>
>>
>> </rant>
>>
>> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Thanks, pushed to -misc-next-fixes
>
> Sean
>
>> >  W: https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
>> >  S: Maintained
>> >  T: git git://anongit.freedesktop.org/drm/drm-misc
>> > --
>> > Sean Paul, Software Engineer, Google / Chromium OS
>> >
>> > _______________________________________________
>> > dri-devel mailing list
>> > dri-devel@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

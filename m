Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060FDC5ACD5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACE320657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfARUKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:10:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44415 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfARUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:10:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so15463055otl.11;
        Fri, 18 Jan 2019 12:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sUo+0azJHeU/IxduQC2o8S5A/gjk7NSQ/GRq57LSFQ=;
        b=tcIWXtySnWzY8r5wNWSZlTOYkV0RkWCBFBjD1YliMgYbYPTXxQWS1TUehJKp8Intz7
         nQn/wflNHmF2ifirmMJxx7i56Y6/MlmYDEo2T3FpMv6S/UGT3cPU3zLtRwEPrrCmUAE3
         2JwPwjJDn5vNXjBcECskhh1EfAdRDcK9mgBXjN3oRwHQiEkDQVnQ+onfKLXu6EPlRUkS
         oGmLE13rqkcn2FRotrWgflcxFcuotg2p7yo1Ig8XgvXNWtPwvxGXV5EMap416z/JGA0x
         tpO042uuYCOb9Z7Y21Ca0LvX6ylrs3MUNT5aYAotvx2kHhykdDmmIimJe+emxgUohrC4
         tghQ==
X-Gm-Message-State: AJcUukfK1w2eQDbdGrAWEyzY4M5/M37WsCtvwax/qQcfwG2GvzR6sxLk
        RGkaHhkDRbdzxzLEB9ohDEh+l9HcApwGK1fuiwR5+ikj
X-Google-Smtp-Source: ALg8bN4YUuQj/7RzDs9F5VjIKjCz+fKtDA238qhvVeMAbjEIN0MWoOPg4vVQBjylEdlnP+DdtIp8st7O1F9deA4vy+o=
X-Received: by 2002:a9d:3d24:: with SMTP id a33mr12924903otc.365.1547842209857;
 Fri, 18 Jan 2019 12:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20190118193248.535-1-malat@debian.org> <d76c2a301d324239db09ccc7cd8421821ba93b87.camel@perches.com>
In-Reply-To: <d76c2a301d324239db09ccc7cd8421821ba93b87.camel@perches.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 18 Jan 2019 21:09:58 +0100
Message-ID: <CA+7wUswhGdSdhWpAi=PZANpr4X8yKKJkZUWTtsFLs0NAVQ76oQ@mail.gmail.com>
Subject: Re: [PATCH] video/hdmi: Change strncpy() into memcpy() in hdmi_spd_infoframe_init
To:     Joe Perches <joe@perches.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 8:51 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-01-18 at 20:32 +0100, Mathieu Malaterre wrote:
> > Using strncpy() is less than perfect since the destination buffers do not
> > need to be NUL terminated. Replace strncpy() with memcpy() to address a
> > warning triggered by gcc using W=1 and optimize the code a bit.
> >
> > This commit removes the following warnings:
> >
> >   drivers/video/hdmi.c:234:2: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
> >   drivers/video/hdmi.c:235:2: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
> []
> > diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> []
> > @@ -231,8 +231,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
> >       frame->version = 1;
> >       frame->length = HDMI_SPD_INFOFRAME_SIZE;
> >
> > -     strncpy(frame->vendor, vendor, sizeof(frame->vendor));
> > -     strncpy(frame->product, product, sizeof(frame->product));
> > +     memcpy(frame->vendor, vendor, sizeof(frame->vendor));
> > +     memcpy(frame->product, product, sizeof(frame->product));
>
> This is not good.
>
> vendor can be any location and shorter than sizeof(frame->vendor)
> so this can copy from invalid memory locations.

Ah right. I did not realize that and know I see the call with "Intel",
will re-spin.

> You probably want strscpy.

Right.

> This is called with at least "mediatek" and "broadcom", so perhaps
> it's better still to change the struct vendor size to something a
> bit larger.  Maybe change vendor[8] to vendor[16];

Looks like 8 bytes is required for call like hdmi_spd_infoframe_unpack()

> include/linux/hdmi.h:struct hdmi_spd_infoframe {
> include/linux/hdmi.h-   enum hdmi_infoframe_type type;
> include/linux/hdmi.h-   unsigned char version;
> include/linux/hdmi.h-   unsigned char length;
> include/linux/hdmi.h-   char vendor[8];
> include/linux/hdmi.h-   char product[16];
> include/linux/hdmi.h-   enum hdmi_spd_sdi sdi;
> include/linux/hdmi.h-};
>
>

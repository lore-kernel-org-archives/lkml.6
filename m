Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394DAC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196E920870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FbE/l1zG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196E920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeKUDPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:15:03 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:46116 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeKUDPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:15:03 -0500
Received: by mail-ua1-f49.google.com with SMTP id v24so863641uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gL+bZ0qIQNK56BwknIBXZiRLj/xRz1GnfiNvQqxmqnU=;
        b=FbE/l1zGHy+Q4/yw9VFDvmgJ+6iV0BS2N8wvoFLvfLXnenc8uH4+LUX3LXGBoToWHm
         Drk1HDtu0O7EsJubT60kBzxeA4YtbUVSmcgTcIMbDKY6POc6JHo9AIOHwMLO5WaHrGeQ
         3vp4QqNnHXEwDCKL4claTZSjG584NopAf4QJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gL+bZ0qIQNK56BwknIBXZiRLj/xRz1GnfiNvQqxmqnU=;
        b=Qpm9v8JUSD66MTW+DTP9Xwc/sBM6JwB6KmhCeg25bd5/xfoo+yQuMMAad+ewciBbOT
         lapU4H1AQ9IW4/T0148M65Y2hDHVQ67fn9WMHTdWmatw7boHdnYCw7Ta0uXZkGdqQHIG
         PvaNIfQUpgf6UB6BKOr53nXg6Rzzlq5ZM6KJcEGqYbDxMmZf/jc55+vuc2JBhN8yt74F
         cosGrb+CPVJPdFxdRlHmXsOsqxpHaz6cyLr5NgTWLtsYHRaS8u37u3ePHhadvi3HpSnl
         VDtlU7rrbfGALePHgA2I8jB0gz9DbswTmN7PMVD4L2TEjc6sbqKnsPNNcjYqDLGdF3oW
         5w6Q==
X-Gm-Message-State: AA+aEWZ45zc1YzN6jCRt9ClQnH21s0NJQjI/bsuiai/2fwv205zNi90C
        eHZ6b7oBHYBtHgyYIPhqajw9udhMqWA=
X-Google-Smtp-Source: AFSGD/WNCtXuGplyH3YOCT0gNA40XgyqC7/0eHrCkto7x9kc3X2QED7vTWQTLEE9SdX9AWey7Ekicg==
X-Received: by 2002:ab0:16c8:: with SMTP id g8mr1251909uaf.60.1542732299092;
        Tue, 20 Nov 2018 08:44:59 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id q192sm11391678vkf.47.2018.11.20.08.44.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:44:58 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id d21so874677uap.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:44:57 -0800 (PST)
X-Received: by 2002:a9f:2bc6:: with SMTP id f6mr1221709uaj.52.1542732297380;
 Tue, 20 Nov 2018 08:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20181120162808.B73391124DC2@debutante.sirena.org.uk>
 <CAD=FV=W==50GsF+R3_qGbqDH2VF8VKXv3Y6Co90d2GdUbhn69g@mail.gmail.com> <20181120164125.GK3894@sirena.org.uk>
In-Reply-To: <20181120164125.GK3894@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 08:44:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xgp=2vicWuMmp_hQ4LqL+bE91cyuSSRPT8=M2LK=9jsA@mail.gmail.com>
Message-ID: <CAD=FV=Xgp=2vicWuMmp_hQ4LqL+bE91cyuSSRPT8=M2LK=9jsA@mail.gmail.com>
Subject: Re: Applied "regulator: core: add enable_count for consumers to debug
 fs" to the regulator tree
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 8:41 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 20, 2018 at 08:37:04AM -0800, Doug Anderson wrote:
>
> > Hold up!  How does this compile for you?  It looks as if you landed it
> > before ("regulator: core: Only count load for enabled consumers")
> > which is the patch that adds "enable_count" to the consumer structure.
>
> > I'm just working on my replies to you about the dependencies on these
> > patches but they're definitely not separate...
>
> Dunno, but my script for applying things does a build after each patch
> and didn't complain so...  are you sure it's not e-mails getting
> reordered?

The first thing I did was to fetch linuxregulator/for-next and confirm
that it had this patch but not the patch it depends on.

Now I just tried checking out this git hash:

f556213bad39 ("regulator: core: add enable_count for consumers to debug fs")

When I build I get:

drivers/regulator/core.c: In function 'regulator_summary_show_subtree':
drivers/regulator/core.c:5229:16: error: 'struct regulator' has no
member named 'enable_count'
        consumer->enable_count,
                ^
drivers/regulator/core.c:5231:38: error: 'struct regulator' has no
member named 'enable_count'
        consumer->uA_load && !consumer->enable_count ?
                                      ^

...which is consistent with what I would expect.

-Doug

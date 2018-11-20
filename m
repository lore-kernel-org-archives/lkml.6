Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7E3C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB36C20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbJZD7qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB36C20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbeKUD1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:27:55 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34126 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbeKUD1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:27:55 -0500
Received: by mail-vk1-f195.google.com with SMTP id y14so569043vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLoUUWSM9fFIdSTU3RPmiEoKSpyKKdVwNlh9D3OeoH8=;
        b=cbJZD7qpT3rX4Zl7/pIURNFk9TcjbrAHeRnvAqizGiCgOt1+amaePcS4/zxeDKmdC8
         P1Hfx/CM1+hwH/ID6LMMHmef6t7gcVPcOUZIV+Tts/QoTbRPY6YiW3twTigZUP4gaAvB
         PK302myF5FPJJ+u70fEh3n51W3EXZBBFW68pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLoUUWSM9fFIdSTU3RPmiEoKSpyKKdVwNlh9D3OeoH8=;
        b=VhZ5N1BKqPqRowx5bTurU/WGhDtObmul7ZIqXqnx4PsGz3dkDo2TC5SyvPKYljxKw2
         RyCnMXdR/Zm06+tY/y48/JBPgwA/NVjNXj4/J0e8o3aIzV6X4zozyPB/pwj6J1gcSzMx
         omW1boWusBzYZoiSOzmGY93OYP8jEziEFwamg1z4ODumU06XnbOYyIa1NMLOU3V6Xmuo
         4AgdAXPZzbMyTtAPCYBbUuuxpFjK7Jrh+cW2Kc23iNx9CTCIadiHvObSx/rVLyPxH166
         GRDIL6Z5451/d/PW/xSCVDGw5Cq33yIX4G4+/7purGdXfs0Co8xqwV61sdtM4HuMtkcb
         Zndg==
X-Gm-Message-State: AA+aEWbYze7Hb5XE7hdM4zz1P874QlgX5gRY2egN6Wzu20j/0G450qUp
        GVu5CH7ndzCDVFZBHtvzXNXn5SpXIrc=
X-Google-Smtp-Source: AFSGD/V8oKFv8icE0naNRK0YJSjxMQANbHYvkmuqu3UBGvHMtQv1ybLVGQWkTvz2GVQbnTPdlZnUqQ==
X-Received: by 2002:a1f:8a8e:: with SMTP id m136mr1190001vkd.46.1542733066995;
        Tue, 20 Nov 2018 08:57:46 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 67sm9608238vkt.35.2018.11.20.08.57.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:57:46 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id h78so1498476vsi.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:57:45 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr1207612vsj.144.1542733065187;
 Tue, 20 Nov 2018 08:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20181120002654.1891-1-dianders@chromium.org> <20181120002654.1891-7-dianders@chromium.org>
 <20181120155458.GG3894@sirena.org.uk> <CAD=FV=UHiwjt2a8GFZKG3ZrRfjTgQDWD_mZu_qZP7Ve-HNTMYg@mail.gmail.com>
 <20181120162504.GJ3894@sirena.org.uk>
In-Reply-To: <20181120162504.GJ3894@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 08:57:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VncEViv-mUJzUdjA8qvEouHHtiVfV2EpYi6bLAMW7S7Q@mail.gmail.com>
Message-ID: <CAD=FV=VncEViv-mUJzUdjA8qvEouHHtiVfV2EpYi6bLAMW7S7Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] regulator: core: Remove loop disabling supplies in regulator_force_disable()
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 8:25 AM Mark Brown <broonie@kernel.org> wrote:
>
> If something has been forced off the system is in very serious trouble
> and had a cricial safety problem, though the fact that there's error
> handling code that did the force disable might mean that there's some
> ability to recover the situation - for example, this might be part of
> thermal management or something like charger management.  Other drivers
> do get notified if something gets forced off so a well written system
> will ensure that other users of a regulator that can get force disabled
> will have handling for this as should userspace.  We don't have any such
> full systems in mainline, though - it is a really uncommon case.

OK.  I guess for now I'll just change this to disable the parent
supply as many times as this individual consumer enabled it and call
it good enough?  It can be for someone else to figure out how to make
it really usable for system recovery.

...I originally only ended up here since I was auditing all this code
while moving the enable count to the individual consumers...


> The usage in the Adreno drivers just looks to be another completely
> out of expectation regulator API usage in the QC code.

Yeah, looks like it.


> I do wish there
> were a way to flag API calls as needing review :(

Would it be worth adding a WARN_ON(1) splat here or at least a
"dev_warn" so people knew it wasn't really an API for general use?
...or is that going overboard?

-Doug

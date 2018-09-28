Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78173C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9522073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9522073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeI2Cx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:53:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46719 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeI2Cx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:53:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id d8-v6so5021601pfo.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGMmSFA4POW1uD9XjGB22WBf65nt6qmfIf497bWJBAo=;
        b=px7bo6Sy8ef88ac9naVkptRzoCnKerY0M1nWFF5mCc5UPJomn6FqN7PhJkWnQBwd9y
         7d9Dgr8j1ajuEsd5KLrJFKC0Wi0Pmqs1XfFm3aeJ2te1326BNO4g8YFJ765kwZM+i0FM
         Fx0FfLZIcWjOJ6lWluvcUxo0Qfi0vDX90k7URBY5XM2G6oS6DHZs1eZ8tkWpk3TfP5mB
         tj1O3LnqCmfL31wZJKSLcRzEtSLO9d7+qEAsjTRSXyCOHmSGmgihTAPmOgrrni+TfuFh
         Gvvr7Z9dLJN9owqqCL0pRjtlNQF1pPmqq2UJqydIAU9i4g0e1mISRQYRTFJRPQWO0IQB
         3n1w==
X-Gm-Message-State: ABuFfohxLO2nMiXvcD5zU+2vEfLiPti6oGhH8zrxCzOxCRNnDSlk1Q75
        TaMUmlubm7ia/t+cIo9y4jCEADsyPFy67wyTk3Y=
X-Google-Smtp-Source: ACcGV61JAGcBqaQGixdeOkqNKrutI6J/qzdIYIEYRNY2iYzuOMYWuGTuqcR4aPCIJAtMohCeonXwjaWbFmG1tPnEXfs=
X-Received: by 2002:a63:982:: with SMTP id 124-v6mr251113pgj.80.1538166485323;
 Fri, 28 Sep 2018 13:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180927092427.507-1-jekarlson@gmail.com> <22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com>
In-Reply-To: <22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Fri, 28 Sep 2018 22:27:53 +0200
Message-ID: <CANBLGcwg-g=GfobJrr=BO=2gz9z_OEpmO7a5yh7hf29E6NUx9g@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros-ec: copy the whole event when msg->version is 0
To:     narmstrong@baylibre.com
Cc:     jekarlson@gmail.com, sadolfsson@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lee.jones@linaro.org, bleung@chromium.org, olof@lixom.net,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 at 14:15, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 27/09/2018 11:24, Emil Karlson wrote:
> > Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
> > be truncated on many chromebooks so that Left and Right keys on Column 12 were
> > always 0. This commit fixes the issue by restoring the old semantics when the
> > protocol version is 0.
>
> OK for me, can someone confirms it fixes the issue ??

Both this patch and the updated version fixes the same issue for me on
rk3399-gru-kevin.

/Emil

> Thanks,
> Neil
>
> > ---
> >  drivers/platform/chrome/cros_ec_proto.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index 398393ab5df8..457e4940dba4 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -519,8 +519,14 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> >
> >       ret = cros_ec_cmd_xfer(ec_dev, msg);
> >       if (ret > 0) {
> > +             unsigned int copy_size;
> > +
> >               ec_dev->event_size = ret - 1;
> > -             memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
> > +             if (!version)
> > +                     copy_size = sizeof(struct ec_response_get_next_event);
> > +             else
> > +                     copy_size = ec_dev->event_size;
> > +             memcpy(&ec_dev->event_data, msg->data, copy_size);
> >       }
> >
> >       return ret;
> >
>

Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0481CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8B20672
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UWil0FAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC8B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeKZELr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 23:11:47 -0500
Received: from mail-vk1-f174.google.com ([209.85.221.174]:32950 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeKZELr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 23:11:47 -0500
Received: by mail-vk1-f174.google.com with SMTP id d201so3647388vka.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 09:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MAgT/1VuNGECLv/5u/GitUHFKyEgJIXIYCU3luh0/0=;
        b=UWil0FAlGb/tbu5SxO19dg3b1WcnVtWZ3u+62d7SpwkTm4EBK9eMTMfMOhI5dtDKRK
         Z9CZo5qvfzuSY0HKtRxPKFvlgKwcSn6eZiMCKbcAPF1V0+YjY0Am16yHLteAQQjFRMsq
         PSXkPMOqs0uiVTup9FvOw8sSADK4uLJi8wlkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MAgT/1VuNGECLv/5u/GitUHFKyEgJIXIYCU3luh0/0=;
        b=KkJ8WfDIws7AXwSvwriBIbY8MdaWJi8i53mwPrKN5EWwa1vq+X24EXBTdagPO9ICBF
         RJYymTa52WGBeMqczOG/ZT0w+7Yo8sgoUTBpO6K5Vt5MY5nQ0NPwd6WqwaeNu/Ep5Fn9
         1kiDpAyrW4bIP9ju5a4Iv8g3GCj+dcotPAfFDqEKC3g8xIM/sphBxi6i4uxhak8dHYg5
         7uoqZCi6XFvlKCaO7ptMNSqXJjmHZq9GMwIRHV7w0k6YGhyc50eaFE5mc4Y7vs4C7Zwf
         +cUW6xP9qRezG+CDUB6mc3QiHyyNnvnTHtT1DLu1wIk3cgMhFxF9Uedt7+uZem/SWUJP
         2j9A==
X-Gm-Message-State: AA+aEWbcdAx7WcTAp0Ma2i5+fGE+vcZRoUETEqq2Hk4tFRSOuNVNROH2
        vbIL3KWuBulV7xbG+w89j6OOoELKMfM=
X-Google-Smtp-Source: AFSGD/WbYTd7LNYwKsfeaabkQSwNQufYEirlDCkZFRRcr1JWn+r2kYRQkrFcC98KUaCwkI6zxQnGeg==
X-Received: by 2002:a1f:8746:: with SMTP id j67mr9257984vkd.57.1543166415068;
        Sun, 25 Nov 2018 09:20:15 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id i17sm15349647vsg.30.2018.11.25.09.20.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 09:20:14 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id d2so5547059ual.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 09:20:13 -0800 (PST)
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr9197356uaj.126.1543166413440;
 Sun, 25 Nov 2018 09:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20181125093750.GA28055@basecamp>
In-Reply-To: <20181125093750.GA28055@basecamp>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sun, 25 Nov 2018 09:20:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VuPerEgPPiUKk7-Ck9aVz=oR1CAAzg+0wag1WTrTGKxg@mail.gmail.com>
Message-ID: <CAD=FV=VuPerEgPPiUKk7-Ck9aVz=oR1CAAzg+0wag1WTrTGKxg@mail.gmail.com>
Subject: Re: Question about "regulator: core: Only count load for enabled
 consumers" in -next
To:     masneyb@onstation.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 25, 2018 at 1:37 AM Brian Masney <masneyb@onstation.org> wrote:
> I bisected the issue to the following commit:
>
> 5451781dadf8 ("regulator: core: Only count load for enabled consumers")
>
> We have to increase the load for the sdhci in device tree in order for
> the phone to boot properly. This change was made with the commit:
>
> 03864e57770a ("ARM: dts: qcom: msm8974-hammerhead: increase load on l20
> for sdhci")

You have a 200 mA system load on this regulator?  I guess this is a
workaround for drivers that don't set the load properly themselves?

I wonder if there is a bug in my patch where the system load doesn't
take effect if nobody ever calls set_load.  Let's see...  Does the
below fix things for you?  It's totally untested and whitespace
damaged but I wanted to get a response out quick and I'm just walking
out the door.  I'll test more / dig more either tonight or at work
tomorrow:

+++ b/drivers/regulator/core.c
@@ -1344,6 +1344,12 @@ static int set_machine_constraints(struct
regulator_dev *rdev,
                        rdev_err(rdev, "failed to set initial mode: %d\n", ret);
                        return ret;
                }
+       } else if (rdev->constraints->system_load) {
+               /*
+                * We'll only apply the initial system load if an
+                * initial mode wasn't specified.
+                */
+               drms_uA_update(rdev);
        }

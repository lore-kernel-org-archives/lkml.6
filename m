Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735C4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411F9217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgNMD29z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfAWIxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:53:23 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43816 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfAWIxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:53:23 -0500
Received: by mail-vs1-f65.google.com with SMTP id x1so816584vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myClBJYjky/ABLpOmhPetslgHGs4AKLWXbFb0S/s6TU=;
        b=FgNMD29zgVsSQlmigRDZeHU3WZHUc1lA3RTW0xS7RykJzN8JVzKiXGIcHH/IBP9Oc4
         89SfL9vV7ZKu9RYfwkpvbStqohfNbKcZTjs0GU3f6U/WJJWp38AXaG7pqlkCSP6tQfuA
         OXJGxPO3PKhkAXGH7J5pvc3kzfQe/HKiRbzd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myClBJYjky/ABLpOmhPetslgHGs4AKLWXbFb0S/s6TU=;
        b=rvdoyPnNqtTEH0Cu2eEi6yC1XCGJ8wW7UbU3JtthqI7eCR4e/Z+ezDvtQ3ZsTl23bT
         Cwy5ats21KALNObXqWYRd7ZXDhLcgknD/ZXyDhfGp5rPddWAoTZT3dyjygTkFrcjJ54x
         ktOpVDm+U3lro9w8HL4xGHfPb2vnmfjmmZWZwsyY1WParMxKZlX/+is6ztmxtqTDhism
         1YD7NDj5rUFURZD2J/zZt82nKhfahX2hopc8IU76nV3jz6OKPsoA+CTCZRgmyMT+55jZ
         Gqv7fD5LzByygAGiT60Evw1JInFgdLD7WjFG2V+fRPxBbexuPqRbNii2CehyejLYc8xc
         teIQ==
X-Gm-Message-State: AJcUukcaQ6QOVxhkecYDAqR/aI2MvjwpoVWbvObii0nzO3O6iLpWaWDA
        /FECbvJELjEEFDMy5AhazCp+EpnpswoAgFhjr+f40DOB
X-Google-Smtp-Source: ALg8bN5Wba57QENUjnSVXUGZiFwVNQlOehcyTTWcwZxKY3Vr1AbmF7RdDkczHLWmprDaxv0o21JEblWeiqsHytMaXDY=
X-Received: by 2002:a67:b245:: with SMTP id s5mr517434vsh.200.1548233601993;
 Wed, 23 Jan 2019 00:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20190116113723.15668-1-ulf.hansson@linaro.org> <20190122162421.7F047609B4@smtp.codeaurora.org>
In-Reply-To: <20190122162421.7F047609B4@smtp.codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Jan 2019 09:52:46 +0100
Message-ID: <CAPDyKFrSF0J7d7vM+RWFbS=Chn+pK6ur4xepCPGxnGXGajLRMg@mail.gmail.com>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Tony Lindgren <tony@atomide.com>, Eyal Reizer <eyalr@ti.com>,
        linux-wireless@vger.kernel.org,
        Ricardo Salveti <rsalveti@rsalveti.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Jan Kiszka <jan.kiszka@web.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 at 17:24, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > During "wlan-up", we are programming the FW into the WiFi-chip. However,
> > re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
> > is made in-between the programmings.
> >
> > To conform to this requirement and to fix the regression in a simple way,
> > let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
> > (runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
> > current code is to treat this scenario as an error, but unfortunate this
> > doesn't work as expected, so let's fix this.
> >
> > The other part is to guarantee that a power cycle of the SDIO card has been
> > completed when wl12xx_sdio_power_on() returns, as to allow the FW
> > programming to succeed. However, relying solely on runtime PM to deal with
> > this isn't sufficient. For example, userspace may prevent runtime suspend
> > via sysfs for the device that represents the SDIO card, leading to that the
> > mmc core also keeps it powered on. For this reason, let's instead do a
> > brute force power cycle in wl12xx_sdio_power_on().
> >
> > Fixes: 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > Tested-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Patch applied to wireless-drivers.git, thanks.
>
> 13e62626c578 wlcore: sdio: Fixup power on/off sequence

Great, thanks! Let's see how we can fix Jan's problem on top.

Kind regards
Uffe

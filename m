Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B684FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7862088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLkZDalS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7862088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeGYMDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbeGYMDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:03:14 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C5D2088E;
        Wed, 25 Jul 2018 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532515926;
        bh=u55AIfXf1/sNdvAh8Cd5WWOXAH6K42JQfiLvFR3DdUg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nLkZDalSmgA2Wxrxujbga0KpIGBNX6f6ZL7vdqe9ADgnazQJcnmuGvMN2RNP9LNkd
         AuowwDqfMr2LVnbo7vGDKKqwuXQ3c/A2d8fJMJI5WT727ADq5NttmiLLTrOc9T2mzc
         MvWG3Jo1i9plgD1m4g2GrgV3GUGY2Ped9aACTAys=
Received: by mail-wr1-f43.google.com with SMTP id h10-v6so6953533wre.6;
        Wed, 25 Jul 2018 03:52:05 -0700 (PDT)
X-Gm-Message-State: AOUpUlEPR4twXevjLW+vTFVX5vwdaGS7phIOqzDCaOF1F+uZjuuBL6l9
        B+XRk2ME+n4nnNY5SOOd67t4eJzEdbB+9W403+Q=
X-Google-Smtp-Source: AAOMgpcz47Nu3yNpLdnuNsXnkUueFLk7jRRuLRpmVQn5o3bIgJlXGaMZx3kfk+nMaZjYP+u1pVT4bqfqNZDF3G8D31g=
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr14913759wrr.227.1532515924324;
 Wed, 25 Jul 2018 03:52:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 03:52:03
 -0700 (PDT)
In-Reply-To: <20180723040816.19455-5-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br> <20180723040816.19455-5-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 25 Jul 2018 12:52:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcyPgtifVVT8VJQ3smcGzXxeVSoUdUyCV1ZsD5PbjnnQg@mail.gmail.com>
Message-ID: <CAJKOXPcyPgtifVVT8VJQ3smcGzXxeVSoUdUyCV1ZsD5PbjnnQg@mail.gmail.com>
Subject: Re: [PATCH 4/4] power: supply: max17040: Send uevent in SOC changes
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 July 2018 at 06:08, Matheus Castello <matheus@castello.eng.br> wrote:
> Add check for changes in state of charge from delayed work, so
> in case of changes we call power_supply_changed to send an uevent.
>
> power_supply_changed send an uevent for alert user space about
> changes, is useful for example to user space apps made changes in
> UI battery level or made other decisions.

Hi,

Too many "changes". How about:

Notify core through power_supply_changed() in case of changes in state
of charge. This is useful for user-space to efficiently update current
battery level.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 3efa52d32b44..72915ac9e13b 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -202,14 +202,22 @@ static void max17040_get_of_data(struct max17040_chip *chip)
>  static void max17040_work(struct work_struct *work)
>  {
>         struct max17040_chip *chip;
> +       u16 last_soc;
>
>         chip = container_of(work, struct max17040_chip, work.work);
>
> +       /* store SOC for check change */
> +       last_soc = chip->soc;
> +
>         max17040_get_vcell(chip->client);
>         max17040_get_soc(chip->client);
>         max17040_get_online(chip->client);
>         max17040_get_status(chip->client);
>
> +       /* check changes and send uevent */
> +       if (last_soc != chip->soc)
> +               power_supply_changed(chip->battery);
> +
>         queue_delayed_work(system_power_efficient_wq, &chip->work,
>                            MAX17040_DELAY);
>  }
> --
> 2.13.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

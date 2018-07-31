Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB00C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81DA20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbW4sjH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81DA20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbeGaSn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbeGaSn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:43:56 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67E220841;
        Tue, 31 Jul 2018 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533056563;
        bh=Y4xZKAX+XF6CeJSF6/AZLu4SFGeSQ6tw5RGCYabIycE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QbW4sjH/h8OYQNDFDHDtM9Aeogw+9PRV4jqvibGSimlGNqnixcaOjafNAkN8rPDn5
         hzm0r7c0naLDkaBLL+TBKOMPhNTjOpSPNPC3roDhK5dDVH64Tq82Lqs47lmpheXUEl
         nUBFBH7yF0yGKlkzZQMQsqSBqwhdzsnz23c/3VAQ=
Received: by mail-wm0-f53.google.com with SMTP id s9-v6so3890534wmh.3;
        Tue, 31 Jul 2018 10:02:42 -0700 (PDT)
X-Gm-Message-State: AOUpUlHWVHjhY+z3uImIB+s6zXxBvC+2Uzwd8z+9uBVAlWv8ERRy/Ami
        XZSp8wcSS6myBmlzahrHpNlBq8wwT8jXS9qBzmQ=
X-Google-Smtp-Source: AAOMgpcoIKbxU2kZHRb2kgQ7H6fl6Fmaelz70dXtCYYXKoBJADfwO49Mju6fIilZjd5UrvAjD4dCJ3oVGrpE+yFoFXk=
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr352086wmm.117.1533056561353;
 Tue, 31 Jul 2018 10:02:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 10:02:40
 -0700 (PDT)
In-Reply-To: <20180731164316.32696-5-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca> <20180731164316.32696-5-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 31 Jul 2018 19:02:40 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdGf643nW2p_wcMWQgmjwTs08Wy35+LXagRwuST335z3A@mail.gmail.com>
Message-ID: <CAJKOXPdGf643nW2p_wcMWQgmjwTs08Wy35+LXagRwuST335z3A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] power: bq25890_charger.c: Read back the current
 battery voltage
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 July 2018 at 18:43, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> The part has the capability of reading the current battery voltage.

Instead of "part": BQ25890-family of chargers? Chip?

Anyway,
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/bq25890_charger.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 23b39da07e56..1aa7872ddeb0 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -461,6 +461,15 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>                 val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
>                 break;
>
> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +               ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
> +               val->intval = 2304000 + ret * 20000;
> +               break;
> +
>         default:
>                 return -EINVAL;
>         }
> @@ -669,6 +678,7 @@ static enum power_supply_property bq25890_power_supply_props[] = {
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>         POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
>
>  static char *bq25890_charger_supplied_to[] = {
> --
> 2.17.1
>

Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5720855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWof2+Yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B5720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeKZRLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:11:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33933 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeKZRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:11:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so15418310ljd.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHdBpzOqujIzObqg9evHk7t2I4F20aupal2seUd+uME=;
        b=HWof2+Ytzn2vEPSr7RihPY8BKXTHMD2CANN/LvjQjk3JhJRFppjdidBFlffY5HOfih
         GU+AxBCBt4QW1AASZeQ4GZZj0sVc6eNpzl9YCwne/q51pW1jAcHT7zW69tc3GLWWkLGG
         2GPMze2yCg1ok7U7prMGRe3u+UJcUrPsVbZeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHdBpzOqujIzObqg9evHk7t2I4F20aupal2seUd+uME=;
        b=NgD9NcNbfnzeziLxSGLdT567LxmgSS8Jhq2CmNK4enO6eOwsHYhpoLgJtFKgsuPuSl
         Xhe/J2+i+C4OseY7R7E6mpKOwQShzjys8/Y07NrGmlTdjKoy/COTeCRGxjDWPYRFSGJJ
         grrY3Q2Z2mbzoMHpwvaZqyumQm/n7X6loM6XmBc06mWlIEpOQgNfZcAPU+804y+V1ynE
         keJNbW8XSAAgrudDh6dhfV6NGT36GOH5pOu92FHmzEzXCIWgZ7px3EEoHrjhM/Y5zg2/
         19HubcvDYtzuHvvyiHSPgIFLG+54nZrZ+cn/dM7iDHzdvPm8DTT5vhdgphxJyL8b1475
         45Sg==
X-Gm-Message-State: AA+aEWbhs0K5kRMVkClQImGWv+Hs22EnHQZ4bwLGxRoC7WuUspTNZa+o
        McgNk31475hL0mMGoAF4IVPMYi7itGVBr8KMh4R4gA==
X-Google-Smtp-Source: AFSGD/WNE17W06hDfulFeosi7pvN8ZUFsnGCoVn5IIyZ0m3IU3LsoG82PGQEria6s06b8SIJ0Uj9P8nCqnwmyak9hKc=
X-Received: by 2002:a2e:449c:: with SMTP id b28-v6mr15438717ljf.47.1543213119407;
 Sun, 25 Nov 2018 22:18:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542185618.git.baolin.wang@linaro.org> <db2aa7892d7ecfae563ef22de5bbc7587ea3471f.1542185618.git.baolin.wang@linaro.org>
 <20181125214823.GB9913@amd>
In-Reply-To: <20181125214823.GB9913@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 26 Nov 2018 14:18:27 +0800
Message-ID: <CAMz4kuJ+7J+MYh02YhP9j8Tf6ntdL6tOLiJO6yN0a4Qot4t4Jg@mail.gmail.com>
Subject: Re: [PATCH 5/5] power: supply: sc27xx: Save last battery capacity
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
On Mon, 26 Nov 2018 at 05:48, Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Our charger manager can optimize the battery capacity periodically, so
> > we can save last battery capacity into registers. Then next system
> > power-on, we can read the last saved battery capacity as the initial
> > battery capacity, which can make the battery capacity more accurate.
> >
> > Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/power/supply/sc27xx_fuel_gauge.c |  143 +++++++++++++++++++++++++++++-
> >  1 file changed, 142 insertions(+), 1 deletion(-)
> >
>
> > +static int sc27xx_fgu_set_property(struct power_supply *psy,
> > +                                enum power_supply_property psp,
> > +                                const union power_supply_propval *val)
> > +{
> > +     struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
> > +     int ret;
> > +
> > +     mutex_lock(&data->lock);
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CAPACITY:
> > +             ret = sc27xx_fgu_save_last_cap(data, val->intval);
> > +             if (ret < 0)
> > +                     dev_err(data->dev, "failed to save battery capacity\n");
> > +             break;
> > +
> > +     default:
> > +             ret = -EINVAL;
> > +     }
> > +
> > +     mutex_unlock(&data->lock);
> > +     return ret;
>
> if (psp != ....) return -EINVAL; And you can do that outside
> lock...
>
> Ok, OTOH this is easier to extend in future. Do you expect more
> writable properties?

Until now I think there are no writable properties, I think I can
change it like you suggested.

>
> > +static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
> > +                                         enum power_supply_property psp)
> > +{
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CAPACITY:
> > +             return 1;
> > +
> > +     default:
> > +             return 0;
> > +     }
> > +}
>
>
> Same here. return psp == POWER_SUPPLY_PROP_CAPACITY; really looks
> strange written like this.

Sure. Thanks.

-- 
Baolin Wang
Best Regards

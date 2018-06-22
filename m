Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4772C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6378E23C15
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k6j8P7sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6378E23C15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934189AbeFVBd3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:33:29 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34978 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934081AbeFVBd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:33:28 -0400
Received: by mail-pg0-f66.google.com with SMTP id i7-v6so2218488pgp.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 18:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=irLhuR+gYNbzEmXvn9Y6sxsUhZxiykGNuQHi+6OXkHg=;
        b=k6j8P7smC0SnGZc8PpdCj069ls6GwaAR5XYmPQr4TN2xFwjglZRwJzHO5JFVUbfvzT
         8+C4w4YzxxNxB4ZocqDZ3c1g8MIiFl0K/B5lbs6vhDvIHuSaRsKN0qlPSJKql/kFA9qw
         hn8fmfG6jysfkyin93/7LTdL8dYg/8vMNJ5B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=irLhuR+gYNbzEmXvn9Y6sxsUhZxiykGNuQHi+6OXkHg=;
        b=GZ1cIbnQjBZIvIl49Yd1oq5aWq5k/rtJfiErwuJJQ5Ys/cOG/YsI+KII1NdX4SYuSd
         kiDecpTxqieDqhcAk9eHW+Q/PPznmusy3bECSfcLySsB/OAHcvyGzdY0A9EgZsop61+/
         /yMdIregmG9zfqX9kewjUAZpplJU7cnjFPh+2hDSugB62yvK35UATZ4RPNS5nqn/FLuz
         asZKLTQuX+A4KbmjRn6I3mGsQ12TvKFJi1wWI1PwO1HCmFcFg5oYygy42t7mPCSUB9vJ
         R9fdLAtp2AYVGgdR/unVL6xHRpL9I83Wd2cQfx5hQYkbyKGaAbOZKt1b3dRSZK1yz6lv
         1hTQ==
X-Gm-Message-State: APt69E3y9FgYSsBptWXImDVYK3UrS+2e4WQ3O0ryrrwxSNeDKQCKSK8n
        eXt7+/71hWQOz2lQxyMh7LIC0Q==
X-Google-Smtp-Source: ADUXVKJ7pObbV0/dRG0jf+E1+nOEYRwQ2DQ0LjNehrfjiruBA2MvNrEtesm9Bd28azwUnUEIBXRG0Q==
X-Received: by 2002:a65:5306:: with SMTP id m6-v6mr24262397pgq.250.1529631207555;
        Thu, 21 Jun 2018 18:33:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id r79-v6sm13573702pfe.115.2018.06.21.18.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 18:33:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dmitry Torokhov <dtor@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAE_wzQ8YKUF1U4MKBfi9GQpFz=971j57w-1n-ggZHidMA4HEzQ@mail.gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        andriy.shevchenko@linux.intel.com,
        Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org
References: <20180621234138.30537-1-swboyd@chromium.org>
 <CAE_wzQ8YKUF1U4MKBfi9GQpFz=971j57w-1n-ggZHidMA4HEzQ@mail.gmail.com>
Message-ID: <152963120631.16708.8144626801244854977@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] HID: i2c-hid: Add vddl regulator control
Date:   Thu, 21 Jun 2018 18:33:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Torokhov (2018-06-21 16:58:31)
> On Thu, Jun 21, 2018 at 4:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Some wacom w9013 devices have a vddl supply for "low valtage"
> > requirements. Add support in this driver to turn on this low voltage
> > supply. We can also drop a handful of error messages because the
> > regulator core is already printing an error when bulk regulators fail to
> > enable or disable.
> >
> > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Dmitry Torokhov <dtor@chromium.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Cc: <devicetree@vger.kernel.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > Changes from v1:
> >  * Use the bulk regulator APIs instead of open coding it (Dmitry)
> >
> >  .../bindings/input/hid-over-i2c.txt           |  3 +-
> >  drivers/hid/i2c-hid/i2c-hid.c                 | 62 +++++++++----------
> >  include/linux/platform_data/i2c-hid.h         |  7 +--
> >  3 files changed, 36 insertions(+), 36 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b=
/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > index 4d3da9d91de4..89e6ab89ba38 100644
> > --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > @@ -26,7 +26,8 @@ device-specific compatible properties, which should b=
e used in addition to the
> >
> >  - compatible:
> >    * "wacom,w9013" (Wacom W9013 digitizer). Supports:
> > -    - vdd-supply
> > +    - vdd-supply (3.3V)
> > +    - vddl-supply (1.8V)
> >      - post-power-on-delay-ms
> >
> >  - vdd-supply: phandle of the regulator that provides the supply voltag=
e.
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hi=
d.c
> > index c1652bb7bd15..1d83531454c5 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -1002,18 +1002,21 @@ static int i2c_hid_probe(struct i2c_client *cli=
ent,
> >                 return client->irq;
> >         }
> >
> > -       ihid =3D kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
> > +       ihid =3D devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);
> =

> The patch looks good, but I think this chunk needs to be split out.
> =


Ok. It needs to be done otherwise the regulator put with devm blows up
when the containing structure is freed underneath it.


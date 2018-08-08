Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C99C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EAD21BC7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aQCAFTZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EAD21BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbeHICE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 22:04:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43578 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729884AbeHICE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 22:04:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id a14-v6so1805568pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=eLmQcjIvTXsjHLXqUOUF2WfoHuZw4r7CxLWZDyJjpkI=;
        b=aQCAFTZr6UT1RVRldreQnn+Rkxhe/4ztfkNgHNni6oYDL9xpRSAHl3Aw5XpGQHgCYH
         L4DMc0E3vtHV3yzAW56uaBZXx78a2kbzXXbfzpJAcoeMJoZ0tXnXDS/6TqkRHV8kNIZJ
         w91/Js2Qzp2wDLBRoOGhmrTXwygeLMgjUUg0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=eLmQcjIvTXsjHLXqUOUF2WfoHuZw4r7CxLWZDyJjpkI=;
        b=p4L7n7zCBjXu4NYLBwao87IbgH0iw/UP4XQlchn332oKlfBCEVTImKiwuW0aYXOrLz
         ehFoUcpOW0APEc5Hy5R3iHO83Gb7UEPokt36JFblyL/sF4zMiqXVG3Qg/EkiCyNnFWqS
         IXc8V+DtT4Gz+iEunf+PjI1kK7p0B8MgV+5/9zkVYHDAKCGU3VwX5HU90R/zmFsR8oTI
         gOVhMSMgAHaCb5A7M91gmllXPPQK9//5llGTu7+j7DNSC9z+DMMrvMLJg99ygzeCfLqe
         xGvLtyql30W16Yqb0xmzlNplXUByCAk7Ts6yLc7pj2VFxavYoQb6oPqlnUzVWGWDWlUv
         HytA==
X-Gm-Message-State: AOUpUlGFJsfcw9mwumxNFiwNp+SKvqWwD+/IZgpHKYL47u77fzCYhdHY
        B7dLTw0WdVX8x2McDxjh8wNnJA==
X-Google-Smtp-Source: AA+uWPwfEvPywsB39hILcR7EL3Qb9ti64ELnaRH0XxfHXM0BOpc52XDG0B7OXxdSVrr2QTX9rPMA0Q==
X-Received: by 2002:a62:64d0:: with SMTP id y199-v6mr5027274pfb.255.1533771751039;
        Wed, 08 Aug 2018 16:42:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id a81-v6sm10112038pfa.152.2018.08.08.16.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 16:42:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Julius Werner <jwerner@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAODwPW_sP2=w-qRmVTAm+HCgomxj7C1Z_tLtLzUy-eSp8QrZeA@mail.gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org,
        Sudeep.Holla@arm.com
References: <20180808172414.29983-1-swboyd@chromium.org>
 <20180808172414.29983-3-swboyd@chromium.org>
 <CAODwPW_sP2=w-qRmVTAm+HCgomxj7C1Z_tLtLzUy-eSp8QrZeA@mail.gmail.com>
Message-ID: <153377174946.220756.11492509142148153962@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] firmware: coreboot: Collapse platform drivers into bus
 core
Date:   Wed, 08 Aug 2018 16:42:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2018-08-08 12:07:30)
> > +config GOOGLE_COREBOOT_TABLE_ACPI
> > +       tristate
> > +       default GOOGLE_COREBOOT_TABLE
> =

> I don't think this helps in upgrading (as your commit message says)
> unless you also keep the 'select GOOGLE_COREBOOT_TABLE' here, right?

Oh yes should be select, not default.

> =

> > -int coreboot_table_init(struct device *dev, void __iomem *ptr)
> > +static int coreboot_table_init(struct device *dev, void __iomem *ptr)
> =

> nit: There's little reason to keep coreboot_table_init() a separate
> function now. Could maybe compact the code a little more if you merge
> it into probe()? (Also could then do the signature sanity check before
> trusting the length values to map the whole thing, which is probably a
> good idea.)

Sure. I can make another patch for squashing that all together.

> =

> >         if (ptr_header) {
> >                 bus_unregister(&coreboot_bus_type);
> >                 iounmap(ptr_header);
> =

> Could ptr_header be handled by devm now, somehow?

Yes. It hasn't been devmified yet because that would be more things in
one big patch. This is quickly blowing up!

> Also, don't you have
> two bus_unregister() now (here and in coreboot_exit())? Or is that
> intentional?

That's nice. I didn't notice that module_init() was registering the bus
and then platform drivers could remove the bus later with the driver
unbind. I'll move them both into the driver bind/unbind path, in another
patch.

> =

> > +static struct platform_driver coreboot_table_driver =3D {
> > +       .probe =3D coreboot_table_probe,
> > +       .remove =3D coreboot_table_remove,
> > +       .driver =3D {
> > +               .name =3D "coreboot_table",
> > +               .acpi_match_table =3D ACPI_PTR(cros_coreboot_acpi_match=
),
> > +               .of_match_table =3D of_match_ptr(coreboot_of_match),
> =

> Who takes precedence if they both exist? Will we have two
> coreboot_table busses? (That would probably not be so good...)

I'm not aware of a system that has both ACPI and devicetree, so this
isn't a problem.


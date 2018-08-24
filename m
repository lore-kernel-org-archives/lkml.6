Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DA420A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="nfbs0VE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DA420A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeHXTdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:33:53 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41072 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeHXTdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:33:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so16119508oiw.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s4NqYYv4al0MM6lxB+Qa8E6RGfyvHUJdHavy6zaTqnk=;
        b=nfbs0VE5yB+hQwctGroXfVSvUIjcpcpRglt0fzsKpxs5Wxx/St+QUpUKIxex4tyKkD
         dnXK1wsd+XjZ0gImHyNr3JCUKBKkt19yRUE0/UmSHFv3UcAknpRv7Ss8rUKsby7kfcyd
         J/+oFnO4RTkpJUWHDx99lbb0l3nSIhhAJzXL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s4NqYYv4al0MM6lxB+Qa8E6RGfyvHUJdHavy6zaTqnk=;
        b=jOG73CLRyc1c5jHRkFqWYdk72pOHNGGczUXzksdzlj10Muh+EyrTdU8STT41U0LhTb
         PjdMkmHlFniZ3VQmNsN/dtKKKuHnV8gXc8s5ZorpkICr8N+Ko/qlMXq+3y1RdqRPu4sv
         2I2PKSzDhWgy5u0AaLm+GZRV/7YPqe/RNJErG99hn0msUqx7HUL5veVSQMmybNpk/tgQ
         MAPJ//Zab6mUtizUZo94u2VmSb8Nwe5Kt+g7bv7r2YMuQ352CvPLuNstAJLfuyzQzPcE
         1t6II7gt6Cchr267rzEYjCPfMTEurMPlK12LhKPwTQrWuZAPbCmKhaJFF2vF2gHogndT
         vDFg==
X-Gm-Message-State: APzg51Aktc7ODEsfT3hHj9cDMp+5A90olvyQyffrKMceDDeXB8cXy+v/
        hJjiw0MAInaymC5yoGJeihACoA==
X-Google-Smtp-Source: ANB0VdZfhRCEahe8pv0N7oLq0v97Sqjbd/WjAcNT0lKiBGs6Ef/dHjAU44AHqmScgddAwbeytE7Xiw==
X-Received: by 2002:aca:f105:: with SMTP id p5-v6mr2132304oih.342.1535126314765;
        Fri, 24 Aug 2018 08:58:34 -0700 (PDT)
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id s133-v6sm5767600oie.4.2018.08.24.08.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:58:34 -0700 (PDT)
Received: by mail-oi0-f42.google.com with SMTP id p84-v6so16154188oic.4;
        Fri, 24 Aug 2018 08:58:33 -0700 (PDT)
X-Received: by 2002:aca:3787:: with SMTP id e129-v6mr1760656oia.39.1535126313398;
 Fri, 24 Aug 2018 08:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535039998.git.starnight@g.ncu.edu.tw> <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
 <30b75248-7589-fc98-819f-2b68844522f1@infradead.org>
In-Reply-To: <30b75248-7589-fc98-819f-2b68844522f1@infradead.org>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Fri, 24 Aug 2018 23:58:29 +0800
X-Gmail-Original-Message-ID: <CAC=mGzjMm6OdJJXB=G0NEBkGASWyJv1cgeS=_wiUhDn+WYaqGQ@mail.gmail.com>
Message-ID: <CAC=mGzjMm6OdJJXB=G0NEBkGASWyJv1cgeS=_wiUhDn+WYaqGQ@mail.gmail.com>
Subject: Re: [RFC 1/3 net] lorawan: Add LoRaWAN class module
To:     rdunlap@infradead.org
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "linux-kernel@vger.kernel.org>," <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter ROBYNS <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2018=E5=B9=B48=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 08/23/2018 10:15 AM, Jian-Hong Pan wrote:
> > diff --git a/net/maclorawan/Kconfig b/net/maclorawan/Kconfig
> > new file mode 100644
> > index 000000000000..741992b059c6
> > --- /dev/null
> > +++ b/net/maclorawan/Kconfig
> > @@ -0,0 +1,14 @@
> > +config LORAWAN
> > +     tristate "MAC layer of LoRaWAN Network support"
> > +     select CRYPTO
> > +     select CRYPTO_CMAC
> > +     select CRYPTO_CBC
> > +     select CRYPTO_AES
> > +     ---help---
> > +       LoRaWAN defines a low data rate, low power and long range wirel=
ess
> > +       wide area networks. It was designed to organise networks of sen=
sors,
> > +       switches and actuators, etc automation devices.  It could opera=
te as
> > +       multiple kilometers wide.
>
> There are several things that I would change.  How about this instead?
>
>
>           LoRaWAN defines low data rate, low power and long range wireles=
s
>           wide area networks. It was designed to organise networks of aut=
omation
>           devices, such as sensors, switches and actuators. It can operat=
e
>           multiple kilometers wide.

That becomes better!  Thank you

> > +
> > +       Say Y here to compile LoRaWAN support into the kernel or say M =
to
> > +       compile it as modules.
>
>
> --
> ~Randy

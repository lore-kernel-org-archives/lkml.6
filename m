Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799FCC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E7620834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 18:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsnS0myD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E7620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbeLBSaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 13:30:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45410 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbeLBSaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 13:30:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so7459717lfa.12;
        Sun, 02 Dec 2018 10:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZXursNr3Y7FGpdsuTl0nEcaVlPiTtalREFY2a4vvFVI=;
        b=LsnS0myDN+lLp1IoO7QFkSz8NHVSshWC+poHHnNR64sucBEce7heBM3Ewpeb2Gqgo8
         YNSG3kx1uKf585sSvnAQ8Ei7aVL+yVVCC16NZ/xmqm4cybFEeWBTCkH/xwT59/ZasWEI
         wYgnuh8HqGvtXVpyoPny5p86A+PkjZDa9olSKecIrTD9jQvZ7ojJwhRSBpP+o6ha63Mw
         fC4jkgQ4aMcfiqDhZaqZMxOXBnvwAjBp19Akq258Hm2eWXnn5lZxSrxHljtavCmIrUi2
         dGK1NZbG8DayWwxyGQsX/+ZE46RoMJ07ojsK0x+YFWE8ZzigMAxJ3jIP0GUzR9pL00j3
         j57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZXursNr3Y7FGpdsuTl0nEcaVlPiTtalREFY2a4vvFVI=;
        b=Swtw90Mw6NRd+ln2mRnh1B2sOYyl+KV91gaTxW7fd7q/hf1cIiMj5SspqIN+H1b3v3
         GPt2HnF683W8iMNgwaujFrPTNWUA1X++xZJ0fM3AmA1zuuQePLTJUE253cFxrKFXMdyF
         v8bB5iDxnts8aaq4g2rkUB2xtjqsdKak8odnezl0aOXAscncK5C2uBoahsm+N1awGEZ7
         oLv7PEjaU0RwiJjpcQatI6Sf/LcPo1TWANchJXWsIOberfb+Grmz3+Kfho8YzM9EPCH7
         F2NwAgawyTo5ywZQ0zjib5Sl6bJoL8fv8pJnMj1q0RbVHHvMcCUlW2zqZFbo5+3lgxc1
         6S8w==
X-Gm-Message-State: AA+aEWaxQOsUvleQ9czltpm1mLxia2NQQUMDiEpznxBPpC8TBgYfM75K
        VPAIt/Y3WYj4MCX/JoX6H9g=
X-Google-Smtp-Source: AFSGD/Vg3iIoRhZIvAC0fcndSh63U7CwaIanQdk7cHkrUGqVaDsmTwdzrSKSF29epGjdmKsiha8JTQ==
X-Received: by 2002:a19:5e5d:: with SMTP id z29mr7281933lfi.105.1543775403282;
        Sun, 02 Dec 2018 10:30:03 -0800 (PST)
Received: from localhost (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id a18-v6sm2042659ljk.86.2018.12.02.10.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 10:30:02 -0800 (PST)
Date:   Sun, 2 Dec 2018 19:29:44 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] iio: chemical: sps30: add device tree support
Message-ID: <20181202182943.GA8286@arch>
References: <20181124221415.10081-1-tduszyns@gmail.com>
 <20181124221415.10081-4-tduszyns@gmail.com>
 <20181125085939.421523d6@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181125085939.421523d6@archlinux>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 08:59:39AM +0000, Jonathan Cameron wrote:
> On Sat, 24 Nov 2018 23:14:15 +0100
> Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> > Add device tree support for Sensirion SPS30 particulate
> > matter sensor.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> one comment inine, around the fact we are trying to move
> to generic names in DT where ever possible.  Now we don't
> have a suitable one (IIRC) yet so time to make one up ;)
>
> +CC Rob for his input on that.
> > ---
> >  .../bindings/iio/chemical/sensirion,sps30.txt        | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> > new file mode 100644
> > index 000000000000..6eee2709b5b6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> > @@ -0,0 +1,12 @@
> > +* Sensirion SPS30 particulate matter sensor
> > +
> > +Required properties:
> > +- compatible: must be "sensirion,sps30"
> > +- reg: the I2C address of the sensor
> > +
> > +Example:
> > +
> > +sps30@69 {
> We should define a generic type.  Rob, what would work for this
> one?
>
> particlesensor@69?
>

Wouldn't air-pollution-sensor be somewhat more generic? At least
wikipedia has some article about that. Various other names like
particle-sensor, pm-sensor, particulate-matter-sensor,
air-quality-sensor, tend to return more or less similar number
of search hits. Which means there's no universal naming convention.

> > +	compatible = "sensirion,sps30";
> > +	reg = <0x69>;
> > +};
>

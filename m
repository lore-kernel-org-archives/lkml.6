Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8C12086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHgt6g/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfBARLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:11:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41087 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBARLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:11:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so5582799lfj.8;
        Fri, 01 Feb 2019 09:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+k3jBZgOiGWsF48btTSWXSYXJ6qIP2mZUeP7Mb1/fuc=;
        b=BHgt6g/4qemIHI4eGucVTMY62de9Da2ZpTfwhHmlZbDrNRUztIxGxlqztqjBWHy7zt
         nGSesxYwDnvPSZ3s8kAoQYB3t6ojl7kKbwUbclBo7Aflfhxq3gS/le4JxliJ4XWjrBj8
         i6muAk2TnS1E9qGbU9xXJz1TWNJW8/TGClJKkK52++AwR3hXUNcSvjQSxFQB090wQFXc
         3UhafhOy240mpXAza1iApWbpyDuuBNgXleVFZZxDIy61O9oZJk9CR54SIV29gB+0TNhr
         DIik5Y/BIOCWElBZJUZuV1eqKhD8+AAl5hf7n6y9RUspce6lVUv9RPWHxhFbEySSRHmF
         FogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+k3jBZgOiGWsF48btTSWXSYXJ6qIP2mZUeP7Mb1/fuc=;
        b=UGZwjF936/ATp4GVOvgIpskkw7fCdEf88GPVDZYk4kZEdb1b3GF8SrgmUVIhe9Yz0Y
         lVyXPkz753AnWqqXReC+QgAW24Fsj68A1gXroK6lg7u94lNWlWxKSRpYUm5oMO/7NVFJ
         H2wc1SYtwwtZunCMIsMW8v3lWuWfat3wsERlcew7vKiDj86K1jDiM9hhFWOcnpFZAmwy
         Vfn5vWTYa0aMbbx74/jC+UPGmgKq+KZUJL72qHWARLotd+2TK5mldlai3eIu7u0L8+G9
         rgMqezbbWV/hN35ZSxYiFSx+D8aK0gzFdeJeDwOvCr/Vz5gnl/p21taTsPdooVOvAh7S
         tluw==
X-Gm-Message-State: AJcUukd5yumfAbrTVT9AsnuIRgnNsuQUM90dJgvtBXerMUI0JxmBjx/k
        lmPHkTPUjHqdrQCGUszy8UU=
X-Google-Smtp-Source: ALg8bN5RU3bHhIwNeAtKl70JvFGVfXKbQ/+wq7pmm7t8cwgMIeWzGatN5KKtlyRQcDFClmfxzprW4w==
X-Received: by 2002:a19:2c44:: with SMTP id s65mr33556653lfs.41.1549041056811;
        Fri, 01 Feb 2019 09:10:56 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id h22sm815570lfc.12.2019.02.01.09.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:10:56 -0800 (PST)
Date:   Fri, 1 Feb 2019 18:10:33 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, jic23@jic23.retrosnub.co.uk
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: chemical: pms7003: add device
 tree support
Message-ID: <20190201171031.GA20304@arch>
References: <20190127181916.19948-1-tduszyns@gmail.com>
 <20190127181916.19948-4-tduszyns@gmail.com>
 <20190128075819.GK3691@localhost>
 <20190128184332.GA25627@arch>
 <20190130091254.GN3691@localhost>
 <20190131204000.GA14750@arch>
 <20190201091231.GZ3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190201091231.GZ3691@localhost>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:12:31AM +0100, Johan Hovold wrote:
> On Thu, Jan 31, 2019 at 09:40:04PM +0100, Tomasz Duszynski wrote:
> > On Wed, Jan 30, 2019 at 10:12:54AM +0100, Johan Hovold wrote:
> > > On Mon, Jan 28, 2019 at 07:43:33PM +0100, Tomasz Duszynski wrote:
> > > > On Mon, Jan 28, 2019 at 08:58:19AM +0100, Johan Hovold wrote:
> > > > > On Sun, Jan 27, 2019 at 07:19:16PM +0100, Tomasz Duszynski wrote:
> > > > > > Add device tree support for Plantower PMS7003 particulate matter sensor.
> > > > > >
> > > > > > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > > > > > ---
> > > > > >  .../iio/chemical/plantower,pms7003.txt        | 19 +++++++++++++++++++
> > > > > >  1 file changed, 19 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > > > > new file mode 100644
> > > > > > index 000000000000..e4c7f2fb1e30
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > > > > @@ -0,0 +1,19 @@
> > > > > > +* Plantower PMS7003 particulate matter sensor
> > > > > > +
> > > > > > +Required properties:
> > > > > > +- compatible: must be "plantower,pms7003"
> > > > > > +
> > > > > > +Optional properties:
> > > > > > +- vcc-supply: phandle to the regulator that provides power to the sensor
> > > > >
> > > > > Shouldn't this one be a required property?
> > > > >
> > > >
> > > > Driver does not use regulator framework hence to me this property fits
> > > > here better.
> > >
> > > The device tree describes hardware, not any particular driver.
> > >
> > > That said, there is a bit of an on-going debate on whether mandatory
> > > supplies (from a hardware perspective) should always be represented in
> > > device tree or not.
> > >
> > > 	https://lore.kernel.org/lkml/20181123133126.GF2089@sirena.org.uk/T/#u
> > >         https://lore.kernel.org/lkml/20180409102244.GB11532@sirena.org.uk/T/#u
> > > 	https://lore.kernel.org/lkml/20180425171123.xhyoay3nu463btoq@rob-hp-laptop/T/#u
> > >
> >
> > Even after going through this threads I am still unconvinced that
> > vcc-supply should be a requirement. Making this a mandatory property
> > would automatically imply using *_regulator_get() in a driver code
> > (on condition one is adding regulator support). In case there
> > isn't any physically connected we end up with a dummy one and a warning.
>
> How would the device work at all without a physical vcc supply?
>

I meant the discrete IC regulator.

> > Is it how this should work?
>
> As Mark mentioned in the threads above, you could add a fixed,
> always-on regulator for cases where the device is always powered.
>
> Boards failing to describe this supply would still work on Linux, but
> would end up with a dummy regulator and a warning.
>

Fair enough.

> > > > > > +- set-gpios: phandle to the GPIO connected to the SET line
> > > > > > +- reset-gpios: phandle to the GPIO connected to the RESET line
> > > > > > +
> > > > > > +Refer to serial/slave-device.txt for generic serial attached device bindings.
> > > > > > +
> > > > > > +Example:
> > > > > > +
> > > > > > +&uart0 {
> > > > > > +	pms7003 {
> > > > >
> > > > > The node name should be generic and reflect the functionality rather
> > > > > than model. Perhaps "pms" will do here.
> > > >
> > > > Agree, ideally we should have a generic dt name for this kind of sensors
> > > > (something like air-pollution-sensor perhaps?). But unfortunately there isn't
> > > > anything available now so I guess compatible part name should be okay
> > > > (besides this is the type of naming commonly used in other iio bindings).
> > >
> > > What's wrong with particulate matter sensor ("pms")?
> > >
> > > Seems like a better fix than any particular model name to me at least.
> > >
> >
> > Personally I would vote for a more descriptive node name, for example:
> > particulate-matter-sensor or air-pollution-sensor or other name
> > which clearly shows what device we are dealing with.
>
> Spelling it out seems preferable, yes. You know the domain better than
> I do; I only suggest you come up with a generic node name.
>
> Johan

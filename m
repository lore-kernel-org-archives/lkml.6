Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445EAECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19A62086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19A62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeGPHcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:32:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:45540 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbeGPHcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:32:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 00:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="asc'?scan'208";a="71692060"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2018 00:05:56 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>, ezequiel@collabora.com
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>, kernel@collabora.com,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: of-simple: reset host controller at suspend/resume
In-Reply-To: <CAFqH_51EvuJmU2rxcndWdyYj6CAhzDv_o6YPnUHJb6ctM+k8VQ@mail.gmail.com>
References: <20180709150844.32505-1-enric.balletbo@collabora.com> <536642654ca55f08877497c86a5cb106d5458384.camel@collabora.com> <d9ea42a39a80c12b9d5730376d2f8e5a953771ef.camel@collabora.com> <CAFqH_51EvuJmU2rxcndWdyYj6CAhzDv_o6YPnUHJb6ctM+k8VQ@mail.gmail.com>
Date:   Mon, 16 Jul 2018 10:02:54 +0300
Message-ID: <87d0vnslwh.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Enric Balletbo Serra <eballetbo@gmail.com> writes:
> Hi,
> Missatge de Ezequiel Garcia <ezequiel@collabora.com> del dia dt., 10
> de jul. 2018 a les 0:10:
>>
>> Sigh, now actually Cc devicetree folks
>>
>> On Mon, 2018-07-09 at 19:04 -0300, Ezequiel Garcia wrote:
>> > (Cc devicetree folks)
>> >
>> > Hi Enric,
>> >
>> > Thanks for the patch.
>> >
>> > On Mon, 2018-07-09 at 17:08 +0200, Enric Balletbo i Serra wrote:
>> > > If we power off the SoC logic rail in S3, we can find that the
>> > > Type-C
>> > > PHY can't initialize correctly after system resume. We need to
>> > > toggle
>> > > the USB3-OTG reset before trying to initialize the PHY, or else it
>> > > times out.
>> > >
>> > >     phy phy-ff800000.phy.9: phy poweron failed --> -110
>> > >     dwc3 fe900000.dwc3: failed to initialize core
>> > >     dwc3: probe of fe900000.dwc3 failed with error -110
>> > >
>> > > Note that the RK3399 TRM suggests that we should keep the whole
>> > > usb3
>> > > controller in reset for the duration of the Type-C PHY
>> > > initialization.
>> > > However, it's hard to assert the reset in the current framework of
>> > > reset. We're still skeptical about that, and we haven't yet found a
>> > > case where this seems to have mattered. This approach is much
>> > > easier,
>> > > it
>> > > simply holds the USB3-OTG reset while device is supended.
>> > >
>> > > The dwc3 core is going to reinitialize the controller at
>> > > suspend/resume
>> > > anyway (including a "soft reset"), so it should be safe to do this.
>> > >
>> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com
>> > > >
>> > > ---
>> > > Dear all,
>> > >
>> > > Now that the usb3-phy otg port support for rk3399 has been merged
>> > > [1]
>> > > we
>> > > found that suspend/resume is broken. The problem is well known for
>> > > ChromeOS kernels, they solved it in a similar way adding a reset
>> > > pulse on
>> > > resume in the specific usb glue layer (dwc3-rockchip). In mainline,
>> > > though, we use the dwc3-of-simple glue layer instead of a specific
>> > > layer
>> > > for rockchip. The patch is based on the Brian Norris work but
>> > > slightly
>> > > different, it holds the reset while device is suspended. It was
>> > > tested
>> > > on a Samsung Chromebook Plus with usbc docking station attached by
>> > > doing
>> > > different suspend/resume cycles and checking no usb devices has
>> > > been
>> > > lost.
>> > >
>> > > I am not sure this is the better way to solve this but I did not
>> > > find
>> > > any other way, and, as I am not sure this can be generic, the reset
>> > > is only
>> > > done on rockchip platforms.
>> > >
>> >
>> > I don't really understand why there are per-platform hacks in glue
>> > drivers, instead of having per-platform glue drivers, or some other
>> > pluggable hooks.
>> >
>> > > Best regards,
>> > >  Enric
>> > >
>> > > [1] bfdca1736ea76345071bbc5607d18928e54909ac ('arm64: dts:
>> > > rockchip:
>> > > add
>> > >     usb3-phy otg-port support for rk3399')
>> > >
>> > >  drivers/usb/dwc3/dwc3-of-simple.c | 21 +++++++++++++++++++++
>> > >  1 file changed, 21 insertions(+)
>> > >
>> > > diff --git a/drivers/usb/dwc3/dwc3-of-simple.c
>> > > b/drivers/usb/dwc3/dwc3-of-simple.c
>> > > index dbeff5e6ad14..1d1ece99ed94 100644
>> > > --- a/drivers/usb/dwc3/dwc3-of-simple.c
>> > > +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>> > > @@ -201,9 +201,30 @@ static int
>> > > dwc3_of_simple_runtime_resume(struct
>> > > device *dev)
>> > >
>> > >     return 0;
>> > >  }
>> > > +
>> > > +static int dwc3_of_simple_suspend(struct device *dev)
>> > > +{
>> > > +   struct dwc3_of_simple *simple =3D dev_get_drvdata(dev);
>> > > +
>> > > +   if (of_device_is_compatible(dev->of_node,
>> > > "rockchip,rk3399-
>> > > dwc3"))
>> > >
>> >
>> > Instead of calling of_device_is_compatible in each suspend/resume,
>> > which seems quite expensive, how about having a per-device boolean
>> > 'needs_reset' or something like that?
>> >
> Yep, not sure how much, but probably use a boolean will be faster. I
> am also wondering if we can remove the of_device_is_compatible call
> and do the reset on all platforms. This will need lots of tests on
> different platforms, of course. i'd like to hear maintainers feedback
> here.

ideally, the reset would be unconditional, but in practice, probably
it's handled differently by different implementations.

I'd be fine with a single of_device_is_compatible() call during probe to
set a driver flag. Another possibility would be to use the data field of
of_device_id to pass that flag.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltMQx4ACgkQzL64meEa
mQZNoQ/9HqRisCYieeLPQQqghb8/BHZweLozYv+K7D39p5n5+FNFv72lW3NAZWji
sfhmXYOnKlM6HI30b8NC0zb7SioefRhjTxP2sIUg4mYIWnyStHH4Ot46pdsQ4SAm
7Fd+YalmYh4xaUcJkSFbhY3FyGd1DCTzSti03ndG2vrG5Og9iotb6Ono3eBUIBdu
cQKRaSyWwneHtrQEyvAQtX1eqyJHsFdt5VTt6ZfhZ6+BF1x4TedUgqGwz60aiyIO
w1JfOlARvsK1h4/eBQMmDmEj6QcCwhj6urNKImP557sDeJVTng4zg3iKgmUtFsX5
A4bLG6ZE0Lb73q6MRBZVKi5Lsc6mqIKxe0Q5rron/WljLjB/sqA3hC54fg4xcyY3
YypEDs5/FdY4MdIrprFDSAAaijjBv7LFNk39l5MgvF8Nn/pvbFwsmfpZt6MlwQG9
MVGLMiZRwSB+Z8+IP4WL6Vg3h+VnDqL0MkuGgZPyBqFpjwOLUfHpuEY4pDemeqso
fHxSLISpW6zwYbnnXY5Chf7H/v/1E/AhXNZUUYHNVWegolzvCeIPi5ZWGKPFgB1x
juCc9NkKhAGxmgixLbbpkCK/wxr+lDHAHXa8msPX00t7j1YfBbcFuUv7zrDbZBP/
JutuYphkY0qrsUuDBE5KWi7UUWYSj6OyKBVEjkdsYfrYWjre9ls=
=EHHp
-----END PGP SIGNATURE-----
--=-=-=--

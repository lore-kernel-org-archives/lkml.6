Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45647C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBA520862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVw21bB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBA520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbeKHEJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:09:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbeKHEJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:09:09 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BEFE20818;
        Wed,  7 Nov 2018 18:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541615852;
        bh=eu6uLDaEC4qHMh7z0ygUHSxPL7rvOUOusfO7PYlR++Y=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=WVw21bB6lt9iwhAFJAxfI0GcGgf7+Wrss69BrFaiFiyjEom66qUcR4KL2XRLOK8z+
         Paei2X3S/DNtr4uE2GOwIqtLlXKzgI4/QrWnC4z0TdVXSozHeN8ylLHJAQSzIKjd0L
         noH1LH4Ug5zl6ml5esdAVlLBqZdrfxUexZaF5UbM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Frank Rowand <frowand.list@gmail.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
Message-ID: <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
Date:   Wed, 07 Nov 2018 10:37:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2018-11-06 12:44:52)
> On Tue, Nov 6, 2018 at 12:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > We have a handful of clk drivers that have a collection of slightly
> > variant device support keyed off of the compatible string. In each of
> > these drivers, we demux the variant and then call the "real" probe
> > function based on whatever is stored in the match data for that
> > compatible string. Let's generalize this function so that it can be
> > re-used as the platform_driver probe function directly.
> =

> This looks really hacky to me. It sounds kind of general, but really
> only works if we have match data that's a single function and we lose
> any type checking on the function.

I don't know what this means. Are you saying that we lose the ability to
type check the function pointer stored in the data member? I don't have
a good answer for this besides it's not any worse than the status quo
for the mediatek drivers.

One alternative is to add a DT only array to the platform_driver struct
that has the platform driver probe function type and matches the index
in the of_device_id table. Then we can add some logic into
platform_drv_probe() to look for this table being set and find the probe
function to call. Then we still have match data for anything that wants
that (maybe it could be passed in to the probe function) at the cost of
having another array. I don't have a use-case for this right now so I'm
not sure this is a great idea.

  struct of_platform_driver_probe_func {
  	int (*probe)(struct platform_device *pdev);
  };

  struct of_platform_driver_probe_func mtk_probes[] =3D {
  	mtk_probe1,
	mtk_probe2,
	mtk_probe3,
  };

  struct platform_driver mtk_driver =3D {
  	.of_probes =3D &mtk_probes;
  	.driver =3D {
		.name =3D "mtk-foo";
		.of_match_table =3D mtk_match_table,
	},
  };

> What about things other than
> platform devices?
> =


I suppose those would need similar functions that take the right struct
type and match the driver probe function signature. To make the above
more generic we could try to figure out a way to put the 'of_probes'
array inside struct device_driver. That would require dropping
platform_device specifically from the probe functions and having those
take a plain 'struct device' that those probe functions turn into the
appropriate structure with to_platform_device() or to_i2c_client()?

So the example would become

  struct of_driver_probe_func {
  	int (*probe)(struct device *dev);
  };

  struct of_driver_probe_func mtk_probes[] =3D {
  	mtk_probe1,
	mtk_probe2,
	mtk_probe3,
  };

  struct platform_driver mtk_driver =3D {
  	.driver =3D {
		.name =3D "mtk-foo";
		.of_match_table =3D mtk_match_table,
		.of_probes =3D &mtk_probes;
	},
  };

And the probe functions might need to container_of() the device pointer
to get the struct they know they need. The probe function could also be
added to of_device_id and then we would have to look and see if that
pointer is populated when the device is matched in generic device code.


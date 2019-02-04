Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440F3C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB10214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG2/KFiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfBDISf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:18:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35419 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfBDISe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:18:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so12402717wmt.0;
        Mon, 04 Feb 2019 00:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/5yowHnwrS7SSvciGAh6vaPgBN44GHjnSI4oIIcs/tw=;
        b=RG2/KFizD0lOiDXSwXRdRa9tqGjIFlVK+W5jTLafk2PyKRttBHqDGoI3PHVF3Z+lZb
         48dTww0SAoEKRKNMbJnZzZUWTouSlEXGG/pbvZt5a+ju15IBiy1SEvQDAN6/Hj+3mUX2
         qcZp7GAAe3fZ9KdPXjtFlb0vp26me82Z4aDsLiTUqAQnndstGva4IfqqSW7p09IgtJSx
         8X81u63H4pI8JAsJdZmvdWWW6E+5melFREHjAhtYIwTKjOuOO4b220YRmBAbI6GhYmZI
         ICSchRzpTEtUT2XAwkGydWT2ksm9xQyX1DDP4eZU7uXuOW2/TX0nP9fFpTAR6XAJ8Eer
         qi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5yowHnwrS7SSvciGAh6vaPgBN44GHjnSI4oIIcs/tw=;
        b=YlWYhIKgBO1o78EHUU88XaNkIh2dgyk+Q6i7H6qGjF5dIBhtO6S+3JE8iV99ryGTWK
         5h79GleBuyCZz52UGAwzw+ClfB25+00PFbuDxKdp4CV2VXaBXANFZZlJ4vnKH3XYAJnq
         08F4dxHYmoXlfXFw/8mR4RyB5GCpez+uSdDD4woz+4COmHvBSllM9kS0sAt6PuxIGUgh
         AO45tdqvehpGqTYmjK9CAfxPTyUkzgt7pK/G6aBXGANyqH44bPg7zN0avXA7H9hvOThT
         0PduI0VRtg5P8Cvr1up3MopkZynKXABa00CPh4WQJOzP4JU4bc0sb0lnWZ3xi89tvFnR
         yx0Q==
X-Gm-Message-State: AHQUAuZdke9sXXToVMMF1NWU0sfvkPGqSJGAvRr8h2x5QIdQxgntXsIb
        2+oFo6NMJJSHECS4yG+fJXk=
X-Google-Smtp-Source: AHgI3Ib/M9Dm+XV5hk8OJvDYvRJRdGIp2gz7n1peAjFZb7zQV29hHz+jtkM0onktWKx8xK+uVXeviA==
X-Received: by 2002:a1c:2d08:: with SMTP id t8mr12759751wmt.5.1549268311314;
        Mon, 04 Feb 2019 00:18:31 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t4sm12971321wrb.64.2019.02.04.00.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 00:18:30 -0800 (PST)
Date:   Mon, 4 Feb 2019 09:18:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
Message-ID: <20190204081829.GC19087@ulmo>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <d37e901b-1c26-3d9c-7f68-29e06f4ff993@gmail.com>
 <BYAPR12MB33982BC5A58A000A0CB84F6AC2930@BYAPR12MB3398.namprd12.prod.outlook.com>
 <a5e79739-3ce5-6c22-c9d2-e9d2c709cb30@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <a5e79739-3ce5-6c22-c9d2-e9d2c709cb30@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2019 at 07:48:09PM +0300, Dmitry Osipenko wrote:
> 02.02.2019 21:32, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> This patch adds DMA support for Tegra I2C.
> >>>
> >>> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for=20
> >>> transfer size of the max FIFO depth and DMA mode is used for transfer=
=20
> >>> size higher than max FIFO depth to save CPU overhead.
> >>>
> >>> PIO mode needs full intervention of CPU to fill or empty FIFO's and=
=20
> >>> also need to service multiple data requests interrupt for the same=20
> >>> transaction. This adds delay between data bytes of the same transfer=
=20
> >>> when CPU is fully loaded and some slave devices has internal timeout=
=20
> >>> for no bus activity and stops transaction to avoid bus hang. DMA mode=
=20
> >>> is helpful in such cases.
> >>>
> >>> DMA mode is also helpful for Large transfers during downloading or=20
> >>> uploading FW over I2C to some external devices.
> >>>
> >>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> >>> ---
> >>
> >>
> >>> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev) {
> >>> +	struct dma_chan *dma_chan;
> >>> +	u32 *dma_buf;
> >>> +	dma_addr_t dma_phys;
> >>> +	int err =3D 0;
> >>> +
> >>> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
> >>> +		return -ENODEV;
> >>
> >> Another detail is that we need to keep older kernels working on
> >> T186+ after its device-tree will get the "dmas" property,
> >> device-tree changes shall be backwards-compatible with older
> >> kernels. Hence we need to check that platform actually wants the
> >> APB DMA driver, otherwise T186+ will be failing with -EPROBE_DEFER.
> >=20
> > Yes, that will be a separate patch later for adding DMA support for
> > Tegra186 and later chips once we check on GPCDMA upstream
> >=20
> >=20
>=20
> Sure, and there is a requirement in upstream to keep older kernel
> versions working with the later device-tree updates, as I pointed
> above. Please include the ".has_apb_dma checking" that I'm suggesting
> into the next version.

I don't think that's true. The requirement is for the device-tree ABI to
remain stable, but that technically only requires that kernel updates do
not require a DTB update.

The assumption on which this is based is that the DTB may be shipping in
read-only storage, like it used to fairly commonly in the distant past.

Conversely, if you update the DTB the assumption is that you can also
update the kernel, so the compatibility doesn't need to go that way.

That said, I think what you're proposing here makes sense and is pretty
trivial, so might as well add it at this time.

Thierry

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX9VMACgkQ3SOs138+
s6G1ag//exFZIaKJSO0vB5wrW6HZ1CA2EbV9qoMEo+Z/8qGXeXsiHRF3hP78kkn4
hMW0fo8AkBZ4oKvX0F8imDjKYt3qIFp1eRZtZn1IhYFLc6S6E6sr8kHhNybEdIS+
GYTM3A/NuuEqwy+iexT1iQC87+hPTwqZD6ReKFaspI4sFupm28a1qj1RrGpD2fW9
qi2gnehglSzfps2tckWzYlRzH2S7EtEuwfq1hp0ROwn6kLx8UXGMCtEG5w4FYoGY
igp2RTANj/6Y1kPgpyEHaDD5XP2iOzYS6lsBbEKynNHLbIN6MKsDHo7+fTqU5758
botJhulhlj/xuMpb3INjVI/PiyJozWb+/8Wx3Y/f7BFkHFQMn8JYdn7RoJZv7c7x
crSkZnDgZ4ss/WOQzUpEg0NBa451gstRfPhHyXHmuDRHvZ8UezgzE7xv1CvmwUdj
77OgywBwtb8qhLJG2AeTLNs/wOKNZs/gvF8EbECY/YyoNywvSko1cfdesZHlruNZ
9x1bHoyjI5qWhLAscejjZt/6IojXNDH/gY8XBf+iFUegt0eU9uI2g+gH/0JWWz4n
GekHaK0ptUW06irdRuE+XrU6VxrtKUE+OwFoNC9GMuarPvAVeOhfwK5mrBY3TwL5
aXCw8h00zYiwlb7tbBXT/kQrcnWPE1/ofb5mARcUPOByJwu4/GI=
=jv1E
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452CAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1606B20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1606B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLCNtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:49:18 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:57501 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:49:18 -0500
Received: from w540 (conf.hotelmediterraneo.com [2.228.78.71])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E9C7B20000B;
        Mon,  3 Dec 2018 13:48:08 +0000 (UTC)
Date:   Mon, 3 Dec 2018 14:48:00 +0100
From:   jacopo mondi <jacopo@jmondi.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] media: v4l2-subdev: stub
 v4l2_subdev_get_try_format() =?ISO-8859-1?Q?=1B=1B?=
Message-ID: <20181203134800.GA2901@w540>
References: <20181128171918.160643-1-lkundrak@v3.sk>
 <20181128171918.160643-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20181128171918.160643-2-lkundrak@v3.sk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Lubomir,

  thanks for the patches

On Wed, Nov 28, 2018 at 06:19:13PM +0100, Lubomir Rintel wrote:
> Provide a dummy implementation when configured without
> CONFIG_VIDEO_V4L2_SUBDEV_API to avoid ifdef dance in the drivers that can
> be built either with or without the option.
>
> Suggested-by: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  include/media/v4l2-subdev.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index 9102d6ca566e..906e28011bb4 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -967,6 +967,17 @@ static inline struct v4l2_rect
>  		pad = 0;
>  	return &cfg[pad].try_compose;
>  }
> +
> +#else /* !defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
> +
> +static inline struct v4l2_mbus_framefmt
> +*v4l2_subdev_get_try_format(struct v4l2_subdev *sd,
> +			    struct v4l2_subdev_pad_config *cfg,
> +			    unsigned int pad)
> +{
> +	return ERR_PTR(-ENOTTY);
> +}
> +
>  #endif

While at there, what about doing the same for get_try_crop and
get_try_compose? At lease provide stubs, I let you figure out if
you're willing to fix callers too, it seems there are quite a few of
them though

$ git grep v4l2_subdev_get_try* drivers/media/ | grep -v '_format' | wc -l
44

>
>  extern const struct v4l2_file_operations v4l2_subdev_fops;
> --
> 2.19.1
>

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJcBTQGAAoJEHI0Bo8WoVY8Y+UP+wbrOpdeFYGcvJXJSq/F0Y97
WUFCeBY83lZ8hHSbNYJAx12s/RVl9uP8hI6MUDQWgsa/21rtQ4IUkzeXTkVYKRJ4
vJPwdQw6iIWeJEzunuWBv1AlhXaf2xncEti1Ne4mnezL/aCsIZbRnZQ5QkGQlfyf
WwqR9A/Y8H8d5hKjAB8Z0H4XNUMKby7tpWGMODN2h67te6DlLBvwCciKA7z7f2oo
Yn1sTlLhSctfqXfUo1LCvFqntcNu9L3Tsmm7WksuSevwWaeMUFJd3Qea3OvZ28Db
fXq2C+cy3WUAL4MUKZOruo+B9KV4znucaWI4ldoIZ/Xhp8e4SyRQ+ZoUBbZFv5MD
2pyGxA8W0Dlh/FJaAWWUDzr5PdMLLDnfmWdKrjIzQ1KA/45t+oa/uKxJQCN0rSuN
0qgwt7imAcnSWo73ZJh9XX3BvySfUnXV2WdKDKXQuMI5CMpsaLuX0vmsMM8tzOjO
qCQe3MDcNjeS/6oIQSyGPvIoYQfsneSNF6NjI6RSdUvYd217OHEMmKoLicHOReAG
Hk5XwUQER6KQYnxLHuW7IQI9VMRnifijzzuwoiQNr8PaPfV8BZXdbtqdbYilEasa
F/4mryPghCk696q0RK8AVzES7UTpujCVvp4ADBWR8QVb1SFseLTzfMHgt+oKERZ+
VqG1az7jFgvX+YPpsBqb
=FEFJ
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

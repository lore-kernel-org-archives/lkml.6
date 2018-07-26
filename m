Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C1EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEDB20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEDB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbeGZM1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:27:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:56332 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbeGZM1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:27:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 04:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="asc'?scan'208";a="248536824"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2018 04:11:26 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Xidong Wang <wangxidong_97@163.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vincent Pelletier <plr.vincent@gmail.com>
Cc:     wangxidong_97@163.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb:gadget:function:fix memory leak
In-Reply-To: <1532344186-30505-1-git-send-email-wangxidong_97@163.com>
References: <1532344186-30505-1-git-send-email-wangxidong_97@163.com>
Date:   Thu, 26 Jul 2018 14:08:09 +0300
Message-ID: <87fu061ch2.fsf@linux.intel.com>
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


hi,

Xidong Wang <wangxidong_97@163.com> writes:
> In function f_audio_set_alt(), the memory allocated by
> usb_ep_alloc_request() is not released on the error path
> that req->buf, which holds the return value of kzalloc(),
> is NULL. This will result in a memory leak bug.
>
> Signed-off-by: Xidong Wang <wangxidong_97@163.com>
> ---
>  drivers/usb/gadget/function/f_uac1_legacy.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/ga=
dget/function/f_uac1_legacy.c
> index 24c086b..2fcdade 100644
> --- a/drivers/usb/gadget/function/f_uac1_legacy.c
> +++ b/drivers/usb/gadget/function/f_uac1_legacy.c
> @@ -630,8 +630,11 @@ static int f_audio_set_alt(struct usb_function *f, u=
nsigned intf, unsigned alt)
>  							ERROR(cdev,
>  							"%s queue req: %d\n",
>  							out_ep->name, err);
> -					} else
> +					} else {
> +						usb_ep_free_request(
> +							out_ep, req);
>  						err =3D -ENOMEM;
> +					}

I feel like this hunk has been ping ponging between having
usb_ep_free_request() and not having it because completion callback will
call usb_ep_free_request() or something along those lines.

Can we get a final solution that solves all cases and doesn't introduce
other bugs?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltZq5kACgkQzL64meEa
mQbMPQ/+JMoKRBXYMh8ZQdgYRUkYM47HJzhCxgg6cOkGTLLmv73INF7e3m38kK5C
bE9/LJLHzLZtuJs2mG2WbPHWEVQC1JXjTwm9frroz+XwNk1Jm1ZbN+d2Hio6TZQd
GA0mkoavUnfdO+MQipG394KNnb4qdbRgfyY/eGRJm+Pqf0OzFcXKR0wZSyEzWpmU
Zb18eRIr+TeD1R3O0JrXtrl2iGds7Ue9EdCVtj90Yu/Lsx/SMb+tmp8wL6235Vvs
I74quqH2YqU8KKxRZW0Mc5F7r1WNjxMOEjNN1OKL/LikdL0RzhaJE4lmqmezQBp2
xiOceBJPzGVqLB8X9svPVX02UZocimr92/fIB9FTjN/cmkg3IiyMz0GqNSODtufF
89iENMIk9bCuuxTOM/zERbvYDA0m0UEV/QhjZxVCSOn/BaRAf4IsIUEVyzUNhq0V
f6f7Yw4aLjXa0m+2HG5Bcu1rH18JH1WMgHi1ltLUYucnWXvM3W5sOztKXMhouDRm
wax2HMdMmVxQeawNES0+KTMBbwtntmmD8GgLSK7w4gg/ciQxWTC4c83N21taPP8Q
CWlKcXefuwT1HTErT83l6O/uhriNGjoym0xutO49F4ilBu/TtX/AR1xBkkVNagg6
lXxjKatFDpdsVXKfJOyNCro6kKxzqaBop45z6YpFbz3hLcUq4iE=
=DHiW
-----END PGP SIGNATURE-----
--=-=-=--

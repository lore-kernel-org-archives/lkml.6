Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D72C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218852080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544786641;
	bh=80hzkteHQDRw8gcNklsCyGzNwTw5t6gq6qtqZj42q3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=JbJgU5ODjeCeA9ObKBkQrSTPH8NkcvK3Qzl/XvdVKwjVoA++DZCK9jMf0TrNs+K+O
	 niGDeFIMvwqhHwswWFY9cRxGJZLZlZMNoHSrkOVpobmxSotjya7wx2tH2G7Kz62R+p
	 eQxQeVlwkzNsLmTZB7c50CG+/4ZOCcNZ2CoFI3Ls=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218852080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeLNLX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:23:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:61428 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbeLNLX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:23:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 03:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="asc'?scan'208";a="125901293"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2018 03:23:57 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     "Zengtao \(B\)" <prime.zeng@hisilicon.com>
Cc:     liangshengjun <liangshengjun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>
Subject: RE: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by IRQ latency
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED24E20BE5@dggemm526-mbx.china.huawei.com>
References: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com> <87efaklcd1.fsf@linux.intel.com> <678F3D1BB717D949B966B68EAEB446ED24E20BE5@dggemm526-mbx.china.huawei.com>
Date:   Fri, 14 Dec 2018 13:23:52 +0200
Message-ID: <878t0sl5br.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

"Zengtao (B)" <prime.zeng@hisilicon.com> writes:
>>-----Original Message-----
>>From: Felipe Balbi [mailto:balbi@kernel.org]
>>Sent: Friday, December 14, 2018 4:52 PM
>>To: Zengtao (B) <prime.zeng@hisilicon.com>
>>Cc: liangshengjun <liangshengjun@hisilicon.com>; Zengtao (B)
>><prime.zeng@hisilicon.com>; Greg Kroah-Hartman
>><gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org;
>>linux-kernel@vger.kernel.org
>>Subject: Re: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
>>IRQ latency
>>
>>* PGP Signed by an unknown key
>>
>>Zeng Tao <prime.zeng@hisilicon.com> writes:
>>
>>> If it's a busy system, some times when we start an isoc transfer, the
>>> framenumber get from the event buffer may be already elasped, in this
>>> case, we will get all the packets dropped due to miss isoc. And we
>>> turn into transfer nothing, to fix this issue, we need to fix the
>>> framenumber to make sure that it's not out of date.
>>>
>>> Signed-off-by: Liang Shengjun <liangshengjun@hisilicon.com>
>>> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
>>
>>There's a patch going upstream already doing this:
>>
>>https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/?h
>>=3Dnext&id=3Dd53701067f048b8b11635e964b6d3bd9a248c622
>>
>
> Sorry, I think I missed to update to the latest version. But I think my=20
> patch is more efficient. Because I just sync the frame from the HW, it
>  won't fail and there is no need to extra tries.
>
> What do you think about it?

the 14 bits you use for your check is not representative of the actual
micro-frame you're currently in. Thinh explained that in the discussion
we had until we came to the patch I pointed you to above. Please look at
the mailing list archives for details.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwTksgACgkQzL64meEa
mQZJng//XfRK6HOJ2tT9+GNmNvtyo8h1BNhMhEZvXkn4WTvU2ecqq3GLOphr9Fts
ux0T2be5pbjJ0xdBCbiMjL9XKDs3BxKTP5kzfjDikGFeZyjwPDqjlOC2HGgiJt40
GXorTFOBfEsGSP9nVNYL1OFPYsTTwZSYypmo5FpRNpq4Ey9izfUvu/NYN1y6l5RA
MH6gOdasaMZL98mETXNP8hK4m3pjz5RbcBUJW9uDlw53XjWlQ3L1lbaFCsT8f0lY
GCDVVUNYoRr4vxrsZ1WkaHa7BcU4ONLnWhK1S5s0CtMv77nXlzzy6nQ2IOEfZJEJ
VQYVBbst02PTQPlACB32Knt367ajrH+Xh0k4vCRvJ6SxgAwMzjwq1QgUGg9hV881
zj9ZNESbNC/+KGIK83w1uKoUZ6S4MELD1tbyD6wTtIOUHJZ5KSUqvk2b0DAqiiqw
RWr+UVj54J5mx+viwICw1MJvQS489oh39uLznB+ODXSXkFBQZDXrt/ZTkd7+XKyp
zzDbJIyFLCJtSnP1xg8FrHTu99dbQtHwi33xLryP0V5OmbRzkvG7Xsl+zLiRQsuJ
gdd2rmy07gAkeN+Qnfa7HE/RSYt1/OD2DBB1OIegBsIgOd2fe34WhfSxov333906
ZfhEjwk7KKchpwIfKvdj66WIJzPF5jhic/jAW4Vr9pKvvFOyeSA=
=Sr1X
-----END PGP SIGNATURE-----
--=-=-=--

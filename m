Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB6C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880A8218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfBGK6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:58:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:5921 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfBGK6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:58:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 02:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,343,1544515200"; 
   d="asc'?scan'208";a="132264301"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga002.jf.intel.com with ESMTP; 07 Feb 2019 02:58:30 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Use ffs() to find page size in xhci_mem_init()
In-Reply-To: <74208350-eba5-c299-376e-9df194fe71b5@intel.com>
References: <20190207000349.7816-1-andrew.smirnov@gmail.com> <1ecb0604-3e27-810e-9fae-18d9d1bf7ff9@linux.intel.com> <87mun8klxj.fsf@linux.intel.com> <74208350-eba5-c299-376e-9df194fe71b5@intel.com>
Date:   Thu, 07 Feb 2019 12:58:26 +0200
Message-ID: <87k1iblval.fsf@linux.intel.com>
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

Mathias Nyman <mathias.nyman@intel.com> writes:
>>>> Get page size order using ffs() instead of open coding it with a loop.
>>>>
>>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>>> Cc: Mathias Nyman <mathias.nyman@intel.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: linux-usb@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>>>    drivers/usb/host/xhci-mem.c | 6 +-----
>>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>>>> index 36a3eb8849f1..44b43c3d819f 100644
>>>> --- a/drivers/usb/host/xhci-mem.c
>>>> +++ b/drivers/usb/host/xhci-mem.c
>>>> @@ -2362,11 +2362,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t =
flags)
>>>>    	page_size =3D readl(&xhci->op_regs->page_size);
>>>>    	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>>>>    			"Supported page size register =3D 0x%x", page_size);
>>>> -	for (i =3D 0; i < 16; i++) {
>>>> -		if ((0x1 & page_size) !=3D 0)
>>>> -			break;
>>>> -		page_size =3D page_size >> 1;
>>>> -	}
>>>> +	i =3D ffs(page_size);
>>>>    	if (i < 16)
>>>>    		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>>>>    			"Supported page size of %iK", (1 << (i+12)) / 1024);
>>>
>>> Hi
>>>
>>> using ffs() is a welcome change, but it will give different a result th=
an the loop.
>>>
>>> *old loop
>>>     valid page_size value if i < 16
>>> *ffs()
>>>     valid page_size value if i >=3D 1 and i < 17
>>=20
>> off-by-one, just use i =3D ffs() - 1. Or use __ffs().
>
> and handle the page_size =3D=3D 0 case.

Can it be zero in real life, or are you protecting against academic
possibility that's never going to happen in HW?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxcD1IACgkQzL64meEa
mQY2KhAA1y4TsANVaNWuPVkIMk9b0q38i04ae6yOvGaMiozJ08hXh7rNEe2ZII3B
YsEU9ML2pN820ROhA0KELrSV7/fgrJvvYbdpc7LrDjTSInYyUAQLP001GizFmnzI
Z7XX1m3gevH5eZXkla9nYuuwbTVxIqGxb24BlUMpE2NqGDOC+p7hHpxAZuEa3Z2/
12jJVXyQIVoHiJ0Mltd9utujQTFNfGTKlvIlr3g2yY8nfPfpzfLnAUcBXkSQ8uDp
yjkWmp6AVMgoSASE7lHifEZq0J6Srosa12La8gvFlxVJ0N1NFlQD3ANg/yjZehqj
tUPnfgEql/CcU565iUVf+ZhP7+o/aWs9rU0BbekjFekbxZy4clVqKyvl17sT9CEY
yVNaVDyRqyv0j3ffhYPnNi0YWetRmH9221fGEL74BPW5qEZVFOGt8EDyHN7Wup79
hNoh+IICU3Vqmw00lS/9Ldu2VGoaNrV1lYR3kNgigz5GljmgBhKDXIc64Rf8oGw6
o6Wdk4zJFz4pVcqK4xEyFDzTMeFYSG2AcjGlSv1NgI/HNfH48pOFYvP+74xRKDT1
JJwe9Nwgk7UuI8W/fgcJXjNKRoZao83euWu7sVJgm1+K3Jjp7E4n7RA7cJJ25+s6
iVMVu8EsXKYV+iN7UsUFblRwQd8n8Yd5P1B2+VVpJGql/dBcKtI=
=GWc2
-----END PGP SIGNATURE-----
--=-=-=--

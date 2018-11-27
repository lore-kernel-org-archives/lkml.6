Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0121C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F0A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F0A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbeK0T5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:57:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:6929 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeK0T5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:57:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 00:59:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="asc'?scan'208";a="103728713"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.97])
  by orsmga003.jf.intel.com with ESMTP; 27 Nov 2018 00:59:47 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        vigneshr@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        "linux-stable # \= v4 . 13" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during suspend/resume
In-Reply-To: <ca6e775c-98ce-abab-56e1-e40e673dd111@linaro.org>
References: <1515667087-4110-1-git-send-email-rogerq@ti.com> <ee73347b-e996-4052-6a9d-dd94edd4a61a@ti.com> <606dbc68-2014-8590-ce47-83c175d4cd41@linaro.org> <87efbm92zi.fsf@linux.intel.com> <027608c0-8d2d-42ab-5125-76b86f286d2b@linaro.org> <08ebcaea-45c4-d277-9585-97045960e83a@linaro.org> <ca6e775c-98ce-abab-56e1-e40e673dd111@linaro.org>
Date:   Tue, 27 Nov 2018 10:59:43 +0200
Message-ID: <8736rm28w0.fsf@linux.intel.com>
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

Todor Tomov <todor.tomov@linaro.org> writes:
>>>>> After I apply this patch on 4.14 (or receive it with 4.14.70) I see a=
 regression with
>>>>> the Qualcomm QUSB2 phy driver. I'm testing on a Dragonboard 820c.
>>>>> In boot log I get:
>>>>>
>>>>> [    4.525502] phy phy-7412000.phy.6: QUSB2PHY pll lock failed: statu=
s reg =3D 0
>>>>> [    4.529232] phy phy-7412000.phy.6: phy init failed --> -16
>>>>> [    4.536170] dwc3 7600000.dwc3: failed to initialize core
>>>>> [    4.541743] dwc3: probe of 7600000.dwc3 failed with error -16
>>>>> [    4.549979] phy phy-7411000.phy.5: QUSB2PHY pll lock failed: statu=
s reg =3D 0
>>>>> [    4.552843] phy phy-7411000.phy.5: phy init failed --> -16
>>>>> [    4.559606] dwc3 6a00000.dwc3: failed to initialize core
>>>>> [    4.565181] dwc3: probe of 6a00000.dwc3 failed with error -16
>>>>>
>>>>> I can provide a full log if needed.
>>>>
>>>> please do. Also, try mainline and let us know if the problem
>>>
>>> This is the full log on 4.14.69 + this patch: https://paste.ubuntu.com/=
p/N5WdHw47QC/
>>> I also managed to get a log from 4.20.0-rc2 and I see the same error: h=
ttps://paste.udwc3_phy_setupbuntu.com/p/jz6fvYyZh6/
>>>
>>>> persists. Why do you get -EBUSY from the PHY driver?
>>>
>>> Maybe I could have proposed a fix if I knew but I don't know.
>>=20
>> I have done some debugging but I still cannot understand it completely.
>>=20
>> What I see is that if the PHY interface is configured first (dwc3_phy_se=
tup)
>> then the PHY init (qusb2_phy_init called by dwc3_core_soft_reset) fails
>> with "pll lock failed". If we move dwc3_phy_setup after dwc3_core_soft_r=
eset
>> as it was before this patch, it works.
>
> I have found that during dwc3_phy_setup the PHY interface is configured
> to suspend and this is what breaks the QUSB2 PHY initialization.
> It seems that it can be fixed by adding the "snps,dis_u2_susphy_quirk"
> quirk in device tree. If this approach proves correct, I'll send the
> patch upstream.

That's the correct way, yes.

Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlv9B38ACgkQzL64meEa
mQZ2Kg//Yg4i56ErNjasoC1tMlC6NbN3ayIcVEfW9u7oAoOZWxrdt68Rag7sc55c
+VfQxrTaSyfqvlU1C/3A3EnWWUmZHxOM1FGzPFRtg6qiyE3cyx/ran28HdZW95v/
q1Ct0ak9UZUTdao2OeBKPRY/vKSvolkQOJ65SXXVYExhNIxMEODLQsMkmQEPq5qh
KwKZrLgh4CoSg0TyyBMbLC+UCV+O8dry3IDAYa+gEu9NVDlnF4eIsxcIiaW4dM6q
GDg77Vvejc7M01UoHKR6s5QAP6hfGu3ye7C0+0J9hwp7AYJDhqc+1D8A5VcfrqiH
BCJMGyYdtsEhKfPEgQCnIWObGO/TQ9W7XT+Ge9AWRs7KhdhDB8mMF2t7V8tvvVmL
ypAKKVkoW5gPMADZn0Cis8lQvqqt3z2Oas3avhslJw/8JI8maMOBLNrUA1KVdszk
8ypdj8pgqyZeXKXCJRiIrgBSEUUrY33eUqKSNS12LGye8h9TKoF01z9ffBAR6FVF
nlgS0Y+A7JIqY6+be8gF1kzGrTDwVJrTmrfqY2QdGMhz/xvfZxLfU/mr7RhlxJ4b
R2PQK8I+ApM0zbhHJzqH3VHaa9/PcOmVo5Z1T1R/hVuXYCuyGf44lErbiWN8K3aj
U1hlb/cJUlxkVgA7MtZUhMJx4WwgoBk+S1A0Qx6fv/FgMf4qCzw=
=08IU
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D5DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0572075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohUHFAYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0572075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeKSDdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:33:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40010 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeKSDdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:33:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so20401736wrt.7;
        Sun, 18 Nov 2018 09:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=2BD3/j8J2JXNFkqU5V15pU3i6cW+TibHL6sS29BDPZM=;
        b=ohUHFAYs5vJqdQ+WQtV0wsktVdOYZGf1c8Zvp5Vsx4PtTz6nTZsuxneyZJtIS1QQ4T
         vMqKzNC80ZTQuDbJoxgBQF6VCYiHST4afWQNT1VHwMhBnQABGHUpQ0KRF/7tNqIdRpiU
         yo6FVUED2+vnIyJB5ohB5RxGu70Q9LxtNQnLtE24f1z66eMgeOLKbaPrF3B72dMfhOsa
         gK8HqM0AtzqYj4Hvd18tKehoHVpH5f56zsk7NqrS3nc72GIWrpUsdQwiskCX9SfQgYOH
         9LIIKIJ+V3bXj2lrD3qvOfgkldnZP90eYyAtW5avOB2t32zKJRfWu9tv9xSyWZ0x/7NP
         xK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=2BD3/j8J2JXNFkqU5V15pU3i6cW+TibHL6sS29BDPZM=;
        b=lgTVWJ5ZEi3LUwNz4vVKx58OvkpuM/BM1mv/OtqowIQhxpiQ/3afKrJ3g/tc9k3ZNS
         N4o+XfmSAKn3Hpq43VMB6y/ojDe3riIexSoDSqYwWPRVDCrPg6M+DQvi50Un5NNIAL7c
         8b/zbOWZBXf7Ej3ubLaLKUffPEoqqmlEqtAq6lVIBws5UAvhwJDrK9tajqVsyYdkRqEH
         iej2cqn8d/4VIQpPyB7kmSsmTUemLaI+XC4BkhIrxaBUQjjVQUYRK+lv9FA6w49mSs3A
         IkfkhpIwWLfYzXnMAuVmcUp4EG7qh1Xfit6HxOhD04jiKKPgMaOW9U/f8m5uSHg8YpjX
         rRJg==
X-Gm-Message-State: AGRZ1gI0FhapEerx6FR9HYW14Fda/j2J3Dgii5Ss4UVNxo8Cv0j6PcHL
        mrpll1kuph5FelNkNrQkCK4=
X-Google-Smtp-Source: AJdET5c1jGhI0ABkrcuOwMiLm2o0kbLgPmKfSdOxo3pzRqMwWaKKWbmwxfAtFjxPuaaE1IboHgbxlg==
X-Received: by 2002:adf:fb47:: with SMTP id c7-v6mr15260855wrs.200.1542561137888;
        Sun, 18 Nov 2018 09:12:17 -0800 (PST)
Received: from linux-gy6r.site ([93.176.147.153])
        by smtp.gmail.com with ESMTPSA id q2sm15763171wru.56.2018.11.18.09.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 09:12:17 -0800 (PST)
Subject: Re: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
To:     Rob Herring <robh@kernel.org>, matthias.bgg@kernel.org
Cc:     mark.rutland@arm.com, ck.hu@mediatek.com, p.zabel@pengutronix.de,
        airlied@linux.ie, mturquette@baylibre.com, sboyd@codeaurora.org,
        ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        sean.wang@mediatek.com, sean.wang@kernel.org,
        rdunlap@infradead.org, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org>
 <20181116231522.GA18006@bogus>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
Date:   Sun, 18 Nov 2018 18:12:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116231522.GA18006@bogus>
Content-Type: multipart/mixed;
 boundary="------------DE07BBB8F39CF4FD41CA126C"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DE07BBB8F39CF4FD41CA126C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11/17/18 12:15 AM, Rob Herring wrote:
> On Fri, Nov 16, 2018 at 01:54:45PM +0100, matthias.bgg@kernel.org wrote=
:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> On SoCs with no publical available HW or no working graphic stack
>> we change the devicetree binding for the mmsys clock part. This
>> way we don't need to register a platform device explicitly in the
>> drm driver. Instead we can create a mmsys child which invokes the
>> clock driver.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>  .../bindings/arm/mediatek/mediatek,mmsys.txt  | 21 ++++++++++++------=
-
>>  .../display/mediatek/mediatek,disp.txt        |  4 ++++
>>  2 files changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,m=
msys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.=
txt
>> index 4468345f8b1a..d4e205981363 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.tx=
t
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.tx=
t
>> @@ -1,4 +1,4 @@
>> -Mediatek mmsys controller
>> +Mediatek mmsys clock controller
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> =20
>>  The Mediatek mmsys controller provides various clocks to the system.
>> @@ -6,18 +6,25 @@ The Mediatek mmsys controller provides various clock=
s to the system.
>>  Required Properties:
>> =20
>>  - compatible: Should be one of:
>> -	- "mediatek,mt2712-mmsys", "syscon"
>> -	- "mediatek,mt6797-mmsys", "syscon"
>> +	- "mediatek,mt2712-mmsys-clk", "syscon"
>> +	- "mediatek,mt6797-mmsys-clk", "syscon"
>=20
> Doesn't match the example.>
>>  - #clock-cells: Must be 1
>> =20
>> -The mmsys controller uses the common clk binding from
>> +The mmsys clock controller uses the common clk binding from
>>  Documentation/devicetree/bindings/clock/clock-bindings.txt
>>  The available clocks are defined in dt-bindings/clock/mt*-clk.h.
>> +It is a child of the mmsys block, see binding at:
>> +Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>> =20
>>  Example:
>> =20
>> -mmsys: clock-controller@14000000 {
>> -	compatible =3D "mediatek,mt8173-mmsys", "syscon";
>> +mmsys: syscon@14000000 {
>> +	compatible =3D "mediatek,mt2712-mmsys", "syscon", "simple-mfd";
>>  	reg =3D <0 0x14000000 0 0x1000>;
>> -	#clock-cells =3D <1>;
>> +
>> +	mmsys_clk: clock-controller@14000000 {
>> +		compatible =3D "mediatek,mt2712-mmsys-clk";
>> +		#clock-cells =3D <1>;
>=20
> This goes against the general direction of not defining separate nodes =

> for providers with no resources.
>=20
> Why do you need this and what does it buy if you have to continue to=20
> support the existing chips?
>=20

It would show explicitly that the mmsys block is used to probe two
drivers, one for the gpu and one for the clocks. Otherwise that is
hidden in the drm driver code. I think it is cleaner to describe that in
the device tree.

--------------DE07BBB8F39CF4FD41CA126C
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFuECLIBCADD/t6l9ZYo+koZfGSuIrxbdrI1wR3iCxem+yKPz6cTUtRE6HNe
fRKM83CjBt5iPFFwBkofXFoTGS/9zKcoPAWM9QK2f6ibkmUIYH4mNZfYmYbVWg/e
nWQru5SLl8LzNKIQm3adJKL+PiLMiDuoSJ7Z6sD8dhxxjZgCn12ulKzJuzjTp9+v
AlByTWs0U4UibjZyJrcGN5ZL3lbYDqHxAVLeN5os+VezXYXa6GglscmSv8QdVMui
XY37mNkhBGr7MD81JckqXn/95Z+nWpRE3upHSxGtUNfkoW4PNpBOa8jPO1TBA4f0
0xZtDB7bFNzZYtdsJ2LnyXqsrwWoxPQiRoQFABEBAAG0KU1hdHRoaWFzIEJydWdn
ZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+iQFUBBMBCAA+FiEEhdxoJL7wYu3O
B7UPj8JuPkuXuCkFAluECLMCGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwECHgEC
F4AACgkQj8JuPkuXuCk3IwgAkW6Q3folu6SMcIVa47KQIms7K3qUgXoi4nt8HbET
T1wm83ZmHXyI2S3ibzR+9yhbrqZZ7d6mHMjwvEnS3RVGw1dUGs9DgliREeyErC/5
SHTXYm2EvsPVCUd9yEe0VabhtTdLk5saQC1SncMnjorIWCWHyuBbIEIzSYmiVZlw
VbcD9kDYSKHmi/RSv0EeyedKW6aanbkB9j+M0NaRbCPbsmDrfJY31T8Jf66bLH7h
WfI6HURtQuvhSRzYWypp9yO6ndizoMmv1NQk/OO40j7QCVzaOmqJxc41FAxz57cg
6fN4ic/o7KNf6ZXoTuicb0Ft9gpUNtSj72dQymhdaXGFcbkBDQRbhAizAQgAv1Bs
N6c451tfbXWM754NxHhXVwhR/JKKD+PpHsYh1BSSvE7wwu4dW1Uu60GPeRM0jq7g
pfu5BB2X6V2qL2mO8FdVf83Xp4h6nsEl220Ep1dq8zXBajX9cZVkzbkEXRs751xx
o4HzOP6sTjimQLG1ALWdAZtE4HSyIafh4GWs0uPFYYSie7w1no4pXzLBTAcQ1PB7
hMw9pHBu3Lx7FsgWU4k3riBGSklr1AEbJl0Z3wEuV7wC6BLUAqvQ/lmkf6Dg7URa
aKzlgkDh4g/L5k3VeznJBLITTMprbN97zV13mvss9FCKduRY+YcAXpTVtOlLeIPD
L/0AATCO2Y/WiAndgQARAQABiQE8BBgBCAAmFiEEhdxoJL7wYu3OB7UPj8JuPkuX
uCkFAluECLMCGwwFCQHhM4AACgkQj8JuPkuXuCk1TQf/es2YD5q3GFce9wxGsm0j
pPo8xuP1KKeORIMPXieHqVphlRgZp/ppWnSU3ZwgG8y65+8nW2iFJGmNyRxtgDiY
J9Ji33ulefz66oDlC7YNZhA4MKFVW7A2pjvQSEkXmadk3N0RNBZQ6LKAY0+/2EbF
atb6Cm46qahc/AkXegmLWaP/frb3p7peT6KCu59m94m6sj8yPre0USp6CiqkZK4G
wF7sUgU1BwTveTZFwlnV1LySmZVBE7Ro7de/24HDO/1U2iUfvatlfkT2OrrkA7O4
zBJY75tooUAUNcYczF+WAtHKBNyJwHo1ZXyRCUgddw9JosmapYAwOkZgYlVzSWxS
Ww=3D=3D
=3DapZK
-----END PGP PUBLIC KEY BLOCK-----

--------------DE07BBB8F39CF4FD41CA126C--

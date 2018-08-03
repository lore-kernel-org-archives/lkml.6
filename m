Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4567C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5985B21759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="FfO2UpFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5985B21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbeHCOeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:34:01 -0400
Received: from mail-by2nam01on0072.outbound.protection.outlook.com ([104.47.34.72]:31744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730129AbeHCOeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmUU/r5MamgPJRbzRdVMTd9MT5ZZNtdbHSn2tIRrBOY=;
 b=FfO2UpFM558A9Cy3Kv35IZhI/1f+F8qEs/cBM0wZiHRWuIE6he5r/xEyqkI60Dlm2rHcbmS+piYtrKjhc3u2U4Dr3Pky/mQht7dWc0GNcD1okM45YUIA2YPIyFSn5qxSw3NGGT6N9RxdzX6nAE+4m8Y2oGPCFaBu2K14XKNBhP8=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB602.namprd06.prod.outlook.com (10.141.229.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 12:37:46 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 12:37:45 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Topic: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Index: AQHUDsAqECp4D0lQUUKx9mO19FFp2KR1YqSAgAG0kwCAAAIjgIAAAc0AgCcOdICAD/s1gIAAAWiAgAAH7gCAAAHkAA==
Date:   Fri, 3 Aug 2018 12:37:45 +0000
Message-ID: <F7B041D7-4E55-4B26-A263-9289C4616223@cnexlabs.com>
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
 <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
 <19b2f125-d373-cf2b-43c7-140b3872cd64@lightnvm.io>
 <D6AFE2C1-D273-4945-9A12-D4A0A57FD108@cnexlabs.com>
 <8c2fc1ff-e2ea-499e-3699-39622d00be9e@lightnvm.io>
 <88659F4F-8105-41CA-B0B8-849E707F18CD@cnexlabs.com>
 <423c5d4b-6d9a-d233-d3da-f2cb8b10f880@lightnvm.io>
In-Reply-To: <423c5d4b-6d9a-d233-d3da-f2cb8b10f880@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB602;6:Xa1cV9oNGSjwTr2zNlMb+EwiXzo0lowzNGietWnevOKjmMUNs9To6BnrAkC9Qsky4jGpyazOMwNLhHoGdTJxB937E+XZZx4xS3CwRGHYHOdlFx51XsunIMl5m3nMiWtv2Tb1V9N5z8iYBnY/mAyGJBaxhjtAo/NQZVlvMp0hoDVZv/0+FdgIL+2VtsnRlKBT1Dat5k0EMUJU3BngovpXvhZF+MkzpiSFAVhL+I7UQxwIF9Ni2iNYrNuNQ0sDiTsXp3B3QNdSF7aa+bQ4wfdwzzorIfoKvtSwRSppLDVg9v9dgDlBNLrBiM3vRprCvCOz7tXQXH8902ZVLVMSX0xR1nP+kp069ngupC18cN7cG44V+lfUbX2GZdTFw2ESwoId0JTFn8W0GSZscdvfckZPrJa2l/7e+ThBVR0RX+uR4rr9G+oqW1YyC1HlW0Q9YhflRbHFg5miz1mGixs0Cc25sA==;5:LXk+N4TB0fLNkYtF8xNFVDmYzs56Gp4WvOZji5j0BiYCwg5cZ7jicCTSUow4GAdDZEwo5fiuIWRxYjmcyxVBLpzRcshvXQptnkXccUJ3r+Qi92BSJs/ItZqN3FJBvCenrToG0Q2e04vrDuzP+bYfJm4FZqEXLUNyksy5acFs2FA=;7:EyM71BVqQ2d82/F4lZFxlnZa0MGrOliDobBLVWQtQgBM11Z5Sf3RAu/iHu30RnXsnjBBhDKRw53JyU1uaud6gtI8w9Px0sQmZyaMDheVFv7td6ZfhZ6C+0gjUOEPHvfvClir6vPA5lZNKBPHxMKT33ZP/lseeJGBvVO33vDzz3QJDm3++LwvhnYP9bu3zKpAknc2iFDcVymc5wBTV3X4Fy0X/OpLp58GlTHPPVKd5Ns0kC9NymwB65GW3Tkyine3
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39840400004)(136003)(199004)(189003)(81166006)(8676002)(5660300001)(99936001)(446003)(14444005)(33656002)(316002)(478600001)(86362001)(83716003)(105586002)(6916009)(106356001)(5250100002)(8936002)(36756003)(3846002)(6116002)(11346002)(54906003)(14454004)(476003)(2616005)(256004)(7736002)(81156014)(26005)(486006)(305945005)(93886005)(6512007)(53936002)(2900100001)(25786009)(6246003)(229853002)(82746002)(4326008)(53546011)(97736004)(6436002)(6486002)(2906002)(99286004)(66066001)(76176011)(6506007)(102836004)(68736007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB602;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 1f6e75c3-2860-4b1e-b16a-08d5f93dea1c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB602;
x-ms-traffictypediagnostic: CO2PR06MB602:
x-microsoft-antispam-prvs: <CO2PR06MB602C96C92B102B1961291FEBA230@CO2PR06MB602.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB602;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB602;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2m9nFtzS3Wu5CjLk4dVtqNGyNX8TPk0diRCzXulAzFOtJgXGjFMYwr5Q+3fAs8cM0/EGToW7KTHxuldDyc1nHNd7ppSo7dQuPMcn050LJyWlqHI0vc+uNP8b/H5v9UQp7+imF8/A9hYh64zEiqLZNFcVblXLYh4QOAi3Bn2EKM+wSVkOhfn459g5Y7e6GX7280S8rZ1k0Kch5s+TLkICuCTlsIX8cT3hM2jeSe2DKEDh0tnywRWS1QqQ4uBxtDlZkScchyuN0Lt4ZXEuugI8ZPjJjyk+SCOuUQ/LlI790MtS6N8kt0ruKbR7Xv+T60BBUmAoIrVIjc3R4IfDe5TS5LmoCSMz4spIkc7JBrFSz1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B920FB36-7AAF-4147-AE97-EAFBF9B7B5BB";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6e75c3-2860-4b1e-b16a-08d5f93dea1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 12:37:45.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_B920FB36-7AAF-4147-AE97-EAFBF9B7B5BB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 14.30, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:02 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 13.57, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 07/24/2018 09:54 AM, Javier Gonzalez wrote:
>>>>> On 29 Jun 2018, at 13.28, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 06/29/2018 01:22 PM, Javier Gonzalez wrote:
>>>>>>> On 29 Jun 2018, at 13.14, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>>>=20
>>>>>>> On 06/28/2018 11:12 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>> The Open-Channel 1.2 spec does not define a mechanism for the =
host to
>>>>>>>> recover the block (chunk) state. As a consequence, a newly =
format device
>>>>>>>> will need to reconstruct the state. Currently, pblk assumes =
that blocks
>>>>>>>> are not erased, which might cause double-erases in case that =
the device
>>>>>>>> does not protect itself against them (which is not specified in =
the spec
>>>>>>>> either).
>>>>>>>=20
>>>>>>> It should not be specified in the spec. It is up to the device =
to handle
>>>>>>> double erases and not do it.
>>>>>>>=20
>>>>>>>> This patch, reconstructs the state based on read errors. If the =
first
>>>>>>>> sector of a block returns and empty page =
(NVM_RSP_ERR_EMPTYPAGE), then
>>>>>>>> the block s marked free, i.e., erased and ready to be used
>>>>>>>> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
>>>>>>>> (NVM_CHK_ST_CLOSED). Note that even if a block is open and not =
fully
>>>>>>>> written, it has to be erased in order to be used again.
>>>>>>>=20
>>>>>>> Should we extend it to do the scan, and update the write pointer =
as
>>>>>>> well? I think this kind of feature already is baked into pblk?
>>>>>> This is already in place: we scan until empty page and take it =
from
>>>>>> there. This patch is only for the case in which we start a pblk =
instance
>>>>>> form scratch. On a device already owned by pblk, we would not =
have the
>>>>>> problem we are trying to solve here because we know the state.
>>>>>=20
>>>>> Agree. What I meant was that when we anyway are recovering the =
state,
>>>>> we could just as well update ->wp and set to NVM_CHK_ST_OPEN and =
so
>>>>> forth for the initialization phase.
>>>> In 1.2 the use of chunk metadata is purely fictional. We respect =
the
>>>> chunk state machine as we transition lines, but all the write =
pointers
>>>> are ignored. Instead, we use the line bitmap to point to the next
>>>> writable entry. This is BTW the same way we it in open lines on 2.0 =
too.
>>>=20
>>> Now I understand where you are coming from. I had the understanding
>>> that we where using the write pointer now that we moved to 2.0,
>>> looking through the code, that wasn't the case. :) Which means that
>>> pblk doesn't work with a devices that implements 2.0. Yikes... I =
knew
>>> I had forgot a detail when support was added into pblk.
>> I think you misunderstood; pblk does support 2.0 devices. What =
happens
>> is that we transform the per chunk WP in 2.0 into the line bitmap to
>> simplify the lookup. The point being that we do not need to create a
>> fictional chunk for 1.2 devices since we do the translation to the
>> bitmap directly. Does this make sense?
>=20
> The chunk->wp isn't used anywhere. So it can't take wp into account.
> It uses the EMPTYPAGE marker from 1.2 instead. See pblk-core and
> pblk-recovery.
>=20

I see that the patches for this are still internal. Will post for 4.20

>>> There are no empty sector marker in the 2.0 spec, since it uses the
>>> write pointer to know where it is in the chunk. So there is a bit of
>>> work to do there.
>> Yes. And for 2.0 devices we go and look at the WP, but for 1.2 =
devices we
>> need to scan.
>>> Since this properly is a bit more work to do, I'll look into it =
after FMS.
>> Look the comments above. All we need for 2.0 support is in place. We =
can
>> talk about it f2f.
>>> I'm also moving the explicit coding of 1.2/2.0 chunk / bad block
>>> fixing into core, so pblk can be simplfied, and doesn't have to =
think
>>> to manage each version separately.
>> Good. I have a patch I was expecting to send after FMS for moving =
chunk
>> / bad block out of pblk for the same reason. If you're doing the same
>> thing I can stop looking into it...
>=20
> I am, will post when done.

Cool!

Javier


--Apple-Mail=_B920FB36-7AAF-4147-AE97-EAFBF9B7B5BB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkTJcACgkQIX4xUKFR
nnTNHw/9G4WDVFkwkzZr44wYAscR6zPnq5j1OcB/+t85381hPUITrse08da1dePq
KZ8SuD0tAjathPfSLsuf31NqvCqXqWDA24EkNdxWSoakIUM2/8cjg+5myXKKTZM/
8jxQ0430haJNShRJBm1UkKYT7Mboigh+qWjiA4xhHmia9OX3VYOX6umVJaW+gg9l
pMxSPUzr9T2nFCGgjL1Is3IJAa8cDOTZfPUX9De59Q2D/iTxSndTh8H2Uod1AX8+
DpzLE7Ix73hSS23gh/P+PkRv10oISSgqx4tZWIXmKkS9IRwXWtSCUus/wZWtWh6q
X3bCWl3w/y5PEqptahyjWqS2LDmpJpLAw1FZJdloNXnZFuM/HeVMFuONaZN7AALs
CLsPbbKgwcZixPVIksFP+RdyH0TfDuFmKqmu7rs405Ja2wu0c1R5KjwkGPBBk0PV
OX3Ri60IyFna9Y0lxio0WJ0jaijumo+7IODM4jOEJaY5GbV429mz+pF2fkQtYhB3
B83JAhtrtbyefWo9U4TPAswoOv8Bsl8PY/rGhFhdoLBP4QnZu9YtuQF+7qndw3IJ
uzMLANhns/6bzaPUlKD0Y6NmsH4BKLtjeT3ESl8IRg30g5UxaxT7tVbAD9JPhsHH
1z8+KycRaWhTniKJomkduvVz7hmgnbfx+Pny0h2MQt5pyYXa8T0=
=ml0d
-----END PGP SIGNATURE-----

--Apple-Mail=_B920FB36-7AAF-4147-AE97-EAFBF9B7B5BB--

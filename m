Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6BF21734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="DK4X8A3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6BF21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeHCOCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:02:38 -0400
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:27360
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbeHCOCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ix6nN8TY/pRUSNAN0CYMr9/tFfwo6qzD/vcFrFHOGU=;
 b=DK4X8A3nohTE0kMB3u54zSsU2bR/Zl8hvosnYVq1h1OLUae3aLRhXVvJu3/L4JcVRfsrtMp2/SmBHOvp+l6RSMvUdJlJkOQsRIO0zOJqi33aP1wS76Crox2folNB0iGTRo/Yec6QIca29o51eU4/IBj5JAnVnvPGtbaaMXKb4ps=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB570.namprd06.prod.outlook.com (10.141.230.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 12:02:40 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 12:02:37 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Topic: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Index: AQHUDsAqECp4D0lQUUKx9mO19FFp2KR1YqSAgAG0kwCAAAIjgIAAAc0AgCcOdICAD/s1gIAAAWiA
Date:   Fri, 3 Aug 2018 12:02:37 +0000
Message-ID: <88659F4F-8105-41CA-B0B8-849E707F18CD@cnexlabs.com>
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
 <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
 <19b2f125-d373-cf2b-43c7-140b3872cd64@lightnvm.io>
 <D6AFE2C1-D273-4945-9A12-D4A0A57FD108@cnexlabs.com>
 <8c2fc1ff-e2ea-499e-3699-39622d00be9e@lightnvm.io>
In-Reply-To: <8c2fc1ff-e2ea-499e-3699-39622d00be9e@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB570;6:DjPsEEXgjPSk0mgq1vXtciOb2ajVQtgXL5k1VSMN7mzGDvoCvQjaSbCGHb0Eki5j48UvaoWXKUcFXXkIugtBV3Gx5jeA/xkxnGoe0+KWzMgMSo4o2zBbWmK9BrVnP6gZtwc9S9wbunRcEy6B7C2UCfsJgkMXv+h2ggeSDMBygxtLAF+4wvU/3bBK0xpMzfY8FTlAy9qUix8NB6i0R4+bYBHopzCUcWq62S12v2/jK/b/8l6hWIBzqAxW9npKJHCt5Lx9h/T9uqTiaqeybeJegaPMfHMsEDfBr8kwLhSSWq5ZB/b9NUroMBirGvtGN4Xe/9+mKFBFerpvxdTiW294tjXwl/RnvtJWYPifLD0Vb8tdaImYDu/dOMYxMpgrkvb1kjRI6xVbYIRNKt7DQgVrj6nrtf0pc4cDn1Pw9zqLG8SLmxu4QPlxMJNDsd/MgwW+dWGxxcghpe1rYWsANjVQzg==;5:disZPeyYrHWWVpkhOWPIsBZy6JJyXRtT0MJcOS2KbWrZmxGSrPqxmcxEKoRhRIrYcy6hMFKoOfMtSDr9XIf4erRlWhPYp3Q87p2qpi5PMqNSUj+l+amrTaXK6ALIiboO9UTkxVBnsWEfpXHg+pR44yWICT3c/sr6ZjLRTmdHapc=;7:mpAaQ0YhkPmq7YtYWICmWuN/kyyMrhw4uX8NxvEQD8VGskfoYipB4ZJobYrr1KyTlkdPabLoTaJfC8BnEiLk2F6KdD3ue+Qkex6mWIb9uDObFhZstzMmN3LJFfcdsMEQd5cj1hWdR1dUHZjSBYgKBUz5CNQcPGDXwvO2VSMA6BLnUfe4lsF8A/hvBkH/DeZH10cv5IF0Xql16jOp1DaP25wD4LjX+s3FNwowi1U8FJlHNBmL2G3s1MqHJphwHraT
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39840400004)(366004)(396003)(189003)(199004)(53936002)(68736007)(54906003)(97736004)(99936001)(7736002)(93886005)(14454004)(3846002)(25786009)(6246003)(6116002)(476003)(82746002)(305945005)(486006)(2616005)(6486002)(2906002)(6436002)(316002)(229853002)(5660300001)(106356001)(36756003)(11346002)(6512007)(5250100002)(105586002)(66066001)(81166006)(446003)(99286004)(33656002)(2900100001)(83716003)(478600001)(26005)(76176011)(4326008)(186003)(6916009)(8936002)(14444005)(81156014)(6506007)(86362001)(256004)(53546011)(102836004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB570;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: e61ff58b-8d36-4f7c-c7d3-08d5f939016b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB570;
x-ms-traffictypediagnostic: CO2PR06MB570:
x-microsoft-antispam-prvs: <CO2PR06MB5706F46D6D7F3C506721588BA230@CO2PR06MB570.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB570;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB570;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8Jd/er8ATNeQnobdwSBR0xfOyrYuShGzFbbzl5bPmRMi/X79ItcxU0VWkB3CI1NBKY2Jligx5SGsaq1jTtmIKkjwkBtdcnmFktj2JIVxgo1XLGEK5NBOeCed5zZdpJMbpznpCcTFOx3UraAoBGXDlrfxYjb0hB7lmh4eQqS6xBdhr95aBrquwc5vRFKrAFnTmJIhXS5oJM3hWw7KpFT1wGuR1F6YvaPhrYqL8+B9mapxSnpsxpa00qE8/J9J/QghyLZIlOXB6CQA+YMRogfRHDnISSiqdhijQCTS2+Ah55msVjXU+NwEKleSl9LbUI9AQSNyTqr0ChSnUHB5dwE+alBIBaf5qUkZi6giz/tdfks=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3BC33749-B9D9-42B0-9EC1-E5F7699E401E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61ff58b-8d36-4f7c-c7d3-08d5f939016b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 12:02:37.0722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_3BC33749-B9D9-42B0-9EC1-E5F7699E401E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 13.57, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 07/24/2018 09:54 AM, Javier Gonzalez wrote:
>>> On 29 Jun 2018, at 13.28, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 06/29/2018 01:22 PM, Javier Gonzalez wrote:
>>>>> On 29 Jun 2018, at 13.14, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 06/28/2018 11:12 AM, Javier Gonz=C3=A1lez wrote:
>>>>>> The Open-Channel 1.2 spec does not define a mechanism for the =
host to
>>>>>> recover the block (chunk) state. As a consequence, a newly format =
device
>>>>>> will need to reconstruct the state. Currently, pblk assumes that =
blocks
>>>>>> are not erased, which might cause double-erases in case that the =
device
>>>>>> does not protect itself against them (which is not specified in =
the spec
>>>>>> either).
>>>>>=20
>>>>> It should not be specified in the spec. It is up to the device to =
handle
>>>>> double erases and not do it.
>>>>>=20
>>>>>> This patch, reconstructs the state based on read errors. If the =
first
>>>>>> sector of a block returns and empty page (NVM_RSP_ERR_EMPTYPAGE), =
then
>>>>>> the block s marked free, i.e., erased and ready to be used
>>>>>> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
>>>>>> (NVM_CHK_ST_CLOSED). Note that even if a block is open and not =
fully
>>>>>> written, it has to be erased in order to be used again.
>>>>>=20
>>>>> Should we extend it to do the scan, and update the write pointer =
as
>>>>> well? I think this kind of feature already is baked into pblk?
>>>> This is already in place: we scan until empty page and take it from
>>>> there. This patch is only for the case in which we start a pblk =
instance
>>>> form scratch. On a device already owned by pblk, we would not have =
the
>>>> problem we are trying to solve here because we know the state.
>>>=20
>>> Agree. What I meant was that when we anyway are recovering the =
state,
>>> we could just as well update ->wp and set to NVM_CHK_ST_OPEN and so
>>> forth for the initialization phase.
>> In 1.2 the use of chunk metadata is purely fictional. We respect the
>> chunk state machine as we transition lines, but all the write =
pointers
>> are ignored. Instead, we use the line bitmap to point to the next
>> writable entry. This is BTW the same way we it in open lines on 2.0 =
too.
>=20
> Now I understand where you are coming from. I had the understanding
> that we where using the write pointer now that we moved to 2.0,
> looking through the code, that wasn't the case. :) Which means that
> pblk doesn't work with a devices that implements 2.0. Yikes... I knew
> I had forgot a detail when support was added into pblk.
>=20

I think you misunderstood; pblk does support 2.0 devices. What happens
is that we transform the per chunk WP in 2.0 into the line bitmap to
simplify the lookup. The point being that we do not need to create a
fictional chunk for 1.2 devices since we do the translation to the
bitmap directly. Does this make sense?

> There are no empty sector marker in the 2.0 spec, since it uses the
> write pointer to know where it is in the chunk. So there is a bit of
> work to do there.
>=20

Yes. And for 2.0 devices we go and look at the WP, but for 1.2 devices =
we
need to scan.

> Since this properly is a bit more work to do, I'll look into it after =
FMS.
>=20

Look the comments above. All we need for 2.0 support is in place. We can
talk about it f2f.

> I'm also moving the explicit coding of 1.2/2.0 chunk / bad block
> fixing into core, so pblk can be simplfied, and doesn't have to think
> to manage each version separately.
>=20

Good. I have a patch I was expecting to send after FMS for moving chunk
/ bad block out of pblk for the same reason. If you're doing the same
thing I can stop looking into it...

>=20
>> Chunk metadata is only used to setup the bitmaps on init/recovery. =
From
>> here on, we use the bitmap to find the next writable sector, without
>> worrying about the specific per-chunk write pointer. Thus, updating
>> chunk metadata here has no effect.
>> Does this make sense to you?
>> Javier

--Apple-Mail=_3BC33749-B9D9-42B0-9EC1-E5F7699E401E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkRFkACgkQIX4xUKFR
nnRIDhAAwqZZEOQQOgUyROwIpb9kJXaHNnQuaXTwRIL96qNoWYEONdKD+E4fRaht
ZwxMgU0kGetcgWW/8UY3xQdSA4vEt+X5Mqjc8mgBu3HOB/AxngrJQiw9molf2uSU
VIR9+ZWX3lC61ESZs8bC9r+v9dg5Z/l7+oF6Q3+fieK3Fy03tvcB+0STyEf8I+WO
FSJ78G3qJIzbHULJvVwksUxOcjUUKLfR7wHL1dJclqRdmJdaixLS8NykK/bjxamD
+txxmvGlaSFQh/uGHfO/A9CwXj7sunWugnsrmkGrbNQJf4j+0WBcTEgqipkxj59d
z+SF13SpODuy8sBCjiPM/NoTlyPaf4pbHkMhwTxbDP/s647VNnFnZuV70+B4Jo6t
DgfzZ2mCtx9cOwk47gmPwHj5qysL8PjjtC1ACerLkn6RFw0Lo8jPILQVyFbTIK5S
T6Lloa7POMAEhs5hQnA7+E8Jfx8RbsiJe3zSX8SctL1b03ZFKFHjGtv76XXCLus4
xm3mZrqJuSsf2TxrYGgFTX91RgzFLRc/mqJ45vN2eifvTvuHKvWXFOg35LeRNdUp
dM/N9iPOiZ8oX9yOvQpbacPYmWfwmh12vJcyH3vdGHOEM8bUHwvAdfVJ9N3GoozF
IEJvXrfM9QIKacsP1yz8ke+IxETckclu9xSkVmAGb/lNFfM1gUg=
=QP8u
-----END PGP SIGNATURE-----

--Apple-Mail=_3BC33749-B9D9-42B0-9EC1-E5F7699E401E--

Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0912C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DCA216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="mzVAsSOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DCA216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeHCPPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:15:39 -0400
Received: from mail-by2nam03on0064.outbound.protection.outlook.com ([104.47.42.64]:55856
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728300AbeHCPPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WW7VVojHyu3de6KcMJaNWCYUbwVxCu7e7F4k5hZfZ0=;
 b=mzVAsSOfqYN8RRpblhxgsPXts74tkMCRWxvX7pEKlDPDSmMz9sXKgKogUOX7Uq2BBIL1zp9RrUXvDOWvYh+hLmkUFaPPUFsG/TY+F8Rirc+idiXVm+w0ecGHJIxZyKeXS4969m6PCLTvYGdmgTvzk8QepODxNGLoQwInrIluFeE=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB891.namprd06.prod.outlook.com (10.141.227.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 13:19:16 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 13:19:15 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: move device L2P detection to core
Thread-Topic: [PATCH] lightnvm: move device L2P detection to core
Thread-Index: AQHUKweuBQbrOBanp0uVNhhgjqWapKSt8ZYAgAAF5ICAAACwgIAAARKAgAADPoCAAAGtgIAABOwA
Date:   Fri, 3 Aug 2018 13:19:15 +0000
Message-ID: <62385844-6194-4345-B482-D0637EA2718E@cnexlabs.com>
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
 <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
 <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
 <56562d7c-8deb-4597-4274-5a55ec9327f7@lightnvm.io>
 <B2E9F490-32FD-49C5-906D-994762E7191D@cnexlabs.com>
 <e0be455d-2586-fea8-a554-2796b08dd5ff@lightnvm.io>
In-Reply-To: <e0be455d-2586-fea8-a554-2796b08dd5ff@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB891;6:x5STa/VV+rcsCMzqXk09QI9aJsrJXceZpj82JR+OcBSFRw6a9/w7f7Y5JnQicsYj/JSUrxcdol2Y/0lzJcpWEK/EKAwR8FYZOEhojgZJ4ZKAzjG4lnmVe29Cs0sci5MjKDtKZphEOtfB9bRjh0uJbd1ahKCG4/uc+YMJI3Qbc0wPb0eoqN632sPLVCxDk7QqrrYGQV07T0Y88tyuNpZoMoD+Hh2ffBZJEORQUs41GaGvkSuu1QndxYMINDwR94JbEIEp3k8WBjyVn6ucnvMTAI04nztyzer2DBnslnVvhuC8cF0DYSDhs6dn6xijqvSSA6bRw56FY3Q9hDOKQii/1YzuDwVofb8F4nUI+Hl4GyxeUA9C0TFsEODFjBnav3o3AZO/L+PNkkTggXAo4qX3x0IoEuh4fmTqlG8AxhaH5GqAJq111HeuIOcbA4KoKRvN35Rm7NTQtOfQOi8sEmJqYQ==;5:07Jp2jeiNU65YYqycvN91RJRFrtDPKB12KiTG5Vm3Po6spYQUAGHytQYtsXJY5Bf8V51x4FaH3g21088m0o9STSvpTE2ckwCHYjXRE3mk/hx0nsXCal7G/EF7Uh3FYEUhgZBJ/XGUEfjNKqTXEAGRRrjHxxez72GPcUuVfCBQKk=;7:JqkixwEGTnMpie+erm3TVv9bWXvqDlMRJdFlRStD3SrDA/KJRlXnY0msw0xUd3WafLEUMSklcbgVVpjS9RDmQRxwJyTiY/L3B34XG/3T96kRZYlN1J6eUjDabLzXGP/MlokvBYcrjj69pZ/1nuWiFaFmpcwvc+K/gCllBEAHiFrUod9zo9R1PDulI7czer7NDw5XBQY4/OdtGrL9Z2TwrjwQvxjLl1paufav77tsqIOGrIxKYmGMkSwDQEGWA0Fa
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39840400004)(346002)(376002)(199004)(189003)(52314003)(478600001)(486006)(6916009)(6512007)(6246003)(11346002)(6436002)(8676002)(186003)(305945005)(446003)(25786009)(26005)(105586002)(76176011)(36756003)(316002)(97736004)(2616005)(2900100001)(102836004)(66066001)(256004)(476003)(2906002)(54906003)(4326008)(6506007)(7736002)(93886005)(33656002)(6116002)(6486002)(82746002)(86362001)(229853002)(3846002)(8936002)(53936002)(99936001)(106356001)(68736007)(5250100002)(5660300001)(99286004)(83716003)(81166006)(81156014)(53546011)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB891;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 15d7330b-2533-4219-5bec-08d5f943b5e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB891;
x-ms-traffictypediagnostic: CO2PR06MB891:
x-microsoft-antispam-prvs: <CO2PR06MB8919CB159F8F080A2111FCDBA230@CO2PR06MB891.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB891;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB891;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xTueO+rMlQOLR93VlDLEZO+LdnUmkv2LrvhLmNDnbxD0BgfQZiZ6CfMqC6zjoI/5uNxviJTtxoalLScHDeGflhLJdBbwK3nOBz0NVNEdsONGxiJAgPaxBV7PyYKn/qOpzc2dBVA5pM/OKSA36b6nQSUDUeo+LpC9tyz/Xr2lnqML4DEkC4SYKlO6Y+fGGLty9fZjrTMwHruOYCRU4OiGY/sVvDVPiCgEBbC6747vXFo33PKyZAbsh4KznmT4R69jPvbJz6BCaNqs0BZUdjjDx37N662NuQlN7M+8SKV8o8+hqOj6mPRG6NVJF+1+K5H91zN33nLKwMQ/dHg2Y+ArteQDxvLQcREsbYCn0D23gLI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_97259311-9024-4E9B-A9CB-947CE4DEA28A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d7330b-2533-4219-5bec-08d5f943b5e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 13:19:15.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB891
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_97259311-9024-4E9B-A9CB-947CE4DEA28A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 15.01, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:55 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 14.43, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/03/2018 02:40 PM, Javier Gonzalez wrote:
>>>>> On 3 Aug 2018, at 14.37, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>>>>>>> On 3 Aug 2018, at 10.54, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>>>=20
>>>>>>> A 1.2 device is able to manage the logical to physical mapping
>>>>>>> table internally or leave it to the host.
>>>>>>>=20
>>>>>>> A target only supports one of those approaches, and therefore =
must
>>>>>>> check on initialization. Move this check to core to avoid each =
target
>>>>>>> implement the check.
>>>>>>>=20
>>>>>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>>>>>> ---
>>>>>> I see where you want to go with these changes, but the way =
targets are
>>>>>> layered on top of the LightNVM subsystem does not align with it.
>>>>>> LightNVM can support different OCSSD versions and capabilities, =
but that
>>>>>> does not mean that a target (e.g., pblk) does. The way I see it, =
core
>>>>>> should only check for (i) the drive to expose itself in a known =
revision
>>>>>> and (ii) the reported structures to be consistent. However, =
specific
>>>>>> functionality is not for core to check upo.
>>>>>=20
>>>>> Why try to initialize a target, if we already know that it is =
incompatible?
>>>> Yes, that is my point. But the one who knows if the targets =
supports
>>>> something or not is the target, not the subsystem. Here, you are =
making
>>>> an assumption knowing the pblk requires the L2P on the host, but =
that
>>>> could change in the future...
>>>=20
>>> I don't believe it can. It is not supported by the 2.0 =
specification.
>>> 1.2 is legacy.
>> Ja... We both know that people is using 1.2 variants out there...
>=20
> Yes, I'm not saying that. I'm saying the spec 1.2 has been deprecated
> by 2.0 and no longer developed,

But we need to maintain it either way.

> and I'm not going to move that brainfart into the 2.0 spec :)

I would not ask you to. Luckily, no-one has asked for it yet...

>>> I understand this from the perspective when checking for un-even
>>> configurations using the geometry. But this is a spec =
incompatibility,
>>> which I don't think the target should care about.
>> I see the point of not having this check in pblk since we know that =
we
>> are moving towards 2.0 and leaving 1.2 as legacy/not-upstream. But =
does
>> it really make sense to fail LightNVM on a 1.2 capability that is =
spec.
>> compliant? For all we know people could have this and use it from =
user
>> space or through an internal target.
>=20
> It only fails on target creation, not on disk initialization. The disk
> will be up so user-space and targets that implements. Is that a
> problem?

My only point is that there are different responsibilities for core and
targets and some things are supported by 1.2 and not by 2.0, but that is
ok. If someone wants to create a hybrid 1.2 device on top of LightNVN -
in my view -, they should be allowed to.

Anyway, this is more a general layering discussion than actual
opposition to the patch itself.

Javier

--Apple-Mail=_97259311-9024-4E9B-A9CB-947CE4DEA28A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkVlAACgkQIX4xUKFR
nnRFVQ/7B2MabSVU+FJi6c4gbKpoZSwIY+BisMUKc4ICUljPr+WhwpIqmc/FecdN
qeePUu5HUZH1NtQWi2k008ZoUMJVXAjQ2AxPlIllO5oAne+hhTuaxdUfGb6IhHz8
meG3f05ITP+SONpAdJR+LZNjyJWBKT3y/65XKiC4Ui88aszoBHtwJHtvqJe7oABL
5QwJAH6TOH58meogZmRGxGn6poOTwk3SbxzMfip4gsyzQIoGwzi4CRd2SCfechFC
9hOqqaua7oM+nh2KOBCQB2P/LLXUE15eozP0MNnpuVdokm6yCMHtdy2YmNbRTfKI
Rd5egUeTKD4fzH/ahN1v3bRmhigxa6PRqLjiVCo1dkAohyBJ9Rxvdj0SjeViHqXP
e6xkSEQFM7tHP9+G9T+JC8XtziGsGeUdD5lcZFwMzotMC73UrRzI+H7BzOQe86zW
CKhZyp8IND2o5A8iWaPFbO4dLG++TSxXKVnTesJFpjkTXrlSmf4K7b4zOBxzHe0z
jg+trmGAIERpeAdOPs2oF24nhqAWUBlUxORYhQm9j5wfKCwUuLmQn0qMFjww07ev
WlCEyB8jHl0ND2zFWgFfD2NqJKlUtYLsuPwCJKJK3bDANewb7tYWv0ZLJuE19vNT
QyOcJmwXdk8hy7EbykOjwXMDj/sHCL5+zt7n1p7E3KdjfkDzPGQ=
=uwB9
-----END PGP SIGNATURE-----

--Apple-Mail=_97259311-9024-4E9B-A9CB-947CE4DEA28A--

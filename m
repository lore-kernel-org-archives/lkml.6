Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BEAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975FC2170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="Uc2+KtLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975FC2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbeHCOvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:51:49 -0400
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:39993
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728524AbeHCOvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw1msEbntxtkgImCNi5QQdxIYK4z6pne8V6Sq5QJfQg=;
 b=Uc2+KtLJN50Ezj/Df3gWPmgBemsNCAFZNKyB9pxsF941rBffTmgqod+4f+XKvo4CTLW/lmCkTbIFryiHTIG6B4ISJbnebGgzFuWLaU9BgNg04WGraDXGfERo7mQiLVrY/w2Cij1aiA0rcx22u+6tKqofo6STJl+EUTU5DNk9p18=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB553.namprd06.prod.outlook.com (10.141.199.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 12:53:39 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 12:53:38 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Topic: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Index: AQHUDsAqECp4D0lQUUKx9mO19FFp2KR1YqSAgAG0kwCAAAIjgIAAAc0AgCcOdICAD/s1gIAAAWiAgAAH7gCAAAHkAIAAAoEAgAAB74A=
Date:   Fri, 3 Aug 2018 12:53:37 +0000
Message-ID: <D6BDF75C-179D-424C-A8B0-950A1FD80221@cnexlabs.com>
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
 <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
 <19b2f125-d373-cf2b-43c7-140b3872cd64@lightnvm.io>
 <D6AFE2C1-D273-4945-9A12-D4A0A57FD108@cnexlabs.com>
 <8c2fc1ff-e2ea-499e-3699-39622d00be9e@lightnvm.io>
 <88659F4F-8105-41CA-B0B8-849E707F18CD@cnexlabs.com>
 <423c5d4b-6d9a-d233-d3da-f2cb8b10f880@lightnvm.io>
 <F7B041D7-4E55-4B26-A263-9289C4616223@cnexlabs.com>
 <f50b1c39-10a3-a62c-85d4-7a869ba74cbe@lightnvm.io>
In-Reply-To: <f50b1c39-10a3-a62c-85d4-7a869ba74cbe@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB553;6:q7ZV7a5G4M7TPQfccknD8jk6yym9MW3buSr4JfO4Oi9FA9NASFc8NXhcLMCCXQhgMt8eAmEqal4iNIgY4JlT8aDYzfW43WiFkR3pZRxjxEyPE+VheLkUIzQ93VHKDDZRYNMu26M8BzIROltvm2V12JAAQfQIdSuli54iiMeje/ZIZTIQAosjE9VNHdmQcI6duPgSPCtXeLeC2bj7LGHkk7PiPZohy0DSKQjgA/t9xYcpHFStIrbfkzfUfBpatMV64yAk1swI9KS8yAEtrb8Smctn/XCwuX/pFSeIcCeA3MbE9orlyqr61MwYY4GVviAbj9Ze6p+yqig6Vb3LjFL4ObMq/i2aAfz0qihaENAML+2rpz7hvwR5lQPeoiJU3WMWW0YjTV3drI4DpVbZp0wCL9sOtbOkrM065GM/tktShF/2vdO3+jiyk6fLePGT3oaollCt7XWUE//RPoWUL40wZA==;5:wPpvqg8rcg1uD6D+B5Lcj9B70gQiCiDaE8hpHIbBxJPevXpZdefG/OHqJWun6TugsJ9+IrI8o/NxcEAU+lock7C0jtXXCn0EGjfj267+YuPzgTqXkVOLeEiDvuNJgyY5Glzk3qLDsXPfSX5ofZRrl+CaR0ia7kxRZjeSJjKz1AM=;7:RislbekSyI4hG0S12vJG8LnYfhl7sg61pgG/q8CxW+3n81blx9M9e82PjqTQVPFTgfz7ANS8+YXsAAFC0ZZ7N71qxiAeAf4zANicYgpgnEe0bz63+c3dhpwy6jUgCMVSJf5LxBvjE+01kQ7pB0VeHtq6sIjjfDjMyvJAW74cTSwUhUrUC8qO0FAVHCAxk1/2T39SH6gk1sfwSx5aAZtuPESFOXyoEjnNgsuU84AzRmhi8WkArWBlkGLLICM0uVN1
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39840400004)(189003)(199004)(3846002)(83716003)(25786009)(36756003)(106356001)(99936001)(26005)(478600001)(105586002)(4326008)(6116002)(5250100002)(93886005)(14454004)(76176011)(86362001)(33656002)(2906002)(256004)(5660300001)(14444005)(305945005)(2900100001)(186003)(7736002)(102836004)(316002)(53546011)(54906003)(66066001)(82746002)(99286004)(97736004)(8676002)(6916009)(486006)(8936002)(2616005)(476003)(81156014)(6246003)(81166006)(6486002)(68736007)(229853002)(53936002)(6512007)(446003)(6436002)(11346002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB553;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 1db63606-846c-4f13-680b-08d5f94021b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB553;
x-ms-traffictypediagnostic: CO2PR06MB553:
x-microsoft-antispam-prvs: <CO2PR06MB553C2ED8BE4134AA628703EBA230@CO2PR06MB553.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB553;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB553;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vaE4t3EtKnhUMiIY913ITHc0FMc1Wh4/mtbR4eymerqyktUSaWsF6NxIflyWPJofRIimIBs+3fh+3fVeXGn+woXNmbaO4if74/P1R1h7q8IIEwcs9Bexs5a4nB8z5CQLsnnjHrJRDunsxkm7CKN1dnk7/P6BUvBOcwpKmZE5iqCuZ4QASv1+e7z/W5G8HAuoqz5J9+/zq5RbGTf0O04Et4sFDfUieYIKAT1w+/JuSx1WW0MYKU3V12Eg51N9rBMwcd5Nsix5TYX7T83BSdcntnykjyACIRaclgd3VCFnE+CLu05agl/2CvOwzJplY52C22Kn6V0f3ySgsqQwGbHVIAgSTGssbF+i4DI2n/vwINk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_723B1CA4-6A3F-44C7-B490-BFF5C7911905";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db63606-846c-4f13-680b-08d5f94021b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 12:53:37.9732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_723B1CA4-6A3F-44C7-B490-BFF5C7911905
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 14.46, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:37 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 14.30, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/03/2018 02:02 PM, Javier Gonzalez wrote:
>>>>> On 3 Aug 2018, at 13.57, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 07/24/2018 09:54 AM, Javier Gonzalez wrote:
>>>>>>> On 29 Jun 2018, at 13.28, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>>>=20
>>>>>>> On 06/29/2018 01:22 PM, Javier Gonzalez wrote:
>>>>>>>>> On 29 Jun 2018, at 13.14, Matias Bj=C3=B8rling =
<mb@lightnvm.io> wrote:
>>>>>>>>>=20
>>>>>>>>> On 06/28/2018 11:12 AM, Javier Gonz=C3=A1lez wrote:
>>>>>>>>>> The Open-Channel 1.2 spec does not define a mechanism for the =
host to
>>>>>>>>>> recover the block (chunk) state. As a consequence, a newly =
format device
>>>>>>>>>> will need to reconstruct the state. Currently, pblk assumes =
that blocks
>>>>>>>>>> are not erased, which might cause double-erases in case that =
the device
>>>>>>>>>> does not protect itself against them (which is not specified =
in the spec
>>>>>>>>>> either).
>>>>>>>>>=20
>>>>>>>>> It should not be specified in the spec. It is up to the device =
to handle
>>>>>>>>> double erases and not do it.
>>>>>>>>>=20
>>>>>>>>>> This patch, reconstructs the state based on read errors. If =
the first
>>>>>>>>>> sector of a block returns and empty page =
(NVM_RSP_ERR_EMPTYPAGE), then
>>>>>>>>>> the block s marked free, i.e., erased and ready to be used
>>>>>>>>>> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
>>>>>>>>>> (NVM_CHK_ST_CLOSED). Note that even if a block is open and =
not fully
>>>>>>>>>> written, it has to be erased in order to be used again.
>>>>>>>>>=20
>>>>>>>>> Should we extend it to do the scan, and update the write =
pointer as
>>>>>>>>> well? I think this kind of feature already is baked into pblk?
>>>>>>>> This is already in place: we scan until empty page and take it =
from
>>>>>>>> there. This patch is only for the case in which we start a pblk =
instance
>>>>>>>> form scratch. On a device already owned by pblk, we would not =
have the
>>>>>>>> problem we are trying to solve here because we know the state.
>>>>>>>=20
>>>>>>> Agree. What I meant was that when we anyway are recovering the =
state,
>>>>>>> we could just as well update ->wp and set to NVM_CHK_ST_OPEN and =
so
>>>>>>> forth for the initialization phase.
>>>>>> In 1.2 the use of chunk metadata is purely fictional. We respect =
the
>>>>>> chunk state machine as we transition lines, but all the write =
pointers
>>>>>> are ignored. Instead, we use the line bitmap to point to the next
>>>>>> writable entry. This is BTW the same way we it in open lines on =
2.0 too.
>>>>>=20
>>>>> Now I understand where you are coming from. I had the =
understanding
>>>>> that we where using the write pointer now that we moved to 2.0,
>>>>> looking through the code, that wasn't the case. :) Which means =
that
>>>>> pblk doesn't work with a devices that implements 2.0. Yikes... I =
knew
>>>>> I had forgot a detail when support was added into pblk.
>>>> I think you misunderstood; pblk does support 2.0 devices. What =
happens
>>>> is that we transform the per chunk WP in 2.0 into the line bitmap =
to
>>>> simplify the lookup. The point being that we do not need to create =
a
>>>> fictional chunk for 1.2 devices since we do the translation to the
>>>> bitmap directly. Does this make sense?
>>>=20
>>> The chunk->wp isn't used anywhere. So it can't take wp into account.
>>> It uses the EMPTYPAGE marker from 1.2 instead. See pblk-core and
>>> pblk-recovery.
>> I see that the patches for this are still internal. Will post for =
4.20
>=20
> Thanks. Please also put a Fixes: on, so it gets backported =
appropriately.

Sure. I will.

--Apple-Mail=_723B1CA4-6A3F-44C7-B490-BFF5C7911905
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkUE8ACgkQIX4xUKFR
nnQM4A//cFy3JBs8FG/s466SuLWj5sXJMfOGcGCxJm0XE7Tz/elkMjQg3LvOXoYd
6rQI3QP+cvSvJtSU/Am/Mbptp9iaxzvmfyfhghhsmbdd0orHUrLz9hivL9VoTPpW
MRwhqx00/S2ND3DuOVhgJbZgI2dIcoC3R5JVGxug21iv130Cnp3a4SWAvvImqdIa
2FggTaoiQTYWl9Bcpf/x7Aj1RPlHmgoaphdbePufFyZzWNXKj0sBLWhQYfiA9MdH
pKMLk33CHbHm4yovQgSzm8DvbIDMA/nciYhyg9Bm6o0i2ksM3Gral/hvlUW26Asl
nQdsCsTkSbwdXGXf9eBya8nXWN4n9M9IRzeScalycDTnAcDH/LXsygMVTExG+iay
F01GfZgMVA3GWapCnxP/BRO5e1HaVRi07iaqvlLZfOew2zGOA/D88qawr2tTrW/L
1GydZ99t9yvZsp/8N081lokcKuKgfuozTqnT+RIoQ2U22/gOH1OMJNRUsGQVl3cI
1u95hMygXo+yxgq6KmWxkWsuheJlJB6ciADIy8eO3VzfrMWCiPG+IRV7QlvI27im
U7vWHTkETqgrmbCcqeElOvzOFTeKkSf0ukhvTIb4mhYnnyOn4nVV29mCB3btO9DT
Eo+qSoEMdddcbyrALj/QZSz3avTMTgje6i0S00Tpo5YWFFeBTGw=
=mLQz
-----END PGP SIGNATURE-----

--Apple-Mail=_723B1CA4-6A3F-44C7-B490-BFF5C7911905--

Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE963C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB1F21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ndPxNnrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfBSUsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:48:17 -0500
Received: from mail-eopbgr820109.outbound.protection.outlook.com ([40.107.82.109]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbfBSUsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8NyJJSSt1QOqdPqlcIub+dZj+uFYwy4iGD0FEfh5Sw=;
 b=ndPxNnrf2DUN5OP8EJaVCg9X5GH1zyjryz7PT/whVKOtVc1nvzXFUY+Af6VgHEkZxhNj+WKMBTJTs4QYaOBxXF1Yz9kFwKi8Z0DQa+9nqVZ3NPaA5sM7q00cNX0P0CQl35wDSD20VchanZbfQhU9QectMKVGhhGT2QHvDrm5HYk=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1103.namprd22.prod.outlook.com (10.174.169.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 20:48:09 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 20:48:08 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiong Wang <jiong.wang@netronome.com>,
        Paul Burton <pburton@wavecomp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: eBPF: Always return sign extended 32b values
Thread-Topic: [PATCH 1/2] MIPS: eBPF: Always return sign extended 32b values
Thread-Index: AQHUxWsFAaDSuQE4g0KueZPNLuu8CqXnnf+A
Date:   Tue, 19 Feb 2019 20:48:08 +0000
Message-ID: <MWHPR2201MB1277F46755F2546E50A5EA9EC17C0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190215201321.15725-1-paul.burton@mips.com>
In-Reply-To: <20190215201321.15725-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::18) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7181d559-2511-4960-fe11-08d696ab8dc3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1103;
x-ms-traffictypediagnostic: MWHPR2201MB1103:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1103;23:ZzJKpAfMc9J5YkQZXJxM4U/ZL2p+JXLO63ReQ?=
 =?iso-8859-1?Q?8iPfMGvcxQIbsbirm37JefaGBKYXsgz2ooOcUeWSS/5VIhM0VUUyEBAO4i?=
 =?iso-8859-1?Q?HUqwSPiOOZdLnlIVrwU3jV120HpXbI5gen7OCL24Cm13UnZlE3I2HoOgAX?=
 =?iso-8859-1?Q?SFyObZs4555NvG4zZSkLF7Ne75DKcW43mFkb2kH8zrH67Ku/qpMywOPKM1?=
 =?iso-8859-1?Q?5ORUdLxmcA1qLNYG6/oV+ExHyaicahTxkvdxmBX+OQibaEeGckDjEuutIY?=
 =?iso-8859-1?Q?u2Rp76UxJsfEr+iIykXu0og1I7B5W1ar+/iGRQ5iwEtkBI2X7CbAlo7utK?=
 =?iso-8859-1?Q?2q7pPLBhwwleZDRQXu2XLhGpuG8uhzY949b2W5magpvpjTuNMT+9m68Hpr?=
 =?iso-8859-1?Q?Bo+NoO7CNGyNJP13l8KhV6eqVjMxwWwTmEwa25tonA33tWF1APOSrnkBsg?=
 =?iso-8859-1?Q?i/OY9kYmyuLm4tbKUSwPuWAh4ffgP8+sjcOlcigUbzkKvzPOLty4pu0+oI?=
 =?iso-8859-1?Q?RBt13nG1LH2qcZMko6T1IBXUMltwYa1dVNWAIUY9UKcz8FlTz6OKat2ISt?=
 =?iso-8859-1?Q?0LRRzJMZPKH6k+3Y/v3D+eOc0MS9X8VnBfIcxq+TLstUtVKC9Jb0y9vzOw?=
 =?iso-8859-1?Q?oA1WT9W3tWnndX5q7fWoN04iV/16hKovazD5jvSt6znAiC4jkAxSWV/rZS?=
 =?iso-8859-1?Q?xKd3UM0Lbe70vdHhAnQ7Bwgf6BcKxsEvgb1I8rV9YKS5kHyDLkKw0c2ek5?=
 =?iso-8859-1?Q?9unl0Ekr/8xTTDRjJoTy1XR/65GOQDwm60JuwbzOJwgWIpcl4B47NCYGSN?=
 =?iso-8859-1?Q?IPC/d4npPYYEfTc93Om8JcSezL1qredCVHGpOD7qxSuVKVx7lZVHBSojvC?=
 =?iso-8859-1?Q?E4XBl1CwucuEeD+1407FzRLm13Fm9bnVy+yh3BcagNZCMkSf7VdaSdGsjU?=
 =?iso-8859-1?Q?7pW9D9tyc6v/DUAycORl6xVP7KnV8YqGZij0ofMHHKbAyvel5kA1KkoAAq?=
 =?iso-8859-1?Q?7egiLRoZFk2FFs78+d/wkg61deGKa14pqktHglA0EdP60lXU6BL2ae6o6N?=
 =?iso-8859-1?Q?xp4ekp/t1yQu9+7qmYR9vtMXlOHcuEuXNlc/Uer47K+uUVQbdpt8EvNxUJ?=
 =?iso-8859-1?Q?JpnDogxZUHECCQLzXiVR5aJVXmuDJqJf43SoQgADJ2Y6hB/lxGJ/3JAgeQ?=
 =?iso-8859-1?Q?oUrTdVSi4pZTn4Tx6J2exu82JhlzjzX5bZlfsJBSkMd5keZO7ITI2IqKKT?=
 =?iso-8859-1?Q?wE95P5fmLwrsFAuF/uMaJupQCTnExIVq1wzJgihdsqOjdWX23vKwZyIPCR?=
 =?iso-8859-1?Q?yk2y5tn1ssIc0x6YOB9W9YAwc+jeLUUNXqZaYlOuyXW/9+ocZrItRZ7VqL?=
 =?iso-8859-1?Q?WdfSMOKqbo=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB11034CCEAED0B9863F70CA2EC17C0@MWHPR2201MB1103.namprd22.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(2906002)(44832011)(446003)(186003)(106356001)(102836004)(7416002)(105586002)(71200400001)(71190400001)(54906003)(42882007)(316002)(7696005)(81156014)(486006)(81166006)(26005)(52116002)(76176011)(6346003)(8676002)(33656002)(74316002)(25786009)(386003)(11346002)(6506007)(476003)(6436002)(256004)(14454004)(14444005)(55016002)(9686003)(6862004)(5660300002)(68736007)(6246003)(4326008)(66066001)(6116002)(8936002)(229853002)(3846002)(53936002)(305945005)(97736004)(7736002)(99286004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1103;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ifnInEdexWzpbfgoM3TuF88QeHdKcGufXzfU00aKJ+hFAOx8Oo09GwUZhycPXKuPp35YrQiyEXIMAxmYrTIKM+LQxO5puJ8jDwkzEcLZcho7NLtUn0rpatZCEgBEMRv2zj0TeS9P5gImyLYqKjqEjxcj0nwF4JQkCwKj9ubB4H16s1DO761ixLZAIhIBv+lVYlAITDUqpSTr1jy8Sm5soUMW+ISmSC8qPEIsafS9HqMfxUkbz3DNqhVj85GAav+I71/zpjvo3OaesMpx/qskwYLpDykzagcXBuov82EDIeM0vZRtiHykr+VFGgrIHWe74GVCp8AORv0xuuXRpdFmlBhzGIaCU+Q1+HXo6zolMNEmAzgPXvFwyZSRIIRRTvFng8Ncy9ES52kCjSijXEiNHZ+A65iEVbNX4CxI7Zx8xbk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7181d559-2511-4960-fe11-08d696ab8dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:48:08.0939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Paul Burton wrote:
> The function prototype used to call JITed eBPF code (ie. the type of the
> struct bpf_prog bpf_func field) returns an unsigned int. The MIPS n64
> ABI that MIPS64 kernels target defines that 32 bit integers should
> always be sign extended when passed in registers as either arguments or
> return values.
>=20
> This means that when returning any value which may not already be sign
> extended (ie. of type REG_64BIT or REG_32BIT_ZERO_EX) we need to perform
> that sign extension in order to comply with the n64 ABI. Without this we
> see strange looking test failures from test_bpf.ko, such as:
>=20
> test_bpf: #65 ALU64_MOV_X:
> dst =3D 4294967295 jited:1 ret -1 !=3D -1 FAIL (1 times)
>=20
> Although the return value printed matches the expected value, this is
> only because printf is only examining the least significant 32 bits of
> the 64 bit register value we returned. The register holding the expected
> value is sign extended whilst the v0 register was set to a zero extended
> value by our JITed code, so when compared by a conditional branch
> instruction the values are not equal.
>=20
> We already handle this when the return value register is of type
> REG_32BIT_ZERO_EX, so simply extend this to also cover REG_64BIT.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
> Cc: stable@vger.kernel.org # v4.13+

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]

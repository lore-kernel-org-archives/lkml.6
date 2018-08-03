Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A310C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ED42170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="LmF/RE5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09ED42170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbeHCOwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:52:09 -0400
Received: from mail-eopbgr700059.outbound.protection.outlook.com ([40.107.70.59]:8744
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728524AbeHCOwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wON1+yjTAKyszC1TDoPlo0ocGjkvWYIuUe0qsHFapCM=;
 b=LmF/RE5rc5JO5neIicG5M9cTJssZ9ludKSQ/O880oAPx6rAneMbDZWNEqz5M3JlRLhTJFWe3EM1XjITsmDMdmAozMrcwLUAByTZt5WGRi96v0wlV+AaKN683asANYUXYFVwfNcIWfU0HCAVSDavfooWpX+jefoanb8xybY78lWI=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB587.namprd06.prod.outlook.com (10.141.229.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 12:55:47 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 12:55:46 +0000
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
Thread-Index: AQHUKweuBQbrOBanp0uVNhhgjqWapKSt8ZYAgAAF5ICAAACwgIAAARKAgAADPoA=
Date:   Fri, 3 Aug 2018 12:55:46 +0000
Message-ID: <B2E9F490-32FD-49C5-906D-994762E7191D@cnexlabs.com>
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
 <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
 <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
 <56562d7c-8deb-4597-4274-5a55ec9327f7@lightnvm.io>
In-Reply-To: <56562d7c-8deb-4597-4274-5a55ec9327f7@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB587;6:pQYFMYjcPgIj9uy+j7hB2PrN53e8yGPcCOIntyL63++SOow26gtuWPE8q6QGm5dQqdptpOpt0ZaUJVaP3e+9IG1wRB+yQCTOQoknxoqJORF8Z6l47JQEseJmD93/zl3nUU+bv0/v9J06WmokI6yKG7EIGYA+LqIP7XVduiePvyg/ROEVNuNS/AFmpLdiyrCJixi2eAzseQwgWIaf2Q/GOv0l1yDHLGSptj9Bi16leoavhBPEbnLqMCZvpgiBI6IXvpyLCIB84IvOxJNIXO+NwkW1dyPNCS52XM71SfYSWmcopY3NR1Wx27Deu63gsLZ2COBOB64RoIcZS1LO+8lz365KSLfMuQQK9besYsVl9GtGFh3F7XAAwpqWo/foovYVKZFdTwMTGmdSC8/pmW77vT7hPcTHoPmEW/+bq/WtlZUxMVRCJGxLOUx6JTnHAtcVDz8W1yAAgkZYXlX7UsCrrA==;5:x4PtaC6n0u/9MuGCeWY3++Ql1mrQ3oKo7cBr9em8jrhY1oWTNA3fvOgtawSVGVEl0ND20xjkSxHzdXvEvp5Tv+voP/3aDiPq2X8tchdyX+HUlvWVdjtTLfC4/zFBqfyzbfF6IidYYRFaAdyMOjdMv64MjH3AWcnxXzzY1pdnC7I=;7:wQjZZPcbIsEyiBxEuQCF/qD4pvLScreRlMNSpVZcsWur1k+tyMcDP72qyveOm90uvv/h4xaeGRRS49H9/rTa1l0oHkJXMASC02lDbKkgXjkKeV9Uge1lgZrg5Cm+p91YmaDGyrtYTNwQhJFES8a/4xrP+BUEymu8672KbZY+vMCY9UB1kVOqKNqL6n49oRuEALI2ABqIEIcEAPYoYvp0phxvKxS6tnK5Q7qj8v+7/Qg3plgeCzXph9k8Ndjit9au
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39840400004)(199004)(189003)(86362001)(316002)(25786009)(83716003)(99286004)(33656002)(11346002)(476003)(66066001)(2900100001)(54906003)(99936001)(76176011)(14454004)(105586002)(8936002)(2616005)(229853002)(106356001)(82746002)(53936002)(36756003)(486006)(81156014)(81166006)(6246003)(6916009)(6486002)(8676002)(186003)(53546011)(6436002)(5660300001)(5250100002)(256004)(6116002)(4326008)(3846002)(446003)(6506007)(478600001)(68736007)(6512007)(97736004)(2906002)(26005)(7736002)(305945005)(102836004)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB587;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 4e84740e-65d9-4d8c-bcf9-08d5f9406e39
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB587;
x-ms-traffictypediagnostic: CO2PR06MB587:
x-microsoft-antispam-prvs: <CO2PR06MB587C37B23F898FCF4A46AD5BA230@CO2PR06MB587.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB587;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB587;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3iDkxAC0NUH5bvElCmoARRL/03Uuy0AkObxH3SBofPXT8ZBZU9HrpdF+UWjyebbe+l+CknjzGdwFM3HnihoZx1sNxwTufbjnYXbZYm5XDcTQ1V6/rCQr+5BaUUtiXEwGjO8WZD5WgPHo/1/cj373s2HywNdUKIcghA7AtHs4uUaC712pqDxzVM33naLamWc/9H2q6TJa+J6iS91q3dobVTV4IEexy1Ug9u5rKotrt7xtC8QMCgJjJh9bFcMy9H8at7NCamawRNMnfhVZlQRx5QS5pJofHGD/ZoMUlf+7/BNNhxq50dtIjE2EKTt6K+8kz6fljjIE9Mc1eptAsPH4W0nelqM1WSaACOqgS8mU8Ws=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_01B583AA-1E6A-4956-8BF0-E991256862A6";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e84740e-65d9-4d8c-bcf9-08d5f9406e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 12:55:46.3002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB587
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_01B583AA-1E6A-4956-8BF0-E991256862A6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 14.43, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:40 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 14.37, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>>>>> On 3 Aug 2018, at 10.54, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> A 1.2 device is able to manage the logical to physical mapping
>>>>> table internally or leave it to the host.
>>>>>=20
>>>>> A target only supports one of those approaches, and therefore must
>>>>> check on initialization. Move this check to core to avoid each =
target
>>>>> implement the check.
>>>>>=20
>>>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>>>> ---
>>>> I see where you want to go with these changes, but the way targets =
are
>>>> layered on top of the LightNVM subsystem does not align with it.
>>>> LightNVM can support different OCSSD versions and capabilities, but =
that
>>>> does not mean that a target (e.g., pblk) does. The way I see it, =
core
>>>> should only check for (i) the drive to expose itself in a known =
revision
>>>> and (ii) the reported structures to be consistent. However, =
specific
>>>> functionality is not for core to check upo.
>>>=20
>>> Why try to initialize a target, if we already know that it is =
incompatible?
>> Yes, that is my point. But the one who knows if the targets supports
>> something or not is the target, not the subsystem. Here, you are =
making
>> an assumption knowing the pblk requires the L2P on the host, but that
>> could change in the future...
>=20
> I don't believe it can. It is not supported by the 2.0 specification.
> 1.2 is legacy.
>=20

Ja... We both know that people is using 1.2 variants out there...

> I understand this from the perspective when checking for un-even
> configurations using the geometry. But this is a spec incompatibility,
> which I don't think the target should care about.

I see the point of not having this check in pblk since we know that we
are moving towards 2.0 and leaving 1.2 as legacy/not-upstream. But does
it really make sense to fail LightNVM on a 1.2 capability that is spec.
compliant? For all we know people could have this and use it from user
space or through an internal target.

Javier

--Apple-Mail=_01B583AA-1E6A-4956-8BF0-E991256862A6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkUMcACgkQIX4xUKFR
nnTZqRAAg8yQSKq2zMa3nnuN0xqzJ8+XFrL5bjOH1dKxxiMHEFzr5VjdQ9Bs7iy5
R99pKtWqfYwrqh+vjSww031hgbjw8ofS0VL4TqFA0Wqx8Tpks6XS4to0BqqDscsH
9lquaUqc23PiRuFBJIYQGjN/ySyQQgtT444Pzr+d7dAxzkNBeyTyzdr3wPCmeii+
1MT9UfRj05B4AbMPDh1QB35wu6rf2jk+piYYCstrivFeml41C7xC5qC7hXNYaICS
3a+JEoNhhN6Fdh344u4h0jfVVNjIq13g7YGi7c4j8HKO9xz+2Xhd5SFkGW9h4/q4
69aQQSlj38V623navu5R777xsuZkbij7BZVrLXkr5FxApp5NHQcWsZ/27CuJS+7n
1dUUmsqYY5b0wtgnEn7TbWBXiSelXNMXkoQB+J9d4Km5oyrxdCoPpEXXPkRIA+c2
Uwk5tgqfrpK6ElNO9luyzufUlLwQO15DZZjP887rb8JP34Vx7zlPByigmqJILm9v
nDQiJxFZbCQMOdCaFFWAMfBVL231ho42oiKIbnyGPlzPuiGFcoE6MKVaPRlBxjiF
G+VLGazAtYyE1o8R11AlEOUvhu9S4h4xGbqf+oMZLm8Qfuj+hukDpAOIBmUgQtTD
RWxcCJOv5todQzehujWStVQrnENGCpuSMuOvH1wTC2EsGHUDNzQ=
=uJK3
-----END PGP SIGNATURE-----

--Apple-Mail=_01B583AA-1E6A-4956-8BF0-E991256862A6--

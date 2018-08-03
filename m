Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F8EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE242175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="pJEnni7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE242175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeHCOMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:12:53 -0400
Received: from mail-eopbgr710044.outbound.protection.outlook.com ([40.107.71.44]:28382
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728833AbeHCOMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wayjWOyN8H4LefUjWuIjoAWsD9ABFU3fKILn1Z9JUT0=;
 b=pJEnni7yZw2ijHama1/Hemd+xHxisx97pEkEkCAhNRuoYNUkyMOpueoeXL+WQJxuKoWFYEV6LhEql9XNe9Cue+HcoD5xkWWujM0kWzQeMnw5sbn848ooe6gXY3IvYP4XtwT64bw1Bo7s0sXcDucWIXKoR4aIBpTvzsb1imJktKw=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB635.namprd06.prod.outlook.com (10.141.228.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 12:16:41 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 12:16:40 +0000
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
Thread-Index: AQHUKweuBQbrOBanp0uVNhhgjqWapKSt8ZYA
Date:   Fri, 3 Aug 2018 12:16:39 +0000
Message-ID: <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
References: <20180803085449.3436-1-mb@lightnvm.io>
In-Reply-To: <20180803085449.3436-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB635;6:5VWUy7yiEGV8d824DX0euPUUnu3IpNl2V6LtTyYKOuudf42bwV6h9TVibTT7D06NAYUouy0pTMO/JdUmLDOU3m2OAIpYpucy0PnHS3ZlTAFAk+wG+7AuWIVC6F6S/Jdy+/Y0jFkXeIMoFL49MbGwNc+0lP3Ob+KvocsJARMWLZMCf0dzbJUzak2QLQBbtZx8j+7i++mQtR57QolBGTHhUWNo3LiwPueRJdOTApECVIw/31OD2SY4R7ItImo1K2I+4E/JVZWE3oYqcAOqY9dMQ7IDMZogA2cRvuSAjiGVXL08ZvfRgwpBRj//os8Xig03zzPgZO88/FFeujRmYajxCMtffTVJGmGEEdiBVS0QphZxyiM8p200tzu8+1Hk4gRf2l6/SSE2xChjh5e4uOLex6g39BHkAaFt7TYwOb/3qL44HrZUzyIfNYOJP0uPL3vD7sna1cB/TMCQTpwwFudecQ==;5:dOLTLXxPiO+l4h+7JW4wTyox0NceSVBU79TcHLHSGunRSghHFrnsOu34QiDSCn8Br4JCnwR5RgDjhkzSaopy85KF3I8LkmomhYSsoSU30lK+C1AXK3Kzapj+QKPWyVI0cHQtYs5Vgbu6K96LsLKODjX5YdzBs0dMtXRGlvi4ldU=;7:+SM3297NTTb/eBm8Evn3nzzqvnrJmhKiDPtbrfcIxpsSZf4vtF+pi3gP2LHSgDtPOTZrRKI9WCAm0YvjNvAwfZaSmy0FD1sCylb2cKXdkeV20yfzRpjUHiLVM872SJzr+NpCKphvpRuStMGV5qn7hcTaSQxA6UNN+5A8yklKkZDhDNIMunuDLtXohEz0Nym7fxCqS5zAta+hnyZGbZnItKJhkmqJDARwGqNoaQ04O6Gyr8i1fb2sgygTXgbPQNDi
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(346002)(39840400004)(366004)(376002)(396003)(189003)(199004)(102836004)(3846002)(68736007)(6116002)(6506007)(97736004)(26005)(105586002)(186003)(8676002)(8936002)(6916009)(81166006)(81156014)(33656002)(6246003)(4326008)(478600001)(2906002)(25786009)(53936002)(36756003)(76176011)(7736002)(106356001)(6436002)(6512007)(486006)(99286004)(476003)(2616005)(2900100001)(316002)(5660300001)(305945005)(66066001)(11346002)(6486002)(54906003)(99936001)(83716003)(446003)(229853002)(86362001)(256004)(5250100002)(14444005)(14454004)(82746002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB635;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 4e36aac1-a928-4db5-18de-08d5f93af7a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB635;
x-ms-traffictypediagnostic: CO2PR06MB635:
x-microsoft-antispam-prvs: <CO2PR06MB63533C8D7989D2C93EDFDEBBA230@CO2PR06MB635.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB635;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB635;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oY49U57NJC9R10lfq8H64pqgkCWWJQRsyuBXg+mCrRhsOqAtd/KINHb9Ps7Nt9F3arG2pbigP0Gid606jgBksWlZTOrjYzVDQC8T0HUGDWl1TlPZOmlNbnlIPWL3puTRgOLHB7dOBGWmcklH1b/fMpFmcBdzJKShQIgus76I6xcgniHCDPvIh/FoZGeFYf/UNFlYygemwX+0sQYMv1ca+NrRA0it1FoSRxIf/A49uQygeBb1j2nzesqgKWvJrZIZJI8YetZul4C73JSvagVawVahuqxeydaWf9CgReHa1q+lYWcJphkljrxGysJnWy9y8E5pfOPcQJZ3iM1MOBPOZK1APLyRJCws4GXE+L9KHok=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5A4D8955-3463-4B10-BBFB-9A29FF12EA6E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e36aac1-a928-4db5-18de-08d5f93af7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 12:16:39.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_5A4D8955-3463-4B10-BBFB-9A29FF12EA6E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 10.54, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> A 1.2 device is able to manage the logical to physical mapping
> table internally or leave it to the host.
>=20
> A target only supports one of those approaches, and therefore must
> check on initialization. Move this check to core to avoid each target
> implement the check.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---


I see where you want to go with these changes, but the way targets are
layered on top of the LightNVM subsystem does not align with it.
LightNVM can support different OCSSD versions and capabilities, but that
does not mean that a target (e.g., pblk) does. The way I see it, core
should only check for (i) the drive to expose itself in a known revision
and (ii) the reported structures to be consistent. However, specific
functionality is not for core to check upo.

In this particular case, the NVM_TGT_F_HOST_L2P check should be pblk
specific, as it is indeed a 1.2 capability not supported by pblk.
However, a different target supporting this 1.2 feature can be
implemented on top.

As mentioned before, I started looking at moving checks to core too and
my initial thought was to add a .capabilities entry to nvm_tgt_type{} so
that these can be checked prior target initialization. Alternatively, we
can move all these checks to pblk-init.c. At this point, it is safe to
push 1.2 / 2.0 specific functionality to core as registered targets
would have validated the spec and the actual supported capabilities.

Thoughts?

Javier

--Apple-Mail=_5A4D8955-3463-4B10-BBFB-9A29FF12EA6E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkR6QACgkQIX4xUKFR
nnQKlg//eBcJdGKHmcQnEsjzkn6g+L/YnHFgEw9cfIfc8+rGnxwAd70Z4rFDlLYf
60r4p6aYnFVbdLYc1s+ibdVvCRZZ8778V4jGE8aVs18UD45XkIeYLWpHCEC9Lan7
7bBjj7fvqtfywmIgCLpdyH7ebXmPYYA3voGNBxUPEKEbSUPGQTTTY/1tOqOEs1vw
JAtXrZeVHn4n9uBKh97W5Y5r7h4v6sfgF6t3GvfuXuEDmx1CaGaZkdjKbxxgRTV8
8XujxINZU/2JJS+BYPx8X3a6jdL+9JNZfjfZtMZhc7XFyAHwanlSozAiH5++iS/e
e93OjF5o0Hjn/kygkgI4McB0RGLC0uj1cUmFlso8QmmRCA1vuWjY5B0lUM2zsfnY
9jv16w51mH1q1XeU/iEd3Jzqy1UBIr8W/HzZ5dPUTO4F/FSSsFAoIUM3q3CIPccs
rPfYRsA88nnikHC2WroBY897hwKAOpf0CoqgjjsA76RjySYd2uhopExV5ZHxPeK+
pY/sIukELilLyvqanIAlqdT4ys4HckHvCTgpW5Vu76l+FiC5tiQc8nl5wEbavwxF
vZLXAdzkr74g/GTFwprLSAcI36Q9ZbOfO0bbwlYfYiOR5tez6dDl0a6WQ6OBZm4M
NJn5NISO2IkuzwOFJNGkylk/FSqhMD5+V7pBadfhemnSl7jqqTw=
=DQPD
-----END PGP SIGNATURE-----

--Apple-Mail=_5A4D8955-3463-4B10-BBFB-9A29FF12EA6E--

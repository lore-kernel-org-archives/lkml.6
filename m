Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF6C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143002173A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="p/qMyxFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143002173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbeHNQJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:09:40 -0400
Received: from mail-eopbgr730066.outbound.protection.outlook.com ([40.107.73.66]:12865
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730488AbeHNQJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M+SLjm3pC91cnt6IB7Avy8N8Ruqg36YQr/QvIaurzs=;
 b=p/qMyxFm6+jeaQhzC0Mbty9/qpzeWx3SW1grgzxtvZCa4JIhnI3KyQOOoDhgnqHfb//iRQLBYcJxQyqjUZP0bk1RD/+gzdQJVrjfEBLZcbs2CzAOlMjbgXjINb+Urd6lw3viF9MeEOC6cvo1NuP04zeEvaHGq3SmnwQ3k9oQaMY=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB554.namprd06.prod.outlook.com (10.141.199.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.20; Tue, 14 Aug 2018 13:22:28 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.022; Tue, 14 Aug 2018
 13:22:27 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] lightnvm: move bad block and chunk state logic to
 core
Thread-Topic: [RFC PATCH 0/1] lightnvm: move bad block and chunk state logic
 to core
Thread-Index: AQHUM9E0EtL6Kj8kJE6svbb6o2BAu6S/PAoA
Date:   Tue, 14 Aug 2018 13:22:26 +0000
Message-ID: <3B0C813D-EA2C-422A-B017-07F4A5B11956@cnexlabs.com>
References: <20180814131735.6853-1-mb@lightnvm.io>
In-Reply-To: <20180814131735.6853-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB554;6:SXwAepAzkuBs332LnqkPzHFLLrA5CpQQOzj9Kz+c9bZW7MOO8F67M0CFmN0T9ebjkmEUvOMl4DShntmzf/WprDqq5kaw2TjwZWCRvwo1sY7qlpqrUH/MD3Q68SMHJST3qYmZshNXdHD2EKsP8Z7T/5GSOmyXu85Wi8dqPY9jko1oLTg7Y341iy+X90xvTkBXw5rK2iW9wescTDXW6so7BPStBfB1pLlAShmsvZg2eG+4a1Tn4TXGEzuoVRJNkIA+gPAwKsanDuRMqDdLm6bbMpWgZbCJvkvwiK92yGr5IvifDMTYkM1Hi3AWWp4FEniAORH4e2OkMyRPNoN9DxJPTPwaQEFUqrcqLiXB2M8yGzj9DQ7NpZjPxkK2LlpVMUZjEbrinf2KE8F9oU8fzHqaropv1u5S69fRXOTKeW9f1oZtETrSHkFbk07KrvKOO/hJ/f8r63AMMI1wOkYFttkKyQ==;5:CKJYES5HU85Lo5zmXmpEZv7Fwm6uRjiE14Jkq14ZaNhl8JFc8QZjSL54V1Dx4FiHKSWsqk/8Yv7SJUl6Sjgqy8+j+8LJ8HHQRJLPQoQqWlGYM0/1f0i0/F1S1pEkKfURX222BTgqn5iA82JZ4oe7OdLRE0h+OGor7h0IiKXFHK8=;7:mqdraekV/2KQhIMW+cHOsrZ0s7VJIVginsaH1V2I7+mRC4TWerAxh8MKo1dxL8y1Wsb1kY27vEXeoQsG/D1lP2xMUvLmYiGzv4BAvgiZQesZU4nARmv05ozhB4dMyhZIB8k8ZttkbwYk5WEc4CVHvmSq9pvjXrsoitM1gpOF15DaJTQ9q6ttivzp4J9Y+RQJiG2cTymTgTRO0Fvi373zglhgKvHa071GiV1mwT6yOsgNMv8+J9JOx6KLj2fCRLlx
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39840400004)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(99286004)(81156014)(5660300001)(76176011)(217873002)(478600001)(36756003)(81166006)(6916009)(54906003)(14454004)(86362001)(97736004)(68736007)(4326008)(316002)(6506007)(8676002)(7736002)(305945005)(256004)(25786009)(8936002)(6512007)(6436002)(2616005)(26005)(99936001)(476003)(2900100001)(11346002)(66066001)(53936002)(2906002)(6486002)(83716003)(102836004)(6246003)(3846002)(6116002)(186003)(105586002)(229853002)(82746002)(486006)(33656002)(106356001)(446003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB554;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 418bcbe2-fe51-4223-a392-08d601e8facc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB554;
x-ms-traffictypediagnostic: CO2PR06MB554:
x-microsoft-antispam-prvs: <CO2PR06MB554DDC55CA6E53563B4C076BA380@CO2PR06MB554.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB554;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB554;
x-forefront-prvs: 0764C4A8CD
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i8P6JlHxvUGZovgoMoC2A9+E8s17p7oOEwzmEH0dtPLElqkAVdvpc8WIepTivwN9AGwFua4ucCcPpLoAf8qWOe3Y5jC+CHIij2xo8gOjuVPFOGop4NbGeI6Z1ark5DhuWIsXQFNUyaMmF6hVrAKaPus2E4sW1sqoPpHlokIUQyq4eAo3RRYwVQJVhK571FqULUlu0M5g60UBqyXRMw4ltc6MlbEp7/7hfM/bCQ+6PwJcjSd+6JX6xZ+hhK2IwoZzIY7BsJno9soiI74EHcLBMbvSWUmFiupIHoO+pDRNsRAAoKGyyphVuHk8kMSu1Wm7gCW+t4Onn8D02vbGZ2O8dDa2D38IHuDcucn5Q5aF0TM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1985CC79-7CEA-467B-B2AE-90539FABBB33";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418bcbe2-fe51-4223-a392-08d601e8facc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 13:22:26.9818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB554
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_1985CC79-7CEA-467B-B2AE-90539FABBB33
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Aug 2018, at 15.17, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
> core.
>=20
> Javier, would you like me to pick up your 1.2 chunk state patch and
> merge it into this one, or would you like to rebase on this later when
> it has been reviewed?
>=20

This is great. Thanks! Let me look into the patch itself, test, etc. I'm
ok with merging the 1.2 chunk fixes here. I'll then rebase the 2.0 WP
recovery patches that I have staging and submit them.

Javier

--Apple-Mail=_1985CC79-7CEA-467B-B2AE-90539FABBB33
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlty15AACgkQIX4xUKFR
nnROCQ/9GtueUh20caiYuoFfZJ90gtHk2S1AfX7Slk9RQQ6dDefZmS/xdvSY+4JU
GZQg3RhJz1s49toDOOgCuKcU8F2WPNZsubreYd2suZBgYF+O4EdC12eKpVwUyOs/
BzyM8iYrr0I0indanazoPKKfH4Kn0HUvo3gj0xnaIVhVsCHba79Jhuh1yEiqWYrT
5jXAMVNoT5d7pJ2thdF+xUNFZuatm8eeQkV1vQTlabRdRdcTRbVRoJb0KNve4wS6
lBGu3EUjcHYAYmYKf3DKpWQByWN9ICxkwr7MDq8+xnLCtEWflx4tcgsDyivonSbG
QySSmWAILiLCk5Epcg5Lg/N1T5vhngsRfduhnrdD53JfxCZu0HjAlchnyJ/0Ymx6
koELWJWBqUVKYIRQuNfiy4Xpn8SX5T8f9msW9CLW77UmskQB5hCeKnb50GYAfiLW
N5CaJ8V70ZGOFnv++gj/SHctT/SFLahHVWC7Fy638N383GLXD7m4MMs4Sxq7FeSJ
dz0X1mFYaiCveL0wWJ3gzu29bKWD3gNUffCCW672BVdsSb5nUCUSG9xXiI4e8GL+
MfEESk6qFo0eMZUC2WMflMN7C+O7ChnvGlVnsU0YRoskQjtYf1n55surril5Eb8S
zNtsZWfWT2hVZE9lWv0gAKCceCcphFJbITN1Cb+iDijofyf6xaI=
=Wxc+
-----END PGP SIGNATURE-----

--Apple-Mail=_1985CC79-7CEA-467B-B2AE-90539FABBB33--

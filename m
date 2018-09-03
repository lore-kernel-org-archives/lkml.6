Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3957C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E6B20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="ZQD4Brer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E6B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeICNhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:37:51 -0400
Received: from mail-dm3nam03on0067.outbound.protection.outlook.com ([104.47.41.67]:52939
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbeICNhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOvIKXKksmNMi71OK55uMNTXCZb8gjQPrOBRK+Aghn0=;
 b=ZQD4Brery+gcTzUW86nzDMdj5fPmiZTsCf9M9D6ZzQ0smPGku50Iz725rmoWIT4AzGy1JkUWKr3M9zNeuUmmauQsxLDyfvH3FA5ivefSLbmbLN9StYNeOHhxJOMJfcSYVb4MFtBhhYGXWQG+Iawhl5su0Fcr7stq3FIV1JcHNag=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB460.namprd06.prod.outlook.com (10.141.196.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Mon, 3 Sep 2018 09:16:54 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 09:16:53 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
Thread-Topic: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
Thread-Index: AQHUQS9kK77UY0ca10mNeY2WW/uzcqTZ4p6AgARotAA=
Date:   Mon, 3 Sep 2018 09:16:53 +0000
Message-ID: <7FBEB635-C943-484D-A970-D3BF870BAFFB@cnexlabs.com>
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
 <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
In-Reply-To: <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [185.245.84.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB460;6:DCyq8LPHmOSwuDOPSAfj5N0mN8wObG522UfY4Vvweu1a5/zgszpVyy7avrfPYt0M1mb0LgPzDIspX/yJgxMxv2JsE6peUC/NPK9qOKUGuTWUt4nMPmRJEcktmPpISg22W2RcQpmncqSL1+AXpYg+3J/qzvXdlFjIHKB+/zCcTlaHoJWhkaTWJJf1tAETOhbZ30C7YZeo7NDHGTrd7RINy+vardHLhL/V20OH+Ki9v/X2BGfhF9S481XFZFG0famSDnaM3jG5eVHwdY4GLXPqlZXmqnfQMOUxNUhFp1vJ66TFepSQYHI+DabZI0YGa8LXmJo1gSWN4F6sK82j0T2HGNKBB1pbuG2URI1zzh5r5GJkQkFvPnVi7ZMtpEWyqPgy2y50pajB5JgYAJ9u3JleqBgHQkbmyp22f1xVjxg34docceE4cDYT2O55b2E1C3j+qYxzUukwM3D8iKi3gcv0IQ==;5:0+xxcMmeK7cFeJgwqYNGtKc1kMyzse5G34yfOKgIqpdH3kZ/B42Is1Zc2yuE8OY14rWocxvSRvKrUUQ7JY706dzmb5q+99UUjoT1Ez7hK7PLDnASVR/srgbKruELT4iz1IdJikcjtM2gD6nR1+hklsuUCtm8vUVavNMJnCUlVpo=;7:6Ek97s9wcvuCCI3wdLzssciVbHmTl2rZEKAJiUH91t3/P4r+ujmhSiuJp8fZxfrdxwxT7sPvGMid5hjpG1grTwP/njW+/z7ETX8uhko+OpgcjdEfapC3YEco4tfPHi0J5FcObxwsEtJNirDL68lYI/sAcnYe4armGJAIuKVk2DJRBYdnpsoyULdN7m1hqxbpKBoaugbDC1Mtym/GWJjnKR0vR5/c1Xl/e915OZxpPaYBYodahX0vP9jcGQd4L+AF
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39830400003)(346002)(136003)(189003)(199004)(14454004)(68736007)(76176011)(8936002)(99286004)(2906002)(2616005)(6436002)(6512007)(229853002)(3846002)(53936002)(6116002)(486006)(476003)(99936001)(4326008)(11346002)(8676002)(33656002)(36756003)(446003)(6486002)(5250100002)(6916009)(66066001)(316002)(7736002)(83716003)(106356001)(6506007)(53546011)(26005)(102836004)(105586002)(54906003)(25786009)(305945005)(186003)(86362001)(81156014)(6246003)(2900100001)(97736004)(14444005)(107886003)(478600001)(82746002)(81166006)(256004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB460;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 5e065b88-98a8-43ec-7e02-08d6117dfd43
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB460;
x-ms-traffictypediagnostic: CO2PR06MB460:
x-microsoft-antispam-prvs: <CO2PR06MB4605D87F3F303E59EA33110BA0C0@CO2PR06MB460.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:CO2PR06MB460;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB460;
x-forefront-prvs: 0784C803FD
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XJAGrvZAwO/MOf0SELLsFap/OZRmJJTtSzXhULmIDFOSuCwHbEUgi68oNqxR9fg5e4l26tvgFH/KbYSjYbzGwNvJ0J2+bspFmrmS9UXAUhpwkNZ5qvWow+UvrhCDS6O5AKtyJoAluVZdOSxeH5vpFGMTzRhPxLk2tudoYUGhxrhJ/ToLXEm7lBqiF5aeg827WcxbQ2Q3Qw2SF9Ol1pw1wdKGQoVq8TSgEOvYHypb+w0UoiT+spTkO9j8LZmPcZiSA61BIR0439WJCxcOXnOmzV0OFsfqpsTt1JIuxwSPG7zewY0dGE1Ld4Ys9a+du4pwxlhbD6a73i72IHeBeUipyrtFSgjbhPl7jikHLoS8TWU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9BF0F591-CAF6-46DC-B708-61CA4FCDACEB";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e065b88-98a8-43ec-7e02-08d6117dfd43
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 09:16:53.6006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_9BF0F591-CAF6-46DC-B708-61CA4FCDACEB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 31 Aug 2018, at 15.57, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/31/2018 03:34 PM, Javier Gonz=C3=A1lez wrote:
>> Matias,
>> This patchset implements support for retrieving chunk metadata when
>> submitting a reset/erase command. Patches 0 and 1 are small fixes =
that
>> can be directly merged into your patch:
>>      lightnvm: move bad block and chunk state logic to core
>> Also, note that these do not apply on top of your for-4.20/core due =
them
>> depending on patches that I sent before that you have not picked up =
yet.
>> You can see them though in for-4.20/pblk. I'll rebase as patches in =
the
>> list appear in your tree.
>=20
> Thanks. It is really confusing when you guys maintains an implicit =
order and posts the patches separately. I will appreciate that patches =
that are related are posted together, such that I don't have to manually =
track what comes before another. That makes it less of a pain for me to =
keep track of and we can keep the reviews together.
>=20
> This is the patches that I have in the pipeline (from before the =
e-mails from today):
>=20
>  - This serie - Pending review
>  - Serie: pblk: support variable OOB size - Waiting on review from =
Igor
>  - lightnvm: pblk: recover open lines on 2.0 devices. Which doesn't =
apply due to the fixes to the pad distance patch.
>=20

Yes, I know and I apologize - we should have a better flow. What do you
say that for windows like this, where we have a number of patches that
have dependencies that we post them in meaningful patchsets and point to
a branch where they are ordered, like in a PR? Then we can rebase and
propagate changes properly?

For this window, I'll rebase the rest of the patches in for-4.20/pblk on
top of your for-4.20/core, then we can propagate changes as they come.

Javier

--Apple-Mail=_9BF0F591-CAF6-46DC-B708-61CA4FCDACEB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluM/AIACgkQIX4xUKFR
nnSPlw/+LWvj9fJ0ivtsAUDOw6HK29PlpTwm16Pk6L0RComF25n2l/kTitrm9D2M
h1JpGMk8I9x2aq4cmrqJ+dL5AUPNYzhUyWQVMiTuBJpoa3SxSO62+pxW67K59g3C
xj0HRHl6UNfYXbp0is1OkqlDsTgDqfe7kp6tQhUjR48BhC4r/BDNZSJMe8lor4nQ
YWDT57j++hoiguVNpb/TRIuTFw2eUkTX1hVH2nuCoUluLcGU0koxxZTby+501ewJ
44AUyUSWqVaCV5w9+L/yonAn41pzOrxGkMZXVVd75zHzVjS22bX6i/q5oh7U6YuT
saaQKB3JI3J6Czal61t/Aol2eNxmV/S4LH0R09X+bawTToHkZKnth1PUl9mzKroW
6U9eYPd9PVhCB64aNKwGaNBtfYs42XJYcPY0/G+bu77tNMFPop1EcEp05Magnl0I
ZTISZMijT6wnk+KGYW6ci9+mRw3/Krt9N1NFtkkzHB6e9JjbSA4h5j1mV0RVfBLN
jcQyk0QKUyhoL9liwCxLzz4BPE2bNqKhvpupy1o8maMirTWU/O1ECZmrt2jbx6MQ
0RbYoWpgfKV2fafB93iQ+t7A/FjNKQP91bAqJkQWegUsEzxBF3uz6tPgprizUGcj
rb80G/FeeYh+6X61cUGTkxoluyPGXuxK2LVHDjBK4Fj4w97E5vw=
=VjXM
-----END PGP SIGNATURE-----

--Apple-Mail=_9BF0F591-CAF6-46DC-B708-61CA4FCDACEB--

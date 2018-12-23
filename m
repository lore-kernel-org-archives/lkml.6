Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E49FC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E22222A3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="p68l1NAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeLWQQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:16:28 -0500
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:35975
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeLWQQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzO/3URKqL3vha3jMymMVTaLXFcE9NyCPWOQoVXVEHU=;
 b=p68l1NAUxpJdlpCB/gXjjX/u5hnYYbiMTOJhwdz7TwxV1GPFGVeOx46R5MWsGtxBRA0IoD1Xl81YQFOPq2FV4bTFmYGS5k9FuGrtr1vW/WE+e0LVD9Bqw9CsVbFggHzHphg3WhIoKGBxNCjfBAiN30eIt1QIeu95cOoCN7QS9p4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1102.namprd22.prod.outlook.com (10.174.169.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 16:16:24 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:16:24 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.daney@cavium.com>,
        Paul Burton <pburton@wavecomp.com>,
        Andy Lutomirski <luto@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: math-emu: Write-protect delay slot emulation pages
Thread-Topic: [PATCH] MIPS: math-emu: Write-protect delay slot emulation pages
Thread-Index: AQHUmIvU0UY0CfycF02ZZK4s2JaOTaWMhJMA
Date:   Sun, 23 Dec 2018 16:16:24 +0000
Message-ID: <MWHPR2201MB1277DFE826A1F2A351D29CC7C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181220174514.24953-1-paul.burton@mips.com>
In-Reply-To: <20181220174514.24953-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWXP265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::18) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1102;6:CsBdr2Bt6BPyxxjzvCbWjV5ReIsivJkbM4uCmNqCeY0bYsK5wl1/x/mi44/Ma062jKBcnKavUwtwraM4+BHDOETQ8ds/B+7D40KtQCpz8wOj0KwVzNbOXxeTRMya+h7tTDtSI/QQU7yifsWX7JFRHVPLby8WAmeIvEziIMTIOiRX0DcqG2udfnv5mrF/jpi3NgZmYlSDnSCBNs1ofcOK7T9SZ0m57LxT8GT8C91aV5A95vlMbPefLqfMkpt/+qJjc+CtyRs85cTflafGWA6saIPGmw+2qpKeIxx/4mOibfOLl2F9L3Er3yecDY6uaRqsyyo3Hpg/MLmD6kqVD5LWpOnpK6Y82Of/DF+MhJNCvuDnl1IGmuUsqlvPjeL4ChowWAtyMhMIz638eTjkTcjYkXTZA88FAnmL8dUejciwYyK4eo0j4+JNQ+71hexR2fJnJA1eFu7x8LQ3xu7uYYQHKg==;5:cROC+EAl8qk9d6AQqf1XKFue6XzN/lWkfqbr6nMQ6Iw6LR5IZI9DXK4H9cUc62Cns/X4YZkba1Q7oxXz9GRtCoKpa+ShuTRHrwXT1Lp8kXEVkBcLdxLvpyDr7kVL4CwJ8eaegW1tf0SNv6iJo+WYWMBOsXq9PF2NFqbNYgzfmqg=;7:d68jJBmdAF65KqHj1XzZzTOW8G5rjoNWfBCwyl4T6mhX/IRkejvdk//d3YD3vpf8hazadNpHT2F+e8bhgFqMHTU3Rcl1SVv4AZRbLTJtcXqkID+EYHl6/6BfR2eAuFf5AwW/NgNG9ku0t3n1xVkzTw==
x-ms-office365-filtering-correlation-id: f2672bb7-8299-4b9b-8219-08d668f1fbdb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1102;
x-ms-traffictypediagnostic: MWHPR2201MB1102:
x-microsoft-antispam-prvs: <MWHPR2201MB1102A14B7D1386704136AD73C1BA0@MWHPR2201MB1102.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(52105112)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1102;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1102;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(376002)(366004)(199004)(189003)(105586002)(6506007)(386003)(6116002)(71190400001)(102836004)(6436002)(229853002)(99286004)(6246003)(76176011)(71200400001)(26005)(33656002)(106356001)(3846002)(68736007)(7696005)(52116002)(54906003)(186003)(316002)(5660300001)(97736004)(55016002)(8936002)(2906002)(256004)(14444005)(4326008)(476003)(8676002)(81156014)(6862004)(81166006)(9686003)(7736002)(305945005)(74316002)(42882007)(14454004)(446003)(478600001)(53936002)(575784001)(66066001)(44832011)(25786009)(11346002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1102;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0sK57Jq9glP7xqDBEzaEefDg5eGkHRfkssfPd1nbCIgN1q+h9FHqhfDQ0tE+SIu95/pEz7Yshwodno1tF2b3DxZDz013hyWpoz6Y/fLJmgPoY0lph7oSz8+CcWCg7IRfMfp2To3ozc1ViDo9fB0bS+rvTz+KqXoTZiwaOPByPDR8RnHFn1SiSqstZzd2RVskats8bPsAdSPSB8FWftEwKYsxjSjinG3E6+Llokpa4LYAO5+ZBe3ebEU2/bg/4EtrY/ZlJHeBeGPTl6nkQFoWO7jHECYfrphq+wAUufdCsP0kPFnl+K4jQ6bPKHsI5oeE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2672bb7-8299-4b9b-8219-08d668f1fbdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:16:24.4400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Paul Burton wrote:
> Mapping the delay slot emulation page as both writeable & executable
> presents a security risk, in that if an exploit can write to & jump into
> the page then it can be used as an easy way to execute arbitrary code.
>=20
> Prevent this by mapping the page read-only for userland, and using
> access_process_vm() with the FOLL_FORCE flag to write to it from
> mips_dsemul().
>=20
> This will likely be less efficient due to copy_to_user_page() performing
> cache maintenance on a whole page, rather than a single line as in the
> previous use of flush_cache_sigtramp(). However this delay slot
> emulation code ought not to be running in any performance critical paths
> anyway so this isn't really a problem, and we can probably do better in
> copy_to_user_page() anyway in future.
>=20
> A major advantage of this approach is that the fix is small & simple to
> backport to stable kernels.
>=20
> Reported-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: 432c6bacbd0c ("MIPS: Use per-mm page to execute branch delay slot =
instructions")
> Cc: stable@vger.kernel.org # v4.8+

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]

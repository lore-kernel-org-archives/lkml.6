Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92658C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516862084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="GD24eTNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeLOV0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:26:50 -0500
Received: from mail-eopbgr760137.outbound.protection.outlook.com ([40.107.76.137]:40426
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbeLOV0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbmnsLJZPbUIU1l+Glyywnr8p7M+ZYXVjYTWSr2IYBI=;
 b=GD24eTNg2QlwdRdwkbKUITJ9JGf8yaVpuOHYtmpdUCxuf6Hx1urVhzKwOG2RBeS2M0ntpoVWcyGcz230WMVK+4I9g1hpOYFS00iaptiZW8M3Pc/sxZofI5YPNRRWipcPz/gnEuSUFhK2OqtuPydFryIiZ6ocKvcStWWcBB3x6E4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1744.namprd22.prod.outlook.com (10.164.206.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sat, 15 Dec 2018 21:26:45 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Sat, 15 Dec 2018
 21:26:45 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Rich Felker <dalias@libc.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
Thread-Topic: Fixing MIPS delay slot emulation weakness?
Thread-Index: AQHUlKsnfXRylMltrkarAU/KL34KxKWAUGmA
Date:   Sat, 15 Dec 2018 21:26:45 +0000
Message-ID: <20181215212643.sfk2zwzatdfysbk3@pburton-laptop>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
In-Reply-To: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::43) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1744;6:qy5Ugi9+sBQtS2n7jy/VsInZCv9ojJO55hrNEj+ZOm0HvTZ6elU29EHeOtCwrqHTXkYuAKyfPCFRiR92bnBJ5oJq9QX3u8VG3h1FmlhJw7I+MdDvjYV/aQ68ssqWco8kjQVfqTBCL5AXhVg9Sbvy4oV6wHWx23/3zq5/9WB9ijE4P3QOaPZZb/Ze46ettwTROAIizDcT8f9n3QuBvLnAhyWG/SBXaRjBHHnZAqgMXGSVMu5gKiDpH68tOdwtqZ93PSwlHCbhcnEaPbDL9AiImZvw/EWRT9HAbXMSjHqMJBAyTen6BYHUZyvvQ35i2RWAlNt2Z0z2y3b1+rXVYl24Tge6uyyzZ2tLkhYgiZ/Osac/ZmonBBMoyCAG4uH1rSOaeoPmEFGaAEE6nKNpmT0ndIbfB4A0tf57XL1/k4MFMUuxN+97zSMgkEhNL+3nqQt111c40985XBH8NP3KApdkHA==;5:HI5YlU3N6bQAWgdYLZTInD1pzoQCuNchFXrkc4u+h2Ababp4rFe19MEf+M3O6UPQTwEevLbNgXxep18GSzrruz7XbcLOdFA8c7gr3tCOpHwEbq7tayudloXIzQwyW7sYmc9QXbYE/gWPIYy/9DFiOgEvxGRH/X7jKiCAx/BK1oA=;7:OQ2H27ux1+95pRlx2gqEhUvz2A7WLXLBwbp6omN6OlEl5OxWXCcrY3vTgIR8JzctMbMUEfnWL8OWTc/42qutUto+PSI/1KxHiCAzYMIZpjKZPVSdnTNsUgkyLI4uovV6qFVvdsYiOIdQ9c1tfzbvSw==
x-ms-office365-filtering-correlation-id: a42d698a-a71c-431d-6a50-08d662d40351
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1744;
x-ms-traffictypediagnostic: MWHPR2201MB1744:
x-microsoft-antispam-prvs: <MWHPR2201MB1744DBE447D22CFDE8BD913AC1A20@MWHPR2201MB1744.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231475)(944501520)(52105112)(93006095)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1744;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1744;
x-forefront-prvs: 088751B4D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39830400003)(346002)(366004)(136003)(396003)(199004)(189003)(54906003)(316002)(476003)(106356001)(9686003)(11346002)(6512007)(81166006)(58126008)(97736004)(99286004)(7736002)(1076002)(508600001)(8936002)(6246003)(68736007)(53936002)(2906002)(76176011)(52116002)(186003)(386003)(33896004)(6506007)(26005)(102836004)(14444005)(71200400001)(575784001)(256004)(81156014)(14454004)(42882007)(305945005)(229853002)(33716001)(6116002)(4326008)(66066001)(6916009)(3846002)(25786009)(486006)(5660300001)(71190400001)(6436002)(6486002)(44832011)(8676002)(105586002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1744;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7yaExyENSH8AfwLFNYiiDrknQ1AjgMDgp7bPsbIn7JRcPu2pgq1a2YeV2lzbnksyFl0zWLFIRQHTBc9raw7lDwvfTfYUHKAd9sK7Uhw6wzluOdwAiy+bj8dZiymDM7/Vt2kRhklshKsSIhkAAGQb/uoWd3iFWn8E82e6zlGjn37e2lI7Q5zgUheoZkkPKxwVayQYxvu0vN2NHtnYB3OLozjdGEc5FsfwWt21+0IFnV2GbxDjRi15XPp5ehWB0LFtAfg69RRXKw9UqnWLQ9T/IOHnAWsUZuVMAB4XXOpiFHJ1PPrz0K7Y0Kllu6JyDGFj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93D89A71333CCD46975800A7075EA236@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42d698a-a71c-431d-6a50-08d662d40351
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2018 21:26:45.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sat, Dec 15, 2018 at 11:19:37AM -0800, Andy Lutomirski wrote:
> Some security researchers pointed out that writing to the delay slot
> emulation page is a great exploit technique on MIPS.  It was
> introduced in:
>=20
> commit 432c6bacbd0c16ec210c43da411ccc3855c4c010
> Author: Paul Burton <paul.burton@imgtec.com>
> Date:   Fri Jul 8 11:06:19 2016 +0100
>=20
>     MIPS: Use per-mm page to execute branch delay slot instructions

Are there any further details you can share? You'd still need to
persuade a program to both write to & jump to the page, right? We're
talking purely about this providing writable+executable memory?

For the record prior to this patch we had to keep the user's stack
executable & write instructions there, so this didn't make things any
worse.

> With my vDSO hat on, I hereby offer a couple of straightforward
> suggestions for fixing it.  The offending code is:
>=20
>         base =3D mmap_region(NULL, STACK_TOP, PAGE_SIZE,
>                            VM_READ|VM_WRITE|VM_EXEC|
>                            VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>                            0, NULL);
>=20
> VM_WRITE | VM_EXEC is a big no-no, especially at a fixed address.
>=20
> The really simple but possibly suboptimal fix is to get rid of
> VM_WRITE and to use get_user_pages(..., FOLL_FORCE) to write to it.
>=20
> A possibly nicer way to accomplish more or less the same thing would
> be to allocate the area with _install_special_mapping() and arrange to
> keep a reference to the struct page around.

Right, I can look into that.

> The really nice but less compatible fix would be to let processes or
> even the whole system opt out by promising not to put anything in FPU
> branch delay slots, of course.

The ultimate fix comes with a switch to the nanoMIPS ISA which has no
delay slots :)

Thanks,
    Paul

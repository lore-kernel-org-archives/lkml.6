Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70417C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263B5206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="j71GqlFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263B5206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeLEGeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:34:44 -0500
Received: from mail-eopbgr760108.outbound.protection.outlook.com ([40.107.76.108]:13127
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbeLEGeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4ytKWgT+X8+PN4vTyRFEcfZK/nLS/a43J1JJDeKAdg=;
 b=j71GqlFT+2XCzZLaBhiMy08W2dvqeF6pEeCtvjLX6oTyZ+rukGKBTzGpfS/uDHP5ZH52VgaZkDonefgK/vXnBbUXhe+GbpndXo6SSws9Rw5UdDBFaiXbwi+49Qw+A6qjd/sX8aX4IpG5Q/o9SzEPgRxsfQrZB0F/ufKuaI0WwhQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1440.namprd22.prod.outlook.com (10.174.169.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 06:34:39 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 06:34:38 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v3 0/6] mips: system call table generation support
Thread-Topic: [PATCH v3 0/6] mips: system call table generation support
Thread-Index: AQHUh7+2vJcPJayLCUu+NWwjGxPGnaVt/QgAgAG8pgA=
Date:   Wed, 5 Dec 2018 06:34:38 +0000
Message-ID: <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com>
In-Reply-To: <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0024.namprd20.prod.outlook.com
 (2603:10b6:301:15::34) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1440;6:bJ9OX2vIAmA9bfuBF80NXeZNTzORVfxjwyDzoTS812IFDvRJ9Tyz+Rab2qb6Z+hYn1nQujdr0PlhxEgbErsCJyATemovTAmh/47d0/PmKtinBeVo/VEcH+/gSQvjVRD2vtXCG4E/bZ2svApLmi46f9scD+HgUuBHhfs7LZtNUfbmvVpAE1N5m1HYER2cSJHNoDALueuPMZlE+G7NGzjsA3B9XP7DYsRGU+l68yyAgqY5J3Vuob3Ph2OuDvSzwj9fVETsaMsOeY+7zWcQDCI9O0RCPHSL4nUhxKNJvQXe1CdmNwgzKTwlN4TUe4+aWYXLAMl5ZIswJdWsbRduDB+c8LQG3OwR9DMqQKi91D3C5kVPd1aV3j7NxfJFDdVIvuOG7x7t68lrj149s5PZpfTryJe7z8R8sBRV0DzZoU5Hfe14rX9mGso6Mnfn0kKThCjNhtDiO3id9OAXtpiZSByCQQ==;5:4TIwFnk4V1Oew3GkiwX2b0rU6IaoqD+ZmSADBqe7DK3k/9707IuNFEkRfVIfQU0eCaqBm/qXtqxT4ThedRA+vGn34zXzkqRp9Gxb8vNW0DffMfFXyi+ZmCXY9451e/DtOpNALsiTOWNfScjr8C2UNwFSdeWBDJuKdv1p1+gmWh8=;7:kCJPHt7ZudMp0DLQ1j1HmmRQLV0IsEB57/GLzRVHaRFnL/ZmbTNafJvKdcsJdjaHxZnb712Bbevys2M2pmR4zgerozJnBSiRDuOO+KjH47JR0hz2ceYv0s1hBXYcO5HdvmMjuYYhGYpFs+jeZTjFHw==
x-ms-office365-filtering-correlation-id: 1a9d813d-6ee7-4dd1-0af2-08d65a7bbad4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1440;
x-ms-traffictypediagnostic: MWHPR2201MB1440:
x-microsoft-antispam-prvs: <MWHPR2201MB1440547FDED96A63DB38BCABC1A80@MWHPR2201MB1440.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1440;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1440;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(136003)(396003)(39850400004)(366004)(189003)(199004)(501624003)(33716001)(6246003)(52116002)(33896004)(6506007)(386003)(102836004)(4326008)(7736002)(305945005)(508600001)(81156014)(8676002)(8936002)(39060400002)(76176011)(6116002)(1076002)(316002)(81166006)(54906003)(97736004)(25786009)(58126008)(46003)(9686003)(6512007)(53936002)(2906002)(476003)(11346002)(446003)(105586002)(44832011)(229853002)(486006)(6486002)(68736007)(6436002)(99286004)(71190400001)(71200400001)(106356001)(256004)(7416002)(42882007)(5660300001)(14454004)(186003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1440;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZttcL4rKnXi5aKjkEg9259QsbxS09hXQmhjJlElLroJBmA9EVrTkeHOnYghzvt5jEMipPy+5gbutI5Wi2zFLb0JUuxNPmmCqTuvW2qTzVFx3HQ1U4+F0J6nGQtoQ+1OBaz/Ledw9Jow+7hwpPmTYo+F4vKbGpT2lk9jYEBuHPqyg9VZLW6c9Jbz+QfbgFWgeSaXp0KuS4/r/Lvu+PmMR22ua2shGMTlbCMu2n4IrFS1FMMt02MbQ5+cg2xnJJupT5GYx4OiuXxPpVV/E6pXL+vsVFBy1CAOE3X7rVTmROnwre0qupLuqHg12jyTiL+43DcYDAcy0Gcc9gB4M55kTrd+91iwKnGCDDwGB2+zCvC8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9196FB1B3DCEF4AB42EA7080CB4923F@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9d813d-6ee7-4dd1-0af2-08d65a7bbad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 06:34:38.8035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Tue, Dec 04, 2018 at 09:33:08AM +0530, Firoz Khan wrote:
> Could you review this patch series. I would appreciate if you can
> perform the boot test on the actual platform.

This is looking pretty good to me, so I look forward to v4 with Arnd's
comments addressed.

I've verified that the sys call tables are identical for both
32r2el_defconfig & 64r6el_defconfig before & after this series, and that
both still boot fine.

Thanks,
    Paul

Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9456CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4661420823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UyE1TGv6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WRcaXP/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfBLOAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:00:09 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55918 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbfBLOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549980010; x=1581516010;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dmyDCrD8QLnkWSCpsz7FmLQrGwQlEOYty15e5kOk15I=;
  b=UyE1TGv6aQP+FTviXGcQrCYloXc/EweWgvJJtKA+mZSDn5RvO7ZGqfw3
   6eAA9gu2kTBbTGY6YZFVQG7wZcMM2MKQfW2+GrtHN+nS/9jr+MwmPPuhs
   ILAyieMhxak7cdPuW54s/WvpYhg9obyOnMdvwXORJz7np9vaCz6W02TW6
   Xt25M0ZSIenEOP6eVpkXmvXVXBnqa4XIYUNWkdjKj95AHjWZJmeTLSNiZ
   RzvBGfKZuy1sK1mqzgsmSejv0MxLdqhtvZ/ZeQmYmGTZHKmBmgX45L1Zk
   mrXJyMH3OaKNmqrLdLu3ocqGEoDSxkSkN5PNx+X3+gXBHcK+A07iWlETJ
   w==;
X-IronPort-AV: E=Sophos;i="5.58,362,1544457600"; 
   d="scan'208";a="106025544"
Received: from mail-bn3nam01lp2059.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.59])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 22:00:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX2I6izvPXiyFQYtGp1alvn8Gtkx12oF3L4mzWU2+EY=;
 b=WRcaXP/eYKWH21u3CrCXKT8qRKXitPrVAMlIj6//pBD5RswldkVxlWK9lGxynvekycZzs1nPp3xP3ctE0fkOAUfFpMFYK3FnWc7msiaMCWjK3BVXaVaoxHikBhAYhmpwJo52gu3sqK/yJgjufCErXlYcY2/PSlPrWA4izXUlxDc=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.247.148) by
 MN2PR04MB6062.namprd04.prod.outlook.com (20.178.247.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 14:00:06 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1%7]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 14:00:06 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v3 0/6] Fixmap support and MM cleanups
Thread-Topic: [PATCH v3 0/6] Fixmap support and MM cleanups
Thread-Index: AQHUwttCy3g1cjjuyEa0lFKk0Qn0DQ==
Date:   Tue, 12 Feb 2019 14:00:06 +0000
Message-ID: <20190212135942.105008-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::20) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:de::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.48.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c77e8cba-a3f7-4cf3-36e1-08d690f264a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6062;
x-ms-traffictypediagnostic: MN2PR04MB6062:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MN2PR04MB6062;23:GZ5cSFOAuqa1UQuLL9Txj/t8XSRFyulF6/EfSWk?=
 =?iso-8859-1?Q?aZa9cR3lh0NYZE1UhGUzFEUEEtddzvqWMU55QSy1Etaq/tpCfqz1H8STfL?=
 =?iso-8859-1?Q?EDJP4zfgyXOkqeNSka35Z39171WIXrd2fYqpLN5SR5UQ/gfGTPTnE0Lt54?=
 =?iso-8859-1?Q?2rw+Fmv4v9FhWUjn5cNtuperDG7i23mxyu0GZdyAYmV4lygGl47sfWcwTk?=
 =?iso-8859-1?Q?1qf0HQuMeqL7/gyjH42uhnHW7wZdWouyghiTsRrxwxC5BtpLoS7s/IaLU0?=
 =?iso-8859-1?Q?Frm8HSOypGkWXv8DyjEFOcUT2CYKTeBazSIFkzXK8Wa+dG9Y/cCKHYJG6d?=
 =?iso-8859-1?Q?KExFyo8UblhuIMPtBzCU/SUKLEl20iMlGpoWiXivaKhp0pjktmuhepGUWL?=
 =?iso-8859-1?Q?RpQDV0GpNqU1UkCFU0Jh2sUpYAaQ0jMcHU5/iSUvKKtnqU9FwGKm1YUpCe?=
 =?iso-8859-1?Q?AgCxjphofLzLQTeLJWcqR5uvmgSE+MPmOOG6N7Bz/HwsKh3y4BJqXCZnf1?=
 =?iso-8859-1?Q?NC4ErUOKMkWb3v5apZgmUNKQzqzd9zcaurSM9Fo60nIXdRvtGHe0Sf5ALF?=
 =?iso-8859-1?Q?ta5j0oxnuL9HEs2KbhWxyaYRZFMKWldWxY+SVtuKzBlRDUcU+ELxUPDWrI?=
 =?iso-8859-1?Q?nRSjW0i9/UkcO7FtLHYxcV5QOm39BCL+o/f0jlLuwaM5JbKgte/wzDkcTV?=
 =?iso-8859-1?Q?Tk+hz2ZuCKg8+gtRqBVqJ/RXhsINn8zwNjx5ZY8rZsJ+YEjeEgWqLSfHVD?=
 =?iso-8859-1?Q?bMtiy9K9TmjP7rLaMw3nHfevHrTylkppEQ1VdDscfzsV8J+8Bb20oF5zP8?=
 =?iso-8859-1?Q?ThKmYqgMZZt5Hh2v3ITgeCyCysA9RBMsduOTUsyPWDiRnLTrs2rJQrWpX4?=
 =?iso-8859-1?Q?w9tDOBKhtyJC6eCFKdlwAX4Lz069MNmmuaIG7kvvKPVoVLawJOrHlAF/8R?=
 =?iso-8859-1?Q?kD8wJlPD84y+TImUTlbrwcIT/T6dcQ0CjqrwMwhpquVaoqasE2vQj6Tef5?=
 =?iso-8859-1?Q?NofeBNF0Eua1bVVcFMR17s1XgBdyAbLannAyxZGBijcoTuWUkHeS8GH+wd?=
 =?iso-8859-1?Q?puQArpxMl2wtZs4fn8YhtsQeGU8czMFmFDQN7HScQGDheNjoButfWNRPLL?=
 =?iso-8859-1?Q?ZWhSgFXf1pa2dBGuaBOSuv+4vNthZq5ScgH22zkRTDcR0wpOq5+Nvwn2N0?=
 =?iso-8859-1?Q?g62ttvjyPVYHY+Hz7o286QDGPpQJwDt8YqCBwfFE1BtB+ngQT0nNocMMJK?=
 =?iso-8859-1?Q?rRnoR2oHzrF9wnN6mk0jGMWK809vIZKgw0klJfU/y1HpocepCz3eA1v+gT?=
 =?iso-8859-1?Q?UjhZx07qPG4ippIbRfmIF2V?=
x-microsoft-antispam-prvs: <MN2PR04MB60623F1DAD295ECCFD0D37958D650@MN2PR04MB6062.namprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(54534003)(8676002)(2906002)(81166006)(86362001)(44832011)(50226002)(2616005)(106356001)(68736007)(316002)(53936002)(476003)(81156014)(105586002)(25786009)(486006)(8936002)(55236004)(14454004)(6116002)(256004)(4326008)(36756003)(3846002)(71200400001)(71190400001)(102836004)(966005)(66066001)(386003)(52116002)(6506007)(99286004)(1076003)(186003)(6512007)(2171002)(6306002)(54906003)(110136005)(6436002)(7736002)(26005)(72206003)(478600001)(305945005)(6486002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6062;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PYfdDfe6vGeGOJ/IbhUsYNj5cVCRbtY8WnfG37p6kS3pxRQU+2/xBU/IwLWBVpKTp4Tb0j4x31ePccuF0L2417Qk9RCbTB0Oh8LkkxTGxSvWV4+YB3kU0D8vTe9pTDkjAfnikVCUFjiC0wY432w27j5rW2UWUh0h8PGFIRitchs5vizcmJo8hBkLdfUUD96PpK3GKYgtam3GewMqvkzAuRCHjxa3X+iVlS4ZoxeYXG2Sxo61/w3V8mnUXsc3HRheyVlsCN7p/CYlRIpyAIFrSUZQ9SyLMWDqGrfDn8UuQTk96h8kQHVLDYllAyRE44pOH5HbP9f4TPvsM0nORctySNAQY/8RjfS8yiH41cLpgaIBxtkT0O+y7pJKgaHbUaNNKxAHtlpAAHVgbTQekpGN1PsB+46oZEDF7VRi2Z+54zY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77e8cba-a3f7-4cf3-36e1-08d690f264a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 14:00:04.0174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup@brainfault.org>

This patchset does:
1. Moves MM related code from kernel/setup.c to mm/init.c
2. Implements compile-time fixed mappings

Using fixed mappings available, we can now get earlyprints
even without SBI calls. For example, we can use kernel
parameter "earlycon=3Duart8250,mmio,0x10000000" to get early
prints on QEMU virt machine without using SBI calls.

The patchset is tested on QEMU virt machine. It is based on
Linux-5.0-rc6 and can be found at riscv_fixmap_v3 branch of:
https://github.com/avpatel/linux.git.

Changes since v2:
 - Fixed commit description of PATCH6
 - Ensured commit description of all PATCH use upto 72
   characters per line

Changes since v1:
 - Use more characters per line in changelog of PATCH3
 - Removed #ifndef __ASSEMBLY__ from PATCH5
 - Use more characters per line in commets of PATCH5
 - Added PATCH6 to implement keepinitrd kernel parameter

Anup Patel (6):
  RISC-V: Move free_initrd_mem() to kernel/setup.c
  RISC-V: Setup init_mm before parse_early_param()
  RISC-V: Move setup_bootmem() to mm/init.c
  RISC-V: Move setup_vm() to mm/init.c
  RISC-V: Implement compile-time fixed mappings
  RISC-V: Implement keepinitrd kernel parameter

 arch/riscv/Kconfig               |   3 +
 arch/riscv/include/asm/fixmap.h  |  44 +++++++++++
 arch/riscv/include/asm/pgtable.h |   1 +
 arch/riscv/kernel/setup.c        | 114 ++++++----------------------
 arch/riscv/mm/init.c             | 124 ++++++++++++++++++++++++++++++-
 5 files changed, 189 insertions(+), 97 deletions(-)
 create mode 100644 arch/riscv/include/asm/fixmap.h

--=20
2.17.1


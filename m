Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79503C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD212175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C+/GO7TY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfBETHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:07:13 -0500
Received: from mail-eopbgr740072.outbound.protection.outlook.com ([40.107.74.72]:3520
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbfBETHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxwYboRLf+5X1ViXjsQ2WLtKoJdwItoY4rtZdGx3daI=;
 b=C+/GO7TY5ET5RK0Ki/TtZQl5YJx9f4TR2EgtC1Awm7d+ZHqyPTHvt82zjAGjy5bHckcACNMAXhNFFjzsVOdatd7yz+CLY1ct4pvblz9shRWXpL1gg4ZwXGfVpHjxY89XYMMaDX5MfrUXLSFYs8FrH4nj8TbLuB+myI12Jr0bXf4=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2644.namprd12.prod.outlook.com (20.176.176.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 19:07:07 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5%2]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 19:07:07 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: RE: [PATCH 10/10] acpi: bgrt: parse BGRT to obtain BMP address before
 it gets clobbered
Thread-Topic: [PATCH 10/10] acpi: bgrt: parse BGRT to obtain BMP address
 before it gets clobbered
Thread-Index: AQHUutuIySH8oBtHWE66bBohB0AJ6qXRkQkQ
Date:   Tue, 5 Feb 2019 19:07:07 +0000
Message-ID: <BN7PR12MB259308A068895E416766F8DEF86E0@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
 <20190202094119.13230-11-ard.biesheuvel@linaro.org>
In-Reply-To: <20190202094119.13230-11-ard.biesheuvel@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2644;20:GHugVHMuH6oMJijB7GlQYM311M/o9AvF6HlRyfza/rINgsQmHBrN0QcccHCpTcqJjON7JGxoONTQzFes+jR7EzRLZ+TMeu1ouxZOLJRSkTQu95a1tTDTIu/GjUBjRCqUhpDRtZXm23ITPInUWLoNca+v9Vu7AxGfmCSktIs19gAWiHDXZP9Ppp1sXgNuiFP/V47BnTtkIMIJKsq16LdYSoMcTKan6iLVTgH+WPbe7KHgVOIb9Xw5wobe8Aek3Jn3
x-ms-office365-filtering-correlation-id: 94e58463-2853-4a84-51ad-08d68b9d1fa3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2644;
x-ms-traffictypediagnostic: BN7PR12MB2644:
x-microsoft-antispam-prvs: <BN7PR12MB2644A616680E8F89CB5BA8F7F86E0@BN7PR12MB2644.namprd12.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(346002)(39860400002)(376002)(13464003)(199004)(189003)(76176011)(14444005)(7696005)(72206003)(256004)(14454004)(2906002)(478600001)(11346002)(99286004)(446003)(54906003)(25786009)(186003)(229853002)(97736004)(68736007)(33656002)(6436002)(316002)(26005)(102836004)(4326008)(6506007)(6246003)(53936002)(110136005)(74316002)(2501003)(305945005)(8936002)(55016002)(7736002)(66066001)(86362001)(53546011)(3846002)(71190400001)(7416002)(9686003)(486006)(105586002)(476003)(81166006)(81156014)(71200400001)(6116002)(106356001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2644;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZXExqbouDytHDgHU4kRYUPYHebVKj5DbJDmh20VNAFkTpwDQc6JQH/dUCrvHxo4CrXIx38gtvs48zKCAEX+ik5+W1eL+ilVKwPdovVmdFoh8PRLQRXOgYAAS/40JEXOkqNtHmJ2zmmsuAqRKqznzObbwnY8CNUUUAg5NlAVv4FgdT5+sRwF2te/4AxZ3FKS8xIlnriXRPR9LKsXrrruXCHBc/FvEcP90kqhRtNyGSKxxXVZMW8nXIYJHIGRXHLz/hnltCgW4w2wnzSe0+8ElRYxmdLHgwqSQP5ANIwmGIEnPinrFyolmDGoPbC1x+LZKPkmFUgZBiWG3bGsAcgI8/w+zolQXIzvAojoOoFVu/rc0lNr1NP3YV5sSmHI+xzIFgghGWlQSg2vRfOv8G0SOww2KGX0MdaGYQqIcChruxHg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e58463-2853-4a84-51ad-08d68b9d1fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 19:07:07.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Ard Biesheuvel
> Sent: Saturday, February 2, 2019 3:41 AM
> To: linux-efi@vger.kernel.org; Ingo Molnar <mingo@kernel.org>; Thomas
> Gleixner <tglx@linutronix.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>; linux-kernel@vger.kernel.=
org;
> AKASHI Takahiro <takahiro.akashi@linaro.org>; Alexander Graf
> <agraf@suse.de>; Bjorn Andersson <bjorn.andersson@linaro.org>; Borislav
> Petkov <bp@alien8.de>; Heinrich Schuchardt <xypron.glpk@gmx.de>; Jeffrey
> Hugo <jhugo@codeaurora.org>; Lee Jones <lee.jones@linaro.org>; Leif
> Lindholm <leif.lindholm@linaro.org>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Jones <pjones@redhat.com>; Peter Zijlstra
> <peterz@infradead.org>; Sai Praneeth Prakhya
> <sai.praneeth.prakhya@intel.com>
> Subject: [PATCH 10/10] acpi: bgrt: parse BGRT to obtain BMP address befor=
e it
> gets clobbered
>=20
> The bitmap left in the framebuffer by the firmware is described by an
> ACPI table called "BGRT", which describes the size, pixel format and
> the address of a BMP image in memory. While the BGRT ACPI table is
> guaranteed to reside in a "ACPI reclaim" memory region, which is
> never touched by Linux. The BMP image, however, typically resides
> in EFI Boot Services Memory, which may have been overwritten by the
> time the BGRT discovery routine runs.
>=20
> So instead, drop the handling from the ACPI init code, and call the
> BGRT parsing code immediately after going over the EFI configuration
> table array, at which time no memory has been touched yet except for
> the .data/.bss regions covered by the static kernel image.
>=20
> Unfortunately, this involves a non-trivial amount of ACPI entry
> point and root table parsing, but we cannot rely on the normal
> ACPI infrastructure yet this early in the boot.
>=20
> Also note that we cannot take the 'acpi_disabled' global variable
> into account, since it may not have assumed the correct value yet
> (on arm64, the default value is '1' which is overridden to '0' if
> no DT description has been made available by the firmware)
>=20
> Cc: Peter Jones <pjones@redhat.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

Hi Ard, et. al.,

I'm trying out tip/master and I find that my system panics early during boo=
t. Reverting
this patch seems to resolve the issue. Please see the trace below.

I've started debugging, but I'm not familiar with this code. Please let me =
know if you
have any ideas or if there's anything you'd like me to try.

Thanks,
Yazen

[    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate 0x0000=
000000000b40 bytes below 0x0000000000000000.
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc5-merged-bas=
es+ #101
[    0.000000] Call Trace:
[    0.000000]  dump_stack+0x63/0x85
[    0.000000]  panic+0xfe/0x2a4
[    0.000000]  memblock_alloc_base+0x33/0x35
[    0.000000]  memblock_phys_alloc+0x10/0x12
[    0.000000]  efi_memmap_alloc+0x62/0x65
[    0.000000]  efi_arch_mem_reserve+0x10e/0x194
[    0.000000]  efi_mem_reserve+0x31/0x36
[    0.000000]  ? efi_mem_reserve+0x31/0x36
[    0.000000]  efi_bgrt_init+0x2c6/0x2e0
[    0.000000]  efi_config_parse_tables+0x1b2/0x1dd
[    0.000000]  efi_config_init+0x7b/0x9f
[    0.000000]  ? efi_config_init+0x7b/0x9f
[    0.000000]  efi_init+0x366/0x465
[    0.000000]  ? 0xffffffff87800000
[    0.000000]  setup_arch+0x42f/0xcc9
[    0.000000]  ? printk+0x52/0x6e
[    0.000000]  start_kernel+0x6c/0x516
[    0.000000]  x86_64_start_reservations+0x24/0x26
[    0.000000]  x86_64_start_kernel+0x74/0x77
[    0.000000]  secondary_startup_64+0xa4/0xb0
[    0.000000] ---[ end Kernel panic - not syncing: ERROR: Failed to alloca=
te 0x0000000000000b40 bytes below 0x0000000000000000. ]---


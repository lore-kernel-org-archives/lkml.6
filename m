Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DEF7CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C545208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="TakE7L+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C545208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935890AbeFMWT3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:19:29 -0400
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:16460
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935384AbeFMWT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JT4nIJz4c5uI1lTa3Pp9lz6XWnd7OobHGvMegMgXW0=;
 b=TakE7L+tk9KYNsM4NVPNFED9iWUDqaOz9FNJ42eKEMsEdqa7XVgPCKQG5szscvAaaGdj+xiuxr/QI9FOPhfOHZaioQway5H+wyTFWEskJQw6/2cM5PbtcYQoYOX5syoUkFmiUpnJ+esb1AILXK3ol9mVjjWTt+qA6uwB0eEOBQE=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4769.namprd05.prod.outlook.com (20.177.145.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 13 Jun 2018 22:19:24 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::9cb3:7cc0:9f85:b1c7]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::9cb3:7cc0:9f85:b1c7%2]) with mapi id 15.20.0863.016; Wed, 13 Jun 2018
 22:19:24 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] Makefile: Prepare for using macros for inline asm
Thread-Topic: [PATCH v4 1/9] Makefile: Prepare for using macros for inline asm
Thread-Index: AQHUAoBcWQHwkR0gx0yiggpe5MmWsaRedzMAgABM9AA=
Date:   Wed, 13 Jun 2018 22:19:24 +0000
Message-ID: <D9AF0864-EE2A-4C2E-A5A4-C002DEB95B2B@vmware.com>
References: <20180612115050.185112-1-namit@vmware.com>
 <20180612115050.185112-2-namit@vmware.com>
 <CAK7LNATmjTi4Odp5AfbVHCemn7S_tB9nKvgNOf5sp8BiVJma7Q@mail.gmail.com>
In-Reply-To: <CAK7LNATmjTi4Odp5AfbVHCemn7S_tB9nKvgNOf5sp8BiVJma7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4769;7:iPFaehXcXqNEtmtcED9nOxbT1kG0CCXRFJPEPIkOQdpdz1pkX3WR22CZN30larrhdqy5f57y98rs7nFaI1MWmiAH9ypW4ICtjJHIgtBtP64/92zy1jHhUZcoGrHvU9XfN2Lk1HChD6CBolbhGq4JFgwQvHjMGOZ92DbWJCe6pemWCDiHCoCZ2AOCOHThf/n3KiojX2sJOPRl0hmHmwlk8wbVR8z7o9TQSmXw5Jo3rNXbmPXP7QZivjOrailCDi1K;20:ZhIodL9ebDITdCopuVCiXDiID4ptB45QBm+FCLNwQH2UabFyvRNRa4yOL6qWKBaveA81XUl6g7iulDRZ2DHVb4LPACI5Tk4uhwYJPj5BVOpRjlw/rYEXVAU1qCfKIrj7Xv+GMWMWdskolfCyfL0MKASWE5kdtRT40Z+l3JJAVDE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 7f0b243d-3bf4-433a-76c8-08d5d17bb810
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4769;
x-ms-traffictypediagnostic: BL0PR05MB4769:
x-microsoft-antispam-prvs: <BL0PR05MB4769E2958657FAEA8C09007FD07E0@BL0PR05MB4769.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR05MB4769;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB4769;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(346002)(39860400002)(51444003)(189003)(199004)(53936002)(7736002)(6916009)(5250100002)(2616005)(446003)(8676002)(68736007)(6246003)(8936002)(11346002)(81156014)(4326008)(99286004)(5660300001)(97736004)(81166006)(3846002)(6116002)(105586002)(305945005)(476003)(25786009)(82746002)(486006)(14454004)(186003)(3280700002)(2900100001)(66066001)(86362001)(33656002)(229853002)(6436002)(76176011)(106356001)(6512007)(478600001)(6486002)(316002)(6506007)(102836004)(83716003)(54906003)(36756003)(3660700001)(2906002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4769;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gFAI9Ivcchc5mNqz2zrFA5Avj7r/XjL/XtwGoMicS2aWS34EC5f4RUVC9ciMFe2y0mCRsk1oH1La0Qkpk6wy2f4f2yI+JbPell0ZyXSUy8Xq9UEsVNSH5GpzWrcUl77u3aM1a4cJxEOE/Y3WwiSBdvK5HMpc+K127FQq4rGGDvR2YWcXFnpzGONIX/FKG3Pz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E2A08E6687B074F87E68E9627067233@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0b243d-3bf4-433a-76c8-08d5d17bb810
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 22:19:24.0656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comment! I am certainly Makefile-challenged, so your help i=
s
highly appreciated.

Please see my responses/questions inline.

at 10:43 AM, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> 2018-06-12 20:50 GMT+09:00 Nadav Amit <namit@vmware.com>:
>> Using macros for inline assembly improves both readability and
>> compilation decisions that are distorted by big assembly blocks that use
>> alternative sections. Compile macros.S and use it to assemble all C
>> files. Currently, only x86 will use it.
>>=20
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: linux-kbuild@vger.kernel.org
>>=20
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>=20
>=20
> I have not fully understood this series yet.
>=20
> I do not have enough skill in x86 architecture,
> but just some comments from the build system point of view.
>=20
>=20
>=20
> I guess this will probably break the parallel building.
>=20
> Kbuild can build 'prepare' and 'scripts' simultaneously.
>=20
>=20
> I locally modified the following line:
>=20
>=20
> diff --git a/Makefile b/Makefile
> index 2dea909440..6ad484a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1030,7 +1030,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
> # Error messages still appears in the original language
>=20
> PHONY +=3D $(vmlinux-dirs)
> -$(vmlinux-dirs): prepare scripts
> +$(vmlinux-dirs): scripts prepare
>        $(Q)$(MAKE) $(build)=3D$@ need-builtin=3D1
>=20
> define filechk_kernel.release
>=20
>=20
>=20
> masahiro@grover:~/workspace/linux-kbuild$ make  defconfig
>  HOSTCC  scripts/basic/fixdep
>  HOSTCC  scripts/kconfig/conf.o
>  YACC    scripts/kconfig/zconf.tab.c
>  LEX     scripts/kconfig/zconf.lex.c
>  HOSTCC  scripts/kconfig/zconf.tab.o
>  HOSTLD  scripts/kconfig/conf
> *** Default configuration is based on 'x86_64_defconfig'
> #
> # configuration written to .config
> #
> masahiro@grover:~/workspace/linux-kbuild$ make all
> scripts/kconfig/conf  --syncconfig Kconfig
>  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
>  WRAP    arch/x86/include/generated/uapi/asm/poll.h
>  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
>  WRAP    arch/x86/include/generated/asm/early_ioremap.h
>  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
>  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
>  CC      scripts/mod/empty.o
> Assembler messages:
> Error: can't open arch/x86/kernel/macros.s for reading: No such file
> or directory
> make[2]: *** [scripts/Makefile.build:318: scripts/mod/empty.o] Error 1
> make[1]: *** [scripts/Makefile.build:558: scripts/mod] Error 2
> make: *** [Makefile:1050: scripts] Error 2

You are right. I tried to filter out the use of the switch (exported as
ASM_MACRO_FLAGS) for empty.o. Any suggestions on how to do it properly?

> Are you planning to support for all architectures, or x86-specific?

Not right now. But I think that other architectures will also prefer to
separate the inline assembly chunks in a similar manner, for better
compilation, easier readability, and better code maintainability.

Thanks again,
Nadav


Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F229C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A6520834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="U16+3b+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A6520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJZE1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:27:07 -0400
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:27154
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbeJZE1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSL3JMOolczDWffyi92TyDyE5DgERdVQ9mCi/xsodF0=;
 b=U16+3b+mqPdYHzptXEK/1gmLLy6TtnkM5R7R1cTjnUzgwA6NNnQgtBMEUKUDMDSd9e7RB5eL1vEvOwUAAgt0WEu7aIGXn33Fs4IEv3iVNGP9m1ttjBTdt+wED2HkaL6S3ZL7belKpQ6lbDsh7dp7Aa5EX21fMGD9Mvv/v7079EU=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1421.namprd22.prod.outlook.com (10.172.63.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Thu, 25 Oct 2018 19:52:56 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1273.022; Thu, 25 Oct 2018
 19:52:56 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL 4.14 33/46] MIPS: Workaround GCC
 __builtin_unreachable reordering bug
Thread-Topic: [PATCH AUTOSEL 4.14 33/46] MIPS: Workaround GCC
 __builtin_unreachable reordering bug
Thread-Index: AQHUbGyp4ZMIC0bLFUybkBvjm/PHRKUwX8kA
Date:   Thu, 25 Oct 2018 19:52:56 +0000
Message-ID: <20181025195254.q55noj2rdh5vyw5s@pburton-laptop>
References: <20181025141053.213330-1-sashal@kernel.org>
 <20181025141053.213330-33-sashal@kernel.org>
In-Reply-To: <20181025141053.213330-33-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0065.namprd21.prod.outlook.com
 (2603:10b6:300:db::27) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1421;6:RscD18jhSE0jZauMd/55ocR6G7vy9I7vmBN0bFkNdoFploEg8b+3h74poezs1JJ32c56BrMYIKmt1f8q9K5AopEjIpxYMY7Z8oCGv9IAAf68ar0swG3QPS/zl0AP5YexFda/Qw+DeWwlzfEzLNojeKle0aijGfYmKUKacu+jr6ZTI+pxUUGi6N6pdb3J5BFsNrkdhwZ4GtrPMiUUGLWz/ZWn1yjzx1Twm2ietY6bkIjz/5yBbfXcpFwSXMrmQNQnvQtS4yGsHhuRmsswAL7FYt4iH10QpGkH1rdwHzEf4rnG0xmcTtBOIqWKxjYBRNjjhihgo1Lij4DMZRuJ7mdgB0RPtUXPyfusiBMXUmxTQzr6OnDAOf8Wzu+nnbEK74k5Ob0mrsK7L44vIBX+Me/DnKI2VHJBNowJufA6WI/EejnuuGJlx0oIwUaTtOldW1OEcxVDPf29twnB1bCcouCXpw==;5:WbPOCz3MMmOZ7+e7qMNQzRFE21LYuf7qrWxePKWcMNEeRrjpM/O9iewF9STiQk1x3W5nTg3MizTbid5TgAMV8m1GzKJQktzoItghxF6tXV8RwAbX1oVPzvHzAjWy/B1nmTt2lAxay22DEG5L4ypyD3yQ/opKNoJ75drBcxbRdCo=;7:6NQ9CbycV3CTtPt+GrIVbvh4PoVcPTTtReDKvh0kTXOsCJoWCkPZ8PjZy3mmhn8f+DlHMeVkLeaB3UCgIX+hZIwDqsBYOmiyZi7QRvdl5/yHsvWD5k+/Le5GDgbtRXoW9FMew9Z23yd5NS1lrJtQvg==
x-ms-office365-filtering-correlation-id: cd823085-bc4f-42b7-9281-08d63ab3752d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1421;
x-ms-traffictypediagnostic: MWHPR2201MB1421:
x-microsoft-antispam-prvs: <MWHPR2201MB1421A65033A9DE2ACBBA8876C1F70@MWHPR2201MB1421.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(183786458502308)(22074186197030);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1421;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1421;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(396003)(346002)(39850400004)(136003)(189003)(199004)(966005)(5250100002)(446003)(2906002)(256004)(14444005)(486006)(11346002)(476003)(6486002)(66066001)(42882007)(217873002)(6436002)(26005)(44832011)(305945005)(6246003)(7736002)(6512007)(1076002)(9686003)(6306002)(575784001)(6116002)(3846002)(8936002)(58126008)(8676002)(81156014)(54906003)(105586002)(106356001)(6506007)(2900100001)(71200400001)(33716001)(71190400001)(81166006)(229853002)(99286004)(386003)(316002)(14454004)(508600001)(53936002)(186003)(102836004)(6916009)(76176011)(4326008)(33896004)(97736004)(25786009)(52116002)(5660300001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1421;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9avLyeyP/l6SQkyJiZ4lUvw92/21gAmcsBpsH3vPLtwGWS6eUN4Z8Q+1gy3xu6hUamoAmQgPIQ2Mq8aGCivzKDNcnyn39QZYyBJApUW009LOgXZTsOIPsREtcGF5UhYotsq62Jl8xZMXRxydEqCFkqcHCJDyTuPHKXYmIuxksO7nMzew3/rkNK1ZI0uiW7dRscSnAyvSLYjVVJwMG8PMlEF5iA+SVwCrKFYYxSWXLuhPIBEbre8FnJZ1m6/OH2Ba9yoXycb4hpFoMnW1KfFAVUZZaa88Da4e9mXxRs/ZKGghRSeYJ4CzlRCJh808Ukuc0z0B6CQczqvVsIjp9Sy0AoXz2Ofz6cVexqjJFX5QQQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFC5AC0EFDAD5449B5ED6B5A98B32B62@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd823085-bc4f-42b7-9281-08d63ab3752d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 19:52:56.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Thu, Oct 25, 2018 at 10:10:40AM -0400, Sasha Levin wrote:
> From: Paul Burton <paul.burton@mips.com>
>=20
> [ Upstream commit 906d441febc0de974b2a6ef848a8f058f3bfada3 ]
>=20
> Some versions of GCC for the MIPS architecture suffer from a bug which
> can lead to instructions from beyond an unreachable statement being
> incorrectly reordered into earlier branch delay slots if the unreachable
> statement is the only content of a case in a switch statement. This can
> lead to seemingly random behaviour, such as invalid memory accesses from
> incorrectly reordered loads or stores, and link failures on microMIPS
> builds.
>=20
> See this potential GCC fix for details:
>=20
>     https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
>=20
> Runtime problems resulting from this bug were initially observed using a
> maltasmvp_defconfig v4.4 kernel built using GCC 4.9.2 (from a Codescape
> SDK 2015.06-05 toolchain), with the result being an address exception
> taken after log messages about the L1 caches (during probe of the L2
> cache):
>=20
>     Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
>     VPE topology {2,2} total 4
>     Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
>     Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
>     <AdEL exception here>
>=20
> This is early enough that the kernel exception vectors are not in use,
> so any further output depends upon the bootloader. This is reproducible
> in QEMU where no further output occurs - ie. the system hangs here.
> Given the nature of the bug it may potentially be hit with differing
> symptoms. The bug is known to affect GCC versions as recent as 7.3, and
> it is unclear whether GCC 8 fixed it or just happens not to encounter
> the bug in the testcase found at the link above due to differing
> optimizations.
>=20
> This bug can be worked around by placing a volatile asm statement, which
> GCC is prevented from reordering past, prior to the
> __builtin_unreachable call.
>=20
> That was actually done already for other reasons by commit 173a3efd3edb
> ("bug.h: work around GCC PR82365 in BUG()"), but creates problems for
> microMIPS builds due to the lack of a .insn directive. The microMIPS ISA
> allows for interlinking with regular MIPS32 code by repurposing bit 0 of
> the program counter as an ISA mode bit. To switch modes one changes the
> value of this bit in the PC. However typical branch instructions encode
> their offsets as multiples of 2-byte instruction halfwords, which means
> they cannot change ISA mode - this must be done using either an indirect
> branch (a jump-register in MIPS terminology) or a dedicated jalx
> instruction. In order to ensure that regular branches don't attempt to
> target code in a different ISA which they can't actually switch to, the
> linker will check that branch targets are code in the same ISA as the
> branch.
>=20
> Unfortunately our empty asm volatile statements don't qualify as code,
> and the link for microMIPS builds fails with errors such as:
>=20
>     arch/mips/mm/dma-default.s:3265: Error: branch to a symbol in another=
 ISA mode
>     arch/mips/mm/dma-default.s:5027: Error: branch to a symbol in another=
 ISA mode
>=20
> Resolve this by adding a .insn directive within the asm statement which
> declares that what comes next is code. This may or may not be true,
> since we don't really know what comes next, but as this code is in an
> unreachable path anyway that doesn't matter since we won't execute it.
>=20
> We do this in asm/compiler.h & select CONFIG_HAVE_ARCH_COMPILER_H in
> order to have this included by linux/compiler_types.h after
> linux/compiler-gcc.h. This will result in asm/compiler.h being included
> in all C compilations via the -include linux/compiler_types.h argument
> in c_flags, which should be harmless.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()")
> Patchwork: https://patchwork.linux-mips.org/patch/20270/
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/mips/Kconfig                |  1 +
>  arch/mips/include/asm/compiler.h | 35 ++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)

In principle I'm fine with backporting this - it does fix broken builds.

It's only going to be of any use though if you also backport commit
04f264d3a8b0 ("compiler.h: Allow arch-specific asm/compiler.h"). I'd
recommend backporting both or neither.

In practice I think it's unlikely anyone will need a microMIPS kernel &
be tied to the particular versions affected by the bug this patch fixed,
so I don't think it's a problem to backport neither.

Thanks,
    Paul

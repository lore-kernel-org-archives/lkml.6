Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B0C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D8B21746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="JFdm+xrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D8B21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeHRVTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:19:50 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:49386
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbeHRVTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4s/coGwrNva37hdnDh7+QznJCWVO4WL7qOfj5oNyjA=;
 b=JFdm+xrw0UzJsdnbbGipBfdjfpsztU49+FFUB4nXk41hb9fN6Qv3w12MSOu+HfShWaXHk7HrPaEaa0WSi1eh/zK68w/VMYu5xZwDHpjqxp9gTFFOjd0LKPZY92wkk9ZVC/N2byAk19tUEm70XLZ24vSwCfLLN6vjLOJ90qtCzJM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:6a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Sat, 18 Aug 2018 18:11:11 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v8 0/2] MIPS: Override barrier_before_unreachable() to fix microMIPS
Date:   Sat, 18 Aug 2018 11:10:15 -0700
Message-Id: <20180818181017.1246-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0035.namprd21.prod.outlook.com
 (2603:10b6:3:ed::21) To BYAPR08MB4935.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82cef1f8-6f0b-4e21-7009-08d60535faff
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;3:YB3rHBqIrRtGe93dopf9OzBbVAynj6wphhNb5vd2AcBz9crl4xBspuXvQ/xRIReNCNsjHQ6DziyH3SjKI2SecYbuVywF6Ny9S1si5qioqjRjaUQ1CcSiqVSDymxBkSUQDPIhEAW6jqcgQZBp0b9yySCokER7cbJ5vMPo+YKoYsWUZ2aDGXHCBpBHCzhk/o9bHzZw/nHpeLjd9qdkPttqwrVSZn8hT3XSID+NUl0wz6mLYRYTT829TJn6w9nAmGCq;25:5MpNeN3fpN4xkGqL5L9wkwMGVmR4YQ1KvMlsto+ALXSX4zigSixlUhdKWBlRQ6hA2u/JKFiFYj728Ebntsi5viuluFe3EoIQNgxN5ICV4cpCkhi02DC3AxeMyztZxb6C7xgImZoANMx3+4VEo6j8LQwhui7pbYydDL4l7k6MvMT0kuXplNDODbjZVqHZcXG90of1Q9d5HcO5R9/mj/Q+RqXnQDj3Tj+H2DIk5kyMMewXBjj1i2slskz72gEdkACqB+l7AIC0qkE9NND+tMV/lHfdn3Wypetcb3cgPFm1jVY5SCOJzCnQey/8HX9sREr4BmOS/dkcsS25ut08A7H2AA==;31:V9+GhbeA7exn3Ic2tqsYZH8S6wEZNCaKuKuxEzzLboN0u004uD1+/KA+h8ZdgYAm48TWoLRKSnxrczphM85XDcGfZhGGiivq/iwlyC70VuyEnkmUZK6WjnhWEMGJVERnDwWRDOjmm28KsSq0nmBFulrm7AoIQGrqBBLC27LhbX5Sk1HUazVzgijG2FvabQMJNYC2fZyALyraulK2GuMHGYjmPPLaZjD0wxv9oIUWDZw=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4935:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;20:tVUT9pxfRttr7jzVBZ7hMz+aAOiG5YDNCIyz4+BdLr/ixcucl8SdAbWZpoBnDhIxeFhnZ1+xKsj+66q3wKoRfGytTZw2rHn267NaeHjeN313GGP/dKjzp1scmJZ/iz+4AIP+p94mZr82MHZ/G9uEaKerPuSjx2pBD49gsqqY3S9/7ZA1DWkgWDp8jGMMsoKtQ+Fq7mC5rw0Nwn8IpfROzVQqXQpHhcF1YJo+989lqfSbAUiz78BJjgNx1DwhTb62;4:Bl0GXYTHJ+aCCh5pHuW7CNo2zyOjTOMdFPa9x1329qucmA7mX6ciq2a8g5Zd44pkSWUh5eAUMwuLSiVY5zpQHNYshqfn1GdX1uQ7v5Q2j8KT4aiDkMuzWDfXVzWJF2Kk2uaANEhlnBvPl5Nfj5PgbG400A89aDR56u8viF1n1QDc4p4zcVeg9A+JdDDIAR2H/EyjN2MqLne5Jakjc0uqHPwJpp01qA/AoI7OwJVheMOCV/F4NfUZwGT06jXOZjWPhC91CitRxjgIJwNksg/WWw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49358CD0204F0A80E44C6C0FC13C0@BYAPR08MB4935.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR08MB4935;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4935;
X-Forefront-PRVS: 076804FE30
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39840400004)(199004)(189003)(53416004)(47776003)(106356001)(105586002)(14444005)(50466002)(6486002)(6916009)(48376002)(386003)(6506007)(956004)(476003)(2906002)(2616005)(8936002)(42882007)(16586007)(486006)(316002)(2351001)(36756003)(68736007)(66066001)(54906003)(966005)(50226002)(186003)(16526019)(478600001)(26005)(1076002)(51416003)(52116002)(53936002)(97736004)(69596002)(6306002)(6512007)(81166006)(8676002)(81156014)(305945005)(44832011)(3846002)(6116002)(7736002)(4326008)(2361001)(5660300001)(25786009)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4935;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4935;23:q914A92ths5sNfeJHTTzlmKfu/YqM+4FZzJZs3Xa2?=
 =?us-ascii?Q?uJ+C5QjlYM+d3sdns/AOaQ6MZA3FpKj95zmcjABA45dRlOH9Mbdh6IQ5MaQp?=
 =?us-ascii?Q?MAXKheZLudorH1+Mg/9QUKDtd3DSS3oT+zqWUI2PvmiROtEk5xsBC9yOJuoE?=
 =?us-ascii?Q?C7YtZrsbUPHl3wPQSbUmluSwKjOhCHbWEKUYAbRlbFBBvqhIva1yHsVM9FRL?=
 =?us-ascii?Q?52c8MT7tN46DGZtE7xQcdFq/5Y9Kz+93e1rvcMneLUAj1UsQt9cxuTgfXcOL?=
 =?us-ascii?Q?pyYNQDG3E8bh9OhBd9qwiff0aDLJAGqcoKYLnvedCgXuFY0yaiNuUQYU3sV+?=
 =?us-ascii?Q?QcqgoWlA+sb/jkgNKJczzCCKp2uQJS3Tm/r9gRk1bsq17pKNOsJirv7qZb1J?=
 =?us-ascii?Q?+Bs6T6cg9XanCJqgv0sQs1rT4ZHSRfeU19wjm6q1H5pN7SK9CYHHt5Ldo2n3?=
 =?us-ascii?Q?PSnnV6WbLETQby8XgN+kLcnKeG0Mc8TS+YasnuWc1CBMM9qD1SZB2bUZfOkm?=
 =?us-ascii?Q?pm/icPOMvZgcsAq5aloncgr2enh878es9cXFaSHEmx5KqoSbZ2/k3S12/AM1?=
 =?us-ascii?Q?k4088fmzjQgAgU9GoET+ZBIho1BRSO5E3TKwDEjIu4ryJ0FlNCF3ALRI91L4?=
 =?us-ascii?Q?J6hgq+BhdTMx07iURwTkWrwdx/luHXwW0F+xk6mwjNfEl3WZLMsZBSVtdhxc?=
 =?us-ascii?Q?PNIjLWVm8urW57oNFnIYlJnqfZXK9T6ixaP8ONmNq6HjZKnCQ5bPNRLk2ShO?=
 =?us-ascii?Q?a0aeZUKSPbAYNC/oE9XPxi88UvL5iNXdKzy9nNpJfeNDNUCfpnUXQKCcSKRW?=
 =?us-ascii?Q?E/9V4ivnwviktUorgfuM0PNYseBZXTAtj8KmFn4PlXHCFYdm55/hli2GUcCl?=
 =?us-ascii?Q?CP27AegZzGP2s92cSsH5XyI+jKe+pDJB7ERAgytANKOYTTOLnc410MDhEOuh?=
 =?us-ascii?Q?8l/uaMI2kuGi3R2N9gS3QpE/EJSpUp/0MOpJYR2lbmQh1rIOygKSxGqNXlSF?=
 =?us-ascii?Q?iOBq+BncpReLGwj065DOGLCYV9pmHhQJFGrbnTLvqAHiLDVhyI4ZnyClNe7x?=
 =?us-ascii?Q?bRIZ9FuLQef6RaQ/kREnDz9QFhtuKGYxlriLMAquWG/oSwlqKykRUTp3tLRp?=
 =?us-ascii?Q?mbzaktTK9AJAQ0tr89OlMvlyuuat+iXuH8EMwAVC96CwvADC0EEVwvcIJmBO?=
 =?us-ascii?Q?77njSioeGBqZJ3Giap9lEI7ek/2sAdeOnyG+2/lcXfgpZN/m3K5uFSFmSJ+l?=
 =?us-ascii?Q?fs2kz+Pt2PApRzyLwJXvM4MzGVj7/0LGKY4cYjDDWUwc79xOQJr+S1h3VJ++?=
 =?us-ascii?Q?CmFLzFAofTNdnuu1ZiboJ4=3D?=
X-Microsoft-Antispam-Message-Info: bXL27h52zohs4U6U+Fwd9ulmsSb28xgqEONXmuI3l8Ja7iDoBq2+Aw8ftuqX19MKstRQ8S94DVtvctEdQ1g776v6ZYHt5NBPVmxyD2k76JF/Judq/l5Fq8REiOcgNLYGK0ZbvP9pyDG/Em6AnNA0DO6WGNVVlhyNACCVNVP9nM2GAv8NxGEpS+YkiLL2POXaG63hzTo5QYtTNwNLQgIhUho6oKcBsD6bmU2LKcKvjONNrkkjz8ZlcI13QMYkn0iHnKkF1s5DB0V6E9EHTH4LZAbIZYR9MRCA/bHRXELgUujImp0lhxO0xKaBGqqSa57KUgNcxWXw5spNVsysQme/HN7k/U2B6ncS/LQum8RWpKA=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;6:izvElteu8grYOsz5tKaZ0EZjuZzJefn5TocKJeuCWRYXU6052D8NB35QVabr32BQIeyEdUrhTm4Lo3xq2rNF2rM7C1TLbINiHvvu7JSdp3rlL4LNqm8SI6U/KN8AY3pvZPFnXoE3PVtZ8hJvvVSOTNvgPznL8PR5EOBlwjWcy5qErjDacMwqyGpoCk0qXcSYy8cKkGuwQ839SKWvw47b7IkWf9MHBQ5s1n71m+P8+mX5o2LpoQtO+5lMU76o2yuJimCQgHqfslQTolR6DOHNLjexysDEQ3t1g/gj3VlJ/AJSVuTedTvObgKOPW8cdK/vtrsuUrDiecp5Qbta7Abfog/zJkl3kqbaKCMovI/RV8n1oyaTKTY+dyqpRmea7/d31wAC3eki0BtcRdVhcJ2nQzFjTBdNNMuBS1JrYH+4OduqW3fWDt7vNPg1v2wrM5Bt0MFwubRXFp/PjFu28JPEtw==;5:H9EYJKxzZGxH3X4GEIWaJW8QhHWWNMEB2advSr/gTYFnxk4HkThMwwwUWEvum5wFFqhd6+LDhiCgcm646J+TFz8Kg2CHkuK5aRViZgC6BcEfuAxRGNJ1/GYwC//N/UYEo5i9v8qv17ZSZZc28sJB3j6hb4ZAYynUa9fagBLIve0=;7:OxsbE02yp1Bg4RfM1DUr3LPpiIVJGR+6mNAMjcWso4kINYEQQ+0+k4dqIbiafEFa2e0pavW9oW5X+ntXSlfBk1a+zDqYdroa7Jdqj0Go3ctk2ArclxAfKgbpdMrzm/SfEl7YM0vRQrod46LGjMaVqGhvPLxZzaO5aS5YCiOQNwc5M1UXWe5IRCDhrc4Ieot6ud2RGNbkRck36aWcimsqnpz8lqq6X+RGQYX8Mvg6L7pYbEGrTanjwgfMJ/vt2+LU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2018 18:11:11.2266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cef1f8-6f0b-4e21-7009-08d60535faff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series overrides barrier_before_unreachable() for MIPS to add a
.insn assembler directive.

Due to the subsequent __builtin_unreachable(), the assembler can't tell
that a label on the empty inline asm is code rather than data, so any
microMIPS branches targeting it (which sadly can't be removed) raise
errors due to the mismatching ISA mode, Adding the .insn in patch 2
tells the assembler that it should be treated as code.

Applies cleanly atop v4.18.

Changes in v8 (Paul):
- Try something different... including a header that might be an
  asm-generic wrapper in linux/compiler_types.h creates build ordering
  problems for any C file which can be built before the asm-generic
  target. Patch 1 changes tact to avoid asm-generic & the ordering
  problem.
- Commit message improvements in patch 2.

Changes in v7 (Paul):
- Elaborate on affected GCC versions in patch 4.

Changes in v6 (Paul):
- Fix patch 2 to find the generated headers in $(objtree).
- Remove CC's for defunct MIPS email addresses (Matthew & Robert).
- CC linux-um@lists.infradead.org.

Changes in v5 (Paul):
- Rebase atop v4.18-rc8.
- Comment & commit message tweaks.
- Add SPDX-License-Identifier to asm-generic/compiler.h.

Changes in v4 (James):
- Fix asm-generic/compiler.h include from check, compiler_types.h is
  included on the command line so linux/compiler.h may not be included
  (kbuild test robot).
- New patch 2 to fix um (kbuild test robot).

Changes in v3 (James):
- New patch 1.
- Rebase after 4.17 arch removal and update commit messages.
- Use asm/compiler.h instead of compiler-gcc.h (Arnd).
- Drop stable tag for now.

Changes in v2 (Paul):
- Add generic-y entries to arch Kbuild files. Oops!

Previous versions:
v1: https://www.linux-mips.org/archives/linux-mips/2016-05/msg00399.html
v2: https://www.linux-mips.org/archives/linux-mips/2016-05/msg00401.html
v3: https://lkml.org/lkml/2018/4/17/228
v4: https://www.linux-mips.org/archives/linux-mips/2018-05/msg00069.html
v5: https://www.spinics.net/lists/mips/msg74408.html
v6: https://www.spinics.net/lists/mips/msg74425.html
v7: https://www.spinics.net/lists/linux-arch/msg47934.html

Older #ifdef-based attempt:
https://marc.info/?l=linux-mips&m=145555921408274&w=2

Paul Burton (2):
  kbuild: Allow asm-specific compiler_types.h
  MIPS: Workaround GCC __builtin_unreachable reordering bug

 arch/mips/include/asm/compiler_types.h | 39 ++++++++++++++++++++++++++
 include/linux/compiler-gcc.h           |  2 ++
 scripts/Makefile.lib                   |  5 +++-
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/compiler_types.h

-- 
2.18.0


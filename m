Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8B1C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA562173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="bRXrMDPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA562173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeHUByd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:54:33 -0400
Received: from mail-by2nam03on0092.outbound.protection.outlook.com ([104.47.42.92]:33719
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbeHUByd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPCMlNQIamgxmO64b/HfiCOevf39O6Wv4KTxdRX+Nrc=;
 b=bRXrMDPmyNGmxixpQUArYt2n575R/SgeAYV/WOnB4o0zbUcWH+NY00g3G+p/MpOzOL1cSzdKl5PHzzsI4CEHF/FaGuTNNgu+7uZrVuXU+q4ge6g81+lU885Se0n6fYb7f0spEWUOUOkbCkyj8o4HuacXILp4/8enl+rUHYKrOh4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 22:36:46 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v9 0/2] MIPS: Override barrier_before_unreachable() to fix microMIPS
Date:   Mon, 20 Aug 2018 15:36:16 -0700
Message-Id: <20180820223618.22319-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180820183417.dejfsluih7elbclu@pburton-laptop>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: SN6PR0102CA0031.prod.exchangelabs.com (2603:10b6:805:1::44)
 To DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 086c16af-95f3-4a86-5999-08d606ed6997
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:1T3RiOvS47OdTbio/xVS+oNkPNpy/t/5xvY9MTqKdn0sbTkNroGRplmamBtB+P0ErU6/z4R3otbq+1Tzy6p8NzylzcfzpyBRLA5ZEdTElbM0AbrMveMNpg9iDaWP6bwwZ3DsWXXSFkkffY7vb8fLblwBdXdU3XsgosiNueG7eYrSBxsMqpcIPw9NyF0QAdIWX5KdIbKE0jgOVZijkXjRbeESVBkQ4q5JL/L6JPr84BPR/nf9WeG3k96ycPxGWEva;25:LaLdSBz7P3e+4Q00pirrWItDubIbxPcwHgw/hS3PgxgMPajk0KjpUi9SMImKXrGw0oRnoAJ9SNnHK82bH274r/uWSNaX/A+41+AdKWpi4c64Jyz8SBOrDbmQMXbbAxm9znpmwX5wbSoqHKjd3Mkfsyw3AMLA7GAkCMzDokB5NwxqHkRkHBHnijpSDZUvtuGf4fl5CedzxkorIRCS410v9zKOm7WYOYcgSJd2aONT0yJHbOIum7REeNpcxOEKIlcjpaSBopzLWpkDd3iBHrGBX6xSxu3xso4b5z4YW5DccLNcPE5fFEYfpOTsp3xy+1uhQvY4pwRU/p1hHuHUWEoPuA==;31:Anp5ejIjKVhsmytGvn7AsGYS/ChmXXm0AfTjYl23bgdheTJHLs8mJXiAnZvz28oYg3JYmTFMS9yBY9/HOZnsLfs8iS9BCiA2HfMEznbZwzOQRUxSu6/CUZmu/GN3ydY6xmJc9auES/wTGMO/r7gYGGenyqtYoKHZjcwFp9nIiOlF2JdxkoJKCrp5wn/ZZv85yP6X/ElXxR936XzrxObS1LzsPbV+cbtDxP+51ATCPIY=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:y8gw3nbUV6VnKovM7tA0WcjMYHxz/iEYoFvgv+ne7Y5qnt4fW8ZidXIt+PREKPETwsBNjJZvG67+LKu2VcTr8jEPNfy4Agmm7yQbytt1jMh2Ev/ydpa210KMIt49nqzVBxqQvRPtiU/0yrSo3mz31NIG4RfLnhhQxgf4yurlnWOK2caKwVG27egSDw++PzLcikZIyI/yDwTyiET0G8Mske/BaFNqNF1UjeJP0q5lr0GFJk9Whbc+JdHwXFfU7tyq;4:M0VBpBCg9AUNdXqHcrIWNOJxrcsHN8i+QlmmdPvPvxotJ4Qrt128u6L1OreEz0NQXJIRkeL8g3u9vhVw3Fkgk8Hk7wScngPOkDqvp2oON34jQllw99v6b0PNdJV/zwsP6p+R9r3Xp2do8SwUdOarKHIuV7iMmn4y5kxYsciwi+qsxji+XrlCMPeRq6bgzf/hbIiRffeNTeprx3mi5/mhMUQQI8foou0pnwIWGiK6GAZLNNIDA/Nm6oHwPdVW+Pp/GxMWZDstvJPcFIjYWdTVRg==
X-Microsoft-Antispam-PRVS: <DM6PR08MB49395224596137FE8A526E3DC1320@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(346002)(396003)(136003)(199004)(189003)(6512007)(2351001)(2616005)(6306002)(53936002)(36756003)(25786009)(476003)(956004)(4326008)(6486002)(50226002)(44832011)(66066001)(105586002)(48376002)(11346002)(478600001)(966005)(68736007)(6916009)(6666003)(53416004)(47776003)(50466002)(486006)(69596002)(106356001)(446003)(1076002)(5660300001)(16586007)(16526019)(316002)(26005)(2906002)(8676002)(2361001)(7736002)(14444005)(8936002)(97736004)(386003)(305945005)(6506007)(6116002)(81156014)(186003)(51416003)(81166006)(76176011)(52116002)(3846002)(54906003)(42882007)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:bqrKLNwk00t8XEdDOYwj0rftJ7q91xgdwTNPI1iuL?=
 =?us-ascii?Q?Ny/Gsm7WMVlDllfWPqbnJl0c0fwut9BIXYgDVeW7turdcFdWHzFmdRc9KbRs?=
 =?us-ascii?Q?5F/ga9VWApy4geEGAlzQ2UKfgZ4lfWBV1oHzZUFEDfz+JaeHYfnzqgeJX8Vj?=
 =?us-ascii?Q?mhvk88Nn2G4tokRd82foMR6V3ek5sC4tLnwpiksN5zX229B20d5gvDKP8UH3?=
 =?us-ascii?Q?BGINLlbpccymNcmHuVOMeygao7unWkCqBkXy6VKtY4oBiuYsj/1xuXdxIC3F?=
 =?us-ascii?Q?oqvQq9PPWksjA+wmd+o7pmORixReov1SXOio8OyCzXBzMeOAc25ZUHP0vhXs?=
 =?us-ascii?Q?ZDE/Jmni7Yr2PR2LFxYQfuE8QZmlONbIXzUqGSjG+EejA9JM09YF1bIAQ+bo?=
 =?us-ascii?Q?NXRV70OE21FNYC4pLauz/YMea93cuTNBkzqAfqHrSw1iSZIhKny+g2+I/iaJ?=
 =?us-ascii?Q?FOp9DeCbYH2Y3fzmbcmqIhm/P+9ZVK63dsfE45zW+Aa0HBOgS3HS0XS7b/1e?=
 =?us-ascii?Q?DiAVv4KYHa135KgQZuOaHGxLIhPw0wDTJ6PKlL0XwdRnESiuyE/SUSsPgkuK?=
 =?us-ascii?Q?FMvty+mRBkkuR0wa54XBW0793muKIN7HIBXdc7hM45RFCvlrOxuLUIGSaA0l?=
 =?us-ascii?Q?rVUCP3W2UgxaqksxkOxvVTpZmGmOsMiLr/8NRghQT/uPDXJ57LbD60jo6r6m?=
 =?us-ascii?Q?cZMTkTNNIbTcWjROqRjCZB0+5qkX2QOCTKQS3b4WrVISnLYrZ0p0gXQ/FsIx?=
 =?us-ascii?Q?blwDp0AWXLeutZwWrvHKk2FZIrXcnuM/+ePJdC9H6Sw+cb0TsxmqCbTYFZLK?=
 =?us-ascii?Q?C6NtVMSnj1FJF+G4x1etT1sW5GPl057tTVZSSiLZV4N2IYCJT1y8CKcskOnq?=
 =?us-ascii?Q?RCTZIGLKY8gRGTA1wxmwOtzlQ9HIVgA68PK/URVoxGJqb2+n6f9vYBOeIBnC?=
 =?us-ascii?Q?2PfqVq0JfJWuDzFGsL7fweyQHnqCKbB4K6DeX/y9hMstl0rYbo6RR1WYOwGK?=
 =?us-ascii?Q?2ybN4UmKHfee8RRE7XM7nQSWXbEkSY+SJ6lQ+O5hriR8+0Eh6GUT2JjkkiLh?=
 =?us-ascii?Q?PIGcUOVs6Mv30+up3ARFUBiiWj5woUDZ2dZPGMuwWb/abxlC6Q9C3ewj4tjO?=
 =?us-ascii?Q?azZ6TIgJ0B8icNlIoWEkv7CdEzp8TUB0pY0TA/HxR+sqeY6gt1b0n2/61AeI?=
 =?us-ascii?Q?BSdSXf1ouNRjdHr9k+NgpqcnjUy7CIrRm7V6jxqKwrfSoNwQ98XVVjNwbyxP?=
 =?us-ascii?Q?RBXHea+MBjGDw7XQwO/Y4mBvYSnEaBBAYmmXhO5VptjgnD7uQ08Jg6Rlwb0I?=
 =?us-ascii?Q?qCTNZMvrEjN+uNIB0iAbV/km84GJ0WUwmYkSzcJLpZHQJkAOzXd55PaUtkA6?=
 =?us-ascii?Q?i3bTFVTWFo0Amqu3fP+j3x/qCIgkrAAvqab81+olE6LJQSN?=
X-Microsoft-Antispam-Message-Info: t6ERJUVpEYZoZN43YNL4VDReuYXQVmOWQJVOG2F9C/GaVA2IqQUBiK8lDIbklwFsyj4PQen6BExHCbsikyL81x/UAl7hBmaszIClF/V3NUAE/1MLmy7viBEuzKgLrZQH1yf7RAdkHdwZuO1YQEyj6tGeQlJ4Wu2Z5LFvpy7SfgGhYiuEt884Li/m2rTKD207PAe46Jd3ZSuALoXLABn3ROcN3YackHCcHiY74CXZmXcKv5hYwTgvg+4prQi7DjVfLA1QLFJxOUXagWV1L3VUTZSBEe+c7ULX+BxtVxvPufunXsUpZjq+4zzH4HkX7v1DlPQmVwieP8Es8/hsX1wG+jzyo6tfL328jQMFGXdX2QM=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:u1cts9zEAmUi25ZhRVEFIc28LFKNmRfpd3OjnDPVjuYjbyXPKfGyPGIaV29nxw9VTHOy5PcNwPhehaNFlbMV5b7K+DQnZCgYAhtPOkezAXw9+y/8X8SlAhpCTA8sn4vU4cNH+A9bvrJkoYHS1UvmnyC4azh4TnC8Q6qv1bt+0M3k7cUaM9MyKX0DrH1yCCuxUBb3aSaf9YVUcDGtCXopqFfwOF+XLcsqi3LWWEmljJsghEW46Q/fd887SWwr5/UgHl48JPkxTuDLTSNf0ZN3PCYxTPbOZ1LaneqsjfjxxEYVo16oRYrHcAT78cc4r2Qg79BWGnLZ3BMSurTaJQro2Pqu9c0RUT7DaWCWWLH/BVoRVlo3tdOmz1iToQV5NVwhsiU3NRWdE06bTvURuEB6XtXQiErK3DlzULXFjLv4pCVQDUuNnhSsO2ES058bQcX4lZ8qDJfrYXOrKLzn/SBSTQ==;5:e/Kh6ICu8Uv/He1cLOenvJbThuNYjCGhrwL+tCTnElSEvErShznf9MOhU9FoNI3C6Z7CSBtO67EftcgqtAbXsJzwsR8q1aFlklyfUe4GkfPgYZ/VxyaEw4wmosy3RmrFRlMEkwTlqvQ+mYCRB1oJJgc3mfjj1f4fKpqtI4Nb5FQ=;7:D9V6LFjtQsI2N1S6qZ0tGOckrzh3svUNu6N8raMueIKwHRnm/ZYJkBsD0hBES/fJdRxYLiQmclXSEvpYQxC3EVoWwhmqb7bKx/ojR8gMjcmcNz+BYYSbPkBp4i7B6Nqk+kUZv2skWx5HKCgCDdhM1GHgksyRba1gHycwH2Jp+91OGhWdJJ1U0m9w7kNRNxe4y1/inoJzIAvD2rgYgM5fbj8BynscmuDUiG8gGaKBkYuPKaoa98icrG8uwz3Y6J0G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 22:36:46.0650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086c16af-95f3-4a86-5999-08d606ed6997
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
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

Changes in v9 (Paul):
- Use a simple #include conditional upon a Kconfig symbol, as suggested
  by Masahiro.
- Move back to asm/compiler.h instead of asm/compiler_types.h.

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
v8: https://www.spinics.net/lists/mips/msg74562.html

Older #ifdef-based attempt:
https://marc.info/?l=linux-mips&m=145555921408274&w=2

Paul Burton (2):
  kbuild: Allow arch-specific asm/compiler.h
  MIPS: Workaround GCC __builtin_unreachable reordering bug

 arch/Kconfig                     |  8 ++++++++
 arch/mips/Kconfig                |  1 +
 arch/mips/include/asm/compiler.h | 35 ++++++++++++++++++++++++++++++++
 include/linux/compiler_types.h   | 12 +++++++++++
 4 files changed, 56 insertions(+)

-- 
2.18.0


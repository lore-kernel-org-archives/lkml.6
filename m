Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6558C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F0C2173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="GZ+l+TTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F0C2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeHUByg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:54:36 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:42758
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbeHUByf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uYPkPIfFjwhleqctInd/ocfB8x3ppeJFOh7x9h9lr4=;
 b=GZ+l+TTMrs1Xbu1wyaxAxvdisdk8jMO8d90iksypHKLjX12vcIFzAR4lzs7pTvwTV6y8+xjkcjQhX8fV0H1Go2/R2VN2XMEzaDWBqx3rFeu/IVJnZ9QmCZNgFf6AGPwxM3QZlNXEtu3+iOkR7Ru1lGCCa/ElyRkKnsNMhvJx4R8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 22:37:05 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v9 1/2] kbuild: Allow arch-specific asm/compiler.h
Date:   Mon, 20 Aug 2018 15:36:17 -0700
Message-Id: <20180820223618.22319-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180820223618.22319-1-paul.burton@mips.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop>
 <20180820223618.22319-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: SN6PR0102CA0031.prod.exchangelabs.com (2603:10b6:805:1::44)
 To DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d41d25d3-2be7-485d-9693-08d606ed74ff
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:kAlcw+tklixBofw7k1TJUQe1VFpLqEfNAhx0G1mMthWhcLUkvYwFNEI5dTqTrkOmWLLSw4imER5ir7rdgDRI0uQekXNlUoDNIU3VDzg2cStcW0e6wvt1L60GsOfGGlBYAZ7AiyrugruI5OcJdE4gLYwMm8ykDg+XUKagMV68iO2nzS4pjHktTreE54wBd3z5utCBZpr+Yxr+ZNQkz5zAcl6tA76kuk4LEFxu38aFYON8/suud5hLhQcg9+HBrDe8;25:9KVRWjHM1u92ImYGmOTSkIuMMbTEPTj1OnYBhWDxv6Mt7eWYRguDurC0OIDvnD4ZlMdWgJVAhUJrwQ6SFVibxa7iUyIM7k+GPOGD0rH2k9O3Ymg68czZGqO3o9ILO0p3VTSYmMxbIDIAHEH/mFYQitC9PzncUGFWaCA4BmSThCf+0MYn3xWWegZU5wYIOAQfvxpOV7zEOL97oyQW407DrvxKhLpDjrNHZ1Gh4UwzSK0yVJfbjAs3202PHy4uz4W7mG17F58NNp9CMyeXjIA+2K26kVNN1WMx8fz6XwrUBSDRbyrx7b4l6GceC9BOtDbrHvWxGJ5C3K4OtVTjUMmdKQ==;31:KGjfV5UjjLOs5dQAhXfR7ln0dlEshmvnM09DJzGsO21PM7XU7uxkvVkd9tivtiUdzO0VhCkT0yzQhlmAmISWt/lX98/W0BRgljo+0fSzAyco4LjXa0QPs8U2ddLMJov/EvdTGKCS2AoQ8WHWCLNh1gL+TYF6e5zWBGQRoWkSvjDc7xjrlvzds0WwFJwZci7r7+MTf2RL4nUnMmJ7C/ZlqBgG7GL+tMW3tCnPOV7srNs=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:GNV2kRueIlOIr1Ol2BPJfKGUKsTrZGxrDH3LPxtlkU2t4oFHwn1Cd29MsHJuGsGXATY+c52P3xoO/TCgWLb33U2yPbo0JaFXUf2TsRqXMU6P9X23u/e3/G4JNGoCwp+JuuHEE8piYB6TnhghqOGl2y8etBbN8yhP6yiwVWnEwUnnLTOSumHQgOGbdrXCfAtui4Jjw7ssJ91UtGKpMaqF+zVyZabHdhtj7YDGq9Yzzetb1errnTxj2VwamxoQ5MGg;4:FFgMmMQdg3qquymLpcJz0KkhfXgaf4icgsPxDaxTtVnirCUmdULGevGourBD2aacxqHkN8fcM6sbmDQYk1fbyTAYWgvPcmOGXvtGQPGuqDEdhyijng9EzXtSkqFUUvN7/A0rkjvpB+93vbitnaAkVSYyBbCQl2Ii+VzOib8ypEaMyiy/30vb0JFWrvjpRzpB2ZwmUAHrv7gUlMVW+PgX/5waBiYW98zfsO+APSSh4sM919LB5vzWAi92CSVA/752FXK88KWD8NPPkUCdUHdrpGgdyWTVTM3Y6jfWeFXw4jjrmZixd6MRhothN3pg1Yhg4fKMIVhr2Jp4j8YDQ5pSSWzZJ0vxYiwS4MPdTSp5HbPcbJ8zOucNTgTBg6C8GGqs
X-Microsoft-Antispam-PRVS: <DM6PR08MB49396C571050DE9F90298755C1320@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(9452136761055)(162533806227266);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(346002)(396003)(136003)(199004)(189003)(6512007)(2351001)(2616005)(6306002)(53936002)(36756003)(25786009)(476003)(956004)(4326008)(6486002)(50226002)(44832011)(66066001)(105586002)(48376002)(11346002)(478600001)(966005)(68736007)(6916009)(6666003)(53416004)(47776003)(50466002)(486006)(69596002)(106356001)(446003)(1076002)(5660300001)(16586007)(16526019)(316002)(26005)(2906002)(575784001)(8676002)(2361001)(7736002)(14444005)(8936002)(97736004)(386003)(305945005)(6506007)(6116002)(81156014)(186003)(51416003)(81166006)(76176011)(52116002)(3846002)(54906003)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:6cJd7oJ1VWUFOGFIOrbG1jjcYD0RLS36H65VljH1O?=
 =?us-ascii?Q?g0PkpJmdBRK5MSYJ+9dPEVgnayoh2Y8f9lrUTjTYHWQpG03HRCc4RcteDRHV?=
 =?us-ascii?Q?m9o1+qz0U6jEitYubUByCpMYTQIs6hrXdtL+N9v/x4mN8MVgoFfaR8qAYajH?=
 =?us-ascii?Q?X/NbYy7tM6vwZF0dsqbLnieYoOCe7+HY6OPaqbspY7IA+RxwfGE5hHzlbGqU?=
 =?us-ascii?Q?dj7sV84I6uc+u3LPJZZWFmKBDuFPgE/zxcg5CY9Z3+Y8fkWaWQ5yh8jT8EXo?=
 =?us-ascii?Q?ggQer5CUNjuWhzmhHs7AL5E3MbM4vrpPh1T1AymL7c+v6H3rPwDftfVxNx1t?=
 =?us-ascii?Q?KA/VbqQMCTmc2LwHhByQImXhgS7H0t0sNjneQOdJUN1sSC4CFRAP++AEVjMu?=
 =?us-ascii?Q?KppmNwkBtuUsrN3V7sVwrlPAYT+my00XKX4kGcZanmHEowHAtA5EVWmiYupL?=
 =?us-ascii?Q?NNX3aqiKZlXmdYiFBgJbDuEe3nsmaXo8cjPMn4I4lgKNMgk9kKWcXdtVyO8f?=
 =?us-ascii?Q?aFhbm0fCK4q2DdWQDY4Lw4BdZpo4xPSboaJtYJafHCUB9jEzbp52Fplg7nIp?=
 =?us-ascii?Q?9iOj2gRyZS/s2qn/nOe6W4HcZ+VyGWj9jIpd48PtYld0VEoZCnkWZNKNWGjZ?=
 =?us-ascii?Q?K3Iddt+RqAMQL71NKx0+9HKNDhXUJta785QjLNfzFmRzRJNA7FHOVQS1xMjF?=
 =?us-ascii?Q?Tziwxm1G1887we7KIIENEU2eYti9FCaKLXcR+prKnE+AZ16DvCXiRa3PY2qI?=
 =?us-ascii?Q?ovO7WIrkoztOiJOLegwUpBuOjF+Z7WypM/XEMAzmy4T47O9FkBvktPeLbKka?=
 =?us-ascii?Q?jhPFETZvBGqkiiT1VPe7Nm+DRv0Z1IxlpkK2XX7kzUzfg9s6NzZd9DNyz2YO?=
 =?us-ascii?Q?zdOgc7NMi8hcpcryCxNFLNCz9hg/h71Sl5NrgFdiKm5JCXqPZ665bRxLH+4C?=
 =?us-ascii?Q?PseRujqBf+pW5RmYkCYoCxGvnJXCuzcviUPNX5sXo93sAB8hRQ4E7I4fXfq4?=
 =?us-ascii?Q?HR05HJLCsNV+JzFI2htlXDdYZMGTVFvia1xmRDCMjaqWi3N4jwNUipgscQev?=
 =?us-ascii?Q?KNXirdmgNX3mtARRpFNn7xwQVqpQQxY0ru5xQMW/+b5s71vZaseoCBuVrTq9?=
 =?us-ascii?Q?K5iU25iTHxtvWiUdLIx1lgvf/E4oACJi1kMruA7D4LVzvEvgWhwXzYWMR+NU?=
 =?us-ascii?Q?iHYKmQTbtBqNUiuQJHMohI97uJFTg3VUl4NTp/cHoQL1lfRDGVI3/stxmGDg?=
 =?us-ascii?Q?DSO3m01Y8t7bW8uPnbGshzIpGlq2nbxEJJW+6Wxe7LQFlReZm4cgVYclvcT0?=
 =?us-ascii?Q?fI07IFef85LAJt16A4NN41rsrJRWOGB9uBbKNLHyp3D6gxRagRui2VYbDzsm?=
 =?us-ascii?Q?h1ni8Dlcecq84dnAbYuLwIYuZ4=3D?=
X-Microsoft-Antispam-Message-Info: ukueV5/K8yd+9WbVqg6uXsy1WjXFLDIBBlyWb1jV92ymXCkuP+UCio3wSmeuIgCXy4OVy9Lso+s7+UxDt1Tf/nwSdLGoCsgO6+aBbeBDwM22dqzj+xopOHnCHYA05ir0xevVUQOpcuwuYb7ZT58CQyqyQ4Wx9bxkFWGKKWJQgtHESSWQXx80gZcTcjpnyNj30d9IvE0ApFed+vy3VaNd4eT1yPKsn2Fdl4XFrtPEyE0eS7tIABl4tyOJev91mJt1amZLqGgH/s7TaAUc6fp+F7FASuVEGuuKlQBcA8YHwVG6JL1sjBrIDnf/HHJ17WJXfdAk8pAdMqpH1E5sHNwylD2eewURygjnEhNSLcRtb3Q=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:yduI4DzU2Coay34Cg4GsbkNtfFfe5OujusSPeuenQPtVhhL+oJo9Qlk//GRmTx0MmhbW54RRu8iAegLJ3nZ4Ze+R1vGyYAZSGKLPzoVsrQCg/awxHSkakNQ72AfFT+vabEc6xm09BNimnDau1WgvjNWpn/KrQ02w1gCVnD/+S1Mc1zhRMeByfhN/Li0nhdzhXIZK5Je+dZ1VzZNkTqj1l5uL0Ueb9xCdbm1jA7Aomh+9MOFt+98IPBPc2L1+McDMAuNOfd93Apj4jcbn0cGq7PO4gjJszLSwHeOsqFjrlie5q3oglYBKeFQl5Bcp95A8rLnCjWy43O0yoKM61KNgNXalXz6dDsd46ZGjP72K4sS+Kek3CzTJG3MTq8t1FV7cwowHGujYayRWkP7wdNAegl0plkdj67yd/nuVLRqyCWsoy+I+m38PicUiYTRDZVWfM7ZJKL7L2+iLQ7TeH4q6xw==;5:eMskJZDVeOZSYw2vc1CX0JCWDZE6vT2tS3PwG0fyOpE0fkEXLas44ES9d0QVzUSas6llNlTp4UwNwXWmXAlTFTF6LJGzOpnT4ymHRvM6IDsdXmiVehj6iwIEzbCOvKbn7WaXxAkM+ZsTfaWPiHD4TFrStMRObSrAoGgca2Yc7wM=;7:zCu110SDYoKeGrKwDmllKk8sjsfbYnEZXvZovAaFYy6jO9rpDp2LqZC3D4BKx+i7gR18OC3luWTg3RLSV/bpJKyGdKFzhlJb8d7PI8VlcyxQa/Wd3A5tw1j6kBfv0/R6ImB52VcebyxI4GtKM5xQxdy1+ioP7lf/hSoPosT4rhYeupVq+QeVR1SAA66os3zdrPxkDHdAFphX6nfVF9+TezlsTgaScd6mWecn/nnE9CD2mjAouG5CkTX118s1iEsO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 22:37:05.2021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41d25d3-2be7-485d-9693-08d606ed74ff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a need to override the definition of
barrier_before_unreachable() for MIPS, which means we either need to add
architecture-specific code into linux/compiler-gcc.h or we need to allow
the architecture to provide a header that can define the macro before
the generic definition. The latter seems like the better approach.

A straightforward approach to the per-arch header is to make use of
asm-generic to provide a default empty header & adjust architectures
which don't need anything specific to make use of that by adding the
header to generic-y. Unfortunately this doesn't work so well due to
commit a95b37e20db9 ("kbuild: get <linux/compiler_types.h> out of
<linux/kconfig.h>") which moved the inclusion of linux/compiler.h to
cflags using the -include compiler flag.

Because the -include flag is present for all C files we compile, we need
the architecture-provided header to be present before any C files are
compiled. If any C files can be compiled prior to the asm-generic header
wrappers being generated then we hit a build failure due to missing
header. Such cases do exist - one pointed out by the kbuild test robot
is the compilation of arch/ia64/kernel/nr-irqs.c, which occurs as part
of the archprepare target [1].

This leaves us with a few options:

  1) Use generic-y & fix any build failures we find by enforcing
     ordering such that the asm-generic target occurs before any C
     compilation, such that linux/compiler_types.h can always include
     the generated asm-generic wrapper which in turn includes the empty
     asm-generic header. This would rely on us finding all the
     problematic cases - I don't know for sure that the ia64 issue is
     the only one.

  2) Add an actual empty header to each architecture, so that we don't
     need the generated asm-generic wrapper. This seems messy.

  3) Give up & add #ifdef CONFIG_MIPS or similar to
     linux/compiler_types.h. This seems messy too.

  4) Include the arch header only when it's actually needed, removing
     the need for the asm-generic wrapper for all other architectures.

This patch allows us to use approach 4, by including an asm/compiler.h
header from linux/compiler_types.h after the inclusion of the
compiler-specific linux/compiler-*.h header(s). We do this
conditionally, only when CONFIG_HAVE_ARCH_COMPILER_H is selected, in
order to avoid the need for asm-generic wrappers & the associated build
ordering issue described above. The asm/compiler.h header is included
after the generic linux/compiler-*.h header(s) for consistency with the
way linux/compiler-intel.h & linux/compiler-clang.h are included after
the linux/compiler-gcc.h header that they override.

[1] https://lists.01.org/pipermail/kbuild-all/2018-August/051175.html

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-mips@linux-mips.org

---

Changes in v9:
- Use Kconfig & a #include directive as Masahiro suggested.
- Go with asm/compiler.h rather than asm/compiler_types.h as it's really
  definitions from linux/compiler-*.h that we want to override & the
  conditional include means we don't need to worry about existing
  asm/compiler.h headers.
- Tweak subject & commit message to reflect the changes above.

Changes in v8:
- New patch.

 arch/Kconfig                   |  8 ++++++++
 include/linux/compiler_types.h | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index c6148166a7b4..c0b56b0d86b0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -841,6 +841,14 @@ config REFCOUNT_FULL
 	  against various use-after-free conditions that can be used in
 	  security flaw exploits.
 
+config HAVE_ARCH_COMPILER_H
+	bool
+	help
+	  An architecture can select this if it provides an
+	  asm/compiler.h header that should be included after
+	  linux/compiler-*.h in order to override macro definitions that those
+	  headers generally provide.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index fbf337933fd8..66239549d240 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -78,6 +78,18 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 #include <linux/compiler-clang.h>
 #endif
 
+/*
+ * Some architectures need to provide custom definitions of macros provided
+ * by linux/compiler-*.h, and can do so using asm/compiler.h. We include that
+ * conditionally rather than using an asm-generic wrapper in order to avoid
+ * build failures if any C compilation, which will include this file via an
+ * -include argument in c_flags, occurs prior to the asm-generic wrappers being
+ * generated.
+ */
+#ifdef CONFIG_HAVE_ARCH_COMPILER_H
+#include <asm/compiler.h>
+#endif
+
 /*
  * Generic compiler-dependent macros required for kernel
  * build go below this comment. Actual compiler/compiler version
-- 
2.18.0


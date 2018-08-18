Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04848C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55A221746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="iRQpw6Ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55A221746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeHRVTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:19:55 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:49386
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726300AbeHRVTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSwpJsT8wFQaIsYGZpytZaMy1SX/9uFUvR3+DfoG4ik=;
 b=iRQpw6Ic/wAxy1O7h7iZTsbM2zrQkd3m0aiUixLdrJ6DomvRa0bTQ+SkrZcdnB5F5kSwePYDksWz4WRB8bmLqtUiKtbvvTHRNrPTKGyFXChwtvRySBAtHCdtj/H0G3q8GWY4Ss/wORyXc62gP4ng1OiMeqyh+384USQXIy8+mfA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:6a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Sat, 18 Aug 2018 18:11:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v8 1/2] kbuild: Allow asm-specific compiler_types.h
Date:   Sat, 18 Aug 2018 11:10:16 -0700
Message-Id: <20180818181017.1246-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818181017.1246-1-paul.burton@mips.com>
References: <20180818181017.1246-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0035.namprd21.prod.outlook.com
 (2603:10b6:3:ed::21) To BYAPR08MB4935.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 192a53bd-524b-47e6-3d34-08d60535fbf0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;3:FDAhvrunjQhu0KcBp9hSrdZLBsCHYPRITRHcDyeErxrO71re4m4OI+zTv12lkFjZguhNJGyXStHSmfwDyCEIS+jeqDhr+Rak41oN2e0J+ayvt2GhnqkPb+7u4jLnlfXO/CW8KKaIVQtat/ACmgcgdAZAiXjOclgcJZM1/5YTDzfgs7PxQgHUm9pJ0xD001AKfXPkMIwaR+G8PjeyQ4S54YOqXXeWrY7rE9Ztkl1hDI1sfeqT5S0PorE2OWl9sOGY;25:CPQDKYACpBOt3d9CQX3dwwLQNj5Lg1BoTna4rrW82AYeOu2+uHQ6gMR6RU8RBdxtAShtrisBPtEPGv+PneHPBwtte9Mmec0RPKGxsyhTik8qGJfVSU3lW8ltd9AjbZmO/iwlNQCex2Ycir2FuqQ4refL6VHqm8OsKVy5wYU6olT/tIw5KyaFB1djeU74JCNkCHdSgurZ4LfYxvuWQgMb/BK2NleMKAbv0Bl65gOzvm/nBE4qVtXExa9BRgL8iLhBwtYjRF40FC78N5Z/YVpWEi67H1OP5M7MYUGu0dkAGfz5BTp3fQjpWi41ViYSexP29nRp7hOQ9RKiDI/XrhalyA==;31:dvw2jBOQxdT9/8hmTMcU4ziUdW1GGLuh9Y5yWUbU9Ek1YSMBDmuOtqpVtA9VOH90EcsB16GiVaxlxwrmg/kyi7Ew/3mSCqc2f1BReb+sm65aRvvY0DvqZuHbgtlVNuYJdapUXiYUa97VzxKsRwhKqOmy2Cw6um1SojmazvqvSoYxhEOXgInWdnegCjX/E6epybWaNQ5m2OXVzWkDgAW92JoLtbldpOF309S96LQcvbo=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4935:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;20:7IF+C1ea/PcbNognLwpPvZz1FjZzweMavzaO2Hz1KYod1jadhrV8gc0gW7lwI4Fd0wXQiTaR/buifjcWMUfViJHUJiZPvqbT1bF4DDVmUOXgGPmL7jARM+gLk3hh3SB65dQYKkcvHCIW/c5Be/+fllB/5HZQkP6Lm1G07120sRoapkm3f8WUZiTxl7dqIkLJ8CHA8dP6u5yH1Vj/H67fyb3tTJ9hUZQ+NqQhiC9tVyl7EgujefJ/ew2/d9Sumn8B;4:9awydkMXl9lOT3btJ/w20wpnxjVmmjYjRv/fKYmqKkUaf31zzeh0vafosvQVFpeO4ol3Gr+h429zwenak+QdJeHv+AvLzNFRlVaj4F3VBVfPIHLunZ5Fo8qB3Bdm9XqcIXMiloLj2r39kHnTNd1h79cqjQCIHk12Bxogusda7hTdim4L8R+c/bF5zjOWulEeq5ZiIbn86DbRZ1lMvXVOnR0nvHV0NjAK5fiAHgb1PmOFePjfJ05+EYDOVbc4RAouwto5Q7CeEH+j3Hp8T3Fxo0cJhyC+Or+heicy/EVo1C5JZGLTVJE2AxZIki8+X07bbtCtHnwvyf9KgyuapuF/p/m9hbBetaRil6XUgZtAYXE=
X-Microsoft-Antispam-PRVS: <BYAPR08MB493559F23FE7E4B10AB5CD04C13C0@BYAPR08MB4935.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(162533806227266);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR08MB4935;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4935;
X-Forefront-PRVS: 076804FE30
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39840400004)(199004)(189003)(53416004)(47776003)(106356001)(105586002)(14444005)(50466002)(6486002)(6916009)(48376002)(386003)(6506007)(11346002)(956004)(476003)(2906002)(2616005)(8936002)(42882007)(16586007)(486006)(316002)(446003)(2351001)(36756003)(68736007)(66066001)(54906003)(966005)(50226002)(186003)(16526019)(478600001)(26005)(1076002)(51416003)(52116002)(53936002)(97736004)(76176011)(69596002)(6306002)(6512007)(81166006)(8676002)(81156014)(305945005)(44832011)(3846002)(6116002)(7736002)(4326008)(2361001)(5660300001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4935;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4935;23:sokQhFSRy32uSUbIeKrU6egRCVTTI5vgMmP83ylvY?=
 =?us-ascii?Q?LWh2LvmVACR0LXEbAj8AmwY8s9uxEY0//f+OysZF5ZklFTxAM2dz3ix4TaPi?=
 =?us-ascii?Q?6U2p+GkxTX4WGJiP6Fubv4KvYIeTaD8HDVlQEP73eR4XU3WXlBXVl5gkFfZi?=
 =?us-ascii?Q?1SQj0iic61L9P3kAK1MZsuCdqTctRsHlCxWCWNzKA53U2VmSeqX3bXTytNpK?=
 =?us-ascii?Q?GS8yF6dEvuqSdP6D1jgaXep/jvu9efLc2OcvEuB/aGnJ/SVeuKd142GhyRT2?=
 =?us-ascii?Q?8jQvKmKJSWQqlspJOK+aMx5RKHYFy+VDBhDYcHognsrwdR7zMmEs4AHuH+2G?=
 =?us-ascii?Q?F4EvnxjITyBm1181OVzXKRk1lYo97HRVXy5xqZLnss+YHi1ASUU5lxJTHUpR?=
 =?us-ascii?Q?rhFkbN46zBHUO3XzWXl8vL7vfUW7OIE7vN3J6+WHO6noRZ1YycN2WyBndCQn?=
 =?us-ascii?Q?9gzQ7Nyf6R71V8tyd+vd8f0fD6YNDi1K2BWSLk0f0ecgtxj9lCb0tRSK651y?=
 =?us-ascii?Q?iBtmH3TC01p+lCZSK1guGZ/3a9Veim3eeb2LNYzXz4ot+N4CyCnE0DLMxUDz?=
 =?us-ascii?Q?WfcO8nSkW87+fZ3U4iGr8iqe1SDwjKjHFIGfbo+UqCH0HI6s+pFgfS7wynNV?=
 =?us-ascii?Q?VYqHxt+toqC5vNdHITcNn+nGWcZbHKfQ6V/HoBr7cKJbxxZ5A7nfmsP063MF?=
 =?us-ascii?Q?c1j51KknrQaR9ScNeSStrktpu3jsYruohAFzQD9ti7s9kO8tkKOFhvXtOiEI?=
 =?us-ascii?Q?WdxQUYv605znl+wVhCjqioEEI2zjZtel582ejFbiG+jIK+Ic08r932J/f06W?=
 =?us-ascii?Q?+5wotuHqKLeB7JzWkGkjiggeKK5wjfiydKdZy3Ca5ckPsmmyO8Mku8XyQ7OB?=
 =?us-ascii?Q?qEHGu3iSh0S3SkBbhG5mzZojLhB9V15k9a0st0HFFblW7JBXOvrmTXxZJS/L?=
 =?us-ascii?Q?DMiQHkS26UVCCXVESaEzqKsVdsLNHYBsjjmpFHE/SO3owrLDHZHwcPIdOzho?=
 =?us-ascii?Q?yClcUNE8tDBLmphrMI/Ftr5USq92MHj361WBBIeWMlHSt4lQmUPRD5GLwUuq?=
 =?us-ascii?Q?MY2EX53lxHa43P7S6fVIRQFEBt7Jb7UWGimflKYPhltkz+kxz5IkI362PqR+?=
 =?us-ascii?Q?jOy15d1RLxKqX22qV+UJSGC4PjUIbqzE/4SyRXY3crvz81uWaNnMaBB1xqz3?=
 =?us-ascii?Q?e5O+vrhUpl0sT7lJKGy5HIEaaAY1hkwECIUiMctrR0fLqt84XK/mFtv+c6Mn?=
 =?us-ascii?Q?gDx+uDUJcJgKxjq3F0UtBIQ1i0gC5qxfT6haArl2wB+KHQM50jkrqAgmGk37?=
 =?us-ascii?Q?7NUkVVN4IZTn3vtHsXGQtKLEuLPO5j/qMyZs4xLY69J?=
X-Microsoft-Antispam-Message-Info: x5vKmSss0oArL7yuQQa7x/RqA+iV1AHdCF11Lpo7X/S2ORp4qzWptj0X51pKx9iLh+APv9bIWBxdyjN0r2Q0EIFCafHnbgb5VB5mrrFa8b17BNT78k+A5bUKV1Wom2wTvNl7im0kxZKXnVKbg8Ci2dElzL8h5808YtJJMU6+2YIAkDpeKTm8tOg0enBnB5h+xGyI6gVi7BO25LB7wvU/zXa1h38ZoKgu0HxFpFbAdPnzftzfjCJGcuhvV6TeudZ19AVUpuEzGz3xKQbuGj7YChQh4WR1GjEYuBSzqfEtPNewOmXpBbRT/HorG0ZnB9HPI6efPO0fmF5yNo7xezmAsvAPSRNuMDgysgrtEuNKs9Y=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;6:vkSuVBBzmjEQjfYlX3B8aCYRM2O5fwy88Qu8ifQaDiU3pPy2qvWHpTjJ9l71fSbcSbtjBl2szTvguXZJSlOIZij4XViGl5AUToKmh6x3IVby5k5fJLlE97Cwxgi4qKT77oc1v8LeiH1SfBUq4s64SwqDGP3EhPMiH31p4P96Iofog5oioPagU4/C1I0AiGTtjJIQ/OnYBvDyRtYDNZqAkU9QIKUR9V9OpZ/26iPh2B/+5AYSLZlD4+/jUKZDB15vj38iulOSVdHIIDI32eC/wSYsg5Ej4+K1PHJURpuRZhRS1zx2wW+uOxttKnmOu6jpl4+5Ux2xlsl/AhHD28cuIWQsEOmd/1SvPoJO8jf1RuZWZD0JVLUrhOt+84BotRNKqm8nO3k3aIC/tH8uVg+OVYMnexKrscdiYxfCWo8CnpaFH+nFDRf2W6EVOCiugeLrtTXJpguP8db3Re9O1AasDg==;5:EKyJfij8qwOGjJX73uDnUdj7LAlR99xiHU98LpFFADKMcQhJH7bgq5+DYEHvpAkBFxE46WAgkPF08OfC0sHXvOnT0WE0iu17ZNoAkj0lug8yLEum8weHcUEvtWIoiQP1A/dSgvDxgHvVK1FU6C6B4/QEeRz2xmmJ4mFkbij2O1Q=;7:8tfw/TxAIX99N0+rkh7qwmZdhAF1zMQ/1F0mFtXLc7XvJ1mRtQ7nVMtyGo58rEFDyZh+bgbCiL6J7sgohlA0AovcNOOf/PhYjntB3u5/dEg4snk/LTIP5SYhcAtZP5RWb/0PUol5z1qyjU8E8uka1OM5PLIODPsFyCNGgnT4INSZ+huKledRYuX/YD5//H2MQKth83iuEiuF3EYvPI0NRx+oYcYDbsFqYgppKkBdlIB7P7X3v/p7Upv8seSYT6Tt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2018 18:11:12.8203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 192a53bd-524b-47e6-3d34-08d60535fbf0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4935
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

This patch allows us to use approach 4, by including an
asm/compiler_types.h header using the -include flag in the same way we
do for linux/compiler_types.h, but only if the header actually exists.

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
Any thoughts anyone?

This isn't the prettiest it could possibly be but it's a small change &
clearly shouldn't break anything, which are good qualities for a patch
fixing build failures that we'd ideally backport as far as 4.16.

Changes in v8:
- New patch.

 scripts/Makefile.lib | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1bb594fcfe12..4e7b41ef029b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -151,8 +151,11 @@ __a_flags	= $(call flags,_a_flags)
 __cpp_flags     = $(call flags,_cpp_flags)
 endif
 
+c_includes	= $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/compiler_types.h)
+c_includes	+= $(srctree)/include/linux/compiler_types.h
+
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
-		 -include $(srctree)/include/linux/compiler_types.h       \
+		 $(addprefix -include ,$(c_includes))                     \
 		 $(__c_flags) $(modkern_cflags)                           \
 		 $(basename_flags) $(modname_flags)
 
-- 
2.18.0


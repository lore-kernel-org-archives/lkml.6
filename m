Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeBVXHl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:07:41 -0500
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:20512
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751961AbeBVXHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:07:35 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc: linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v8 2/4] MIPS: Octeon: Automatically provision CVMSEG space.
Date: Thu, 22 Feb 2018 15:07:14 -0800
Message-Id: <20180222230716.21442-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222230716.21442-1-david.daney@cavium.com>
References: <20180222230716.21442-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:100::32)
 To DM5PR07MB3180.namprd07.prod.outlook.com (2603:10b6:3:df::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 257081d9-f04c-4d64-4dff-08d57a490e00
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3180;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;3:0AvP4VMbGk5ETFbBEzbXn29OUkFqFkPwZuNJyIe5pTy7sGyjVVkxKhEOFRKgB7SSHsrnZFF9v2mUNpZfZL1aUqzuVJ8kHQuL1uH8QJqzYtYcEXYkbFBaHLgsT+he8huWxwcUpJxpsYwOYS2ZtdT64QvkCIiWctoOYadzRILcsgrNGQXXUUiubH9NjfYyD5Kqj44da9/GNz7dcz7/Xd3wAMn08ZMm6ut6+9/RC8elPNokd+4sCVBlpEjjkWBn+jYc;25:BNdS+bL9AfMFshBzJFIvJr+6ZGYSQSxX6ey5rvowuce4LNPI6ekMUeFAmf0q35MwlS04N2GKj+wHKOKDZyakNjv9ZMzvmtB8LZQ+xOoa5LMzFA92w1LGTsy7/mh9a/XFoMT9g/7sYQgBHoPB2VXech0YJ8pcE14W4iP4sIRZP2rwUQnGqz49TcQ9SufwoEbMeyZUrgqSmhHEg7QS1cvI2vpx9S7q3nL5YQTIAf6/DeJgEaZ4HpLlal+TdvNarXFnS6kiDs4oYrMqYLc55EoEQLTShqPpsiqpB/hXa5hT/db7vm3ngktja5srgeq2sOU8z4KXauydLzGzDVsPowGEdA==;31:J7bMlRVfrZmyz8IpN2UTC2//7onlGuUkCain/4IZVzuLv68vEJb1ZFhuvOcywUgYMr9wC1dU62S+d3iFpMXeiup/DzA4LaIhjO6ZumavQRHcfBDTSH3kGxsJYSw43/EMWaLn19XbS+IdfWIJ9lBoa01p2spKs6gPCyVMrURAdksPjREC0EFBFmFqdw57b3fPe7mO9kYdJGjPB/NHmyOIblv5fKaNnZWdKP/KDX0+7J8=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3180:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;20:qMte6KGC3FsSzqWHvMUKdaylNG3BtQSC+y4FRNA6XJr3H9J1IUiouWT49q/+N4vgwkJ9ADxLCagqm/gqCsvEMkuBSakozbhSpzw7DzKwISnur0rmznJhF1XHxJ4qwbF8zQCpxFWNsCdOpDKAaMIlUmpG+v70FPaEe1tcmVEC15JZiqhaBQFaUJZzSo0dGHsIDr7tABxC72fCJCXKq5qmAmiQWENcv3fE8o+3s9nJ/DA4BIoIDEgH/xHWEDUGld25LwQq7JIcVtJrpWbopdETMukUB2y0BLq2/Nv54iXkBZGqxsx3JvNMF+jOrBnKV2qsdPlXfFiRRqJGcXhEFGhv7imSR53tKItV4kQj3Rm3oUBUo0TId+fVMphCj2ZLfZo/wvyKd3JtmjaQxLbg9E88xzwWC3KVcQ0KDeb3zNjmSkWjyjSUqsEDOkHY9c3Dyn8hp10kSaKjoyiFi3xP6v9M3fdbGpXP4ZVvr2wPgwtYY2oWn4hf7zSEwm9XzQfeZyFi;4:Nqzd++dDGXUFcTEpumJ/Fna7oUg+lt57hyWNIP64AXuTCpIfTarGnUgZ6x2d2PTTZc/RZtYVu45f7OqrCGu/tcS1EDNGmodgjRifElPLheh95cDdENdncS2jKngN4zHZfnYAjRS0DeCfyL6kFpoD3ci4rH9tY9gpxf463NkmFgE8a5oV08JoJ3Y0Urob73Kb6vjDlkOQejR9HRIRfK3d13BRyZXlRfrWO9oz7sKf7fF13IDAOFwvPwLWPqQkhS47xzVxo0fQPD5bB0a2TEhspA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB318079B05E8053E17C87669C97CD0@DM5PR07MB3180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3180;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3180;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(39380400002)(346002)(366004)(189003)(199004)(53936002)(305945005)(53416004)(66066001)(107886003)(6486002)(69596002)(47776003)(6512007)(386003)(59450400001)(6506007)(26005)(5660300001)(50466002)(8676002)(81166006)(16526019)(81156014)(478600001)(316002)(16586007)(54906003)(8936002)(72206003)(48376002)(25786009)(4326008)(105586002)(50226002)(186003)(68736007)(3846002)(6116002)(2950100002)(1076002)(6916009)(6666003)(36756003)(2906002)(7736002)(52116002)(86362001)(76176011)(106356001)(97736004)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3180;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3180;23:1sS2AGUnHup4J2UDuZ3z4Bve3Akz+27hLXZ6f83AQ?=
 =?us-ascii?Q?Xamih/Nk7as9PqjocRmAhLkqZ9bbHWQngB9X7lgzGkm1Joq5SsEEDW6BhcrN?=
 =?us-ascii?Q?IWf4n1GBgDqwCm/75SUqU2rov7LHtBKQbKJyTi2rkQRoL8vavU/u7+P2djqX?=
 =?us-ascii?Q?aEiF35TV4QjUTsfohA7Of1n6f/r+as/Oc+CZsmV+9Go9cmFyCZGrnAC7OH0i?=
 =?us-ascii?Q?kAh3z2sAwK83AVCFRB9xJyoHl26VN27T5H/32WT5hujKBIkyqLKqMbojfazF?=
 =?us-ascii?Q?hHzAJPO+t+xcO7Mf+tKEcP0p6DXM0tOa3qxXsmIyE4S95nfCYhfami5E4mNE?=
 =?us-ascii?Q?v5ZuQGmwKrgCInv5vU2kyKzjDmBRGFInig+26xv08yT1P2jPSZgc+TitYHSj?=
 =?us-ascii?Q?/vLt1/XWRaeX4evTeACTsEQJt8qPKRqfdgtpQ9AktJoRO27ZLJ4KENudaE73?=
 =?us-ascii?Q?cPrdm49GwDRXQNzqcVTczCBOIT1P7sRzaMsttsomFj39VZvnV2nA8lx99tI5?=
 =?us-ascii?Q?OLb7wii1CJ5IcUviFhBXx68kDULZAn9MM9oHqrLqgSE6U9+9c/UR0hLttZl2?=
 =?us-ascii?Q?xrqfQoe725D43Ptwed3mbydmo7X4fvMiegsm8yTSx+QSjFtjvwDev2v9jaEt?=
 =?us-ascii?Q?BGqKSg7+x+Jpl3Wapisqhm7t4J6xpUX6adcKCnGsZ0DP0JOJdJVv4BeB7awF?=
 =?us-ascii?Q?h1iB3gSCCalKv6lA+WxHYcKU4Y7ZRpqJe1vzm9pXSqQVkxUa8Iv2xCZNC6Nv?=
 =?us-ascii?Q?7YUT0nkm5QZwcWSwD6DL5xE1X1Ufxk0sn/jPbBbIGX1pu/fo/sSzlO+/mA5q?=
 =?us-ascii?Q?MEZToV24RspTGdHRrfBrwdt8GXU2TvSZwpX3fcKZigESHr8UotulkcXzGVeD?=
 =?us-ascii?Q?eFz2kQ8udACyWi4woUXi0zP+0jHYFH9fI4JJpJjclmZqVKwa+sGPzMcFOSu+?=
 =?us-ascii?Q?5Swkv7J3J+W5B+NUYEFQHyYzZzGe8UzGQE0w4/LwT0fMTTX7NvAPjtWTbqAe?=
 =?us-ascii?Q?N4EOyV5zb3ApBU49nsTMzc9PlIf1vAqemaBCmJKeGDogCtM84Kn0HuhPcOOu?=
 =?us-ascii?Q?JJi1rAkvNcWemreQrH7n6e6HdaR7xe+KLqXgkXo4XUv/HwAhjQ3WSEWVxTrh?=
 =?us-ascii?Q?ENw5GPW7FLHlNnVT4LBOkhmfy0nW6Bv7SnyfnoqRD2PzqTYrVKY2cbZtys1i?=
 =?us-ascii?Q?NS/ltd4ApFODDy9NY0MUVjBYPQpN9o0LepOAgSgWqVzHpyjeqfBq2asPTvup?=
 =?us-ascii?Q?B5vdD59aWAzs53E0+g=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;6:Y+9ymqhwlAocxNIPjoT+txbGSdkLuNbttF3knlEdCb3R0LKouBC0DhS6N2YhklUcSA4hRr1BRvIuLSrRo+v5XxIZSOmxPfitwYyhX5bVcr3YpGrCZkQhDclyojOAfs5J+ACAtlc0nxgUrXxDYdD0B59b0KUZmaL3t28SMieIuZBrm3PVESy0vgkqW8S5T6t9Ctn8D8qrZfqOoaYDE2XHSPg3wCxCuksits/58+ywOjSuEJzFkyMYP67Ojc972B4bkJ3dZ3h77OahD2iDP+fcfHJjib393uJgx/d0B0tcfkH9cydfs/YZZDzySjpeCA/oP/GsuL270lbsi2vuksQbYGtW1UAC1PURqxf8p5qOLqc=;5:xC4LH4JYouAfrh6QEKScVaDlaayjpkVipw2qE05VzvhA6ggfT5EoFSR3fdW8s4SQsY81UIB6sXI3AOw01azDFKdaDaYEWCd+5bTiqmaWFw7R2ufLB+158k5n0nqvYoLRYndS4JnEwDPCemnKPnU7fBDs0s+lF1v08gFwM12ogzs=;24:YW1PyPpx3y0iiIHf4OQGKYHt98kkkX8GomDrSSYD1lrW+da7yFcXHDreLgASywHJKJm741mT2F0ZOZ01Ctkv/rcnra6Q2TMl3I6GFAGTXk4=;7:3wJSPtnbZa6Zbd8OkehAU5+970UxczeI82xMTLulwvv8C/a6Lf8xjRFo83Vx13eOn1hKeSY45ekOcisXj8rrv1goyqF/EfuNIYU99xLMu6N5Zgho+NE/qCZFw2G9LwyM+DwFTIa1g3MZouZ2rh/IgYdXVQvKwRcs2kjSGAtWZ1k+zBhkD/fjZdCWJNmummMiurg83fJuMPfiSv9G1kPuqext+ofxUNww/3J9pgZIamprJxte9CntWi+ICmwlH9Sf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 23:07:32.2020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257081d9-f04c-4d64-4dff-08d57a490e00
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE and automatically calculate
the amount of CVMSEG space needed.

1st 128-bytes: Use by IOBDMA
2nd 128-bytes: Reserved by kernel for scratch/TLS emulation.
3rd 128-bytes: OCTEON-III LMTLINE

New config variable CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG provisions
additional lines, defaults to zero.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
---
 arch/mips/cavium-octeon/Kconfig                    | 27 ++++++++++++--------
 arch/mips/cavium-octeon/setup.c                    | 16 ++++++------
 .../asm/mach-cavium-octeon/kernel-entry-init.h     | 20 +++++++++------
 arch/mips/include/asm/mipsregs.h                   |  2 ++
 arch/mips/include/asm/octeon/octeon.h              |  2 ++
 arch/mips/include/asm/processor.h                  |  2 +-
 arch/mips/kernel/octeon_switch.S                   |  2 --
 arch/mips/mm/tlbex.c                               | 29 ++++++----------------
 drivers/staging/octeon/ethernet-defines.h          |  2 +-
 9 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index b5eee1a57d6c..a283b73b7fc6 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -11,21 +11,26 @@ config CAVIUM_CN63XXP1
 	  non-CN63XXP1 hardware, so it is recommended to select "n"
 	  unless it is known the workarounds are needed.
 
-config CAVIUM_OCTEON_CVMSEG_SIZE
-	int "Number of L1 cache lines reserved for CVMSEG memory"
-	range 0 54
-	default 1
-	help
-	  CVMSEG LM is a segment that accesses portions of the dcache as a
-	  local memory; the larger CVMSEG is, the smaller the cache is.
-	  This selects the size of CVMSEG LM, which is in cache blocks. The
-	  legally range is from zero to 54 cache blocks (i.e. CVMSEG LM is
-	  between zero and 6192 bytes).
-
 endif # CPU_CAVIUM_OCTEON
 
 if CAVIUM_OCTEON_SOC
 
+config CAVIUM_OCTEON_EXTRA_CVMSEG
+	int "Number of extra L1 cache lines reserved for CVMSEG memory"
+	range 0 50
+	default 0
+	help
+	  CVMSEG LM is a segment that accesses portions of the dcache
+	  as a local memory; the larger CVMSEG is, the smaller the
+	  cache is.  The kernel uses two or three blocks (one for TLB
+	  exception handlers, one for driver IOBDMA operations, and on
+	  models that need it, one for LMTDMA operations). This
+	  selects an optional extra number of CVMSEG lines for use by
+	  other software.
+
+	  Normally no extra lines are required, and this parameter
+	  should be set to zero.
+
 config CAVIUM_OCTEON_LOCK_L2
 	bool "Lock often used kernel code in the L2"
 	default "y"
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 99e6a68bc652..51c4d3c3cada 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -68,6 +68,12 @@ extern void pci_console_init(const char *arg);
 static unsigned long long max_memory = ULLONG_MAX;
 static unsigned long long reserve_low_mem;
 
+/*
+ * modified in hernel-entry-init.h, must have an initial value to keep
+ * it from being clobbered when bss is zeroed.
+ */
+u32 octeon_cvmseg_lines = 2;
+
 DEFINE_SEMAPHORE(octeon_bootbus_sem);
 EXPORT_SYMBOL(octeon_bootbus_sem);
 
@@ -604,11 +610,7 @@ void octeon_user_io_init(void)
 
 	/* R/W If set, CVMSEG is available for loads/stores in
 	 * kernel/debug mode. */
-#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	cvmmemctl.s.cvmsegenak = 1;
-#else
-	cvmmemctl.s.cvmsegenak = 0;
-#endif
 	if (OCTEON_IS_OCTEON3()) {
 		/* Enable LMTDMA */
 		cvmmemctl.s.lmtena = 1;
@@ -626,9 +628,9 @@ void octeon_user_io_init(void)
 
 	/* Setup of CVMSEG is done in kernel-entry-init.h */
 	if (smp_processor_id() == 0)
-		pr_notice("CVMSEG size: %d cache lines (%d bytes)\n",
-			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE,
-			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128);
+		pr_notice("CVMSEG size: %u cache lines (%u bytes)\n",
+			  octeon_cvmseg_lines,
+			  octeon_cvmseg_lines * 128);
 
 	if (octeon_has_feature(OCTEON_FEATURE_FAU)) {
 		union cvmx_iob_fau_timeout fau_timeout;
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c38b38ce5a3d..cdcca60978a2 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -26,11 +26,18 @@
 	# a3 = address of boot descriptor block
 	.set push
 	.set arch=octeon
+	mfc0	v1, CP0_PRID_REG
+	andi	v1, 0xff00
+	li	v0, 0x9500		# cn78XX or later
+	subu	v1, v1, v0
+	li	t2, 2 + CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG
+	bltz	v1, 1f
+	addiu	t2, 1			# t2 has cvmseg_size
+1:
 	# Read the cavium mem control register
 	dmfc0	v0, CP0_CVMMEMCTL_REG
 	# Clear the lower 6 bits, the CVMSEG size
-	dins	v0, $0, 0, 6
-	ori	v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
+	dins	v0, t2, 0, 6
 	dmtc0	v0, CP0_CVMMEMCTL_REG	# Write the cavium mem control register
 	dmfc0	v0, CP0_CVMCTL_REG	# Read the cavium control register
 	# Disable unaligned load/store support but leave HW fixup enabled
@@ -70,7 +77,7 @@
 	# Flush dcache after config change
 	cache	9, 0($0)
 	# Zero all of CVMSEG to make sure parity is correct
-	dli	v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
+	move	v0, t2
 	dsll	v0, 7
 	beqz	v0, 2f
 1:	dsubu	v0, 8
@@ -126,12 +133,7 @@
 	LONG_L	sp, (t0)
 	# Set the SP global variable to zero so the master knows we've started
 	LONG_S	zero, (t0)
-#ifdef __OCTEON__
-	syncw
-	syncw
-#else
 	sync
-#endif
 	# Jump to the normal Linux SMP entry point
 	j   smp_bootstrap
 	nop
@@ -148,6 +150,8 @@
 
 #endif /* CONFIG_SMP */
 octeon_main_processor:
+	dla	v0, octeon_cvmseg_lines
+	sw	t2, 0(v0)
 	.set pop
 .endm
 
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 858752dac337..4e87e4f5247a 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1126,6 +1126,8 @@
 #define FPU_CSR_RD	0x3	/* towards -Infinity */
 
 
+#define CAVIUM_OCTEON_SCRATCH_OFFSET (2 * 128 - 16 - 32768)
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 92a17d67c1fa..f01af2469874 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -359,6 +359,8 @@ static inline uint32_t octeon_npi_read32(uint64_t address)
 
 extern struct cvmx_bootinfo *octeon_bootinfo;
 
+extern u32 octeon_cvmseg_lines;
+
 extern uint64_t octeon_bootloader_entry_addr;
 
 extern void (*octeon_irq_setup_secondary)(void);
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index af34afbc32d9..1a20f9c5509f 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -216,7 +216,7 @@ struct octeon_cop2_state {
 	.cp2			= {0,},
 
 struct octeon_cvmseg_state {
-	unsigned long cvmseg[CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE]
+	unsigned long cvmseg[CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG + 3]
 			    [cpu_dcache_line_size() / sizeof(unsigned long)];
 };
 
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index e42113fe2762..4f56902d5ee7 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -29,7 +29,6 @@
 	cpu_save_nonscratch a0
 	LONG_S	ra, THREAD_REG31(a0)
 
-#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	/* Check if we need to store CVMSEG state */
 	dmfc0	t0, $11,7	/* CvmMemCtl */
 	bbit0	t0, 6, 3f	/* Is user access enabled? */
@@ -58,7 +57,6 @@
 	dmfc0	t0, $11,7	/* CvmMemCtl */
 	xori	t0, t0, 0x40	/* Bit 6 is CVMSEG user enable */
 	dmtc0	t0, $11,7	/* CvmMemCtl */
-#endif
 3:
 
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 79b9f2ad3ff5..3d3dfba465ae 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -115,33 +115,17 @@ static int use_lwx_insns(void)
 		return 0;
 	}
 }
-#if defined(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE) && \
-    CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
-static bool scratchpad_available(void)
-{
-	return true;
-}
-static int scratchpad_offset(int i)
-{
-	/*
-	 * CVMSEG starts at address -32768 and extends for
-	 * CAVIUM_OCTEON_CVMSEG_SIZE 128 byte cache lines.
-	 */
-	i += 1; /* Kernel use starts at the top and works down. */
-	return CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128 - (8 * i) - 32768;
-}
-#else
-static bool scratchpad_available(void)
-{
-	return false;
-}
+
 static int scratchpad_offset(int i)
 {
+	if (IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON))
+		return (CAVIUM_OCTEON_SCRATCH_OFFSET - (8 * i));
+
 	BUG();
 	/* Really unreachable, but evidently some GCC want this. */
 	return 0;
 }
-#endif
+
 /*
  * Found by experiment: At least some revisions of the 4kc throw under
  * some circumstances a machine check exception, triggered by invalid
@@ -1302,7 +1286,8 @@ static void build_r4000_tlb_refill_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 	memset(final_handler, 0, sizeof(final_handler));
 
-	if (IS_ENABLED(CONFIG_64BIT) && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
+	if (IS_ENABLED(CONFIG_64BIT) && use_bbit_insns() &&
+	   (scratch_reg >= 0 || IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON))) {
 		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
 							  scratch_reg);
 		vmalloc_mode = refill_scratch;
diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
index 1e114422993a..33c71f86890b 100644
--- a/drivers/staging/octeon/ethernet-defines.h
+++ b/drivers/staging/octeon/ethernet-defines.h
@@ -29,7 +29,7 @@
 #define REUSE_SKBUFFS_WITHOUT_FREE  1
 #endif
 
-#define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
+#define USE_ASYNC_IOBDMA	1
 
 /* Maximum number of SKBs to try to free per xmit packet. */
 #define MAX_OUT_QUEUE_DEPTH 1000
-- 
2.14.3

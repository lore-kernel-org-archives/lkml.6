Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756070AbeDFOki (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:40:38 -0400
Received: from mail-he1eur01on0092.outbound.protection.outlook.com ([104.47.0.92]:14464
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756049AbeDFOk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:40:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 3/3] ARM: ftrace: Add MODULE_PLTS support
Date: Fri,  6 Apr 2018 16:39:39 +0200
Message-Id: <20180406143939.14642-4-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180406143939.14642-1-alexander.sverdlin@nokia.com>
References: <20180406143939.14642-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: MAXPR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::28) To HE1PR0701MB2473.eurprd07.prod.outlook.com
 (2603:10a6:3:71::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 140f14cd-f769-4849-c054-08d59bcc55b9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:HE1PR0701MB2473;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;3:F01eP2pEa4LmZSf8YQHdloS/6QLfi/uLMcUAcEXH7cM/UbodwwnGi98JMpcgS6yXkzDwmQncOPN7FVG7Y68tBHLTp9MRy/M9ncM44AOyOZ6ROcJJ10g1W45eYkw60PgCtVbjihB4iKHoxiFK9gfLCjeyirnLBE4sh7WabbBZU5AkFw7qRWYL06RkxqAcg1Tm6Pe4h+gHicKiMqU9r67fYww97NnRRZY/e9cEPqV/BfkAoTQqq+u2hqZW3UtWnlif;25:LBQ8vovFfYiO3ik0qJ8WG68Hp42oyo0SBIEiGH8wWJPCVSWz992YoxP29gn8GymAeERqy6gRmVS7GvWJH/WgkoLdgunRmwB7i5DH+zcm0kP72VeEPjNg12D2DnLOGhPXv7GPihTaxzYsyfmpJa9lQ3UFrEDNPiQ7JRGeRkVrqQayve6+c5Q7sMLuDkaw0zKyhVMkIK3N8Pw7MgAuHHK1cNtQYAW68S1NzgVnESqPoSH9mi5ePkxcUOSzVCNh1qRnbSIrBtdBWNq/VmEtUzik1lcaaU2Vp1CgzT79+LfHJ/Km3DeKd4q8QLU7sv/u6JlYyCun1R4BV4fjeNW2TzryqQ==;31:kOtbp0N88WggjPriEY7S89+ZewfZsx3bTUbEGN/FgR45Ck+H8NLVuXS5Cbxia7Qh6Eao/0U+uu6MUgPxMQDHxhOzXVIEKWuVU9na6TsRv9jTV4zM62H/crk8h1OCEjpXSwfrUMLl00S3owXkYQJObKDK5osnK19ZXvQ7VZj2TdJfPZIOUG+1whTCBXpLsbula1wiWWmUlDwCGBm3WQYNAyRvSjQTxxDtDDoBLqnJpj0=
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2473:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;20:zsZmZAoFLw9WHyGl//ytGAI5epoi0dTWDlCqOtw9BWTYVFkmP/8UUnilx5a1NuiIIh46cuuBXgS/ZuX9POpjt29s3RZXwlIhlFVHsE189k2iwnfbFkhMBEL5Sxf23MDqg47KRnVWnUNPbRi+zwDhkPrwX2LQC/O623zNqOxh6bn3DZR5AwpuT/Htp1mFKlHrPeiHHLQuBnSk8XC+IKDDD0d4UhllRRxlU3YHzTQ8B5+phnWj5qaoASjHsjdJvUVUj0ItRItCyw4WADRz7ObUD4Foue1IVhwMHZSy/BPRfmTsPrCLkK9g2QdQKQYX9Jk1b2lOlflFNRbIx/Zt/Mkkm1eACCpjjqjjVHRmNhKJ+0KetlBgKKQy8ehkuPRHRV+CmMuqlGNgl2w/mp4bYg+nUg9IlGVqUFwN+Onh7L92sDjqjyGeOElo/P+SudRM/0XX57B3KBplnH3i2cT2pp49njcBKjQ4T+kbHes9lChwROsiDCBU21SxunRk8StKrauUTZEn6OnagxBmyShBf99KpyIliZLzWJ0IBESkpnrheXwsxrLquwwpwJRfNjazjwLFllmwjuO1BLeIweSSS+R6QQwwO0ZWoB25HYbk2CF3Hcg=;4:ruR0DnE7KUJ6fOhDB4Hf8TnwU3aZ/HJSvxp1CVR9U5SJSbYTJRwe+a0mYXtqyMsNzAALmmrSe3WQ1fIl2vW5oTjjEbT4KzDNucWLY7MG9+aN5XlhB/L2+9g/I9EGnu2yhxVGJCM1tvAH1/HiXET5yL8M2v5EeUUjbeKblySpaPhdo+FL02IjVVzVRbJ5K4mtQMp0l+ESoNnZ7NaA3FsR+ehSOHpR04SL/8ySoWWG7SXQbKxm6xF+7pMOIHAxWaD5PCZgLBb55SERHNeCuGtdApwXuNKhXHCSJTcFRUQk8UxrFJSFtbbXIuedfLNOdL/B
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2473280E324A13C5094CC84A88BA0@HE1PR0701MB2473.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(11241501184)(806099)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0701MB2473;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2473;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(376002)(39380400002)(189003)(199004)(25786009)(446003)(4326008)(11346002)(956004)(97736004)(2616005)(476003)(26005)(186003)(16526019)(6666003)(47776003)(6916009)(2361001)(66066001)(7736002)(305945005)(5660300001)(486006)(8936002)(50226002)(81166006)(53936002)(3846002)(6116002)(8676002)(81156014)(106356001)(6512007)(105586002)(16586007)(316002)(6486002)(52116002)(51416003)(76176011)(2906002)(36756003)(68736007)(1076002)(86362001)(54906003)(2351001)(48376002)(6506007)(50466002)(386003)(478600001)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2473;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0701MB2473;23:k39GbYA133xUlalCE/GcmN08vgzU5krV2XnqkZe?=
 =?us-ascii?Q?7/8LlDcYTFi3Au3Uvkl7UHBm8il+QWTG4KHdMrDADHZYShqPx5zHDqN4muRy?=
 =?us-ascii?Q?dcFWHZL11Uu5k1/KJXtM+enJaDO1matCkjySIXy346o5Cnx4srvh+fP4Fa4n?=
 =?us-ascii?Q?wF+EjY1aMiiRoshR89H1lcd5fcEJ7ZuDqe5mtdhv7pEDj1MYXOTZmTsOIUYn?=
 =?us-ascii?Q?25y2IWfoQ2vM1hkP3FrX6y0y4Y2J+CsS0XO3dGTZfy4d9rHN9KMA5cYWlJbk?=
 =?us-ascii?Q?ybsOxwp13pylTW3t6llGOMZkb+doAIaTfXaj0nEjp1jc9IGaQMXAyj57UmNG?=
 =?us-ascii?Q?dys+XOU86Scd7Rfz3cU3ALV5ODbZyMQ9DqkCcyoMZ4GqbL/X72Ay04ZD/4Li?=
 =?us-ascii?Q?g6PiXFnJKiA0f5wO4owPVdPjWWzEcMKTzT+7kbOePXff8xj9ekIpRbzcVTHs?=
 =?us-ascii?Q?ku+qDglPKfO4o61XwT0WwKY9lvEQMQD3y5BkTvsfDSXCszE1Vb3+JGYYD7ip?=
 =?us-ascii?Q?fLuAw02FaSfH6nsdjLbqAlJiLOPa+KnFnAL7cCHE+p+OajIw4QddeoMupJ2D?=
 =?us-ascii?Q?af+14S9GaVCzrOH+UXtIeSQIsBz3tQRcoygWIfSIh1M+sObIGQENrkzUl3Cf?=
 =?us-ascii?Q?DiQPzAXmRK0sC9We/Vyjb8Y7m1k0Hx6Rc1B6fBWEI/OwyMl3E59o34VPkpDK?=
 =?us-ascii?Q?FFLPzrTgOVWe9CzMRVZwZZpsioXTyJcyd0ER0ylQD6fNoEyERxmV34rb1odf?=
 =?us-ascii?Q?OU6LMxQaRkG+FlwBsd9EU8+sbcdn0HYsEJPr8pRfDDwadvMHQJn6ypKZk4LY?=
 =?us-ascii?Q?uHpnLJv+XjuBRc4djPNyohvhAMgb3SfHc18lweAEhVvPP8wHz4ZLBfVC34ya?=
 =?us-ascii?Q?zqQUs9I18J0pEmJej0JX2ToyOPSyha3KhjmnfVCq6cRW4/hQIfxMba1DBDsV?=
 =?us-ascii?Q?n+zdIcBFlvwbJIKZNOGTqjyBo7JBi4teTwQ/PwxY8CmHooj9E3PvP0WfQZ9B?=
 =?us-ascii?Q?4cntX9E2Je8YFmBUylS/RvGerIOhV6Z7JfEtF4mqq7IrW0v1enKF71W1hvPD?=
 =?us-ascii?Q?XuQY3vYwJXKk9XM74nnnmPPn33nFl4nRecm9qSi49/L8J8QIycombbcMPk3S?=
 =?us-ascii?Q?dAA/P/rJ/pKtLRErxGsGhW2+VE2AjbHvTlPHBkr6Soa5PZpK1jBSOq1PBUwj?=
 =?us-ascii?Q?vtnCcigrT052mZKYPA9tWwzWjp7hLn6IRlttcfLN1UJ9/xBDQt5d7hGZSF2U?=
 =?us-ascii?Q?DdXbL435F1D39NI673rEBe4JWvHjLSs62W5NX77UE+tFdrj9Ey42mTQ6IYyi?=
 =?us-ascii?Q?V8A=3D=3D?=
X-Microsoft-Antispam-Message-Info: MPraAtYmFbkZ+4C0/SLjwI/avD3vFcbzKAj8fZszFqIMo9ATE8h/tQIgMlC/ysRALUhirSoCiz6Psco5U4URxC/6RiSYCx4IQN1HgIwEMo8jxqreVdvZ76Q0F0W6wv57ZfsOL/PKZUnpKuX9K/wKVsLRgNZ6QLElSeOAzHCR03cRFODzCOVfNOthKocG1rbT3u4x7ug9Yca6EANFhcP1OrDReTM1owLJZeL7e+n5Aso=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;6:9UV2U1sGkGyCJ71RuIPfJ4U9dsVJEjUfW1m2BFCg23TsXd0Dkd1UycWdwH8adk18ooV1TRmP1Il+ujd2zg9foYU5IwNsgSayXtDAovAAiECN6PQ0wjF8eUoh5YCHeQbZ4RS6lwnycmfD4ZPSqsMsWlJLsGTUXF9+qnkrTXXnoYqXL934xGWw1H/8Fcu8UAuVEI5sCpOltWaxewLF2oRYrvciFHj8B2C/p0f72yZ3E0Rvr38sujAs6hojleW4WqoG08cAUSMBU+EjILqhPwVTZQed363567tkpMBeNvkIc1XrTlwqtK86dTDBxTSQeZvUP9rXRUGoBWgS8HYfBP63Wa5Eb7p/s6QXB/bDGP96Xr6rJyBWateZskIZZrlLZl/+da8s/cGoT5sJVtVlnXpBDlBjlxEoXoCwRl1YPT+Fyt9CImCs0Nhnc3wHdW7iCgvkhKU1Abgq5W2aZZ9MeZI1mw==;5:ddkfqaV5Q8VIzt78J54diBKh8gv1q3c4i46AB4QBWCr/csBL2ypcS7x4ly/P1l1NKMihBjx/Rng5UeFboR6hX7eZlNmEpFyCeWWAu6UATuTEmP6AX9MPwmFKDq+JatVadsr66SGHKbK4OSztqKmAEkjpnOFR7nCtqgvp7oK+Vl8=;24:SgJGGpO9UOY6fAc4rFGdtdIjg6s8ZJKy4kWH3wD7+3vAitTcgaylFhToN2EW8CfVx7LK0ILdON/ry61naU78coZbjUUAcc1XJMHT+HxrNfE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;7:WYzdYqMaQ8TXcftRrykYJsXGLSZ1GeJxxEduBb3OSaQfzQrsPlBpVL0NaaB/S8PajnX5PLE9k3SwySspX/jRCFcJu8jdZ84Qm5sWOfPYXbpJUhxXTDbtUQLZmzaQw3n8sJWQc/vd2bs8CluC7gxVA7dyyEIRXQsGl/97qMVzu2HKcvbWJmURRnwZDZ9KKcgCbAkzmu+WeWd0Sfpa18Oq+x5dWdbbWL2cAqpl62LRVO+ocbCJ10jJcfZh3GTcHo2t
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 14:40:22.4567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140f14cd-f769-4849-c054-08d59bcc55b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2473
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach ftrace_make_call() and ftrace_make_nop() about PLTs.
Teach PLT code about FTRACE and all its callbacks.
Otherwise the following might happen:

------------[ cut here ]------------
WARNING: CPU: 14 PID: 2265 at .../arch/arm/kernel/insn.c:14 __arm_gen_branch+0x83/0x8c()
...
Hardware name: LSI Axxia AXM55XX
[<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
[<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
[<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
[<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
[<c03218f3>] (warn_slowpath_null) from [<c03143cf>] (__arm_gen_branch+0x83/0x8c)
[<c03143cf>] (__arm_gen_branch) from [<c0314337>] (ftrace_make_nop+0xf/0x24)
[<c0314337>] (ftrace_make_nop) from [<c038ebcb>] (ftrace_process_locs+0x27b/0x3e8)
[<c038ebcb>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
[<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
[<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
---[ end trace e1b64ced7a89adcc ]---
------------[ cut here ]------------
WARNING: CPU: 14 PID: 2265 at .../kernel/trace/ftrace.c:1979 ftrace_bug+0x1b1/0x234()
...
Hardware name: LSI Axxia AXM55XX
[<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
[<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
[<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
[<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
[<c03218f3>] (warn_slowpath_null) from [<c038e87d>] (ftrace_bug+0x1b1/0x234)
[<c038e87d>] (ftrace_bug) from [<c038ebd5>] (ftrace_process_locs+0x285/0x3e8)
[<c038ebd5>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
[<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
[<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
---[ end trace e1b64ced7a89adcd ]---
ftrace failed to modify [<e9ef7006>] 0xe9ef7006
actual: 02:f0:3b:fa
ftrace record flags: 0
(0) expected tramp: c0314265

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/ftrace.h |  3 +++
 arch/arm/include/asm/module.h |  1 +
 arch/arm/kernel/ftrace.c      | 62 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/module-plts.c | 48 ++++++++++++++++++++++++++++++---
 4 files changed, 101 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 9e842ff..faeb6b1 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -19,6 +19,9 @@ struct dyn_arch_ftrace {
 #ifdef CONFIG_OLD_MCOUNT
 	bool	old_mcount;
 #endif
+#ifdef CONFIG_ARM_MODULE_PLTS
+	struct module *mod;
+#endif
 };
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 6996405..e3d7a51 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -30,6 +30,7 @@ struct plt_entries {
 
 struct mod_plt_sec {
 	struct elf32_shdr	*plt;
+	struct plt_entries	*plt_ent;
 	int			plt_count;
 };
 
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 5617932..b55355f 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -98,6 +98,19 @@ int ftrace_arch_code_modify_post_process(void)
 
 static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
 {
+	s32 offset = addr - pc;
+	s32 blim = 0xfe000008;
+	s32 flim = 0x02000004;
+
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		blim = 0xff000004;
+		flim = 0x01000002;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
+	    (offset < blim || offset > flim))
+		return 0;
+
 	return arm_gen_branch_link(pc, addr);
 }
 
@@ -166,10 +179,22 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long new, old;
 	unsigned long ip = rec->ip;
+	unsigned long aaddr = adjust_address(rec, addr);
 
 	old = ftrace_nop_replace(rec);
 
-	new = ftrace_call_replace(ip, adjust_address(rec, addr));
+	new = ftrace_call_replace(ip, aaddr);
+
+#ifdef CONFIG_ARM_MODULE_PLTS
+	if (!new) {
+		struct module *mod = rec->arch.mod;
+
+		if (mod) {
+			aaddr = get_module_plt(mod, ip, aaddr);
+			new = ftrace_call_replace(ip, aaddr);
+		}
+	}
+#endif
 
 	return ftrace_modify_code(rec->ip, old, new, true);
 }
@@ -199,20 +224,39 @@ int ftrace_make_nop(struct module *mod,
 	unsigned long new;
 	int ret;
 
-	old = ftrace_call_replace(ip, adjust_address(rec, addr));
-	new = ftrace_nop_replace(rec);
-	ret = ftrace_modify_code(ip, old, new, true);
+#ifdef CONFIG_ARM_MODULE_PLTS
+	/* mod is only supplied during module loading */
+	if (!mod)
+		mod = rec->arch.mod;
+	else
+		rec->arch.mod = mod;
+#endif
 
-#ifdef CONFIG_OLD_MCOUNT
-	if (ret == -EINVAL && addr == MCOUNT_ADDR) {
-		rec->arch.old_mcount = true;
+	for (;;) {
+		unsigned long aaddr = adjust_address(rec, addr);
+
+		old = ftrace_call_replace(ip, aaddr);
+
+#ifdef CONFIG_ARM_MODULE_PLTS
+		if (!old && mod) {
+			aaddr = get_module_plt(mod, ip, aaddr);
+			old = ftrace_call_replace(ip, aaddr);
+		}
+#endif
 
-		old = ftrace_call_replace(ip, adjust_address(rec, addr));
 		new = ftrace_nop_replace(rec);
 		ret = ftrace_modify_code(ip, old, new, true);
-	}
+
+#ifdef CONFIG_OLD_MCOUNT
+		if (ret == -EINVAL && !rec->arch.old_mcount) {
+			rec->arch.old_mcount = true;
+			continue;
+		}
 #endif
 
+		break;
+	}
+
 	return ret;
 }
 
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index f272711..da9a8a3 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sort.h>
@@ -22,19 +23,56 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
+static const u32 fixed_plts[] = {
+#ifdef CONFIG_FUNCTION_TRACER
+	FTRACE_ADDR,
+	MCOUNT_ADDR,
+#endif
+#ifdef CONFIG_OLD_MCOUNT
+	(unsigned long)ftrace_caller_old,
+	(unsigned long)mcount,
+#endif
+};
+
 static bool in_init(const struct module *mod, unsigned long loc)
 {
 	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
 }
 
+static void prealloc_fixed(struct mod_plt_sec *pltsec, struct plt_entries *plt)
+{
+	int i;
+
+	if (!ARRAY_SIZE(fixed_plts) || pltsec->plt_count)
+		return;
+	pltsec->plt_count = ARRAY_SIZE(fixed_plts);
+
+	for (i = 0; i < ARRAY_SIZE(plt->ldr); ++i)
+		plt->ldr[i] = PLT_ENT_LDR;
+
+	BUILD_BUG_ON(sizeof(fixed_plts) > sizeof(plt->lit));
+	memcpy(plt->lit, fixed_plts, sizeof(fixed_plts));
+}
+
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 {
 	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
 							  &mod->arch.init;
+	struct plt_entries *plt;
+	int idx;
+
+	/* cache the address, ELF header is available only during module load */
+	if (!pltsec->plt_ent)
+		pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
+	plt = pltsec->plt_ent;
 
-	struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
-	int idx = 0;
+	prealloc_fixed(pltsec, plt);
+
+	for (idx = 0; idx < ARRAY_SIZE(fixed_plts); ++idx)
+		if (plt->lit[idx] == val)
+			return (u32)&plt->ldr[idx];
 
+	idx = 0;
 	/*
 	 * Look for an existing entry pointing to 'val'. Given that the
 	 * relocations are sorted, this will be the last entry we allocated.
@@ -182,8 +220,8 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned long core_plts = 0;
-	unsigned long init_plts = 0;
+	unsigned long core_plts = ARRAY_SIZE(fixed_plts);
+	unsigned long init_plts = ARRAY_SIZE(fixed_plts);
 	Elf32_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
 	Elf32_Sym *syms = NULL;
 
@@ -238,6 +276,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.core.plt->sh_size = round_up(core_plts * PLT_ENT_SIZE,
 					       sizeof(struct plt_entries));
 	mod->arch.core.plt_count = 0;
+	mod->arch.core.plt_ent = NULL;
 
 	mod->arch.init.plt->sh_type = SHT_NOBITS;
 	mod->arch.init.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
@@ -245,6 +284,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.init.plt->sh_size = round_up(init_plts * PLT_ENT_SIZE,
 					       sizeof(struct plt_entries));
 	mod->arch.init.plt_count = 0;
+	mod->arch.init.plt_ent = NULL;
 
 	pr_debug("%s: plt=%x, init.plt=%x\n", __func__,
 		 mod->arch.core.plt->sh_size, mod->arch.init.plt->sh_size);
-- 
2.4.6

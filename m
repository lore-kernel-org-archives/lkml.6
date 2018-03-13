Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932919AbeCMNxq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:53:46 -0400
Received: from mail-eopbgr20095.outbound.protection.outlook.com ([40.107.2.95]:3417
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932822AbeCMNxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:53:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
Date: Tue, 13 Mar 2018 14:53:14 +0100
Message-Id: <20180313135314.18780-3-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: HE1PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::12) To DB5PR07MB1319.eurprd07.prod.outlook.com
 (2a01:111:e400:599b::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2da8f2f-5efa-4ba3-2b43-08d588e9d0f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DB5PR07MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;3:r0gaA2GucxALZvQnYBcavplGiEKDD2Fh7Pv8MN1NoVQNTZutj8LEVrBJwwqR9meEtIIiEWe8eOWNYZtWS/GkiTtM3ebt0kZ+vdlSWf+sLZojfUKI8JBF+AwuHJJi19Xw+h9f4oQqEsbNAzwhYJpVkoavKWObS2/H5MmACW/GJInjW6WuDL4h1LaxEsJULAqyVlBT/QPfcBHLeIpjjfeud3xSXFTzea0VBxxGhMEzo/Q9+lnTGpiQ/2NOKltPNbCx;25:Xf7TfPAap8aQZ2A2yjmyb99KEpVe3B9uLvd+adOxAokQY8vxI0PRFxJuE9mjDK6MKrMNQvJusBG8Qql5ZRaQO31jQLVb0dqKk8/PIEKzJLKfwXYY0I67IsFhfW8FIqVQJW/p2oAR2XHAHsmbwzeR1A02yBi8swvG2qQZl7RKjItCh3jy+jORnnJQWbwqP1oF2O+XmxGrJFD5+xUjj3OzFu9zCA/dm9/tV0gqJBYSQ4eDZYP7kFy0HERcWp3TzavVxSl7nU6oZIeP+KpUfeBD2zK3rEhkvuRkVvSXPkZ/qbi/PjhDp8TD6MEbB8qrpRFvq8Ue9Nyv7ugMjPe1xy6kMQ==;31:Q9oNwmcGvT5c9/JP3LMWtJ3x0yHgIXHuAvQa5p6+Ev5TCPi8F+2mIPzuJUiivWLZjdR23uoJrUp13WC9sCQmuHB0LsL/FvlGsWxq4ulU0afQJh8JJTWCDmxJX0WrVJbgcgM240DsVLeHhT1iV57D17MY4zC/eziWVmtrb7B6Vvpmzo8VHm+JFkBOITGp1Krbafinrp4C6Ak6sl9nNFiHLoZOprdf2NexRt7xlRsFU+0=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1319:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;20:opqcxuE4v5Sj5TZCePXak4QRLAe8WQC2MzXmJD4jX/g8aVi9P4QeLWdFeEhRuR18Kw3wd6lE7LGcXTdIkY0VmkXYqUOMJfcuo2y9o7x/Mju5249oL/TkgXRouYGNb4IbtWoB1VXUxi2Xi2W10oTq48xj5RiBalebk7N+ZKkl8AiM/K+vSUCxrJpk2i5x1MZ1j8eDHkKT3mha/HSIvrn/7lRx7xzl78daYW9WNT8Y0DljZGdB06DtvvBMwOzPQUvwIvufq62lIK6ID4nhBtpYvodayTxP8KZZ4YMM2G1aUS2Ato9WUicZTwRBuuGxFFyQEghL4kDrUF7L6b36pjTu4XgU80uMCR0v9JKKug3YSv2wlLXBwyMI/Dcq/TNa/iHLwWbQX/kBZUeb4LWEBIx7zAPyM1iGy0z4j6QSZw575xGcKNAHg/7eu3+3msamo98IbVRbnvSvCl9qXcBI9iZXb/TkJBzzcX3S14TD7jXUKZgeKMo4Pzo6+yMB2MoYJggJAsPc1oHo3W0ks/aPw4gLr2Nbg3U15G4emsFvy9/gwvIVYs6LCSCTYzPSSZan6EuOtnE+sD/e98bZ1CH34vRxGinScPXKBg/FeLbNUmG9yrU=;4:hX3ftU/qJJLDmbVwfe2A5NdWXu9v23cTy8bHAtz13LquTGrwaId7pNIUz/Ab8Vc8IEBzHgf7jzd3oCaqLB3aobY8n7RkeiDEEh5wmAPSSc9Xsbu9uozQA4oK5qh78BQasaE9eE8BKoIKuh9naNZp/xC9IR1fjPrUzYSJ2oAlkdGWUVOHxk482uok3hD4QiMI5YmTlL2FVOG4/IuEV7NW9envLr0BwU+0qY2g5DNZFu9nrw9F61uTkDoH44Q1t2MWkI+uD0ksi6PNHkeTnrkVcpW945A0nwRXjdBKylt71ZClxYU5SH25ppQw3KYjRV4w
X-Microsoft-Antispam-PRVS: <DB5PR07MB131908A621F65D0264EB5DB088D20@DB5PR07MB1319.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(11241501184)(806099)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR07MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1319;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(16526019)(53936002)(2950100002)(52116002)(186003)(76176011)(2361001)(2351001)(47776003)(36756003)(86362001)(54906003)(81156014)(81166006)(8676002)(6916009)(7736002)(6666003)(6486002)(6512007)(97736004)(50226002)(2906002)(105586002)(16586007)(305945005)(48376002)(8936002)(4326008)(5660300001)(25786009)(26005)(59450400001)(106356001)(51416003)(386003)(6506007)(50466002)(478600001)(316002)(1076002)(66066001)(3846002)(68736007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1319;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1319;23:sCyIQacEGHJBvRKnj1HN4KFeMa48VQcBZJAh6FM0J?=
 =?us-ascii?Q?+O1NnJmxnJGO0hofO0mvLQ037QVB+RHeoilwi8YvEpP60SEBdYogFu73JELT?=
 =?us-ascii?Q?2eZlA8bITAblKODUU21LCAxR7Prmu7wae/u3mPqc/LDKrImMDOO6+Zq4GLIJ?=
 =?us-ascii?Q?yHy6703n/TyXmMlniG8YN2jGcRZlGpK5Xe0ZBlKZI9DkscYWYoepWOclOnmE?=
 =?us-ascii?Q?hFiRHijgO8SXYkzqdNkhsmx6zXeCuLb7uj3MICnbCOKyuU6UsqClm/naEhLh?=
 =?us-ascii?Q?yRXhftdxfVLP0QiudhCvSUo6SvRbX8n6u1uDwoOVFFI57iyT6gSa2RCHfQ6l?=
 =?us-ascii?Q?TrH1dFG0jL8FWFKlwGZxwPOPPQPyphwkZsFHHn6Is4lMIOJAnLUdIWYQgykP?=
 =?us-ascii?Q?fO507NJQgkEAs26qdGElPyplpjdPPpiKnxUXK/MYnxuchvh53w2ohZQ9USmA?=
 =?us-ascii?Q?ilddrErisCV+k7MUesTapgIq6zH4qXIBlPkoxKWO+saDlqQAmU/Bo10SdkFo?=
 =?us-ascii?Q?b0zFFEe9DjsHAV1hcUDCu5V0NyvnHDzquuLTRVfgc4i0OhSNbv85/gjM/Wk3?=
 =?us-ascii?Q?GNm/L9jWLK1pqhPCenxW6+mZGEu0appnYfnV6JCUc6Y42NITQoE5yc+I9VnP?=
 =?us-ascii?Q?ojJCx9rEEJzy2T9wVF3p3THrUSCFf3WKpUF/uYdDkOdg10WRus7TVQOIl6Uj?=
 =?us-ascii?Q?C73IWvxZeC9l9JCeKcHLuFlnHE5qSh5DFbIZdZ59wv4/fud29Od+3zafQjmF?=
 =?us-ascii?Q?ySZBYoffm2/c2fYXIbMCZITFJzzQLWAlwy6YWyKVMFPFgp0wPgjXWlANzIAL?=
 =?us-ascii?Q?4mJjqdoo7gyPVdPKlPiGNphrHU5jz0RogaUn8w4r0aO4TojS7ZPHd3fXYqQ3?=
 =?us-ascii?Q?oe7qdpfX0MxbWWsOWNqmCPe/AwQB6Naj7KHpar2rn45AkHNdd+w1oyQSsJtB?=
 =?us-ascii?Q?O+V+n2NB5x9J+RGJJWLytcO6V7yTf4qLQV4LV6LM+WWOnBUuedJ+NmBjNbCB?=
 =?us-ascii?Q?4rU1a6p4Rs5sDwlYXfSZe20jIhPGiuh77/wmK0+PXm96udvJnpyBHoFzzh+Z?=
 =?us-ascii?Q?yMYgCYCnXvUNBDX+6VtUwyhO5KH8zpzZsWEsRBo/Q/s/bVHFUv45A6pEzuwJ?=
 =?us-ascii?Q?rDyLe0NrYP4mAoQrAcj7tP7qJLuWYhxDTwKzJJTxfGsdXuBjXwrxBWRelGXS?=
 =?us-ascii?Q?9KckdQfrHc4ze4XClPBWrRB2s4VKPy55SIk?=
X-Microsoft-Antispam-Message-Info: uMEXC+N625HU4IgUP5f/TzTY6/APs1j5C6meu2XWly/IO49+wgFOuT4zLGx3AHwJKPuvzmicKvNli+OAs2uvq+PdMrIsE9QJKsri/UlUM413kn2H8Hb6ujc7uYTAiJLzXkTVcGR1o9ck2GAI9oNcM2EHF4qxCRXEUD3N89qes2xpgXYIkR4OvGz9i0N4u0UQ5r0iussNpJ31fwbW6bClJxq4BKKZJq9duF6BRBhKdyc=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;6:GUmSuQR1MxIBGGpzxVZLvhsjiLmi1GJsavkuXNpin5oeNTD0HH8gCB8Jq6LOjgT1/TiwBKqTLh3rXXwyh3ITqwlw5vVwavx/xAnPcmVlp+fxsbP6lkFlxvG4Sl5tK4GjL8rzoeXdGIsj9fEmcUmQg0McB4CSN2HnuL7Hs6xV2CdOtdsL6wt7A17MjdjpHi3j07lTFR4bWnyycCqSOn7hhxdShgiDJsIzPiEVNeG5pRFx2wO4PWj+0A18qnIvcHYwXRBQabLh9IBc+LjjffZqxbVm2bQ8t8cRDLF7t4CDIFDLD7l5Ni8mVodqfPAu3bV3VTjbzNdU2Z0EhDrq3TKjk2hPDBvque3xBONibGmCUaM=;5:T2BZfAYD+1md7iFQmEoFsGk/tt2wQcvhSUgG+exBXWJHAnr70d6BezKpEeink5PkGiED3vRYs15ctMkOpU5whTUzjl3sm21jC7opfW5pAOrilrn2xtOSfY1oaebBT7oYGP5hRymCYz/tgpEY030LQqgZ75X8/UJCOslMs0CN4oY=;24:mXX32AwrjZZzI7pru63+fA5Etlu607+xTgo/d17mzCPYzhOlEVPMjidTKAHWtDbV6gb5JlmEbEGdcAKo52j3LBI7Oi212PTF8kyldRtT4Ho=;7:0sgVv8JeyaBgeo4Ojm+KwGCB7enPGnjv6ZsaqYO3wDY6gm6CIwqC5/qRnsdP0tPieBZGbqVad1D7VaNek/Z+7PrqsAkjm76VkFxHb1oGZzz6lJnUh1zCCedTWL4F37fFPNT/1p+b7CcOs1W1itZ6XVHPQm6LvRNQMpiFRlsVQFD3wjt3tCDrvAXVRaglK1kZhMmojMhvaLjUK/qKlSIf1qZ/sXLhPOkOupkaFDjnE7WAw1jYA/h35d4SjT9eqkHq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 13:53:34.9944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2da8f2f-5efa-4ba3-2b43-08d588e9d0f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1319
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
 arch/arm/kernel/module-plts.c | 47 +++++++++++++++++++++++++++++---
 4 files changed, 100 insertions(+), 13 deletions(-)

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
index f272711..0951270 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sort.h>
@@ -22,18 +23,54 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
+static const u32 fixed_plts[] = {
+#ifdef CONFIG_FUNCTION_TRACER
+	FTRACE_ADDR,
+	MCOUNT_ADDR,
+#ifdef CONFIG_OLD_MCOUNT
+	(unsigned long)ftrace_caller_old,
+	(unsigned long)mcount,
+#endif
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
+	if (!ARRAY_SIZE(fixed_plts))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(plt->ldr); ++i)
+		plt->ldr[i] = PLT_ENT_LDR;
+	memcpy(plt->lit, fixed_plts, sizeof(fixed_plts));
+	pltsec->plt_count = ARRAY_SIZE(fixed_plts);
+}
+
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 {
 	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
 							  &mod->arch.init;
+	struct plt_entries *plt;
+	int idx;
 
-	struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
-	int idx = 0;
+	/* cache the address, ELF header is available only during module load */
+	if (!pltsec->plt_ent)
+		pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
+	plt = pltsec->plt_ent;
+
+	if (!pltsec->plt_count)
+		prealloc_fixed(pltsec, plt);
+
+	idx = ARRAY_SIZE(fixed_plts);
+	while (idx)
+		if (plt->lit[--idx] == val)
+			return (u32)&plt->ldr[idx];
 
 	/*
 	 * Look for an existing entry pointing to 'val'. Given that the
@@ -182,8 +219,8 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned long core_plts = 0;
-	unsigned long init_plts = 0;
+	unsigned long core_plts = ARRAY_SIZE(fixed_plts);
+	unsigned long init_plts = ARRAY_SIZE(fixed_plts);
 	Elf32_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
 	Elf32_Sym *syms = NULL;
 
@@ -238,6 +275,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.core.plt->sh_size = round_up(core_plts * PLT_ENT_SIZE,
 					       sizeof(struct plt_entries));
 	mod->arch.core.plt_count = 0;
+	mod->arch.core.plt_ent = NULL;
 
 	mod->arch.init.plt->sh_type = SHT_NOBITS;
 	mod->arch.init.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
@@ -245,6 +283,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.init.plt->sh_size = round_up(init_plts * PLT_ENT_SIZE,
 					       sizeof(struct plt_entries));
 	mod->arch.init.plt_count = 0;
+	mod->arch.init.plt_ent = NULL;
 
 	pr_debug("%s: plt=%x, init.plt=%x\n", __func__,
 		 mod->arch.core.plt->sh_size, mod->arch.init.plt->sh_size);
-- 
2.4.6

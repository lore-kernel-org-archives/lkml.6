Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756067AbeDFOk3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:40:29 -0400
Received: from mail-he1eur01on0101.outbound.protection.outlook.com ([104.47.0.101]:24654
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756017AbeDFOkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:40:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 2/3] ARM: ftrace/recordmcount: filter relocation types
Date: Fri,  6 Apr 2018 16:39:38 +0200
Message-Id: <20180406143939.14642-3-alexander.sverdlin@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee17ace9-1ada-4c7a-4549-08d59bcc5358
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:HE1PR0701MB2473;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;3:aMtHzKOBKx83+YdvHzzDuMN4er5rQ5Uer2pIDA4w0r9bhAqebGrP7q6IQZ8W/NvKIeVeAc0hJkz6iAsEnexrgY7mF3a65RqryISH+TR/C5fo47d8/Y7PUIALDIFM4hOCGwceI2xQoAUzpxGSekkEcKzlwdcuqOOWEnfe5WEh9ptMgOxqDTKIZ3KvwPdTkM0TWCIcXuH3IwdASDLsNsCx3xEiNJVKM5jgVj7j0lZktSZtkEyIlhI6R+4UCOl8gf0O;25:8zWrW4bYWAh+Dmb65e4l8XMfhe47LVpMe0rdcJY2s4KzVKjz7gJqNkNwqZRQb50bS9vR+pKfXqFGB7FBNAvFiQFvWPnZQ1/PJbLVck3ZKGRS6ZiyxI9/9i4M9HsRfYKLddjDFz1dP+SFHfN3ciWIowbdZIUBeFk9jQn47pmnH2g3iDk+AmA+R7EheWMPYZy1yNPKX0DPM6UwOB7DtgmnXMPxgpbou+9IpBxvmsZ3Wu3fsBwuJWIK3/cZ8DEZt6Ujs8MBkujtEqiZNE4/YOeNyYVWdNGZ99scqo9uPQPrzU1PxDz8eh9RhBDq9PXXMXLJDt8JQaGRkmWAxZQz1pEFsw==;31:wcFomZAuCSH8YzQ1VbYUsM38NOAuEawiURzPI+Qe+zdn9sCrSEah7pdDa0YO7c6va7QQTPX3zEu9KuwqJuEJzn9KYIUZe85r+tTCI5iaN+U6lc0vp0fIgPldq5Q2hJufOHBTGgNXc44YuedJlc8IRsSUNfCz0Svdx4aiDKyQ8i3gnDODy0mORyXbIynO5EdfG+S5d5JIVXlWzXqu8d0vi7mu8nHp//AiRNVaf7QDeK0=
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2473:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;20:wspj8tS3vpjkZ4xRJdZqlZsi5ENNzaSJF1KdFB0pzZ/XG45rgdSUf4nJNGERgLrxLDqy0hlINn/moXbtV7MSk5Enkk5/LxkTKPMYSUMwL2F/H5BapbOYObSmzlRfop/FVyYt6iMCPLwGB+bqqTfIDFIh14KQW5tvO4Swf5BVvu8/44mlnUkK4DS+kt09YHqggjeeUjngJU/YQpO3uuiNDu6MSYWyioKZK8oUYwD1YZALAK+V5XBWrBClEGH4SyqCgyFSyHldWiqnxBxBKRw/zxsvA0DY9CEWGcFdfgYr8gj88ZcIdjIItPzpAVSGyleKsjneOBacNwtSGb4w1ieJNclnuMm3zGk4eGG6bVGv0mYQnSYLNAIEL5sNNRWNwPpK/AUoucLyRx/sN9e9eZMrJCEio/zKE1Z+HpoAYOPIoM8Z2uxcA/IuxlaCAqz5VQjsOGv63Kyl4w4dYdEbQSW0Y3QIU+ZzcvQvRtHkEma8KwwapNyTHbCA34TI9uGvo5t/Z2yBoGK5bIZF6zIJxvIoExvcB1g/AVwJJ+fzOJe0b0qgY+P+tXrpCZCWxLULOiwdziNJiu7XI4JtpkWzAv53g6AOnF0qYMjokoD5PQTOId4=;4:EOAPGoyyI1whl709H6edmV4NsT2OnyDcv+CpwqSWE5uNAVIXk+oiMsomV2GGCnN+cmtd5Fl0SnUPO5wJUu5tSfqHoHSMRo3LqtfPPnbDWr+Mv8jS12oqxQ7NiJWbeIqOKMLBOs0AhAbR6CkmJ8AfT3W+9S7fCdo0dh2kyfeq5Yp3Eg0674QYTU//tdWZF+bIrX2pgHo00Hrvy+urNhCQ3mc9g5/+wBBlfsS1gqzDof3mLGN55ts47FboMhSM/404cdxAmIWYVLDnQ8WQcm4Tk9TZSTFkOUuQGerN22odddRGG50VdoUH+ZuNwIinpH7n
X-Microsoft-Antispam-PRVS: <HE1PR0701MB24732816EC2346B540E7522988BA0@HE1PR0701MB2473.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(11241501184)(806099)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0701MB2473;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2473;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(376002)(39380400002)(189003)(199004)(25786009)(446003)(4326008)(11346002)(956004)(97736004)(2616005)(476003)(26005)(186003)(16526019)(6666003)(47776003)(6916009)(2361001)(66066001)(7736002)(305945005)(5660300001)(486006)(8936002)(50226002)(81166006)(53936002)(3846002)(6116002)(8676002)(81156014)(106356001)(6512007)(6306002)(105586002)(16586007)(316002)(6486002)(52116002)(51416003)(76176011)(2906002)(36756003)(966005)(68736007)(1076002)(86362001)(54906003)(2351001)(48376002)(6506007)(50466002)(386003)(478600001)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2473;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0701MB2473;23:SE2bNFRO27WXWYrjWVxIlC3Gpe38ElSVnuuy3JN?=
 =?us-ascii?Q?XCxFUXsLQMB82pNcxTWA1O6tywRUAjB7swO7vTnlvkyRFXLh2IKoIwiUm+wL?=
 =?us-ascii?Q?S5o4BMVVy80lF0cX7d2mo5hoVdv7PvHa8At6KL8EVcQgYESFPo6nTiiMexDA?=
 =?us-ascii?Q?kBOpCBVpeaxDG9alYItatzZQdPNYdDkFdiTM9TpnluB4pMzbzeVnNPASlVAr?=
 =?us-ascii?Q?UtX4POKUxmLVY0D3Qc8D2IliVg/MtNvvMNaXRhU2AUIQbMgrno2tclRxxjTI?=
 =?us-ascii?Q?2tfCrlCEP5xtPh2OnC0OA1oEKjgzGN1OTDP3AfP2a16WW3m9czKb7YrGKNFZ?=
 =?us-ascii?Q?/0kXFCfqit8ntqbj4fHVj/BGL2nI3U28WZiEuVbesiEGtwivYkxAdcktvNJY?=
 =?us-ascii?Q?cYjpedkUhV6grUVOrB3RyiME2ywCt8dTfE5SVb25F+Inc3ZGJLnFDZ/XMlby?=
 =?us-ascii?Q?2LQkPR/+4ZGbIpaKbSlRlQPUd9k92pdQ9AYgDbKUheVAZrrKLyesnQK7bL8t?=
 =?us-ascii?Q?PMxEfubxAX/6n/sgb7rSlCK0OtqFij1Os24DZr+sxxU80qB0YDvd2GmuSLDB?=
 =?us-ascii?Q?xMBdt6IAd41cyIC2rhWo9UZFlbpIppOvY2T5IIIw9oJyAgYpvpcfNxa1enJ+?=
 =?us-ascii?Q?OZiHvSmpkm4BZJmX1op0j+FnL5kSssuxxCOlSB0yUrzaPC2tIq2cwTr31Cop?=
 =?us-ascii?Q?d5sTefoxx6q34RQR9hU0J0V3JOv/blj8kt7xvHEbJDZ+9jMsF1dJqA0L6t/I?=
 =?us-ascii?Q?jk/EAuiLkbSSSep1ScjQaFC5i02BDCFuixQb0CWBAysrZ/bM2YkKIS+J/7KU?=
 =?us-ascii?Q?MGIxBQlazhcSfszHgl3REwhW6Gv63EY0vqpqhP8vgFKFQzjjHqk7D680AU5L?=
 =?us-ascii?Q?BmQZJ/dL7SWl8xYqX7sCHbWqAQ5xohIWaDzsI7Bn8uzOqUVSrOe5PZJGcxo2?=
 =?us-ascii?Q?SXyzZWwLJR+a/UxyHFy5LaFMxTMySA+H7JnWhCZdgz2S6T9m63JMFyieYs+n?=
 =?us-ascii?Q?Kk/5V5np0SB9rNhoPPcQnn7yzNblLYqhzy483Hcq9MxeDclvyRoLavXadgu3?=
 =?us-ascii?Q?SPM3qmvwhiNjDh4S0qvvIR0rMrgYH0suob2Lr9qIOfJmWChV+gMHRVbhn77R?=
 =?us-ascii?Q?SupRcTY4rSdH8plrfJqXAonhtGZuPCJqXhP2w2e+DKt5FHtLztJ52o5kOWcE?=
 =?us-ascii?Q?KNVF5ebSG00vojpu5BzIbGfojbt++bshUohmJ3aWQaoK7xPfehcg/bJQJxF/?=
 =?us-ascii?Q?cp1JGmIqVhLAMmOKLyhL3BWvVGJaMnF4bi9KfPCuruzuVRZt8xnSmZsSTz36?=
 =?us-ascii?Q?LCbpIUMZeycJZlEWhsrqteN0=3D?=
X-Microsoft-Antispam-Message-Info: 6rfYGZHa2yf+BkgekxN+rRIWnqFR71wqkKe78t2GfSu9V5LuE9KFr7h3vJ2eqeYo6fLYtl0bMrN9lax6n7xwX01CIzCC1j15WlWcI3Lp/2ZFtaMTZGgTzJaGXJcfUafn+uyCOWcDKkTxjy024sBHmf7UL2ebVgBBOFi9HqnDEinQG8MrLziOWFMghIvQKmlb5S8NoRCm5Y00zmOiQy6VV/R21PCtfnNhiw+bHvtCXcY=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;6:omRyfaPh3qA+A6Us/o82aEgJvx9TEkv7VMclTKzrhFEARvqSOmovQ4NVU8YrsfoRkmfsQmrHJ94pdFv6ymuOVmEjrz23xDpxyCO7aBi6aOmsU7nItCTZY/ZmkIiTChy89VRot7/Pp7HNQucGBkB7Zrdr7S2ZuYSdgRO45egc0hI4qI+sf64QVY3RUnKmiTvFwMOF4f4I9i50ftM9711jfGV32qLIZPqQ+5Avyp6MzzdNpaZbt1FH55uF2GHXdYHurTrp/exIuTlTaRk3C5R/t+cXyLdLsr2zta9qfsZXC12QSZi06qBwZPFS5aA3rhWiJ7NRIv8i1l+57MaSvHoNWfPNhXiZdfCr7LPVaD8WP/x/08EcafWXxgV3m0r9HFoBg3svz4vQdi3GZPA6O2EiFNBiLzM0stAICElJmChMo1JM+DOF6/fAnvylcoEK+pShU6vDhWaZNXtwABuGiMBCiQ==;5:86MYbDw3LPqvbKugYScanHiG58GT2Pwz36Iuq81xpQPXmslcGyT0ODimIAa+MMuL1vSa7nPXYE1y6ZRoj1pxNuCjk57ahx0fULAYGCG+GVJ2bT4t4NgGPzBkm1HCnsMlFIMyrbT+gqtmh5AKvTaos90qTTxRlCjAQWBIBgF7ctk=;24:JDVBb9PsNzpRc2UTs2YcssQDZIfZ/fyR2so0YkRB5uwtmAXr8vW6nMLNEggfoLf6TD1VGZMwg3RTTCe+421lrJ3cuNmy8fYA2+ILwsnScSQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;7:P9/Pw4uBBAD3M1K/F0Cq2b7R0DRE56IoS5Oxxgb4cw1KnI2gDcGerG80dKiQjbsp5aEdWNNcG63/AdvzepXMXpGJbXsKxO8PNaIVlmAJm5D84cLTdQ6/d5DSBeO2Bhlt66EeA78Oh8dDOi/oMJ3N8gEK3EF11ZvToGpefoDKmNAT9L5yRwJY5VUSM51XOPdbRBxOqMWQXdPcMCCl8OoTCtGN4/nIRE2rtVbtBR0OwaUlvy8SXgR8BHIF85Hyoyxg
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 14:40:18.4594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee17ace9-1ada-4c7a-4549-08d59bcc5358
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2473
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If code in arch/arm/kernel/ftrace.c would operate on mcount() pointer the
following may be generated:

00000230 <prealloc_fixed_plts>:
 230:   b5f8            push    {r3, r4, r5, r6, r7, lr}
 232:   b500            push    {lr}
 234:   f7ff fffe       bl      0 <__gnu_mcount_nc>
                        234: R_ARM_THM_CALL     __gnu_mcount_nc
 238:   f240 0600       movw    r6, #0
                        238: R_ARM_THM_MOVW_ABS_NC      __gnu_mcount_nc
 23c:   f8d0 1180       ldr.w   r1, [r0, #384]  ; 0x180

FTRACE currently is not able to deal with it:

WARNING: CPU: 0 PID: 0 at .../kernel/trace/ftrace.c:1979 ftrace_bug+0x1ad/0x230()
...
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.116-... #1
...
[<c0314e3d>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
[<c03115e9>] (show_stack) from [<c051a7f1>] (dump_stack+0x81/0xa8)
[<c051a7f1>] (dump_stack) from [<c0321c5d>] (warn_slowpath_common+0x69/0x90)
[<c0321c5d>] (warn_slowpath_common) from [<c0321cf3>] (warn_slowpath_null+0x17/0x1c)
[<c0321cf3>] (warn_slowpath_null) from [<c038ee9d>] (ftrace_bug+0x1ad/0x230)
[<c038ee9d>] (ftrace_bug) from [<c038f1f9>] (ftrace_process_locs+0x27d/0x444)
[<c038f1f9>] (ftrace_process_locs) from [<c08915bd>] (ftrace_init+0x91/0xe8)
[<c08915bd>] (ftrace_init) from [<c0885a67>] (start_kernel+0x34b/0x358)
[<c0885a67>] (start_kernel) from [<00308095>] (0x308095)
---[ end trace cb88537fdc8fa200 ]---
ftrace failed to modify [<c031266c>] prealloc_fixed_plts+0x8/0x60
 actual: 44:f2:e1:36
ftrace record flags: 0
 (0)   expected tramp: c03143e9

Fix this by allowing only selected reloc types in __mcount_loc.
The list itself comes from the legacy recordmcount.pl script.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 scripts/recordmcount.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 16e086d..a4888e9 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -53,6 +53,10 @@
 #define R_AARCH64_ABS64	257
 #endif
 
+#define R_ARM_PC24		1
+#define R_ARM_THM_CALL		10
+#define R_ARM_CALL		28
+
 static int fd_map;	/* File descriptor for file being modified. */
 static int mmap_failed; /* Boolean flag. */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
@@ -428,6 +432,18 @@ is_mcounted_section_name(char const *const txtname)
 #define RECORD_MCOUNT_64
 #include "recordmcount.h"
 
+static int arm_is_fake_mcount(Elf32_Rel const *rp)
+{
+	switch (ELF32_R_TYPE(w(rp->r_info))) {
+	case R_ARM_THM_CALL:
+	case R_ARM_CALL:
+	case R_ARM_PC24:
+		return 0;
+	}
+
+	return 1;
+}
+
 /* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
  * http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-001.pdf
  * We interpret Table 29 Relocation Operation (Elf64_Rel, Elf64_Rela) [p.40]
@@ -529,6 +545,7 @@ do_file(char const *const fname)
 			 altmcount = "__gnu_mcount_nc";
 			 make_nop = make_nop_arm;
 			 rel_type_nop = R_ARM_NONE;
+			 is_fake_mcount32 = arm_is_fake_mcount;
 			 break;
 	case EM_AARCH64:
 			reltype = R_AARCH64_ABS64;
-- 
2.4.6

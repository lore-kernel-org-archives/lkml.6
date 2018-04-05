Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeDERS6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:18:58 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:64462
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751571AbeDERSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:18:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Klimov <klimov.linux@gmail.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: entry: introduce restore_syscall_args macro
Date: Thu,  5 Apr 2018 20:17:57 +0300
Message-Id: <20180405171800.5648-3-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180405171800.5648-1-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DB6P190CA0020.EURP190.PROD.OUTLOOK.COM (10.175.240.33) To
 BN6PR07MB2898.namprd07.prod.outlook.com (10.173.28.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d2d6b56-9d18-49a7-6ead-08d59b194ede
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2898;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;3:PI8ofFvHyyxqpbMAuCXSI1mN6dF7mA12/40NOt6LcbCM8tZ1WB/rBqlpAz/pPuGOFntTRvuVACi1HjH8a+v6hYhiqVEdD+tjoKILgRgxEBkTNIbIx1XhN05ZKpn+wir2ggJLPK5q5K435WeSLcv4rhDZZ6AMaain0E4M2iNIowiOMA0sZjm5OFj81CiwK1V3s3sk0nqUFcz7MBAsBS+s/ZPBn6dPoe8YIIgicdoiqFKAXde7rNnDuKnVAyYXrCMa;25:R9mcPYIBQPar2BVFKew6rCBD5Pb60zycVj9psIc8P+UNJWeumWs27nN3UCbfgnTnyCfBdJim5ueYPyjQrdHH79H5fEMKILh3CirBOltKu/NUsmfZUHw4U1a0088g26v49tPnMJfLPKPxSUqqDBA6d8bGeieiOyoCgoio69y8SPQXWJ6NM+N7tFuJ/HV+2ukxl20hXHypkmsEH2wxi89xul1X3/igIULiBt6se5efQBpPgp3Yyn9ogdPOAPPdo4gYdDUEJ2kiP0Gn6Kjx4+2x5gHGjcUunF2fmt4ckfRXwQmGIfw+WOQJr8bPPW2PRcUGEzobUhI57LuwDX5KJmQmLQ==;31:1kop6B3b84nSvK5ngNji9b2+3V/8EPCTPPeHU9ovjUwcy8e9sM+HB7c5WgLmVZncjETCGgDqdKtr0Dn5WBxJbdMIs2t/Zenb081bolc0l4QzM+nbX6srQWzWlrutBcuXR0sg2LUepCgfRQYS5C2fjyzLeGrfNPpFK2U4UXhXQXdFFTY/klqJc6OQPXjGOzy/bQvbB4WM0U15lMXA4x95yvSbyYLXqsdkQFfalGYduL0=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2898:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;20:+IS+aOt5YST/qCh5dFl2b7KO5sK4SsSKZoW0v+d3pLEuHhCwfYFi3G18kiqmTUlZmtBqCT7jh+4cZ3EGkLfOv3McSiTVJi2BHk4rFMgGVmxJ+ZyFmTgBVLx4AVDjIGC6tBZEOGZSRhWmW8AK+PtufyrwhduNdK5w01kW/B8HpjR36xadDJegibXqfTO8JbkH+PagGucuwTyg/4zPJ3w7aFRGQ6xJcByjYw5Xw+DGm5qW545K3cgo6pW8KcePzL049AuCR+1v2NaswUGNBnrtyn2wsa0Ze3XF5p095+hlwKnCVPzsQXoqTIEk2Imk2T3/TdPMi41H7/px50PQdF26Geu6Oy6VNfbBh7Lv332g2x7bBZHO2FbBgcU8uyUpRJQubOBPIPeMT8eQyXMWGQu4kthz3rvBZ7+ujZJjQMsjdVRQrit9Rq/pN770u/SaJbrRsD13HQfoNkZnF8Efx5IE1DxM9/FmUkiyYSvVjA3Q+l7qJyTLjigBYiSMTm/o5VE8JIU+OPE2Ax1G9Gatm514wGDF1f7wy/Pa7ICJ63cul10NA5qTde8kz28lUc188MinURtIt+fYRUPphmgj+6EWzxKdBM//P5mq5qYsF1QnZGc=;4:4cZu3oF36867wi0geODIMRqbMJ/IKj6FYW4ejU8vlcUp0fnn9kVT+SK2lVgYufwH1+o5XT5h39KhD3CVgDrZITB2XWVFMEVYctV/SeOkWqVJPobAINvp1fSGkbpX+wFYtYiVuK89KfQBrUNkFD3RmgJEOZE2EGMbNpaqULFy4zWI8J1KS9qA6JHhbujLsH+YMTthLwDAcwkNvLXven9bz1i58g/OSEVmjPDwQBRhjNoUdS5dP9mgAwo/HmGgcde/IqkGb/d9o25tGHMGmKDVkA==
X-Microsoft-Antispam-PRVS: <BN6PR07MB2898CF3FC0B89CE40AE2FE9CE3BB0@BN6PR07MB2898.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR07MB2898;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2898;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(7736002)(386003)(478600001)(51416003)(2906002)(16586007)(6116002)(50466002)(3846002)(50226002)(59450400001)(5660300001)(316002)(52116002)(305945005)(486006)(11346002)(76176011)(8936002)(446003)(48376002)(476003)(7416002)(956004)(6496006)(6486002)(2616005)(81166006)(110136005)(81156014)(68736007)(42882007)(4326008)(97736004)(53936002)(25786009)(76506005)(105586002)(36756003)(26005)(8676002)(1076002)(72206003)(47776003)(66066001)(106356001)(16526019)(186003)(39060400002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2898;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2898;23:W0S6/5n3t2p11vrCT4ROWaPUjhG+BByLqYRrstRZ/?=
 =?us-ascii?Q?9JrArH5wN+iVbcHRh+Qa91kRiRkJWXhSD5COElC/fdS5OmY+s1kJMnTCBn49?=
 =?us-ascii?Q?omqyEsrjVi9lFAqy3ZN2EkzQ7n+hlrBsY76FLyA5NvXNJJg/LWlZmYfbukEs?=
 =?us-ascii?Q?maFsEatwaTbk50GN/NSlPF5CWl6GaGU0D1i9v+bEC1+04LJqm7ksrT3/2GE1?=
 =?us-ascii?Q?iGwZ62CaMHbZUdaElDJC+mxixQ5lBEpbAHR4uSDlSX7mMJdpwPo2Ii4vVqvT?=
 =?us-ascii?Q?G7wPyMyDVfpUtq8/FHk9E4YZjwFtFD4nRii4qwZn3NNi2M3sQHWPcvnSP8Ib?=
 =?us-ascii?Q?pvKmW565t3Z/94Le4qCCyivX319lYvq8bg29HsQLXsTpwKfGMimeqVlaCPzg?=
 =?us-ascii?Q?zNlhYkYx5W3BEsAyAWsuNGlccwkVNlLSnaMh8JGK9oaYk9QXlQ8PdihGGSJl?=
 =?us-ascii?Q?VgXpMt9AjopqaL7RGUVCaGM3PejoR0rhn6TQlOFjqXXQorm1NDNM8qdy6i0x?=
 =?us-ascii?Q?Xuxcdzmwu2xqnm+27tZYAn7VHkCS6InRV84QGTqe82hoXpz0DTLFhYAvEslz?=
 =?us-ascii?Q?bCDMb3qxid/3+Mk9RfxV8DAlhuy0kYUMqmbSSbaCep2gNacz/FGM0CIFoGJ2?=
 =?us-ascii?Q?RYbQJ6Bsbnz6jys6v48TizHptm6OX6YJ2THXvRf4N4yTfyII50eVNx5mVgPi?=
 =?us-ascii?Q?+Nevd4XnWRw5ZOxdra2/lZwNDjizAnGOxtKeGrsd+RAD9cLBMMLkktdcF03d?=
 =?us-ascii?Q?TVzFPa2/cSNN5HXgU+QrUTIN4hHzgkz9afQQ8/u/bD5JzQIEm0E1EHysVFtW?=
 =?us-ascii?Q?+1bp5FcpwDdTQ5odilWqiXSktBaDUTlWPQqWOnDsVQuFNmc0LJwXMUAH6OXF?=
 =?us-ascii?Q?K7apf/QnXsGB5JvQQg8SXuGBSZ1/0mmtAbXZuozXNkstn8sN882CB92u7tm7?=
 =?us-ascii?Q?WbSGjCHSzKfc3qUlnqw8wpL3mDtqX3HorJ44+rqD/S2stBquWu//Si/tnXYY?=
 =?us-ascii?Q?Mt53taMo/WdprzIW+IekYTGVvnkvv/23xpLVCXhaAVQp9KZFJn5j2Axq2DeX?=
 =?us-ascii?Q?r0EoOtW4RDv2ChUnfqnMED6/CFcysleOFhRz1ISg/mD3SpQKzkBAeUXHOkrr?=
 =?us-ascii?Q?maVlVDEN0WDMk2fzaqlBwziEjuinmUwcQZ7ql0lNxiZ2cXgmWoJCC9bfUlPj?=
 =?us-ascii?Q?FkqpZmp+HfaXEGZSKVOXhUXef+rcUJGrhzE8iMeisLgJqEGiEz2VwJdeUJ/6?=
 =?us-ascii?Q?mjd/x2spTiWZgMtZiR0UG/N1ua+algoxNK5Y+8CaM+y7r1EPMBJazZEOxgHD?=
 =?us-ascii?Q?cQlCOIgMDkjGfBK/VL7QKrZltmyiIijwNKqWfjJVY7R?=
X-Microsoft-Antispam-Message-Info: zCqvs85Wcfzv98omHQQoJrerx26/bEYM15lBICmDmoZuhfW7d8/AIT+fJtnO4hgNGCIiz7nnLxWDfMWhIRLWX8SewQ2dQ7unOItcQiTMPw8cylNDsjIxYuTg3UjuMAc0oNzHfe0I558b7qrzObs77vFj9fA14I31MaA66Kfpcguo+RPAlfsi2VGDtvXYWBQP
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;6:tObRly6CqlDXD/kPRdtzNK7+SrlT6O44v4rMbQ4eduaAU/6zwSVq/bI+Z1DccyXLZmXtjToE4vaIeiYnE478qx3XRCP1KSMo6PJlKE36cXM83hjz6yVJx+WZw0joUyMCFs3g59+ym3fp2PJULX26cbIRDjJtsrip77fFNL6XSKos7RNt9hf3RkeIWMA6VuA/p0Zsn9KyI7YMmoZDJaO8ZEWS/01f+1yVzgNABRg3dt5AEWtwtfuesAyexEAd86v8NE/Eq9Gu6dopxMFGfFID1cAKqTpw9Glq0Bq3j0JOydEmZiCfD5R9SHj/OF7LNgwANDi12iq23HrlX9aOfG6baXZc9nIFJharU5XS6uWdTrfqGSuMhxT8p/kuyRS6XOb4rIJxZPR8rYvsN0SBH14UfqUom26Ybz4l3E5jyaOm345c/vANzo8svl4Tb0i69LdLcISc16XY9xISLB9X1umksg==;5:dU6NCphcOzlkWRI7CIBU94ATDV6kD3xjZgx5nBWvYZf/s07OKk1n5PbKtkjHZTqVzj+tziD7sYtcb3SOpDepy6i96MzF9aJY+ZslPBAUpadQhODUOi30yrr+UjAq7YqH02tL2/pOzpe6csIvSI62MnuC44Nvv0XQgGBre1Bu4+E=;24:ZU5ew1XA+lqZ9DqqOgC81gDojOV6VrnSOtetNbkc+GDvyQfwz1Hj6SGBZCbqCwYTTO45n46XR0qdNgXEknG6v482JxNMrg/5gsQgLh2XBjI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;7:LviE19Np27kyPGwHwo8n4mJoH70Xw4ewQJZDnFR6SpNH3BCxeRhFnHm8Qa0+iwwTSBSN4x2rX08CsHcbIT0zGvdYj63idUB6h2J44A2IQ1dNwKdL/zHU4FYzmk0aOXGgbF/R1JTX7KIYOoW9RMloAzB/l057diiumk0PrvwFP9aHsM4r/40zhL02Tu/f5Px6r9da+vY7BL4XPIInE3zcyV80iwJTPLN4ANB6mtcVVOGCQgBg71OifEmKs52ER9Wz
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 17:18:52.8488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2d6b56-9d18-49a7-6ead-08d59b194ede
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2898
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syscall arguments are passed in registers x0..x7. If assembler
code has to call C functions before passing control to syscall
handler, it should restore original state of that registers
after the call.

Currently, syscall arguments restoring is opencoded in el0_svc_naked
and __sys_trace. This patch introduces restore_syscall_args macro to
use it there.

Also, parameter 'syscall = 0' is removed from ct_user_exit to make
el0_svc_naked call restore_syscall_args explicitly. This is needed
because the following patch of the series adds another call to C
function in el0_svc_naked, and restoring of syscall args becomes not
only a matter of ct_user_exit.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/entry.S | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 9c06b4b80060..c8d9ec363ddd 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -37,22 +37,29 @@
 #include <asm/unistd.h>
 
 /*
- * Context tracking subsystem.  Used to instrument transitions
- * between user and kernel mode.
+ * Save/restore needed during syscalls.  Restore syscall arguments from
+ * the values already saved on stack during kernel_entry.
  */
-	.macro ct_user_exit, syscall = 0
-#ifdef CONFIG_CONTEXT_TRACKING
-	bl	context_tracking_user_exit
-	.if \syscall == 1
-	/*
-	 * Save/restore needed during syscalls.  Restore syscall arguments from
-	 * the values already saved on stack during kernel_entry.
-	 */
+	.macro restore_syscall_args
 	ldp	x0, x1, [sp]
 	ldp	x2, x3, [sp, #S_X2]
 	ldp	x4, x5, [sp, #S_X4]
 	ldp	x6, x7, [sp, #S_X6]
-	.endif
+	.endm
+
+	.macro el0_svc_restore_syscall_args
+#if defined(CONFIG_CONTEXT_TRACKING)
+	restore_syscall_args
+#endif
+	.endm
+
+/*
+ * Context tracking subsystem.  Used to instrument transitions
+ * between user and kernel mode.
+ */
+	.macro ct_user_exit
+#ifdef CONFIG_CONTEXT_TRACKING
+	bl	context_tracking_user_exit
 #endif
 	.endm
 
@@ -943,7 +950,8 @@ alternative_else_nop_endif
 el0_svc_naked:					// compat entry point
 	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_daif
-	ct_user_exit 1
+	ct_user_exit
+	el0_svc_restore_syscall_args
 
 	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
 	b.ne	__sys_trace
@@ -976,10 +984,7 @@ __sys_trace:
 	mov	x1, sp				// pointer to regs
 	cmp	wscno, wsc_nr			// check upper syscall limit
 	b.hs	__ni_sys_trace
-	ldp	x0, x1, [sp]			// restore the syscall args
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
+	restore_syscall_args
 	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 
-- 
2.14.1

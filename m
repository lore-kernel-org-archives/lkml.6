Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDERTP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:19:15 -0400
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:35424
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751807AbeDERTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:19:12 -0400
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
Subject: [PATCH 3/5] arm64: early ISB at exit from extended quiescent state
Date: Thu,  5 Apr 2018 20:17:58 +0300
Message-Id: <20180405171800.5648-4-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180405171800.5648-1-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DB6P190CA0023.EURP190.PROD.OUTLOOK.COM (10.175.240.36) To
 BN6PR07MB2900.namprd07.prod.outlook.com (10.173.28.146)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d291463-4721-4742-9652-08d59b195715
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2900;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;3:veM/WOD1D4bdKT+lpqIQWJPdcb2mOjO0m18KNq/4Z9eXQ9NOI60K1jqpUg21hF5RCd7OuHgv+6LxWERczWXYj9bNKwh5A2AO5gGZOXzk3OK7ChzLtRYMO8NEpTPrlvoQ/1d1x7VfepzNALK/JiIh7VF/iyUap4mIKEleDaSGCoM97V4PtPCAJVCwD8x17/ruIncO7YP2WmArf1oWvKiZAgORRj0kjJcCgoVjype/jCuX4sKGxRO2rLXVF0cQvdjc;25:cbaXrNKpplzidXfnqZv14s/C6CbYMwYqM8QqyhAVODQzQdM7m5LIcgg168pMNwqXBcEemPJgtBiafSm0zM61gVTXZe6IXM02vz39IxnBFKqIw1R4Wh8ZlJ2lreicaqCKiXXxd1b5kId14LWZ3DtzTRx1c8l8PAwe8kcq+uLQKnGqp4fyfXM/iHawFE6Df4o/bahiPw74A9thrlTvOzaUVKz55GG8pG8mHVtaKibmP1hb5Xa6b67PRqMEYI7DkYMGszivyu6X1lef6DnYHdTr7pzWu7ksauiDqQpyxAevzOFXH0HsW7SRFTPB2xHXQtnsHYEzdyfcRN9lqMQrJM38Sw==;31:3rWyqhSO2uAfJ8AS4WRIT7xvCTAuUv8mQu/mhQGOK00wNLQPjY4epKCyXBUN47Yv7/pB42DSVZ3RHv39f2yxfvp/Eckv16d0DxbKzQepMyzlQ1X4cehIxcRS0GUNHyWyoCi7nmT6lGhwoqm9RUIAX7mwaklx1RkVs+bgbEn9dYETtLUUGRjFGzYVB/pciWfvvIJH2SAAuIbL7l/Xq9/oiWbmaeKk2upUMBOeCrXcqVo=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2900:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;20:br48vpiaQdD3m4G+Rzq0MoLHr1rG9WJp1xqk1w9THGTO0aHSc7Ka0rmkwb5ixk+wGBuIkDyp0y6zo4no7Mmj5tnwp6ODGeKaI2WHz4yDN+RkQN8tu2Z4lIC+MQdZiyC95DJxYJb6Ye6aisYsPvShBaOkuHqurLLwuwNAHnlAFkmVAF5mvz0v7pgEitkkw7qaJ8qME/kNcNyJ5wPXflZC7VyvoKF9DdT2ZdcirhBPSiZ+9xMFu0BrqaBs7QXPbeEhMxjOWMlFtaLqHMqasBDCRoX1cSV0K795VkqT4uAUE3OH/HdB2yTXXpxUdKJWK8Gmx5y77Kzf0u6xBGqgfq1eT67Shs9qNNxpkDGjXW1W6OGV5yjxh0mH8enYmHGVdNXjOZg3BwdNLQE1oCn/BlOi649sdNsI5yRyZLVkGmAf7CDSUfiMF9ThTtaKNlPHGvpxXg+xwhJplxRXIASA3FAHTeHOWtmRVrFA/DvOgHw8TVVi0/kjowvtfeE2CIA9tyArARQ9sDcYd2zd7N2lV3/jRQ7+SP01egfyIoi3Ia0AtGQMYgTJ4O//E1rX3xd2HgWnU/KlFmlD+9UxCGcwwE4TYjM92ztUXCpPN9tPlk2qrDE=;4:yvW+1+ufUo6kbU6Xzdi4vVJG4s6wE6KiwVJCHkXQyLg/K35K/grNH7Y2nHwLaoMLmqb3Ewfoa30eO4z82P9jWphoGZdWsxq20nAKYMLUs1JtVWO4z8a60QShVpYufHyFtWUFpnkWnv/H+YdoEODoisuecbSEmof5VRexQPwlrW/qaLiR9xrXW5zCniYxqJ/+EIvQ+8UyCiVCyBd1oGRUYBUNfKAn0zI9Wtf8u3/LxBN349UMPdJHPw4JP8Y/feLstv12oV9q8YQXf5PZ6h+bVbsOmTJZKNHu0LuUxfevzq1lkx9SFLPc5tfekb+0FJno
X-Microsoft-Antispam-PRVS: <BN6PR07MB2900564AD844AD63AD94EB60E3BB0@BN6PR07MB2900.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR07MB2900;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2900;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(478600001)(1076002)(11346002)(47776003)(39060400002)(50466002)(48376002)(53936002)(105586002)(3846002)(25786009)(476003)(6116002)(66066001)(956004)(2616005)(386003)(42882007)(186003)(16526019)(68736007)(6346003)(26005)(4326008)(486006)(6486002)(2906002)(8936002)(106356001)(7416002)(36756003)(50226002)(81156014)(81166006)(6666003)(97736004)(446003)(5660300001)(8676002)(110136005)(16586007)(76506005)(305945005)(316002)(52116002)(76176011)(72206003)(51416003)(59450400001)(7736002)(6496006)(575784001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2900;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2900;23:CWwq2Hq+fK9pdiVYBSdvM8wy5EtqJjpaznRrkmnuc?=
 =?us-ascii?Q?ydAvdZ5Ri49FjBQX9mBOYXZ5teSih4jgx63Py+OhQIrn/NXKJXb2pC1bkS1f?=
 =?us-ascii?Q?VSRTB9LovIGcWqBIfzHA3B9qG38fJz4JUWwwU6qX8AFZIM+POarXr3vvCeLc?=
 =?us-ascii?Q?sVuBpTC1NF9Y/O1MPGLvxkeHcXv7pVodVRq3PY0vPd3FkJaRGp3gOZJU8hq7?=
 =?us-ascii?Q?fh6TUeidbGQ7xfVypeGcJttuUF5urf7EWXDxaRxUq50E9mRNpse8FRZp4Ewp?=
 =?us-ascii?Q?o+bHLehWr52C/QMOGp0jV2IYyhpYAB0at+poIfVg+tt8sWj20m+29zlnH6e2?=
 =?us-ascii?Q?U9OBiCwCTy1HgZnnZ1P4E4Qy9M1WFaFJD5WoFQm5lswlrMWJjDLuIorD2VzD?=
 =?us-ascii?Q?AyinSPyQkLnUb9iLSZOSkGdxLIDTb5ijX9o7fMlPRqlso8Lc3rpIZ/FPpW3a?=
 =?us-ascii?Q?8E7F0wphTQu5U4S3WIaEfUa5vaWKV3+yBZUJknu4tV4QdvZxwFm4Ceg6E69i?=
 =?us-ascii?Q?12ONXxix1ub5nkTZe9amBMQT3DCIBJ627GXQiDpXZtCySGpGbLyQ/Vg0xU+6?=
 =?us-ascii?Q?POjdZMTF+E0VON3pkIHKUyITmLKkUHrnNmskxkqczKlB3vrZBsnu2MOnU9KI?=
 =?us-ascii?Q?8Cn7LRtgHbBfywtBAbFjYtuq1ftV3efuWHszAXtu0Ojv9DdxUQtpd/nw1LoS?=
 =?us-ascii?Q?eoplebJU4gbgrHkJR2W9pUXnHS1gj3HktcWsTdLpibIXCqeJ5CK5xRa522WD?=
 =?us-ascii?Q?ZB+mubBFrI70jcLdAnIdeBSICM614RMKR8JZpwTuv3XfDjeP0wWTuBYNLaTI?=
 =?us-ascii?Q?yLYsECWeHd0nCCK1rITS22+XRYYclRk2AOz4u9N98dkZzGSe+qk/qTojbzoJ?=
 =?us-ascii?Q?BXxPyLuz5DWiu1jwwrawxfrl8FK8Ylx0D66GAa9Pf5wNq+PCeh4vzGZ0d6M0?=
 =?us-ascii?Q?5l48BN61/NdshQBcjNOcf9V+ryzhC2coz8/ToW+F0ytDAQ1H0VrZXnBQR+zh?=
 =?us-ascii?Q?JvFGQA5ohouGLcuxywIT05Ds/YPtUDnq6OhxmOmtnh9pPWa0H0+b6+B9x6Qv?=
 =?us-ascii?Q?f31xxvaR0yQ3URJh6dmtilF35YT2eKuA6i7zkKpnT8/AgKFntGopEDtQ0MWb?=
 =?us-ascii?Q?x/8KC+J4tzyYUd3IVd0B6D36sJ78AlbQT15ZvU0j26+OjvGNVDcIY1A2AcsH?=
 =?us-ascii?Q?pzuUVJxD6YY64pi+VpeNcIQjYoZ4os59YvXM3dWzaHvIFFsWiFV72xEo27WD?=
 =?us-ascii?Q?rdwnuKGQGSYuc/d2wSRNrnAKd+V3NDk8sdV4gofp+uh0PwnGQ1FYF7BiYaIi?=
 =?us-ascii?Q?zQiKGa9BY8y+jjgNsZfHcAWOwxBdwRpd5z8pYf3jk5R2tHHY8JYCx45OsUe2?=
 =?us-ascii?Q?3eZUHYAnrUzJTsKHH/XE+I+R0z/7ys5jc6v/wA92vwtMjul?=
X-Microsoft-Antispam-Message-Info: GoepqHY4TTbpqY72OcF3alIUOmElOIjqhI7eM0iiWOWKQh46Y2V7bbVsV6KUYK7DavbwMx5SUd+XQCaK97OMxqCgaq3qncFmB7OrIF/TV+Z8VW3YQfhAUv6NDbZOROUVIEmqVtZVraBD6VtJysZ5Am4trFxrKh/ePEoxWUceXND/JVgRha669/EZ0Ilvv7do
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;6:k47GBhyTEWGN29FUBS/Q+2ypbpXjEJ1Fhb7dGQay3WTPudCivBn9B4ACDLXFGcCs321Jcf3XPCohJ4mrbYSOoT/Z3xTx5kQHsXh1T6ThXJAGAnddPUVX9CRs3Jq//yLR8lT/WIjSNMNnVMkyrQrXhk+Zne99TVW5mZhapLM/MBvuZmEIye/v0/MbDNsilTok3WfTwY2lSaRZVePyizETA7h99HZpRoL/vx3DuBl/0x7qYSrto59Tq5BSi3kCv2J7Ob96leNH9VVhsvdP1ShijPDMvtYPanqivtQ4bKRgrojL8v3LeGURtE9H7/DA1s2qG/SF6K2GwLQI+GuT48LTq8PxvEqO8hI7SAfcvvGPWS761sBh1zOQzBDbVoq02sSJzCOFyEC89CIVm3tCT+9nzpuLyFWo9ft3epcSWOIRxLFyJ0Qmtd3KUA7u/oUQvazeMvT/iZTaFL3IXzf1NHKT/g==;5:iUP2Pj4HSZoQZea9fmOQMcDwLjYovcrzzHTmuxRUgD1Oh25XccZnoFJoKAuz03eJ4hp2miWoRAoqaLRzmYUNoUPZx+a+V7RYrKAHQK9KMMSRTwUPpnuC3RsYC7ftkCScHhieVD0bwvg8vu3PRzbBEEwpsE0ushxogVd87oHEmbY=;24:yMJAELcZdezB4AmxolxjEM0mOBBz/oT/iZeqqhU0mw9rFUs4RKnftvTMpYiJEGy6yNeNJo4RPm7TKgDbW4AZxxTuEEKlo/RIjCmid4pEyrg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;7:y10FXTdwQnhlsYuyXXRUdIIihdAAMB8HfL0n8kxPR4YVJyMrqc6AY/3OQxO+FHxsB8kjjmwCQd/WdaK2oUR8n5VsMeJh7ZQ+RYmPJ8MXg1yo0pO8gdhP7HyXIf0qBDMYfQbmt4MPsyk+iD0UNYMn3D089OzUAtGfmOffZYOwHFLi2/2swkbiXPagBJ4xChiPiskp3stILUuWA/YieYCqjsILwQdwC3+LLrh1v+XrDlYyDXy1BFDtl8COjSbDTfKh
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 17:19:06.5170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d291463-4721-4742-9652-08d59b195715
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2900
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables delaying of kernel memory synchronization
for CPUs running in extended quiescent state (EQS) till the exit
of that state.

ARM64 uses IPI mechanism to notify all cores in  SMP system that
kernel text is changed; and IPI handler calls isb() to synchronize.

If we don't deliver IPI to EQS CPUs anymore, we should add ISB early
in EQS exit path.

There are 2 such paths. One starts in do_idle() loop, and other
in el0_svc entry. For do_idle(), isb() is added in
arch_cpu_idle_exit() hook. And for SVC handler, isb is called in
el0_svc_naked.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/entry.S   | 16 +++++++++++++++-
 arch/arm64/kernel/process.c |  7 +++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c8d9ec363ddd..b1e1c19b4432 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -48,7 +48,7 @@
 	.endm
 
 	.macro el0_svc_restore_syscall_args
-#if defined(CONFIG_CONTEXT_TRACKING)
+#if !defined(CONFIG_TINY_RCU) || defined(CONFIG_CONTEXT_TRACKING)
 	restore_syscall_args
 #endif
 	.endm
@@ -483,6 +483,19 @@ __bad_stack:
 	ASM_BUG()
 	.endm
 
+/*
+ * If CPU is in extended quiescent state we need isb to ensure that
+ * possible change of kernel text is visible by the core.
+ */
+	.macro	isb_if_eqs
+#ifndef CONFIG_TINY_RCU
+	bl	rcu_is_watching
+	cbnz	x0, 1f
+	isb 					// pairs with aarch64_insn_patch_text
+1:
+#endif
+	.endm
+
 el0_sync_invalid:
 	inv_entry 0, BAD_SYNC
 ENDPROC(el0_sync_invalid)
@@ -949,6 +962,7 @@ alternative_else_nop_endif
 
 el0_svc_naked:					// compat entry point
 	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
+	isb_if_eqs
 	enable_daif
 	ct_user_exit
 	el0_svc_restore_syscall_args
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f08a2ed9db0d..74cad496b07b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -88,6 +88,13 @@ void arch_cpu_idle(void)
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
+void arch_cpu_idle_exit(void)
+{
+	/* Pairs with aarch64_insn_patch_text() for EQS CPUs. */
+	if (!rcu_is_watching())
+		isb();
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 void arch_cpu_idle_dead(void)
 {
-- 
2.14.1

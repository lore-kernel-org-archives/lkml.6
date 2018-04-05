Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeDERTd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:19:33 -0400
Received: from mail-sn1nam02on0068.outbound.protection.outlook.com ([104.47.36.68]:13216
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751754AbeDERT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:19:28 -0400
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
Subject: [PATCH 4/5] rcu: arm64: add rcu_dynticks_eqs_exit_sync()
Date: Thu,  5 Apr 2018 20:17:59 +0300
Message-Id: <20180405171800.5648-5-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180405171800.5648-1-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DB6P190CA0032.EURP190.PROD.OUTLOOK.COM (10.175.240.45) To
 BN6PR07MB2900.namprd07.prod.outlook.com (10.173.28.146)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c7d57d3-702a-430b-c8e1-08d59b196042
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2900;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;3:/4FxuS5K2qnDuZrjOl9Kz+EUAVDezJSKbjP/SCQaV/0EInEbcWEcNaClQUnT6K7YADkwuTwIoqhRWYBmmc+2FX4+gkzk1fiqmLgelO6ygJ/nVnVb6n4rWakXaXCQouX56e+YIKtAbBaxiaoc2NaE/NOgDMnS0OIhaRJz7A9ZLKy0dYS9XY0A1x371zSCyEaHFoTKnZJeSUhYWS/mXTKjr2tnZgEQ0hsH+ei+0CjiXoV1moIJTV5rvnGKdca4ABco;25:sQXs7328R4O2LFeg4WZ55mgfMxcfBsWshdn3NgcQCseF+PYCR4Pmh7R4LOYYao/afv3Xc/oK71r65HGeFx68qov06GuP4pKkAQxWFFqb7P44/F8JcDJNn37tO9vtuGXRRcpMwQkwAScqDQgiu3EViEGnmZXc3A4lrRfq0kVMiJS6g1HBFksLKwVnPVD9zswpIWnGzbeQu2dQVCkxuVAnQS3hY2MsNtoWgqvCTs3jRELsGPC4wxcBA5kUfNuD/qWQgm9Y5pcW5P3asgA87VPQxlzh2qK53JIFGA9GNjw1N7FYNU38I55vY7SFSyLJaPqxJOBRosgge+hKUGJPhXC01w==;31:uE/Xt9ZX+rNWrhxvtVyCpJRNrsHrxr1CLJVPQ1SpXdx//l8I1KCCnrFrTEF6qnTu6q1XoyTw+5y+PCSkSxO9KBV7K5o+UKb7J/kislXbWjfXY+8B530gWeQCHGhSjgRSXg0w/v1q1H0LDT8e0Ip7HewjPvpjwkxNKib3kUxQY7GucaPrfHSd2P0k1QlA3tl8gvSo4opJstL6aVWAlV8EIixRRuHMIsvPd1KmOcO3u5A=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2900:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;20:LWbZGUVpRRUGfcEz/OxfRqqLcGzioLEH/9hEWUULdzpypLL86n26naA3i/sIzBZMI9d2TtBbzzMjl4rNmruxBTlSjikBMLE0mOQN2+Qidkc/ZHVgi91pIo5xeH3WOGou5W/VtVUomiaHyClZdmq7gnrjYjxEgSHGBCNGA2lUbwIyg3xmDczJtcgYMfm57GPLk/Ho0tS79ybfbLhcjQ3nH0VRk36VvnT9Ay6lEI5cvTeWo3/y+jyAM4ozWgaz3lOYNLVG31V4AwkdbNWqlEg5gkrZrbMMwUpMII+CHvABGLHoQl6SNj2bs29BXiX9fXhcqhWzXaNENvXxbL7uYxWHqKY6PtKbgz9LK62IbYpTmc7myP0MNaRIJoySvj1uE1CVZ1ab2iYBcujql2mjDDnyN3rlnHEABGxOXjN2DIrV9F2Mudj9s3YIJfnyIfytUd0z8ZoyZsdxYP3DzkuEovvdIBEftyJ9bH1K9RJI4d8iIbD29FT+/KxxUeQ/T2jkrnAYcXwyEDPIca6nBJR8orbyEZNRu6v+ytzpkFct9oLdNhC5VAzUvuVt17opcpWQ0HwdMcsFhKmJ1yHJx7nrtrWDORJ4D6d3g/ieXP7rEOKvYhA=;4:1Ag7nZvdUK5rOcGd9mxwlPOuKKOyGLAD8KvA9QyLHuF+vwxpjR5P5gAtU9xmWQeixreYVhMItaolO0Kn1F+xFYWH/gg8ng0lRG1uYzOIfVr+sqtK/fVwf42KoamL41G5K1yLH1ggIQuKWB5iUocCBf1Mb+OAQwEvX5/LPZrhuMyjyPy9BdDiail4NckWyqmHym+Z6C1ZicLj5nvUuvkEZagWQWpwDBmfh/U2UGv81r91BU4ERICAOd5dO7wSKmxrItEqr/rv813AepzCfk/By1afUQozu7cx4hKmMMeJIA7eZphbWyXdJgrEOyOTw98/
X-Microsoft-Antispam-PRVS: <BN6PR07MB29002984BC3F768E058BAE18E3BB0@BN6PR07MB2900.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR07MB2900;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2900;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(478600001)(1076002)(11346002)(47776003)(39060400002)(50466002)(48376002)(53936002)(105586002)(3846002)(25786009)(476003)(6116002)(66066001)(956004)(2616005)(386003)(42882007)(186003)(16526019)(68736007)(6346003)(26005)(4326008)(486006)(6486002)(2906002)(8936002)(106356001)(7416002)(36756003)(50226002)(81156014)(81166006)(6666003)(97736004)(446003)(5660300001)(8676002)(110136005)(16586007)(76506005)(305945005)(316002)(52116002)(76176011)(72206003)(51416003)(7736002)(6496006)(575784001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2900;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2900;23:27qCrXoCSqsCLNbJZ/xI0GXuNC4DaOnUlezEW1InX?=
 =?us-ascii?Q?ubIqAoj205yNUkZmdeSPconyfopUfw2JBejwLuSnpLo2/OmwJMfS6ZIy+pRz?=
 =?us-ascii?Q?i57oJ/1qBfDvFIAD7nBrrxMLXfCBvSaKLYVoV9XGcJnEPh8+XFeL1eD0Z+6Z?=
 =?us-ascii?Q?U3RhjHZ3kr8fyeuJTR2C5Fbnyh1kdKIrkPxzZAm/RstKfRC9xz5M/aF9gcDw?=
 =?us-ascii?Q?3ZHxI1zRNHgy+X+W2UyeGyq9Kx/KQnrZlpOaOCh4JF9EXICeaPnwFTLhDf8h?=
 =?us-ascii?Q?LQZHSb4xmb73hgGS0C+10r2sj/mbiHlNi4A14x/9yqfs2ugwmu1xCNYTi3cz?=
 =?us-ascii?Q?Px1KaeIzgWfF2cXPyTkRSMsT6mhU18V+9rA6FA/Ox48rQfMK59cB6vop54Xm?=
 =?us-ascii?Q?CGmKV+uv3PJ/+ujx3Q0jPf5sXuO4uGKaVL3N087MEQrsmAXQPaHg1Qd9hJ99?=
 =?us-ascii?Q?2gXdBsqWfuG8n5MDgbnwuQEr5J99/737dtN5HzixHD7g7fH0oERcBXTZiIFz?=
 =?us-ascii?Q?ODkyW8g+qo/wjJgcLzPA19MzxVaw4Veo0QhFGhK2gzSO9+3ztAjcvcmt0dew?=
 =?us-ascii?Q?4yPG34OmN2i2aIHQiamICkPDR2+6Gi7mHRS18uh1Zj9myIYW+61UFIclAp7A?=
 =?us-ascii?Q?wSzsxhQ2z/hmQu6mR6TcZjQXKZuNXowGo0FLgpDh5NSXh+iULSMx/qXHQD5o?=
 =?us-ascii?Q?VG2VIlBZJ89lKvFAhdFQSRc0bsWPaPxlu6xtT5n5VW1ZX9lplANbV5rmQCRz?=
 =?us-ascii?Q?tawuLa9JrA6qVvD1SZUcLdwgBspDDyDryrSyDZa1DR+zeix1xmx03mcGqyX/?=
 =?us-ascii?Q?MDpuEUEI2RCBBe8N+4limC+q6GwxNiQqnYesQRNrYeagph7rYuwAzrT3tD90?=
 =?us-ascii?Q?4aS+M3r4q/0aHinAW2qy6gELwEW+gP324YR7i8AzZO4XaL2QauRQM7f7XWFK?=
 =?us-ascii?Q?tn8lGH1Iqq/MeKGcUrK4v7x9VQAOmi5Lwrm64NZlVWAUo5EO5e0krx8SvJX7?=
 =?us-ascii?Q?a8NFvZUstXp/QZ3zotD7o/QEVx7adzZxbaxW4T5lgmEBv6sz/Mp+S+FHltny?=
 =?us-ascii?Q?I/H7cpoz3NrlTDFI7RDRdbFaD4+SUiJQtn5Z0znimHbjuOSL4jb6VmYadRSf?=
 =?us-ascii?Q?eWoeo+A1xQeGIPVB4lnnKJT8afhOHJJtbLeEB87cYqsUFC0TTqi9oeNUlVtU?=
 =?us-ascii?Q?rVssJLFYm0uY5NntG9H5y86jTNvodmSf9uL2SA7IijeDbfz86m5/Thx3wwX2?=
 =?us-ascii?Q?R6xLJu9zdoUBOJ4PynD7DcNS0iERX6Oc51y4+sGjCL0njlN0vm0Dkh9GuZiC?=
 =?us-ascii?Q?DyM66D7hpOmyLpg8UN/pjnBHmP81T6P3VCpPvwMUcJA3whfz4iOHJxeiWlUs?=
 =?us-ascii?Q?Hilfg=3D=3D?=
X-Microsoft-Antispam-Message-Info: IHn7MWAs38PXpeOq8QAZVUpCgsAYC2DVFYhUozRJm8pe3D6C6P7W9OFbUU7epkxXhof+GHieAm48JUkaL1gNcuSKf+HDtD0eVH9Y+SrNneMvhq+dOTZnbmdqQsmUqqc6YiWzDsVflFj181g5s58ecqttLgWzeYU1oRRxtxAnpYrosge2HkfZpoSZ7UIXosJe
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;6:lY4EXJq0KTysKEslIAu7HiJkENEQJKTXs6syWe/JS4W1RINymhXAlo8rXKdN0TuuuaMsUIXmOpp3dL9khgoXnto/ElDw8EdU5V7HlySsWragaMNNw5gf6qXOKjm/uwfRU3W2bNg3uFWa3XQvwUHPHu0HRVAtlfxoSd+djoSaZy8d8lg3MqOFjCZi+l+3O7lPyaOGEoeJf6iqUd5SOZoxw0G9C+0Cnl0MPpjkh/K7O0V+mMF7ZLohkCZx6TPADb2E2kU6G+LkZ5bhpDwEtbuqjB2tWFj7bebMXNjyNkuF5nvCkTTpfPxPINZo5OE0oidG2EMKTRh5MrHXQBt9ccrg79AuAMUICBkK0dAveWx2BMUTF0BVLGFgBiRT7e7nAL3KKglYDyuEOwE/7KuQzu03fVfxxYiO4WzXz2SytghRJn/HR5K15NEjqffZPc7nyNf6UCTGp+i9+l2AUUb1yWbCtw==;5:CnkXUh1wyWkHtvj/NyHdp3BbayNxFLTj1pSN7Gpei8dPKQ9SPPLJQ/3HZp99GWL6oykYdXtcwKoeocxpQx7d1nN1rCNsABuVE9CBecdovYgHwaD9Tgprfymw6AkS8Xvxgpb5sq03ls/4kJCIveDmLLh0zT1g8CH+ok3nKr+4EHc=;24:sQi1bnlm6v+kefPLGpne9O/GIfrAJ4OmbTK6/GpWMtsXpwQelAJyue8U6gmIpY3SyvqdiORO3p9RRIgE95gYervqF6gxNMlQDeDiPB6tE5k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2900;7:pYJWhcl5Up0gdt9j7D+znlWJofE8EFHuADJPKCMBJAcSlvY/jO4A1MNL7AguNi7RK/91cWXxiR3eu0UNihdomB8ytHqvnANaM94hB4usRrQCk7Gwrqd+sLhmDzn/kVtwbRCHLoXKDPzUEfy+77gx5aKRKM2VWPdgcCgwASo4gsdR+l0StFSk6e8mqNaXK12zX5kTZ0TK+zpobNGw0xMbvT0geFlYuW2Vr2GmirVLJkwyEDNeHzQ3N8vrl8BvfV83
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 17:19:22.0218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7d57d3-702a-430b-c8e1-08d59b196042
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2900
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch of the series enables delaying of kernel memory
synchronization for CPUs running in extended quiescent state (EQS)
till the exit of that state.

In previous patch ISB was added in EQS exit path to ensure that
any change made by kernel patching framework is visible. But after
that isb(), EQS is still enabled for a while, and there's a chance
that some other core will modify text in parallel, and EQS core
will be not notified about it, as EQS will mask IPI:

CPU0                            CPU1

ISB
				patch_some_text()
				kick_all_active_cpus_sync()
exit EQS

// not synchronized!
use_of_patched_text()

This patch introduces rcu_dynticks_eqs_exit_sync() function and uses
it in arm64 code to call ipi() after the exit from quiescent state.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/Makefile | 2 ++
 arch/arm64/kernel/rcu.c    | 8 ++++++++
 kernel/rcu/tree.c          | 4 ++++
 3 files changed, 14 insertions(+)
 create mode 100644 arch/arm64/kernel/rcu.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9b55a3f24be7..c87a203524ab 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -54,6 +54,8 @@ arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
+arm64-obj-$(CONFIG_TREE_RCU)		+= rcu.o
+arm64-obj-$(CONFIG_PREEMPT_RCU)		+= rcu.o
 
 arm64-obj-$(CONFIG_KVM_INDIRECT_VECTORS)+= bpi.o
 
diff --git a/arch/arm64/kernel/rcu.c b/arch/arm64/kernel/rcu.c
new file mode 100644
index 000000000000..67fe33c0ea03
--- /dev/null
+++ b/arch/arm64/kernel/rcu.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/barrier.h>
+
+void rcu_dynticks_eqs_exit_sync(void)
+{
+	isb();
+};
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a734692a581..363f91776b66 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -264,6 +264,8 @@ void rcu_bh_qs(void)
 #define rcu_eqs_special_exit() do { } while (0)
 #endif
 
+void __weak rcu_dynticks_eqs_exit_sync(void) {};
+
 static DEFINE_PER_CPU(struct rcu_dynticks, rcu_dynticks) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
@@ -308,6 +310,8 @@ static void rcu_dynticks_eqs_exit(void)
 	 * critical section.
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdtp->dynticks);
+	rcu_dynticks_eqs_exit_sync();
+
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
-- 
2.14.1

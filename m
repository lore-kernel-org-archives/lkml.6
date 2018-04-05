Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeDERTp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:19:45 -0400
Received: from mail-co1nam03on0050.outbound.protection.outlook.com ([104.47.40.50]:6080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751984AbeDERTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:19:41 -0400
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
Subject: [PATCH 5/5] smp: Lazy synchronization for EQS CPUs in kick_all_cpus_sync()
Date: Thu,  5 Apr 2018 20:18:00 +0300
Message-Id: <20180405171800.5648-6-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180405171800.5648-1-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DB6P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:2f::42)
 To MWHPR07MB2910.namprd07.prod.outlook.com (2603:10b6:300:1e::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a3436c2-4cf9-499a-2466-08d59b19692c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2910;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;3:cM2U6DtjipXWMuMUxaVEw39o/qFoxnYpiu7DYAeNavDB5WybqwQWoI2MdnRPz+SlvpdHDBRnwiYbx7knDSIdjjYs3TgX7yXL/YJvWUvYBU9olUFf39maWoARsAmO6xTE/vrCyV6HN2CeQRDBk3SHzdtdINDwH66kIUiiTjX9wPohQpIPzZ0PINjn+/m5AFlEd5p2yR/xXiVuCO2tuiiguAoNGoNnuqH8KS5uZxFdJwm0wh7qfzcMum5V0odUDIVL;25:ggVyseE4S3mRpIpTK0SGXUgMs1Gt5SlwrLXAgVhmNPsDsP2Ai4L5DD5R4zn82UKlyyPkWs01/4AKW6AhC1+/mGZ/DyU1GDNHI9NnMFgpfbiI9R0YYG/jhCp9+ENZklKbY+Zr9YuqYSv5zweFEJp6TYuaoIPT+K5WjdDX6Ze+drEPAWNr1xNsRHS8huYuqc+AZc5i2dEhobxLfgb0itTxZJ/1DW4LbUUtYGUQQr6OLFrVVPyQhhPVHcbnNxckrODva27V8clneTwQqPBDuVL1uwb7K9aW12Qu0kfimIP4q0VT57ypeU5mb1Pk98lt5RAS+1p0DnnUvqYuTDb88RgOWQ==;31:aCTIFQ3bs+87gaYKcs3lQ4JLy/omB6tvwG0WT5yP/T7RjThOOV3YvZhH/VXz/MHu5QaP9CUeV1Lp6OmN69Z0FcvUx/R0qSdCk2uWJlKZz4XHFaJadARaHQJ/iRmmL3ME1C3MV8T32mAQ0hiNzLKBCa6OIYb/GGOx2qhfY7oDavnEtfHw9YxadiFgUa9z9jlQffdsyjgdG2qJsPKuIXP+cX13uaWlrYy+Hy5JDM6equc=
X-MS-TrafficTypeDiagnostic: MWHPR07MB2910:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;20:11pR5hsdl9EnyVP60EqOT0PTk9WsPpx893dQNsS7UAi+9xwOFXFSul+e/VpMOCSbDfPWepp6VM4dBeAOu1u7eik9+bwp/Z3vuB0MaAL1SDGmOFrmEV1hZwsXjoavuoTsBoZ9P4En4Thf3fxRftaGNY21WOe7xBCn5zN8G1JU73PDbFen3dYFDRoG9Cby1j0M8HX1MK4cle/dfCRIBrXyc60pghspYAilP2Uwx3X6Tp4MlGjvgNhxphaaaWgIHGqFKPsTXIRBnNXEWQ0vFUC5vWm9Wgkd8+11V7Vycs0rqwhx2LFLOPkfy7dInqSw5eB9VTXr1E2FVpHUtc1NPXmXUACoEizjFA9rMVhhZq7m2EX5hZXl+99u9SwzAdmRqkT4KTrHL6HhSAOd+6O7IRn2xBOJye6rvkGR+G88KOr0TNqB+TGGUwnqoBhDfCzF/TdjJoLmNAoj7qWN2xtD2e8yI8sKK3UK4EC+1VZkvn2hgl+xtKy+RWY1Haj4Oly0y1wDEuPx4jdHzTnIDXhjk/48imKUnpUNablMrg2h7fGaAoH2d4/Hgq8PjUo2gTpRWpk0P02R9NwN2lmHqOZEpSkYUfJIglKxQaJGc/fNwGbqJnY=;4:MreQM6ZWJKj+XU5ouBuglkEmx9Isr3TY97BcgLbLYWp9ZDRegI0wAkP7BjrsWubFxAg9pArGxtVo0e4krViU+8/5EtAA2+4yD9oEuyBfuRKGvlwfjC9WLyySRJfTpaS2xtSm3Ce8Yk/LLypFe91B9VYP+8ribjD0sU7SPnw+FuX+Y2LVayPoMkkDJNdexzyTkGdnUJ3CJiXtrPPk4Y3nZ76iM1zn4uWSTkBHfnrp1lKeEDq/MQYiv/gk34u+S+AnbED7i1MFhd9PVeBVTNQNpA==
X-Microsoft-Antispam-PRVS: <MWHPR07MB2910902BFAAD421C23C26AA0E3BB0@MWHPR07MB2910.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR07MB2910;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2910;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(59450400001)(50226002)(476003)(97736004)(956004)(2616005)(11346002)(7736002)(305945005)(7416002)(25786009)(16586007)(42882007)(386003)(316002)(446003)(26005)(1076002)(486006)(186003)(53936002)(6116002)(5660300001)(3846002)(6496006)(8676002)(47776003)(76176011)(51416003)(81166006)(81156014)(52116002)(8936002)(36756003)(16526019)(66066001)(6306002)(105586002)(106356001)(110136005)(72206003)(6666003)(76506005)(575784001)(68736007)(50466002)(39060400002)(48376002)(6486002)(478600001)(4326008)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2910;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB2910;23:cgvi0xjci/wwf9MkCLMP81S0q5jUQlNC+zdZZDOYd?=
 =?us-ascii?Q?yxfjpXmcMCUmni0pdyLeW491cghcLcbYPPNyyJ+MoLvo2oW8paQw2ua9nozU?=
 =?us-ascii?Q?qskkU7OGu5MaB5K45o5wAH7cXzzWnvxUi3z2kYbX66U0GwuWUGjbju2ildKY?=
 =?us-ascii?Q?KYYO9QX9QI/gf60kVnpyB7USL+f8ldqWtCfXfB9wDe58sQHQg57srfSwb2l7?=
 =?us-ascii?Q?r2Lg8BO7LkuCz6MFeaqmA6rudJyHEEQWnhoIu4N7l7Bw+7qB6SvtLvx7wH5V?=
 =?us-ascii?Q?2PzwWofZTxkq4qW6FdjvdHXwpQv15htqMkg0kvuXGJcY5UZpJToVFw2r601S?=
 =?us-ascii?Q?hPas35hv5UlQxCJfM9oE8Aq2rK4YWxcbRRO4tb8pzKc4X+IdwWBspYtWz3sq?=
 =?us-ascii?Q?Jksi24Iq0EjrLoV/R711YhzaoUgjeKFRgMdM6v1xKZHk83KoYjzX2C6Tkzvq?=
 =?us-ascii?Q?k6zFBEEzIF2SZPSC7dkc1POpb/vf4LqMDV5MKenG6Q3C7BqhjForJNSbFoM2?=
 =?us-ascii?Q?VN0hUlQ3B0sXm6g31iWyLTzVEmrnFLtJHzI298QoQbndtKcuXoPX5xvTCUkg?=
 =?us-ascii?Q?AVy0L8m6fDw5QXePE79YVw0tiU4Als22iCVDST+8SA0kEGXNNh+PC18XLPNo?=
 =?us-ascii?Q?Lo7qGRLir4AByJq1XgjjQvlOCUEAWK/Cxxzjy5EMw4JRwzK235pMrIBagIIK?=
 =?us-ascii?Q?s7ayXSOWxdiQSDsAlD+g5j0k0zVHnWadjRyATY/BokzCFJoBguyoUSBtgRn5?=
 =?us-ascii?Q?o/0J1bnAw2WRAcy+4qTrPWeBD/HsIlGj6dnnd9jg7l8h//9wk0Ey5osn7Vtd?=
 =?us-ascii?Q?ZW1LYsfS5r6D8SvmrIVj8y3Te0wVteR8uHZ7cWRj6eQrWA22NmfD8foMiP1q?=
 =?us-ascii?Q?VKL1h7KuU1pDzEce1X2+ttru6Ly5LddPRycpxoKKOpakXDzlTBQzxfNlknM8?=
 =?us-ascii?Q?67D6EAoAZo9Pmcbfvd9BRLJQL2TSPZWht0fTSRetNG3rc7Yx6ifRgZacc6Vt?=
 =?us-ascii?Q?k/V0vyheew/WLk4STuUyUxAKY23lLeUUjyD0WrUqTRiQs3/mkIPVg64Z1WH4?=
 =?us-ascii?Q?iaQf3xaSJAUh7NX+EDL929e4ZsvJUdi4IuKUaA4BIyd7TkE5J2yfq8qcWADL?=
 =?us-ascii?Q?dQfXsMziLET/orV9w/9A5lhd7rQf7IksyQltOLVXyx8uXQnkUZhTaio6kOFK?=
 =?us-ascii?Q?ZAoGDgFNiRqG4bHGQr4493IgPA3GQq18cit9IVUdSxTyYzoXPpbIGzrybXkH?=
 =?us-ascii?Q?gZ7Y9UKiX9PTTcfe6qOw45KDuSBdHZEOkATgK8DP0tdylEZZJ549rufIe6yI?=
 =?us-ascii?Q?o79HvU6B36HBfI+kYVVcwPTvDIGLVRm4iwsYn/dEJj0Z6orQqyQJeH/g9n1y?=
 =?us-ascii?Q?PDd+Lyo3Q06w96iqAkJwNldI+RXxvnxmiOCCFc51AlamlHi?=
X-Microsoft-Antispam-Message-Info: uLAGI28DTf/K9cgPgkxejJy4g8x1hIOjKOCDpJ5kroFfqgkA+ggXwqEh22xwh7MukYrPFandqLPlMPk4RHTkcJSKTvR8h8tvOLXCxgABOZWfhYbRrLpwa2UorvSuc43UTkafWx9gH5R6YHvbDL/6TXSo1ZgFXKaWhjHExw0/iKww5GXLMu+D7q4WrmmVUvTZ
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;6:maZokV24IIm4oB1V8ILo+R+ul8wI9OgCwrS8RNVwBdF0C5pb2yYdZnpUPp2l9UixdXZh6uIR/4i8rPTyv+og0OHDjSO63h2FjEpm49I3LN4OhdIIdPUAzY65qNj227cjY290o5wzU3Ndmy5rt5UZKrf38PAB/9iTBRAZMPc93aZeLex4TK1K7Blf8RCd7kocV39XZWMiBOCkholcU5daEyxYkZoR9H3/+7z6X/vBD5WBw2SWMvxPxiFYFpysEHVD6nLgD/kQZCL44dMloxmQxkwh1iQStH1yiF9SLrxNhoxZpnaj574hT3IwNn0puMsZYkFfUR7rM97tjq5yac64PbFYL+TnEZYZPZfvFvt5G2Kf+8NIvDFXi+ASPPQZiaFV6O78n0yJPqQAuqG6pTRm1R0rMntEFZLa+8X2wq1axvrh7v85OiEL8W8kA4GMwruuVud3I+eP2HVlFLEN882IDg==;5:8mqzVInJ2rAjqfRtXF5LSK3cVhVsokiKDgGcyB1Dz9eygHnKwkRn7fMQbKo0FlTKuuGg5uB/qFKluGBPBx7DvcQDjGUJo1IrlMaHpIK6QX/z8zOE/w4qcFHBE9pGmyH55Ltbt2yYRTc8DaRR1Hc7Yg4PAWWfojnue/T6d+wtsNE=;24:bVLP9DbBEKoayqb3y/4oH3W40w2PPGHuvt4HY0GOv60dF9P64DXcQv7OzadGW6zD3m/1O/WVjp/oHFJEnp3qcx9JEFpt9KWMF2WZ3HD4pi8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;7:iFf5fCf+XivQSbu1rqV6AvIgSSWB1oD4tfTuLaXiWYNpI5TWE8PKoMRgCUb+O8uCFxSxh6i199vqwhJ6GjoVuejlNrtmhw8p8on9O8iJwUfz4p+ZyryhRB8IQJpKZ3T6f7OHuOITtyoCMKl+NKx08IaXruDqY26n9QCAUDOlTMa4uW6UnJSZ9aJutN3SjpsD+3dIAZUcjLFviFiLo/bw01NJo129QH5a7yDhgKsyH+xznUMu/sbTPUu6yej/fuKB
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 17:19:37.0500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3436c2-4cf9-499a-2466-08d59b19692c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2910
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kick_all_cpus_sync() forces all CPUs to sync caches by sending broadcast
IPI.  If CPU is in extended quiescent state (idle task or nohz_full
userspace), this work may be done at the exit of this state. Delaying
synchronization helps to save power if CPU is in idle state and decrease
latency for real-time tasks.

This patch introduces rcu_get_eqs_cpus() and uses it in
kick_all_cpus_sync() to delay synchronization.

For task isolation (https://lkml.org/lkml/2017/11/3/589), IPI to the CPU
running isolated task is fatal, as it breaks isolation. The approach with
lazy synchronization helps to maintain isolated state.

I've tested it with test from task isolation series on ThunderX2 for
more than 10 hours (10k giga-ticks) without breaking isolation.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/rcutiny.h |  2 ++
 include/linux/rcutree.h |  1 +
 kernel/rcu/tiny.c       |  9 +++++++++
 kernel/rcu/tree.c       | 23 +++++++++++++++++++++++
 kernel/smp.c            | 21 +++++++++++++--------
 5 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index ce9beec35e34..dc7e2ea731fa 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -36,6 +36,8 @@ static inline int rcu_dynticks_snap(struct rcu_dynticks *rdtp)
 /* Never flag non-existent other CPUs! */
 static inline bool rcu_eqs_special_set(int cpu) { return false; }
 
+void rcu_get_eqs_cpus(struct cpumask *cpus, int choose_eqs);
+
 static inline unsigned long get_state_synchronize_rcu(void)
 {
 	return 0;
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index fd996cdf1833..7a34eb8c0df3 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
 void rcu_barrier(void);
 void rcu_barrier_bh(void);
 void rcu_barrier_sched(void);
+void rcu_get_eqs_cpus(struct cpumask *cpus, int choose_eqs);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 unsigned long get_state_synchronize_sched(void);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index a64eee0db39e..d4e94e1b0570 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -128,6 +128,15 @@ void rcu_check_callbacks(int user)
 		rcu_note_voluntary_context_switch(current);
 }
 
+/*
+ * For tiny RCU, all CPUs are active (non-EQS).
+ */
+void rcu_get_eqs_cpus(struct cpumask *cpus, int choose_eqs)
+{
+	if (!choose_eqs)
+		cpumask_copy(cpus, cpu_online_mask);
+}
+
 /*
  * Invoke the RCU callbacks on the specified rcu_ctrlkblk structure
  * whose grace period has elapsed.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 363f91776b66..cb0d3afe7ea8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -419,6 +419,29 @@ bool rcu_eqs_special_set(int cpu)
 	return true;
 }
 
+/*
+ * Get EQS CPUs. If @choose_eqs is 0, set of active (non-EQS)
+ * CPUs is returned instead.
+ *
+ * Call with disabled preemption. Make sure @cpus is cleared.
+ */
+void rcu_get_eqs_cpus(struct cpumask *cpus, int choose_eqs)
+{
+	int cpu, in_eqs;
+	struct rcu_dynticks *rdtp;
+
+	for_each_online_cpu(cpu) {
+		rdtp = &per_cpu(rcu_dynticks, cpu);
+		in_eqs = rcu_dynticks_in_eqs(atomic_read(&rdtp->dynticks));
+
+		if (in_eqs && choose_eqs)
+			cpumask_set_cpu(cpu, cpus);
+
+		if (!in_eqs && !choose_eqs)
+			cpumask_set_cpu(cpu, cpus);
+	}
+}
+
 /*
  * Let the RCU core know that this CPU has gone through the scheduler,
  * which is a quiescent state.  This is called when the need for a
diff --git a/kernel/smp.c b/kernel/smp.c
index 084c8b3a2681..5e6cfb57da22 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -708,19 +708,24 @@ static void do_nothing(void *unused)
 /**
  * kick_all_cpus_sync - Force all cpus out of idle
  *
- * Used to synchronize the update of pm_idle function pointer. It's
- * called after the pointer is updated and returns after the dummy
- * callback function has been executed on all cpus. The execution of
- * the function can only happen on the remote cpus after they have
- * left the idle function which had been called via pm_idle function
- * pointer. So it's guaranteed that nothing uses the previous pointer
- * anymore.
+ * - on current CPU call smp_mb() explicitly;
+ * - on CPUs in extended quiescent state (idle or nohz_full userspace), memory
+ *   is synchronized at the exit of that mode, so do nothing (it's safe to delay
+ *   synchronization because EQS CPUs don't run kernel code);
+ * - on other CPUs fire IPI for synchronization, which implies barrier.
  */
 void kick_all_cpus_sync(void)
 {
+	struct cpumask active_cpus;
+
 	/* Make sure the change is visible before we kick the cpus */
 	smp_mb();
-	smp_call_function(do_nothing, NULL, 1);
+
+	cpumask_clear(&active_cpus);
+	preempt_disable();
+	rcu_get_eqs_cpus(&active_cpus, 0);
+	smp_call_function_many(&active_cpus, do_nothing, NULL, 1);
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
 
-- 
2.14.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbeA3Rdu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:33:50 -0500
Received: from mail-sn1nam02on0071.outbound.protection.outlook.com ([104.47.36.71]:21856
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753349AbeA3RdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:33:00 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, Len Brown <len.brown@intel.com>,
        Kyle Huey <me@kylehuey.com>, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kan Liang <Kan.liang@intel.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v4 2/3] x86/kvm: Add support for AMD Core Perf Extension in guest
Date: Tue, 30 Jan 2018 11:32:42 -0600
Message-Id: <09f44e3ab25741162d2d0787bd03f324bc48b79c.1517333237.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517333237.git.Janakarajan.Natarajan@amd.com>
References: <cover.1517333237.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR10CA0015.namprd10.prod.outlook.com (10.172.33.25) To
 BN6PR12MB1362.namprd12.prod.outlook.com (10.168.228.20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 332a593a-11e1-4231-e12c-08d568078042
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1362;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;3:dQOsr3FHVoobBir1y/Hb6yTVo1q5I/pMuIAPr/4+b/3UeubuOXjr3lEvmY0SXJlZnCB3QF4Xc2INpd9niTLWhZP9m6TwLRUHzwgn++IeT2kejej0/vKVx8dkKk21jB+8R2PfSD7e3WQvjspBAs4YZ4Oq1/wPOB1IcRFNN4aJDDyA613bScmFIQyqvZjRq+PmvfmYSrYAjaE1R9K/dBZtuWAN9krEdCWyXJbyMCs6XJCZLyPteSmzGEYt7+K98QCK;25:ammW82C5sL89DOWE5PFH4WBsjBXNmtSMFYP60jX8/kjKQ+ekz9VYo/xeUv2nUoLiANFywC3r1x9A2lspf+hfCYBxsSiakRq9J7yAaVHGBLWxkEySdL3kUIfBauAgrTXk8r4BfTKQ29FBk7h9pqPPaJDZLbQJ+W9Nl7sdt7EYfecdBoZShLfwGu2M9Q65Ab7ejWmShP5FNWXse6CEtX4bRuoQT/fq72rOXaxjown9JY739W9SdPPEBBt0InrHjekFf5dUkG51r2FgYHeWgFTEVTysDb4w3zMcYjnxLImTozk+lbcLiQr6wxD3PtLCHvoOaklm/zY+JKATWBOotWc0nw==;31:XqgkFGj6+3xPMDpsuZoLIdTcUWVuEssxfHNoiQsguc5ITmFPJXFIcMexD7WIFD+lt8FCiSPulpWXq8ODnelo9aAoXr6NLZRulzdLW1gaZ2n5TWkp3aVYgqlc0GDO0G7Riphsz7dOZ5ltkCWRadEi+RYoxL7TNK8SRokK1lz1UrI+Mc6fDlD9LpKx4Ew0ZTo14t0d5Qf5wah+I2irMghFJS5rCYzt4/ZfC5xQs7zImQ8=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;20:RiMvVqWZ9eez+SPYVJyrvo+UFWoT7POqsRvuKSGKJqarhJQof1XKZerHlY/hMZjWTYDRuwMTgvCiWyqIt4Dyi27sCSJnW6T5HWQoBa+53u3dh++t/zQHA79hgRvjwKLqvzckLHnAjmprlo1o9h92BUP4QW9AF20p46sWaOlHLvro+9O779dKwO3War9BEeLsKRBxxBctTChZVCcd/0XAVMgBs2wWWU90Tlt5qKRPy7oaOIJo2qujuQmrtsttiMxTWqr8MKujAEAtQ0DvU9WjoTOmnOLhR6NS5bhFUXCQvsm/jXp5B/2Yr7QK/AruDxNsOYeCoGTPv7RRQDf41uxTE/CQqIOo5B71GuOCeLIsaNgsY9nCYnwbpmoiJxWixyhR8afsZv9uvlZUmtnrZN8Jk9rlD0spNvffJsUkuAa7EZ792cImlGNKjYBMUX/wM6gLP+QXAhhFQG/uMBfHVszfLnaFIak2ASVuq44KE3rdbiqsXQXFFNgRh6jBiBLYukYZ;4:Y4lp97liWQh5d+k4Q2RGEbp46fYx9lM54BomuE3jwdLmzToaS0TZ6RLpEj9xsmpulJNOdmooa2QvdWAV0ctsGQLD0XFkGWhfsb2dsJEl9os/a9Qa2KjMBthcCsgxWIODauDLwwz6RX1Nbx6no0zY7uF/+aE6x0YNNrgu41O6+aXmDKOykMaENcmHEArzZCNZoU20CoLjttmQ07h/bY2ozX9PYAk33SqzGKkqTriACYX4OZcv+SZYoPt5ifqBvRlr4TIpewnyvkIsgEq2G/F9Y7o8rBqd5FXfK/Y71rrByXlUR28LsYTuRlEYcnZSfPLl
X-Microsoft-Antispam-PRVS: <BN6PR12MB1362B248DB6946EBBECB4D27E7E40@BN6PR12MB1362.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1362;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1362;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(6116002)(47776003)(53936002)(66066001)(316002)(2906002)(118296001)(7416002)(54906003)(386003)(72206003)(52116002)(478600001)(16586007)(25786009)(305945005)(5660300001)(26005)(76176011)(3846002)(7696005)(6666003)(7736002)(97736004)(4326008)(51416003)(53416004)(36756003)(6486002)(68736007)(50226002)(2950100002)(106356001)(8676002)(8936002)(81156014)(186003)(81166006)(105586002)(48376002)(16526019)(86362001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1362;H:gi-joe.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1362;23:RWPDmtA5ss/Oiqh/ggLJSoXz1szxg4KuoUrVu7hA0?=
 =?us-ascii?Q?N4QzeoQRPQsFTymHAL5QD66yk9gWk3k8lwI/8DJFrU8DLZn1vKweRWHUadnw?=
 =?us-ascii?Q?dKorDY3ANvvzAs42DoMPwdin9BCGlS8NNjIyauCUUl07QrHxqxxDnNjIFzNa?=
 =?us-ascii?Q?XqH7gb/Q/9e0XSfXXcxNAlpHdPSe00DYJrJMzWOxqxoFbbXw/ZjWickgYkf5?=
 =?us-ascii?Q?DWjGzK1ahlMJ7lrjPLUUblXK00bxQAeuOFKOGhr7jf/segrvw5fII9k+BYXL?=
 =?us-ascii?Q?oxxFyP81+lDYL+75pErwlgfKjLWs1sjRF5spGYEaN+Tia7gHI0uDXA98I1K2?=
 =?us-ascii?Q?PiJX2zKbMhZx6SM2JE4v+/cT3drN1heBbBy+4kOJ+4mwAqea2hyMwqb2Pp4P?=
 =?us-ascii?Q?fT99tDGNoWo3tfPylG+9KIDARKU38jfyVlnU9FPePVWdwAXDz8sIFrgQ4pz5?=
 =?us-ascii?Q?BwvjXc2z+2qcHP69GNYVrKx+JIbuQ3nc00gd0pnFiBPETxXYagba6xVzjTlX?=
 =?us-ascii?Q?TWvmFqj91pu7tF5/T6BCe/65VJ3DsJcuEWnyw/U7J7tBIAqLgOilzSeYeQ8J?=
 =?us-ascii?Q?km0WvPp+TobL05/LGJymNkzzpHdnsBj4Fh44WxFSxP7braSpjolGyx6kD0sc?=
 =?us-ascii?Q?/VNb82LpKV3ZuYqQdn/uaVw0GI/deObvYByuABALJHzThDfprHSCDYEZ+VCW?=
 =?us-ascii?Q?7IZotdCOxxHMWIDX9cgYnOITmqOV1ths/Q7g5eXdsf6OU6lNBMCH1Yqp+hJo?=
 =?us-ascii?Q?UlBR4CnmFtg5BCKeoVA+3CXdWg0HCQ7Iu7NN0yX7Rt6YYvwCDqTqPmwmQXoY?=
 =?us-ascii?Q?215Dw6x8oFq5nw6EIvaNEVFw5yv6LOLMo177j3XMCA4jkvJMg0WqnnvuQ+2z?=
 =?us-ascii?Q?mx61KQ7gcTKI24x03Y5+UR9k+BduFixsv53FqeW9+Fnp+bhkRb9BAmY/KJ6i?=
 =?us-ascii?Q?QFno3qv5sHm3fLuXlpzGlbw9+vILrHKOhOysG527PBsUUE/Hl1zMezk7w/gI?=
 =?us-ascii?Q?HLN4I8N27bNThXdz20g2Ec51e+v0q3Z7lbxoVBMRDnKUrhaCMfxS4AkbXKLa?=
 =?us-ascii?Q?Y0YOnPZnfnqZOnUftmJTqjKbgiWwqN27s14FFXaQjviV3XO4bnPOnT0XI0Kx?=
 =?us-ascii?Q?32LKs9bbWc9QjTjJhjhadHrUnOgGADp5jt/acONyZI6fO3N34r6RA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;6:P0qQ+xZWrIWBXExCZiO5xyGu6TKCmWZIwiEmlMBB8hOZbQC3G2qQr7ZpiZwHOYNYdnVREdW5WtJVpx+LYecztkinjl63ivq1Q/p4jmB3r91lXV34H3/u4tpub5dXZ3QPuFdIRrqryCIiCxChCqB4Eiqc32PjXRFJoCyroNHrObtw4AuoaHqJWPTXDedgB/yrKHp67ZebOGteaGIXiSgiC4WpD2ZBKYW0bEYlOTfaCEwENxTNdMA+8HDBw3bzsRbeo28Ie2aWle2ilfqDBMRJW5hIYXKwWhFzDBVBO1xIBxZt7zZjD98n1Nu/3qbTWR8th4KwTt+k89/E2wt+Aqy+Y0hsWjz1hyWaOQD/lFf1upg=;5:JE/P09+rZPl6ldIP2O/B7LIHCb6k93r+hykCAMcDG4dVzXrWDARqUY/DOpqOuPKKA4u0Dy3pSdcifZeMDru8YGQLgrxulPs5G7QRwBq17auKoWJIvmiu+wncpKdH0wDfVg4GXB4OgxaYWvv4NNfCmzLdM1VGhEbZrNORWpvwMc4=;24:on3cQfV2+wanqdJRTmWDm0yBfxmCCcv1uzIKRsOhVZYTFNKY+a4Yj3h06WADtqsz8U4ZyK2PFQXEw0JNw2LrrzVzN5p7zRa51+tvJOuPLQY=;7:fysK0VZ8vxKdTgtcWJUwS4jiJp80uHt4keuv6yILzBX6QR5t06fM8NtudvVftT7Y+gzpdYK3lSvXM8MupKujlVYY+RFKUdT2YWMTVLhVGJNI8WIfjGDkXwCJ1WeYuxWn65svJtU5Qln9cwjDLL1mdPYlJsetjyuBr1FaH1NW92uzw8ILNTf3t/CtQbuyzD4BTtTKuyluESo/u/oeDaNIx7bH53SM/MoGLNWwIyPvCsPNBuMi7RjNZV/WXMxO9vLm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;20:RQfc7lNPCW+pG19N/+7HlVRJA572IWwuX2+vh8JSw361Twjn3ziqpFhE0dV1vpSyrQSohRjtKuP1TzmWtKgAFKBwLr9QucnYIiIrYZnItkFvlMKDfJJo/oEyVZNX+G3zxhyadk5req3qc4yPVd4ww5Lx7TKPZBJBJUEvr0DanMsuZsfFemuPvpKj3xpYlzZz2kZmnnrnmTAbGFgZgnz5fMsRod4FglkDLHTdKTc+K6JorCyXMNcZ00YyD/chYDyQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 17:32:55.6688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 332a593a-11e1-4231-e12c-08d568078042
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for AMD Core Performance counters in the guest. The base
event select and counter MSRs are changed. In addition, with the core
extension, there are 2 extra counters available for performance
measurements for a total of 6.

With the new MSRs, the logic to map them to the gp_counters[] is changed.
New functions are added to check the validity of the get/set MSRs.

If the guest has the X86_FEATURE_PERFCTR_CORE cpuid flag set, the number
of counters available to the vcpu is set to 6. It the flag is not set
then it is 4.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/kvm/pmu_amd.c | 140 ++++++++++++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/x86.c     |   1 +
 2 files changed, 127 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/pmu_amd.c b/arch/x86/kvm/pmu_amd.c
index cd94443..233354a 100644
--- a/arch/x86/kvm/pmu_amd.c
+++ b/arch/x86/kvm/pmu_amd.c
@@ -19,6 +19,21 @@
 #include "lapic.h"
 #include "pmu.h"
 
+enum pmu_type {
+	PMU_TYPE_COUNTER = 0,
+	PMU_TYPE_EVNTSEL,
+};
+
+enum index {
+	INDEX_ZERO = 0,
+	INDEX_ONE,
+	INDEX_TWO,
+	INDEX_THREE,
+	INDEX_FOUR,
+	INDEX_FIVE,
+	INDEX_ERROR,
+};
+
 /* duplicated from amd_perfmon_event_map, K7 and above should work. */
 static struct kvm_event_hw_type_mapping amd_event_mapping[] = {
 	[0] = { 0x76, 0x00, PERF_COUNT_HW_CPU_CYCLES },
@@ -31,6 +46,88 @@ static struct kvm_event_hw_type_mapping amd_event_mapping[] = {
 	[7] = { 0xd1, 0x00, PERF_COUNT_HW_STALLED_CYCLES_BACKEND },
 };
 
+static unsigned int get_msr_base(struct kvm_pmu *pmu, enum pmu_type type)
+{
+	struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
+
+	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
+		if (type == PMU_TYPE_COUNTER)
+			return MSR_F15H_PERF_CTR;
+		else
+			return MSR_F15H_PERF_CTL;
+	} else {
+		if (type == PMU_TYPE_COUNTER)
+			return MSR_K7_PERFCTR0;
+		else
+			return MSR_K7_EVNTSEL0;
+	}
+}
+
+static enum index msr_to_index(u32 msr)
+{
+	switch (msr) {
+	case MSR_F15H_PERF_CTL0:
+	case MSR_F15H_PERF_CTR0:
+	case MSR_K7_EVNTSEL0:
+	case MSR_K7_PERFCTR0:
+		return INDEX_ZERO;
+	case MSR_F15H_PERF_CTL1:
+	case MSR_F15H_PERF_CTR1:
+	case MSR_K7_EVNTSEL1:
+	case MSR_K7_PERFCTR1:
+		return INDEX_ONE;
+	case MSR_F15H_PERF_CTL2:
+	case MSR_F15H_PERF_CTR2:
+	case MSR_K7_EVNTSEL2:
+	case MSR_K7_PERFCTR2:
+		return INDEX_TWO;
+	case MSR_F15H_PERF_CTL3:
+	case MSR_F15H_PERF_CTR3:
+	case MSR_K7_EVNTSEL3:
+	case MSR_K7_PERFCTR3:
+		return INDEX_THREE;
+	case MSR_F15H_PERF_CTL4:
+	case MSR_F15H_PERF_CTR4:
+		return INDEX_FOUR;
+	case MSR_F15H_PERF_CTL5:
+	case MSR_F15H_PERF_CTR5:
+		return INDEX_FIVE;
+	default:
+		return INDEX_ERROR;
+	}
+}
+
+static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm_pmu *pmu, u32 msr,
+					     enum pmu_type type)
+{
+	switch (msr) {
+	case MSR_F15H_PERF_CTL0:
+	case MSR_F15H_PERF_CTL1:
+	case MSR_F15H_PERF_CTL2:
+	case MSR_F15H_PERF_CTL3:
+	case MSR_F15H_PERF_CTL4:
+	case MSR_F15H_PERF_CTL5:
+	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
+		if (type != PMU_TYPE_EVNTSEL)
+			return NULL;
+		break;
+	case MSR_F15H_PERF_CTR0:
+	case MSR_F15H_PERF_CTR1:
+	case MSR_F15H_PERF_CTR2:
+	case MSR_F15H_PERF_CTR3:
+	case MSR_F15H_PERF_CTR4:
+	case MSR_F15H_PERF_CTR5:
+	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
+		if (type != PMU_TYPE_COUNTER)
+			return NULL;
+		break;
+	default:
+		return NULL;
+	}
+
+	return &pmu->gp_counters[msr_to_index(msr)];
+}
+
 static unsigned amd_find_arch_event(struct kvm_pmu *pmu,
 				    u8 event_select,
 				    u8 unit_mask)
@@ -64,7 +161,18 @@ static bool amd_pmc_is_enabled(struct kvm_pmc *pmc)
 
 static struct kvm_pmc *amd_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
 {
-	return get_gp_pmc(pmu, MSR_K7_EVNTSEL0 + pmc_idx, MSR_K7_EVNTSEL0);
+	unsigned int base = get_msr_base(pmu, PMU_TYPE_COUNTER);
+	struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
+
+	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
+		/*
+		 * The idx is contiguous. The MSRs are not. The counter MSRs
+		 * are interleaved with the event select MSRs.
+		 */
+		pmc_idx *= 2;
+	}
+
+	return get_gp_pmc_amd(pmu, base + pmc_idx, PMU_TYPE_COUNTER);
 }
 
 /* returns 0 if idx's corresponding MSR exists; otherwise returns 1. */
@@ -96,8 +204,8 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	int ret = false;
 
-	ret = get_gp_pmc(pmu, msr, MSR_K7_PERFCTR0) ||
-		get_gp_pmc(pmu, msr, MSR_K7_EVNTSEL0);
+	ret = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER) ||
+		get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 
 	return ret;
 }
@@ -107,14 +215,14 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 
-	/* MSR_K7_PERFCTRn */
-	pmc = get_gp_pmc(pmu, msr, MSR_K7_PERFCTR0);
+	/* MSR_PERFCTRn */
+	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
 	if (pmc) {
 		*data = pmc_read_counter(pmc);
 		return 0;
 	}
-	/* MSR_K7_EVNTSELn */
-	pmc = get_gp_pmc(pmu, msr, MSR_K7_EVNTSEL0);
+	/* MSR_EVNTSELn */
+	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 	if (pmc) {
 		*data = pmc->eventsel;
 		return 0;
@@ -130,14 +238,14 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
 
-	/* MSR_K7_PERFCTRn */
-	pmc = get_gp_pmc(pmu, msr, MSR_K7_PERFCTR0);
+	/* MSR_PERFCTRn */
+	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
 	if (pmc) {
 		pmc->counter += data - pmc_read_counter(pmc);
 		return 0;
 	}
-	/* MSR_K7_EVNTSELn */
-	pmc = get_gp_pmc(pmu, msr, MSR_K7_EVNTSEL0);
+	/* MSR_EVNTSELn */
+	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 	if (pmc) {
 		if (data == pmc->eventsel)
 			return 0;
@@ -154,7 +262,11 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
-	pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS;
+	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE))
+		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS_CORE;
+	else
+		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS;
+
 	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << 48) - 1;
 	pmu->reserved_bits = 0xffffffff00200000ull;
 	/* not applicable to AMD; but clean them to prevent any fall out */
@@ -169,7 +281,7 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	int i;
 
-	for (i = 0; i < AMD64_NUM_COUNTERS ; i++) {
+	for (i = 0; i < AMD64_NUM_COUNTERS_CORE ; i++) {
 		pmu->gp_counters[i].type = KVM_PMC_GP;
 		pmu->gp_counters[i].vcpu = vcpu;
 		pmu->gp_counters[i].idx = i;
@@ -181,7 +293,7 @@ static void amd_pmu_reset(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	int i;
 
-	for (i = 0; i < AMD64_NUM_COUNTERS; i++) {
+	for (i = 0; i < AMD64_NUM_COUNTERS_CORE; i++) {
 		struct kvm_pmc *pmc = &pmu->gp_counters[i];
 
 		pmc_stop_counter(pmc);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c53298d..acfd395 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2451,6 +2451,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_DC_CFG:
 		msr_info->data = 0;
 		break;
+	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
 	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
 	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
 	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
-- 
2.7.4

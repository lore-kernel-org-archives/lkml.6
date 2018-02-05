Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeBET0P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:26:15 -0500
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com ([104.47.33.87]:43952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750935AbeBETZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:25:20 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@suse.de>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v5 2/3] x86/kvm: Add support for AMD Core Perf Extension in guest
Date: Mon,  5 Feb 2018 13:24:52 -0600
Message-Id: <68e34f77a4e35432cc2fcc8a35a3c2e16bface46.1517850303.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
References: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CO1PR15CA0095.namprd15.prod.outlook.com (10.175.177.15) To
 DM5PR12MB1370.namprd12.prod.outlook.com (10.168.238.21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30849b02-baa1-45f0-8361-08d56cce3127
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1370;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;3:/xwpQPPgAd+yrVg+Zz+faR0UBbkvdVQ01DzGBdvzZ/BciP4xU25lSysy1Hxpg46VqpQLS/EdoO9Q73ue8iVTeWsnestUN82JsshSTGoOjf8mAobWAbFj+yuBGRDj/BPI2EHbFQ6SvLI653GjIE3V/t1hH6cJbpd1n3f3bNyMLuBqhC9vAskVNefYWtNWsqsVVELiHOWfC0nKe8fEc6JKUemZdtnEcl4BYioK1Di95KbwCUNXG/X4pcwgL3SunVN1;25:SekhyKWtVps8CpbM/FSeTl/P8HfFECvzM3RsKHKlPX+wIlcb/jRZQ1fm8n+vYQ7xbKTRMMjRQt98EU9QYzt+Y1/tFV0ljvEAe0oD0DBXaKfKky5MS569Odgis2A9UrD7zMuAJsbRfqmwP92fItwzZfrrlg/+WYyn99+58ZWh6E2Q28Qm3+zyhQ9RdNAz0kVTuZD72IcwCwBCb8bPCgkAvCvivCoGw6wqcoxRByTSRqhl12Bcjoib+n+86hhKtJJ3zcIFvdGeuawZ+30a8wVKs8xHXT1oa02RrtAeSqWzPxALf2/924EX4JvoLLJsRJe6AsDmyd/iDgofPwWwtpL+Cw==;31:qcPjRTVlGfRhBNY0rp/SSqpwWx2Ky+KdwP3blnyZoE0HxHcWrMxkT9dR9ls7khclGlvbfkJU+owlfqlXvkMoQBYlMj9nK8bRzbziK+/DLkD3TG9JXj0i3yeIuPX/4lrWn5GkbybGpyVCJV+SIeWsiETeBmwzQ8XuAz69tTwxb0fVmW8uhay8glMXt8D5vRkk+7ThUAGGfqQGhOvZrcAkklLv0znfoZkoKOLGKLnjsho=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:hba8QdteiHY1aZQYTHJ9rBzQcwPO3GC26eeL6PGiylHw6aVPc6X3ejbk+4ABuoE18MFdd6UBWj1mcHm39+1bEGg2VJw6g+OthNGMXKlMCJ5Nve3YliJWMkAMSUgeWg5XEkt+uCsltVLOccJrcO4Drln7A72kYfi+Tx/wKezZ6669WyAcathe+mUAw+jD6MFqlITmeMV1ZorLmd5/eplnbni0oDJaoLMznE3reJ46So9Vk1f8s470Zp7kIM+dCos9cPPQ3WfW3v7MYF/lpO7D8/QlQHwnKhzfc1+77/oQa3DEnK5K4aaN2wavMfZGGCNG/lwzb+kmdfjAG+20nwL3XwgcvWGVUiCAHfdu3CTqe9mv/qQDh8o9pCdXP5fDJBSBVKeHUwppgoMf0Jakfm8v8dMpLZtuXxYWkICrVuZhIPh6ltvYWKSV7TcjQW1T9RM9wpgwobc34Y7CNtiblqfkEFtIoWFlmGDU820JJEvXsTRInyMYzTzJc7L4iBDwiCxZ;4:E0s48564rGmcbC5u1QGpAysGRjxslslJ00w/JWUGDPHS1f0F8KoUUSpZXeUyF689v4sPpHgPn4JvUs3Bz8l3NyUPDFP/MXjA6gEYJ5sbq08SckrIziea0qvMKC94l5Rc+zPAKso0PnEFPelwNyrRLYMBTeJWsZzuPwsBLL9iMNabAq3FBcPuCZTDqAx9pt/Fyz75TajYWE7TiFKPdH2zDkagI8CpmELzNTArmL2ofb+Lc7yI3M0rv91aeqkil0+wRhYQBPOVRNBIYTWZyvH5iq+zYMzaCHUymKuTSL+QcfZ1pgZWe1H0QdhRaYg8198V
X-Microsoft-Antispam-PRVS: <DM5PR12MB1370E5971B3EE8AF0D3102F0E7FE0@DM5PR12MB1370.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1370;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1370;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39380400002)(376002)(39860400002)(189003)(199004)(48376002)(68736007)(7416002)(7696005)(50226002)(5660300001)(52116002)(2950100002)(6486002)(6666003)(186003)(305945005)(47776003)(76176011)(66066001)(4326008)(81156014)(50466002)(8676002)(97736004)(53936002)(51416003)(105586002)(53416004)(81166006)(386003)(7736002)(8936002)(25786009)(72206003)(26005)(478600001)(118296001)(86362001)(106356001)(16586007)(54906003)(6116002)(3846002)(316002)(36756003)(16526019)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1370;H:gi-joe.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1370;23:DyfCJ9sWShy5wuBaUBRgV+8Rg5zJJyfSitvmOatXt?=
 =?us-ascii?Q?mP2vmTwjzx+lwSyDRPrHQAxwzh27R2uAFldXTnHGoeZsbjsY/B1iQY99KbGm?=
 =?us-ascii?Q?5xO/YIO1AfUieqAK8+HzhENadBIen9M1adQjnZ4g0fGAhoLLp6oyNaGaCQ/E?=
 =?us-ascii?Q?A2LYC2UJ1t4XTvWmqW+nblUKvubD/Dv2oB/Zlvs0xomzv1enGHOwgZiSskaI?=
 =?us-ascii?Q?8VhKSLuVsu7lbmfCqxcmWKqBKkRDpeSJCwaIVosU0DuClV2TZbpesmJ64N6E?=
 =?us-ascii?Q?UHekAWPyhQIAml/I9ZZ6b522GxyJX3WeVM2EGEO3hSHojvnpoXtaGwEH0pea?=
 =?us-ascii?Q?jaA0z5XjuBNgEPtG8W9+C5XReBxivWvRwF3lOhw0NuNqZTJEcIPz+7fBafUj?=
 =?us-ascii?Q?2+2AQ50DLpam4Vq61KELL+KYF1vDKg4Z9qFvlfM38DySnRvWw8MOY2UqG7dY?=
 =?us-ascii?Q?TDfWVgkOFb/edG8Ap/GB70duYlLUuM6lHIj/2UgOoHft0qTkHehv5DeYtBam?=
 =?us-ascii?Q?VAfuxRPyJdf3ILjJpyB24gQ/xCjNvsfsSQHdxHtbhPbLA/2LALanH3Su2otS?=
 =?us-ascii?Q?hiPxrplZ/ZfeqcOqfyd6UIW1p0JPWoSBmWJ0VWbM5QJg+hvY1yqIPINEdbe6?=
 =?us-ascii?Q?jkopsCLZVBIzGANv/jhoqmiFI6LUHcojhRorQM5TzkFhr68GVHq/ctxUFikT?=
 =?us-ascii?Q?aBDYFm71fdVOxvC+RCpHvUlKV5REETDd0S6w3gUM3xBLrKiyCjzP8WkyH6Wm?=
 =?us-ascii?Q?kWNzhhn8Sy5WJ0gdjSchiTNIpQJxoNATp1MJWsANM15TztBKwJNTSxBr60tc?=
 =?us-ascii?Q?VdCw3Za+vMRjf86PTRCVM6ve2/yz//6aksCzJaq146GU+gubBZYr8gPcAkkv?=
 =?us-ascii?Q?vyJcSf6OtBK095LpeZlrdSdoCfj8PuUYXai68+kLinRUocPKtEz4nBgigaGD?=
 =?us-ascii?Q?93P+XD7HQV/1+w9+YqZiMWAGcOsxS3I1Dugqz0V7iveDoU7L8VqnAtSGl0hb?=
 =?us-ascii?Q?J0kS5WnXmisDz42bpoN2KmAOqkS1WsPZEf/CPTMiq23a4rXGWGMsgCfNEf5L?=
 =?us-ascii?Q?nRpgBYGek+BliUtI/fhUlJA7YMZcr3NSyR7DesR8p+1he++eQs0XnSVV1Oyj?=
 =?us-ascii?Q?SzSw7NwEbOghDUZtLZe4vYwTOV6cnTexdcFp3OdGI1A58Yt1IPX9w=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;6:6lc9pFxGZ/NQ88YNys+JVKifCfWFPOJuY5bx+5gtuOTtl273y3ISL23Vr17U6b67OQtZw0Y2DvAY8JKpdqw+FcIyGM7K/UFokAiGQjHEvfL2Px2iG6bWCDTNLENRULMlpTym6FFdMkqGLUD8wfuKo+JFAUQj9f1FM8nZlPYGnn3ZsbaXlhtcJBMDwZRVmuOSv0Rw0OLzmyrI1z8NTmY5KMNP+kbPgqQ9Tzkr/6Fc/dA+786eZoaXR32at1ib3fIWKgb6kI1mtodmLs31x6DJOffFKiw4oQh23awguZN+B6JHXLfNHrfjzXJvTaYLSkDfaItkX+h4+4yrOOYSQQIkfl9OzNy1KRADQzUyTkdbG5o=;5:F1R3brN5haTMHqsWvtUqsKjcguWtcFp/WZJuioX1SdCrM7kOci2FC4Wqzef6f+C+App/b+ZhGwgy+J6ImxphVtbUelDBVRvlzS95GzK2Lw3eRxAv8rQT5Rywbfoa6EaPVpQ8fps8WX68Q9Hu057/tVzJnOm9XdnQaxleNi5ozYk=;24:r/rf5hY1gA3301Ui6CHbwVebReRfbPKrD9Lyf/7P/XpcylxjXVzG3WyBws6iIUhzCN1jA7y+S4tCL5sQylenpEDOX4kWJQaYeryvmb+6Uf0=;7:gpnE576QsCdRVg7bWhGYwsOAdCkdIhcAXrCmKgKmkFt+R9o1NLfQPsEizP2sh8mrmVPqMm0sKxtMDUA7bTBVcrSjSfZ9DGXZKq7DZ0d9bX9bja4QTcZcpgqPsVSDe1bCEytMCeuBzCBSJZMXJjmfG04798zbhD52DHcrmVhF/cn0GEzBxC87goN0QbMZPUHXoRJ0y9IhfAYE9J4LzS4/SRo3vbcX56dhpGUlJaWj8SpRsyOLrYOihHPy01Lcqd2c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:v1Y83Q99EFJYE3jY1AwJqAe/NT+Wo4HWze0/zsHqBtPetc3wtHR5lHMsYYoFxtkjFy1Qf6jBDqRZcmystDqwj5wqUjle1bpIoZn5ZHPJgVDov1jFH4MouHmNI3+TS8haIQIkR0fjIjiCq/8igHB/JvjUu8OT/wkvLYS1OZSvsDD76Hjg+IR2UuArHQ0sIieD5+BUnE1FTwiHFCD0dB1yOtoyZQ6NdthKsaND4g5d4ibi5ccOvZWiyPUsmjSekVOz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 19:25:17.2310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30849b02-baa1-45f0-8361-08d56cce3127
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
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

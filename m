Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeBHW7A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:59:00 -0500
Received: from mail-bn3nam01on0081.outbound.protection.outlook.com ([104.47.33.81]:51584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752372AbeBHW6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:58:54 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH 1/2] KVM: x86: Add a framework for supporting MSR-based
 features
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Date: Thu, 08 Feb 2018 16:58:46 -0600
Message-ID: <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:405:4c::21) To CY4PR12MB1144.namprd12.prod.outlook.com
 (2603:10b6:903:38::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64a24e69-72f3-4392-4303-08d56f47855a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1144;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;3:a0F0lKmcX7kI+cL/JRynsMeLZl7heTksXTTu+R+n+xPjHKIu47Tbw+4YZ0NNM3AoNT9oqLMEaYweuAMldaqAhU4hES5xb1Qi2LSyMlL8BmFQ6vADNYrYiRbvhYPPAN/FIUDGL2DllrPQHEzekKtvjMHcFxWWK7MVcnLYs+MzHv20r0+Hc6VCGF0GQH9J1nsSjV9/tp6FYG0mSvaFWY0lSXvv+ImMYNC02KBmoRmw1pnryVAPxXf3NlOjsTdvLmi5;25:tKOh06W1zWJWEM7xV+EYvbQ7st7Cwo5mhCr73+cl0vZLn7jZy+Vu+cGGdbhWjPqHjj6jEN7Ci+BUV0Wzevoo/N3wC/aK2nnUHdq1k9E+h7LpQ7UVAV0b6kgpx0LQdnAeekZn4HcM64P3DbTGVF4iuOrXJpC7C3iOb4zaf52HeyffthOUP9byG55pMgWQQuiSy6VNf2GpWEVYbW2tZwfz/rzgicSt+A0jxdQMkyXRmT3CDUJKVB0Vi1P0aXVbae/PrwhEhFAGxXe3eSjU+Y3lI4wUKr9BZr2Zv7tqYDnYBnRytQ3LnY5AHf9pr2RvfldY9Zx3PoAU8U5/GzOA6Ht0hA==;31:au9MXIJtjEkiWtzmxDnYUXzYDi/7ZxuyYd55LXEFZZ/ZbBTE/6mxwXX7ohASoL4GXKJiQecQqTM5DCW9bS2s2omNkHBlBR7Dm0NHGj8wnmQ/Ld0WJDEQnkxMHUl7E5AQlJw8onijPB+XLV/BBUk2qlKU5++J5O+Y9FlshnIU48d7jYJiv0DzMVc1QJBq9WkKFRgQ22yKnfm0wIu93o3aiv86HJbGMHPPlTmqawW4PU4=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1144:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:TMh8NEyN8U9kUDX+qomUQ3NYaAsNw7VrXnkTszXRdm2MTmbh9dSr3mEJHuBcUU+UFL+2+mAe3YiSh7VwnZ7biBkUZsUc5RjnJTUSs+r1W7HyefJOG+1e9SGgBf2FZQTetwo/BfR/Yu9vrSC6seJPaRyJZ10ruybJ1Ros/U4Cnc30aWiKYsGhQESQ7yklL8OlVHJZ26b0hHnlsO7e8sCAww8GP1njwAz74N48g3lyTkcRyOl/w9ADx+WpaspvBHdDlEzyte7zCOP/1c7Mlfd5HxzNOTGBoWBvdBnqEbbE7oDqW0uLf6VUKd0VEtuU1GPkb20jGk/gVURFfVqV4p+mmQMIhQovR250mKV76m9ejc66F+1saAc1H6aqhPcl0apnxyxS3R6zR2oPUfTdY66ZP6auDrgr8uQgSo3IwA9uK0UIyWfx4CDMpAqOUDVYS/EokzdUkjIeaDphBTnNK05gC+09VqOhM7OG2uKO7ErUJ3b2oQ6b1ce6/JFk1Ge7nAD3;4:0e89lsCO+JlFmwqviAI8Ee1XBka+ftyAvPWo6cmXMbxPKAj/rzywqKMLPmxhNh/ofAUIYmjPDbIAxFEJTk/qK7zku7DwRZkP0WN/+jbn1HZKX1Umqkn6Bt5kFaVUy47ySDDplmrHVgpgmQdgcjK1DFPsP1zo0PrTRznfMvsTyRnLWWmGJX9ChETgrt/jRsyDmi0q1gGQ97H2XC/NVzw4Pw8y9Ra4Ac9NHs6tyqSJfK5SM7LOkHoBcEYX6PMVQK/MW/tDX82QvPIfMzBy5NktYOHrdafbjADRpPQUU7lmSuGPbA2BXJJBIp5cH5q8YMOk
X-Microsoft-Antispam-PRVS: <CY4PR12MB114484AA16019F0C2B0EEB1FECF30@CY4PR12MB1144.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1144;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1144;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(199004)(189003)(52116002)(7736002)(6116002)(97746001)(69596002)(2906002)(4326008)(55016002)(83506002)(25786009)(7696005)(305945005)(9686003)(72206003)(53936002)(478600001)(76176011)(3846002)(1076002)(86362001)(105586002)(106356001)(23676004)(316002)(97736004)(2486003)(81156014)(230700001)(2950100002)(6666003)(68736007)(50466002)(81166006)(66066001)(47776003)(8936002)(103116003)(16526019)(8676002)(186003)(386003)(26005)(5660300001)(6506007)(58126008)(59450400001)(54906003)(575784001)(53416004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1144;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQ0OzIzOmE5dE1IQWk0ZWxLWW9ES1FBcFpVQUptd3ox?=
 =?utf-8?B?RmZjZGt4czhRTDlnclg3UmsrWjlDUmRBditoSFRuZzVDZXlmNEd6TXdvMUhw?=
 =?utf-8?B?bVlhK01ZTnpFQWhyOXI2UXk2dm91eXFoMlFnY2JVSDJmU1ZjdS9pbkozNHhk?=
 =?utf-8?B?R3d4L2ZaSTR4ZUxObHlTQzZuYzYyM04xU0p2dkhiS0QyUkdCcDc1V1BIQjVi?=
 =?utf-8?B?VlRDWE9VdTMwYXhpY29CTWJ6bVNDa0JzNW5FVDZVWk9xT2J4UERVcjNVcWU0?=
 =?utf-8?B?TlNjVG9nMTRyQi93R2JPc1VQSThZSzkzb2g5Z3djMFdXT3o0YlZoWmtteGEv?=
 =?utf-8?B?eUx6Z0puRFBxcHRNbElJdGJIZWlKOGdCVk0zUy9hV1VSSjJlVi9SdUU2US9r?=
 =?utf-8?B?NjhPV0w4QmdRcFp0UElhR2JxL0gwV2MzVTJaTkVieG9QY2FxNlM3cGpaNUps?=
 =?utf-8?B?d3c0MHZldGd6dWhueFUvc2daZ01NaTR6Yjd0aU5BdXI4NXRrNTY0MTZvWURL?=
 =?utf-8?B?MHNraUd1czFFU2hQcHkzSUlwYkdkdUtMeGw5THRWZ3I1blJPMHBvbE05Y2Nh?=
 =?utf-8?B?L2ZTcUF2MUxvOTZnbVpSZzJoelVYSVJWcHQzM215VEcwdUJiWkRoaFB5NGJU?=
 =?utf-8?B?VjBQYllEMTVlRkdJdDJwT1FPR0R1OXA5Q0dRaFloVGVXckl1K2dLdk1vSFRt?=
 =?utf-8?B?MjU2WXJmOFlGb3prd0hkeFpqWUZpOFNubSttdDJma3cyQVoxRFNQRHRwZ1N1?=
 =?utf-8?B?TmphTmNFWXFPMzdLMUhoZFd4MGYyMXJYbVZTSXlSME1LdXFqYVk1TTBpM3Ni?=
 =?utf-8?B?djdRM0lmWnN1ajJLeldBMmlnKzBGR3ZBc2hRSDlJS3hVeExoenNIQWY4M0U1?=
 =?utf-8?B?Qm12YlpOUVY5NGlNeWk4cFp3aXRKWjZwUzR2MmRPTzlIN1lNbEo2RDRVNmlY?=
 =?utf-8?B?aHpBQVJvMWRKdkNiOXlHR1ZMclhFa1VmNFlLKzY2RXhtYmdXcSs0YVljUlhD?=
 =?utf-8?B?WVpWRVdqZi9rKzV1cEdma0hNcTAyVXpabHplNlJHTStIQlMybVYxdFBWR1cz?=
 =?utf-8?B?Z0JZbXRoKzZKK0xpcTVHTjR0ZVcxcWJ4N0tDUm9VWDdQVXJmUElBMFUvT25T?=
 =?utf-8?B?S1pFNG5RZ1VhYVZFWWlqUGhZcFM4WDZTS3FQbURHZ05vY21qa3R5ZFZrOVRB?=
 =?utf-8?B?bGoxZ1dUR0dzbUt6MStKb2piZCtUUU9pc1JUYWFLTlBadS9NUmpHRmVDNlhl?=
 =?utf-8?B?ZWJJb2lGZVIydndYTU5Bc2NWUEIxWThVR2c0TG9DcHZjQTJCeVlydlZ6TFVY?=
 =?utf-8?B?dWx6R1R2MFpRdmpYSGYvc2ZCcEozK1hrb0MwMXhHeTFWRDZBdFJSRlFOVy9w?=
 =?utf-8?B?bzgxd1hHakNLZHVCNVI2aW1zSGtuUzc2Wm9oaHZzSE04dWhCQkVkc3RXb05S?=
 =?utf-8?B?dWhVbE9KSVA2dDRNSkF0aHI3ZU9GWWZYamEvcWtTdUVENVllYmdta0VJRVZp?=
 =?utf-8?B?N0l2cnp0RmVtRTlNRi90YlhuNGZDQnl1VjZMV2taVTh1L0FMeHVidlBVbTh1?=
 =?utf-8?B?anhtYURTdnV2RVczc29tWk13eTY0V3pJS3B3YVVrZlZFN0ZYNUtnMUNNa054?=
 =?utf-8?B?U3NVbFFjeXZUNm9sVHlaRW5XaHR6SFFIelF6M0NZWFVtbnVlVUkrUk9PSGtk?=
 =?utf-8?B?WVdUcnFYeTAxTDFtaHd6QjlLMjd3ZTBweTdFam80TFkyRS96bGd3ZldNbG1Y?=
 =?utf-8?Q?iWU/7Fv90P4+fKzPbnYuhcSLlZbQ7+OBkPxpE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;6:AR7O3FWe8GvJzu3U5aJLnVQ8wYTatN3EvKTYhRvppY0nbWr4yzkW1bg0ESdv57VwP8rWWzVuXiXN11YsTiN/lvdFxLCS97npb/bk2RDdxvKTJ93NnPGzeQRuQDb2ft+ZMDPguBqsxbIXVOAEQ6ULbbAwSG1U08y1qSOxgJt0YnIAPI930Iblu9Pgcxb24gnXORh6rTEKlcVnzBG50gp238zEhvUO5WQ5HBRplKt3lgdVnDJWmSw9sIPwqbJHhDxK0Ap99Fi8A/9RlvQz7IdqDgiEYeAdzCrBH0w9nPMfaDsS/FlCRwfwkEpUevKHmUCQ9nKyTeXp6kOKAlGnPCAya5wH5DuimP2BGK33ub3TSng=;5:jwhdU6Lza8np3Id6kgwQQ+gwpoTsxyBZ2ivUfCPXLFDl6xTSE/wiSHGcOw9E+6pGY+Fz9H4r758jtKqjl8B0E2hF8Y6uMDBzZlpOz7SUm7AEI56T3ioFkWKl03RtYUrULDL814xEd2KPvtPxzLoe2EKrLmQKbRzsTiD+Q8KSxLc=;24:ieIHD2BZ73P6yiAsQZLnzhzFVoYPA1iiXAAqFdKdWXfiCiyLQkRGdwjoEDITR011ZYwQI/rOv5bKNFmipIcSoiaozckhBNOprylg5AxyrxI=;7:dSlaC+4gZgcC1Rsgf5BIx8TZMFti92hyu6i6LSITKkgHK51/L4dMJbOrcE8MQKslHyNnR3IbUeZ2hnaplXhHL04oNmxGX1k2KsJdBoI/nmSLvcX182fi9dZBxiRCphoiW66EegftXn7geJozzlq/N8ExZUVNBH2MCqZ9mA4PjnxP3ljMQ8f6S/KiLpxpz2VTFqCeTdlZ/hsMcoz5UxlA290rFnYPITatAKXPnC5i8SAfj0giVdMZ3v4fR+Ui81nl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1144;20:MaeVDIIBdTMwQ975H3ysKWqazeCorXGbriZsDdLI3ipywS90frnOCXzDmCp/SbpClj/R7EAdI30q14YmKm44dCJhuh/cB/6VxCRg89WCEPTB2eBaE90mMkW6v3WVMtryv7XznY2lxL3Wst5zQzcBWh4eSMnm2ZqpB9LFyxLwLmMhKLPv/YGJ+oJqvV+9EO0hF7YGkbJW6ap2+PEiMPMcj6U+g4TGJKRalwfN2Lni/ds4MKDVwx8/a1l5R3mL4Y0p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 22:58:50.3283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a24e69-72f3-4392-4303-08d56f47855a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a new KVM capability that allows bits within MSRs to be recognized
as features.  Two new ioctls are added to the VM ioctl routine to retrieve
the list of these MSRs and their values. The MSR features can optionally
be exposed based on a CPU and/or a CPU feature.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/kvm_host.h |    1 
 arch/x86/kvm/x86.c              |  108 ++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h        |    1 
 3 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dd6f57a..5568d0d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1198,6 +1198,7 @@ static inline int emulate_instruction(struct kvm_vcpu *vcpu,
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
 int kvm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
+bool kvm_valid_msr_feature(u32 msr, u64 mask);
 
 struct x86_emulate_ctxt;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 07d1c7f..4251c34 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -69,6 +69,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
+#include <asm/cpu_device_id.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -1048,6 +1049,41 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
 
 static unsigned num_emulated_msrs;
 
+/*
+ * List of msr numbers which are used to expose MSR-based features that
+ * can be used by QEMU to validate requested CPU features.
+ */
+struct kvm_msr_based_features {
+	u32 msr;			/* MSR to query */
+	u64 mask;			/* MSR mask */
+	const struct x86_cpu_id *match;	/* Match criteria */
+	u64 value;			/* MSR value */
+};
+
+static struct kvm_msr_based_features msr_based_features[] = {
+	{}
+};
+
+static unsigned int num_msr_based_features;
+
+bool kvm_valid_msr_feature(u32 msr, u64 data)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_msr_based_features; i++) {
+		struct kvm_msr_based_features *m = msr_based_features + i;
+
+		if (msr != m->msr)
+			continue;
+
+		/* Make sure not trying to change unsupported bits */
+		return (data & ~m->mask) ? false : true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(kvm_valid_msr_feature);
+
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	if (efer & efer_reserved_bits)
@@ -1156,6 +1192,20 @@ static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 	return kvm_set_msr(vcpu, &msr);
 }
 
+static int do_get_msr_features(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_msr_based_features; i++) {
+		if (msr_based_features[i].msr == index) {
+			*data = msr_based_features[i].value;
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
 #ifdef CONFIG_X86_64
 struct pvclock_gtod_data {
 	seqcount_t	seq;
@@ -2681,11 +2731,15 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
 {
 	int i, idx;
 
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	if (vcpu)
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
+
 	for (i = 0; i < msrs->nmsrs; ++i)
 		if (do_msr(vcpu, entries[i].index, &entries[i].data))
 			break;
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	if (vcpu)
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
 	return i;
 }
@@ -2784,6 +2838,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SET_BOOT_CPU_ID:
  	case KVM_CAP_SPLIT_IRQCHIP:
 	case KVM_CAP_IMMEDIATE_EXIT:
+	case KVM_CAP_GET_MSR_FEATURES:
 		r = 1;
 		break;
 	case KVM_CAP_ADJUST_CLOCK:
@@ -4408,6 +4463,36 @@ long kvm_arch_vm_ioctl(struct file *filp,
 			r = kvm_x86_ops->mem_enc_unreg_region(kvm, &region);
 		break;
 	}
+	case KVM_GET_MSR_INDEX_LIST: {
+		u32 feature_msrs[ARRAY_SIZE(msr_based_features)];
+		struct kvm_msr_list __user *user_msr_list = argp;
+		struct kvm_msr_list msr_list;
+		unsigned int i, n;
+
+		r = -EFAULT;
+		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
+			goto out;
+		n = msr_list.nmsrs;
+		msr_list.nmsrs = num_msr_based_features;
+		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
+			goto out;
+		r = -E2BIG;
+		if (n < msr_list.nmsrs)
+			goto out;
+
+		for (i = 0; i < num_msr_based_features; i++)
+			feature_msrs[i] = msr_based_features[i].msr;
+
+		r = -EFAULT;
+		if (copy_to_user(user_msr_list->indices, &feature_msrs,
+				 num_msr_based_features * sizeof(u32)))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_CAP_GET_MSR_FEATURES:
+		r = msr_io(NULL, argp, do_get_msr_features, 1);
+		break;
 	default:
 		r = -ENOTTY;
 	}
@@ -4462,6 +4547,25 @@ static void kvm_init_msr_list(void)
 		j++;
 	}
 	num_emulated_msrs = j;
+
+	for (i = j = 0; ; i++) {
+		struct kvm_msr_based_features *m = msr_based_features + i;
+
+		if (!m->msr)
+			break;
+
+		if (!x86_match_cpu(m->match))
+			continue;
+
+		rdmsrl_safe(m->msr, &m->value);
+		m->value &= m->mask;
+
+		if (j < i)
+			msr_based_features[j] = msr_based_features[i];
+
+		j++;
+	}
+	num_msr_based_features = j;
 }
 
 static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 0fb5ef9..429784c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -934,6 +934,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_AIS_MIGRATION 150
 #define KVM_CAP_PPC_GET_CPU_CHAR 151
 #define KVM_CAP_S390_BPB 152
+#define KVM_CAP_GET_MSR_FEATURES 153
 
 #ifdef KVM_CAP_IRQ_ROUTING
 

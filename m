Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeBUTkM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:40:12 -0500
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:60416
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751683AbeBUTkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:40:09 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 2/2] KVM: SVM: Add MSR-based feature support for
 serializing LFENCE
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Date: Wed, 21 Feb 2018 13:40:01 -0600
Message-ID: <20180221194001.12005.93534.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
References: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CO1PR15CA0109.namprd15.prod.outlook.com
 (2603:10b6:101:21::29) To CY4PR12MB1143.namprd12.prod.outlook.com
 (2603:10b6:903:38::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e03b062c-1bc2-4c1e-0c01-08d57962e874
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1143;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;3:uzEmsolysy7TehX1UUhdXlsq12sVd3nEaho+/q5K+dnRbRcQ81V7EPXGQdP2zWVECcp1Ag/7GVWJUPxqVyKRBbhX1mqWXICCk2eB5g3AvSucuo7QKx/5uREWEpY0tGSTNrHnD64s1Xsnt9J1AOG4M6dnKUgd7djhLVkTNyluvF0txpuZkBYbMW4+pLL01SUhte7972bP9/czJ8WBwglrVxTFjkaHCPbxwCmVDSX7fkC4umZNq3py9LVfoneft2M/;25:13AvFL4excwqWPAyygI1FpHyUcDtUFn3PAJkSINozElLIKm268y8oNMEPV0Y60YRqjwNb25F3rchUjuNokwCd93s/CaeTlM45auGzsz/nxaqsxMuVqFNs27zBcnYslzG7vc0Aqac3xbI53U+RyxUvOAkTWZSTKsSYCJk/NUvOvoNmKU1u7E5qXfpsCqxrA8/gDW8Py0rrQ/Uby1Gc8O7r59Ziv863GCCfr1gwtAKUcABwi0wd8jKdhSAH0V0NxX7iviBjOCVmDblXRkTGi+41jutY8IT+y6ZTuACEORdLzUc1u/Apd3zMUj8lswIvtaXMMINtC3u7YYwaPMaaB4yng==;31:hLAJvqODqe4jz36ij8R4yF0jivDm5kN1BiJcfNG0xR8D3OSyTgkj1Q7/goVZwsoj9WFBnW/wmrMVKUjlR08tlEdn1VwCeMZCBO+fNJVoKOLq2b/5no482d8tsMAUMTSNwf2KpB06uICL2x5Zt/yMzAtjR/zmxcYC8oN5/1jbtwzBr2KAq2c1B3GtBmKzPgRX3jKAmdK3HsEyUqI19+C6q5zXFQH+cCospw+pYcjrSKc=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:Dh2Oe5LlzOGMDNlQ9Ou1PBu4BqWe5Lde7QGnosdyYpraMmEhlxnJ/rmuFP1HHAi9v4YrVIDtB3MSgQctwu0wthlXy+6lteHmBGXB1katUFywI3FjHyOrnVWdUMXDfRbduJ4OsCWi5N0ZCsnTA/O5ohWlfR4MU3abAAVYLwUg1XATNQUJYFvDP/JUNnKMBWjrgLYch//YPgcHRbTEZRALdjXxZ8EEVCyLJVV6XZDneSHT7Ix0oBiNaZbsL4h7SHbcwt5RH/Q89iZIwV36i4g8tCu4eXp2QxBtUFzZ+v3ZrsVSsoSFhDYlrH7IiksHq1ZmGcEhPr3QdSKVX9Mn+6xxYF7/cNZJMlMrrJHJ0DXNMrnPYuJohnAWf3FFEaslY082JZhdbUUtVIJlpA/n24s4zdFijgiWhnkqUeNK0FAsfpOJDW3EufAoBA8wH7m7reJFzBxUEW5yu8UYa6cVNAdcy3yIm0vknwVBPe4dAQm+CWWBHSXoNdpfD9YEmbsudaoi;4:VdsoDpAGXQmhxadC9PpyttCvvVBq0CGmXLRFCH/Jm5P2KetGNeOsX0j3TS+Ip6U7CZOTc4dqvOF/gYP7aM8UgkmLX0sTVwbSTf0SpwAdP6aYBp9+v/fJpgihfpluzFTceQjO3lypYdgiSg2jLNzesbWFqzgR75Pp8fD0kHy6/r9sIJ9veAcO2hCHTvLDa8MS/9wb3WJnkKRJSlvuRReJFRyGPJSBDBpTBFKXOzwrT3h9/hCPigCG0m2qRl6vOyDcLibO94mflEC6rtcuFCw0b+E2MDTEQvyfj26/1GKObCdzvzt4gLvtc7F9+F8eIfkE
X-Microsoft-Antispam-PRVS: <CY4PR12MB11437EA4CD2245C2E673F3C1ECCE0@CY4PR12MB1143.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001070)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6055026)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1143;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(366004)(376002)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(2950100002)(7736002)(478600001)(53936002)(7696005)(72206003)(69596002)(25786009)(52116002)(305945005)(47776003)(97736004)(103116003)(50466002)(4326008)(9686003)(316002)(6506007)(76176011)(386003)(59450400001)(26005)(66066001)(2486003)(6666003)(230700001)(55016002)(23676004)(106356001)(54906003)(8936002)(68736007)(2906002)(105586002)(16526019)(186003)(5660300001)(81156014)(81166006)(86362001)(3846002)(97746001)(53416004)(58126008)(8676002)(1076002)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1143;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQzOzIzOnBndXZTWkowdXprVThwbjJmWHlhTjJJSlJh?=
 =?utf-8?B?SjYzMVZGUEZhK2YzVDBzUmx0aStqMlZlZHBkKzhuVjBWZGVUdlJ6SU1pdHgx?=
 =?utf-8?B?YUFwbEFUSjBSRWFlZ2lUYTYyT1dGSFZHL1NzNDRmeHVrQzhud0NYayttTkJX?=
 =?utf-8?B?dk03WlNMc21lY2ZjTHlJdTBMYlNGUTZiQzBaa250OSs4djdUbTVySjBRY1NP?=
 =?utf-8?B?aHVXVWlrajc1VDVmeVg1RE5FTVQwVXcwRi9lQU9vc3dhYWU5dnVpckl6eXU3?=
 =?utf-8?B?bmwvSkdCNG55UHh2Vy85MFZWbWZzTDh3NGR5YnlrVUhONXlwUURXRmNDRkNM?=
 =?utf-8?B?MEh1TzVCZURLUEhOajZmakd4dTNNU3l4aTNra0MvREpudEk4bEZYYXFzY1Zk?=
 =?utf-8?B?cFZLUlRIUExhUVBQSU83azB6VGRsR1JYallndGdScUUzSGVZRDBTK3drdEo0?=
 =?utf-8?B?WmVkSXFHV3MzaEtodmdPWnFYL2VEVjNyaTV0NTgwNkZpQ3ZET1UvZ1F3TEdQ?=
 =?utf-8?B?eEw1c2NhWjhvNGcyTlBmSDdxRDVoM1pUOHpFajFCek5rWUlXQWFWYlhxb1ZM?=
 =?utf-8?B?eU1CZW1wS25QQ05PZ1VTR0JWRXN5U0xHQzM5OXBxTithSFdqRUg5bXJSUngv?=
 =?utf-8?B?aHJTMDQ3N0s3WmhFSU53ZkpMYnBSQitDaEowMnZUZFFnek5Mclloanl2M2Zz?=
 =?utf-8?B?TlM1dUpwdm91REowaW9SbTJJYklraHVFN3lxNTV6UU43MXpSaG13NXBmSzZG?=
 =?utf-8?B?ekJVMU5UbHY5d1FoaVdUbzZCQWhwZlQzd0grUkh2VGVSZEJvL0FtOG84SHpG?=
 =?utf-8?B?TURmMFk5bkN3WmF2S0N6QVBKZUIzeSs1M1EzRmdaY1l2b2gySzM5Smt1WE1H?=
 =?utf-8?B?K2RUOS9nTnFJUEtHS0lqNzVQcExhK1pjb0o1d3BJQ0N3dU1GRDR3bEVndDNs?=
 =?utf-8?B?ZmRpYmVRQm5QL1hkcDZwU3hmN3hmNllhTUVmbUxuL3FBUFlGNnZva2VmMU5p?=
 =?utf-8?B?Q3hybUxLM3l4MWNjOVdzZmE4MlZPTzdyZWpocWRuNGhhNE15N0tZcE9iby82?=
 =?utf-8?B?K3RoM2dxRnVjRldjb213a1pCYVV0V3JFVVdKUUhpRDRwVU0vT1pLVEtnaGFG?=
 =?utf-8?B?TGhDTUU1OGIxWFVtN3VJQ1BYemkrQjlmSUZNampBckFBai9jOURlZFJXUHR5?=
 =?utf-8?B?dDh5ZDBKam5peGVzQWd6c0I2NEdzMzNvYnBmWDhqc1liTlFtWFFjZDBqM29G?=
 =?utf-8?B?Z09UZWdBSG0xWklMVkZKVG92NldDaWRlbDl5WThXQlY1M3E3MmEzYVJtWkxF?=
 =?utf-8?B?NS9WWnNyTVVxd0tLTlVzQnc0bS9iNnA0RXlqTFpUWGVvblpleDFoejIrSVBF?=
 =?utf-8?B?TGRZMFg0RDRRM2RUT3F1b0dtMTVlK3pXNXBsMnNKbmphRnlIdkIxRksySWtV?=
 =?utf-8?B?R1pJWFNlbDlVcmc4dUZWcW5ORmE3REhFSWVZQ1ZKNFRyaFVVVDhrNjN2REZQ?=
 =?utf-8?B?SW96VmUrWTZBZmorWEJXM1ZuZ3BVL1JCYTExdGJ3SWJld0xCNC96K0xURHJU?=
 =?utf-8?B?WVRkakJrYStxL0pZQ2V0N2pNdDdmVVpDR2wyZm5ucGtYeWE3NEgxNEF0ZU5a?=
 =?utf-8?B?RUNWM1FweGdJdkpDYUhtVThtTkpRTTR0Y1oxdDBTQmM4TDdsLzNuVnBXUVBB?=
 =?utf-8?B?RGlXOXZZMHpkSjl2ZHF6RVJUbHQ5MzhkUDM4MS9TcjRUWkNtQjBUQm9sL2JD?=
 =?utf-8?B?bnV0cHptWml0UXg4L0pMQk4vbjNNQVNhQU1LZzZBVk9Xc3ZXNnNmSzhmVjd0?=
 =?utf-8?B?SXdENEhmc0RneFVucmxIUmxJaU45TjNWYWZMaUdraXREMUE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;6:MjNqs0nWtK6IOUkE7ZU8mk5ZmWvBw4h0oOJ7S4Nn9qBgKJ3bMyzFtZSUSk1gFqo5RU2s+zcRJ7rnBU278mM72hB6Tw0g+3rc2e0NWwAjDnfNU4woIo2MQCHZCWwg+WmCoMM8vhEA2VwRpIzg3Lwp7k9sNK+NPIUUlDH5+MRgnKhNaTPKicSes4ZfifoOaqxlFGqbwjnrgoWcntXg/SeZHhEAcLP15+teAXuqcmq8/Rhlxc8L5VcDV3oXqrfYpSlS9fO1k1lgAjKGxIC0i9+mcgIHrLXheT/HzLHErWX4pKAu86copCfeCB/KmsQjgYGlkEgDfmpwqfdbIN3pwuCXADahBaRQhIqjsFmAxZ42vu4=;5:lVb0Dm6aBkRzvqrz0QrfefO2X7ji72EYil8Iw8A1+9dwUabctZ8F4b22ckGRfFgw2BFtXmgCIge297KGbuBkVrKfrwYjLJ/cZetoUDZ7Y1Yfyg14j4Y42zgSH4m1ju9HKuDkTdmnDBCYGWG6nhcpLlkwyeiu9p/X5jZWIH4VCME=;24:rtbdDzwAgMFuiAZjyenvq4wTGlczQaDHaU/ZrF/oXKdB7a9neHsm1KjhLXqjqj2vi6ZFo41PAAyYHzkzadYOpbGwIrg9a2dvsYiTL645O9Y=;7:sL/y/IkgdqOs+y4BG2aymc2KEu+mWAcf2DD3J19mDjfgSklsoERiI8ZErvgjI3qOS4ixEL1UgCROnXUoE/EFs0+v6PR9/85O+PBFagXvou+qHKam/9U8/now8ElpXaFJc0WBlGgPpneovm5ZPOtyd58FScCNLb7pPBcJ6HzcXxIuNJfyfqjXqA3bWpSrozwvnqTiD4SQ3Il41zE0TGxybiIzrBlkwX/p2JwrkE+kjuASmO46qgWx+P9YCzspQ8pS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:GJmfxJqzH2tzYmznamfS3HvtCNGVZobIDscTJHY5JMiMAxx1aBR23yCcHnKCuMMDJysGi46UW4mAUGtiVw7k1gFYNjIOdIp/XrdXmM7Q0H2rZQiyIlMDhe0U3/jg0AncHU7FAMIn0hK6yPdP3CeN+05kCp9EXnmsZJpFTGwFznt4pJG0HxneNhTC23iP6b8rKlI1kDuPDSkW012l82QREGm9YoUtO7p/sE/2zezPrzhNI/YYsKZh2PUrq3pQytAN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 19:40:04.8343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03b062c-1bc2-4c1e-0c01-08d57962e874
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to determine if LFENCE is a serializing instruction on AMD
processors, MSR 0xc0011029 (MSR_F10H_DECFG) must be read and the state
of bit 1 checked.  This patch will add support to allow a guest to
properly make this determination.

Add the MSR feature callback operation to svm.c and add MSR 0xc0011029
to the list of MSR-based features.  If LFENCE is serializing, then the
feature is supported, allowing the hypervisor to set the value of the
MSR that guest will see.  Support is also added to write (hypervisor only)
and read the MSR value for the guest.  A write by the guest will result in
a #GP.  A read by the guest will return the value as set by the host.  In
this way, the support to expose the feature to the guest is controlled by
the hypervisor.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kvm/svm.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c |    1 +
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b3e488a..2b40885 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -178,6 +178,8 @@ struct vcpu_svm {
 	uint64_t sysenter_eip;
 	uint64_t tsc_aux;
 
+	u64 msr_decfg;
+
 	u64 next_rip;
 
 	u64 host_user_msrs[NR_HOST_SAVE_USER_MSRS];
@@ -3860,6 +3862,24 @@ static int cr8_write_interception(struct vcpu_svm *svm)
 	return 0;
 }
 
+static int svm_msr_feature(struct kvm_msr_entry *msr)
+{
+	int ret = 0;
+
+	msr->data = 0;
+
+	switch (msr->index) {
+	case MSR_F10H_DECFG:
+		if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
+			msr->data |= MSR_F10H_DECFG_LFENCE_SERIALIZE;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -3955,6 +3975,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			msr_info->data = 0x1E;
 		}
 		break;
+	case MSR_F10H_DECFG:
+		msr_info->data = svm->msr_decfg;
+		break;
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
@@ -4133,6 +4156,24 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_VM_IGNNE:
 		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
 		break;
+	case MSR_F10H_DECFG: {
+		struct kvm_msr_entry msr_entry;
+
+		msr_entry.index = msr->index;
+		if (svm_msr_feature(&msr_entry))
+			return 1;
+
+		/* Check the supported bits */
+		if (data & ~msr_entry.data)
+			return 1;
+
+		/* Don't allow the guest to change a bit, #GP */
+		if (!msr->host_initiated && (data ^ msr_entry.data))
+			return 1;
+
+		svm->msr_decfg = data;
+		break;
+	}
 	case MSR_IA32_APICBASE:
 		if (kvm_vcpu_apicv_active(vcpu))
 			avic_update_vapic_bar(to_svm(vcpu), data);
@@ -6917,6 +6958,8 @@ static int svm_unregister_enc_region(struct kvm *kvm,
 	.mem_enc_op = svm_mem_enc_op,
 	.mem_enc_reg_region = svm_register_enc_region,
 	.mem_enc_unreg_region = svm_unregister_enc_region,
+
+	.msr_feature = svm_msr_feature,
 };
 
 static int __init svm_init(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 80ac039..5767e15 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1054,6 +1054,7 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
  * can be used by a hypervisor to validate requested CPU features.
  */
 static u32 msr_based_features[] = {
+	MSR_F10H_DECFG,
 };
 
 static unsigned int num_msr_based_features;

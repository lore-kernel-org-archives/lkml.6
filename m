Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756646AbeBOXMa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:12:30 -0500
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:60941
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756626AbeBOXMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:12:24 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 2/2] KVM: SVM: Add MSR-based feature support for
 serializing LFENCE
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Date: Thu, 15 Feb 2018 17:12:16 -0600
Message-ID: <20180215231216.31016.18777.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20180215231156.31016.79657.stgit@tlendack-t1.amdoffice.net>
References: <20180215231156.31016.79657.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR10CA0016.namprd10.prod.outlook.com (2603:10b6:4:2::26)
 To MWHPR12MB1149.namprd12.prod.outlook.com (2603:10b6:300:e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 290d8c22-ce82-4876-485d-08d574c9915d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1149;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;3:zlNQxbLH8YNsOaKPqY2hSV9bFkG05mkZM/H4VpVUXPC3FO2eegGLB22NpQozlSD4K0SocXPVOiN3joO+y6y9t64ztUFirttOrHMBsmp6ufLNQSjLKtQvMcNceQ+5echIn5+/3veqCbmgP4ffyavJB7SoXJ8J4CjlKb7651QJ2uEQEVfFn1r12qKeuBc1iCvCoAxkC/u/Xdls3tenvIO+GejKM/NbGOPVRWCiX+jjMlZnYirh0smVNvNKVjTTNNeP;25:3KaaEAiEny4m7ER6PIVrd/c410UxAVlnWHfeTFRkLBNwMbcrAKDcX5V8YJR5XrezdTNTJUJfZW97ue7+56qZQhMI+mjOBFG5NqVmDxwVuMnI8QgdqEqeaUIo693OqZfa6scXxyTl1TBB5OrdQ92sb5sJoeT5yJtb9L9vIjCwM/iMkd8u6gmV8nKGIrHMPDyT0iH14to7P4mWl2K+bYHtDyukQmjRAQy9bybo+VhrqNLBjFN1w/B0S9Yc0mOfCDv3L2pVRZPooYmwXI7k28xD6vkXjTNP1YxnyktfDf4aDounFqujCbDY0oGzp2c+0edubhBCxts3FxKDeeZBFphQFw==;31:bZQTSLtyyqiM7dcOOQ9vIG0jKomBVAi4c8M0uULjG63m/Wsw27DX83HTYXLtDVly/jLB7iq7quaHCmY7iSGCGe55k7KuKfstG5Gxa0Fpxg2KszKon8mW/cujygVUgGx2gRFITRqGv5zY57VlTIQf0ajAUKVhay6hF3MK7KyG/DQ3iYWExYhvUfvYXmUh8Y2nY0gLFnx98ccKJ7/0ZT2ZLRm4iXKMk4Vol6oY8hEchUg=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1149:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:UliMFHS7iTQFjg/7DBzrrVsvvsbrYa5I942NW0X/AZFyY4TN1frkw0SK4aIWhxC1+uo7BpJxz3rI5vexjJYNE0K8U0qxFaQpRF86uNIKW1BMWzVr/kIoM1d4JVYEMsee2k69HSMnQAgyC5yViqpKY0PuSXQZ9Cgjzgux+MIKES2sEvUUfnIcLwoa6zuyvPaRPE0GI/aP+UoKcBBmar4s1zP1DrQVmavrxbEjHKivrXQDIrM2kifwEkei1B7hi4zSxegB0tT2Cf00a4xbLk/Boy3Z4MNxM9M5F5MDz5RwXNRHWagzN7EzGQu6TojpW9gskhMmB1Zzgo5OKFqedbYONqy8sQ2KJ0x/iu7zEBxcE42Lg6WZrkuW/cPkAXg988g+EPpFTqe6y8nltvuuG/cp1SQFIhsTY2a/P+/FNK/6qiKpksiIFaR17TiTZX9mgrRvsRDyX0LB2m34yoFB6XS7WCgEmDuWWwQLKHvO/CRwgf8ececFjr8j00KWpLnUEwpj;4:mSXjUymnXr+YM6UumV/6mI/PNKUJWOhxQmy6tqU+iGhq59u4drU0vUfn3ciEdQrKkaixOw5AB5xwK/5fcdYgVKls2x+m8Z6r33ETqERIbNhOOTawGYbFOkeNdP41EhnqTL0tclvZ9UNkJ5hq7tkBsy7UWWlA+RrQxhPt6Bnyaew6VulcyNAknUVbkQybp4o+Xl9uIEmI73J9BYumTc2QBmHN4TSWedyntK0OOYWuD1op/3ZR+oQ7FjPVGZYc1fAsrTl+RIfbKO/DBewJpWwFqXSreTz88BppJQ1aqQ2D+OZOOpp27674kLKPzQITL1lz
X-Microsoft-Antispam-PRVS: <MWHPR12MB11491AC2EF86C487F23042E4ECF40@MWHPR12MB1149.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR12MB1149;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1149;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(39380400002)(346002)(366004)(199004)(189003)(305945005)(66066001)(25786009)(58126008)(7736002)(47776003)(4326008)(316002)(53416004)(103116003)(54906003)(105586002)(8676002)(478600001)(2906002)(2950100002)(8936002)(6666003)(97746001)(72206003)(230700001)(86362001)(6506007)(50466002)(386003)(6116002)(59450400001)(76176011)(1076002)(186003)(9686003)(7696005)(52116002)(5660300001)(2486003)(97736004)(53936002)(83506002)(69596002)(68736007)(81156014)(81166006)(16526019)(23676004)(3846002)(106356001)(26005)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1149;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTQ5OzIzOnVMRmhmRU1PeWU4QVdneW4xZTVkOXNIN0Nq?=
 =?utf-8?B?cG1OMStvWGhQK3lhb2g5K2Jsc0FSRnNselNRMmNHdStHR3NzSDlWZmt6QjJw?=
 =?utf-8?B?dnZ3eGltMXZEc1pKZDhueDMyUkYyQ1U2OHBhcEJ3ci9EdWtCdHFOcUxTUG5Z?=
 =?utf-8?B?NGhjNUJFaTRGV3J1cElHSXBabGNGQkZjZHhRSlJXcDEzdVZOTVhtT1ExZ0Vq?=
 =?utf-8?B?NlNzZHpLTHY1M080TU90NzZxTklyeDJNU20yQmhOR1lkWERZZUllcFQ3K0dp?=
 =?utf-8?B?ZHIrR3RIL0lNMnMzSThyVkZLL21TSW5xU2xxRmExZ3ArR0JoUWYvekNGdVBr?=
 =?utf-8?B?OFVsN3RJQzVJVTNhbm01dGNKQk9DT0dFRDFjcU5vOFU1eERVOEtzbDZxaHZV?=
 =?utf-8?B?cTdpaVJPbHJYTW9xcmordmlRdmlKWGVhbUs5NytwRkZ4dGt6VDRCOVZqai9t?=
 =?utf-8?B?R000MS9QRXNTbGpYOTR5QUZKNlBjTHUweXpITUVOUjVaeFhGRUlvQmhBaG8z?=
 =?utf-8?B?d0ZkUkczYm1QcHFOQ1RGeGZRWUx2cXhaQkVrK05BUXJzZnF1WEREQUE0bkxY?=
 =?utf-8?B?UGZicUI1RGtuK25FNjJCb1VYOHZmcWl2R3gxREhZcWVlN2pNNlV6bUsyUlk0?=
 =?utf-8?B?czdsOVd5bitTakZlQ1RVTHc2eVhkcUdmVGtaa080eU5aZjI4dEIxZEFKUDJQ?=
 =?utf-8?B?SitKNFRSbHlPZVl0NnVTRGtEV1dWRHYyZHhyUUp4K09NSFhUSWpIRUVPcFM4?=
 =?utf-8?B?YlBFblgwSmFFbW1NL3FLcGFma3RjR0VpOW8vU3o3ZHBUWGVNRTJ6cW9PLzZE?=
 =?utf-8?B?QnZvNENUa09VcUtORDR5Zk9oT2dYbFFHTU56b3hwdWEvNWYyd2lsZGNZQ09P?=
 =?utf-8?B?V2ZkK2FJMGNqNk5WU1ZnN0tlQmwyQmg1V243SkI4RmJyaDRlOExFWk8rd2Q2?=
 =?utf-8?B?b3RPNUg1c0hBa3grcnh0QTRXWjhrSXBsT2JFMkdWU2ZENzFySFV4cGZBZGtj?=
 =?utf-8?B?Wk5VU2FQNngxKzRFQ2t5UStnNFo5MW1xYU1vWDFqUVcrZ2prQ3cwNk1KcDQ4?=
 =?utf-8?B?eUIvOTBsVmowZ0tHOVpiWGVWeHpadUkyRjRtTDFWbzFkbEJoN0xyaHM0cW94?=
 =?utf-8?B?MGJqL1k3c3hOaVZJOHRWUXJTZ3FVSFN5RHgxS2paWG4rdzAyRE9GTm80SWl6?=
 =?utf-8?B?bE1jRGZTcWk3NDFhK1Z5MEhXa2tyZG5ZdWZleEI4Ky9LdFgwNHBHcmluVllV?=
 =?utf-8?B?a0NnVlhTaW1rVi9jbDZUYU1QMFZxRERLRldCTVhMTThYRE1wNm9IT2ZEQlZC?=
 =?utf-8?B?MzhjcnZiOFppQ21RUzZ3dGlxbW1YRmFQWUlMRERZYUVpY3NKODI5L0pHK1Q3?=
 =?utf-8?B?a2NNVmRqYnptVDlIYmY0M1hHUHRrVGwvRW9yK0hPays5UHE5YkNvMmFYWFYr?=
 =?utf-8?B?akJORjkzbS9QV1lyalc5UmpIMXJjOVJ4WWNHZzVVWjI2dmR5UnJVendoSVJ5?=
 =?utf-8?B?eDArMFR3R2ZLc0xCbVFld003elV6WVdNc0hJQUpUazhVeUVCSFdVNzY2bklo?=
 =?utf-8?B?cXJ1bXFMTmk2dlpjbXk4V0owcUg4WmVJQWp1Vkt1dEpLSmFlczdsaWNwVWxz?=
 =?utf-8?B?Rjc2QTJ4RGhqWmlPb0RMZ1JvVUtjMnRQOG81TWVrM1hVL0JJMFVyRjBXd2sw?=
 =?utf-8?Q?KTN+0nGjpMOKIfQowZfPTYEzs7wEcXdbNpK1Sv4?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;6:IERrZAxiQY35/olf0RI5Eduife91QjHwaqGaYYLo8hHMiTUUB6S3NAsDdANGQsZ5f+F0FitR8ERVD1oSNw8eUjySkxlSlGdq8mdfc4Hx8e4SOnHUdzfimuiNHjm/N9fRzplTOWgSLDHHbFpt0h7LZBeIGbUfKinCSN6bOsDNCzw8jk9mK3ZhKoliyx7+DtJWJBhPGckhPmvKaN77u35W6HcmoONlu+eQdX3903W9KCFFOvbdsd7K9QMItGbru2j9TasbEpm6lidWOPRnITfrfljU0RUdLdPB2adSKGjZAEYOgycGBdrGmEAT5H9QgOmuJ9fYpL17P13dg/8PQwMpoa/JVmsMjn/IESQ01wj72s4=;5:zq+yB+8XNlyvm+csHuJ9zQv9LQMf0rvUmDSLRIKo8eEM2bek24+GoVMzNpmpGE+kI1i9L3oI39mSeVYfEwGjpEiQJg0psH8TKP8kZEl64oya9JBMIux5gmbGIOXq/6gkZ9ywUU3zwHy0xQdbVMGD83TuN/nJjuytzkqkeLvpYNw=;24:2nj0hK7nVhnDfxKdqIfpnvHioOjjntK+aTXNVJmooDtkVsRW+15pfYrzXSL10CxOpeD5G2sg+QkS7wRquFRLqXYq7E4jt+Sly7fGw9o3Krs=;7:itMsgitIxGBYqOtcrXnlWLHH2Nc76ynd8Pgep+Nok4fPdFQhadwVF5qArIL+VC1/6tBx52h8fpFYZcv+yt1sSsGaWbQcwMuWOl5jo56ESzkotKlZIG04JtETAROczOX3daO7vDxgiep6/nUCmUOabzYkZ8oeSZRQJ5lwsgksHb4qpLOSXItV3Ve++Ci1/JNuiw7PjimaE45TyM1q1X++PeO1WflhIASmptT1n2vYGI0Y3voWBnlGRBnuF/K1Jumo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:NvyZo7waCr9Ih56ygBj7HdB3QLmUX5KwsaGbgFlKEB0uFrtgZzq7Te+KXS53F9fc/tfPgn1gyk+0olaVedZJ6ShsSqpqFFupAtckSWc6qBA+yA/Vl7/AZbNcU1Az9qCzkddx0R+pyNZ1L+HUNqoPz4dvfAJxnEDpEZqNkOTteRA17cOslxJ9BUowGoqguvGxHkCW2WOoVwUN9mJW+wO8l0HZbJYcmykPPBecGjBy62eQhtASRusyrCYDn6exJ4aL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 23:12:21.2601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290d8c22-ce82-4876-485d-08d574c9915d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1149
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
index 0219c5c..42fbbf4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1054,6 +1054,7 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
  * can be used by a hypervisor to validate requested CPU features.
  */
 static u32 msr_based_features[] = {
+	MSR_F10H_DECFG,
 };
 
 static unsigned int num_msr_based_features = ARRAY_SIZE(msr_based_features);

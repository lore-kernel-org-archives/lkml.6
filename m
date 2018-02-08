Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBHW7I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:59:08 -0500
Received: from mail-dm3nam03on0081.outbound.protection.outlook.com ([104.47.41.81]:19443
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752403AbeBHW7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:59:02 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH 2/2] KVM: SVM: Add MSR feature support for serializing
 LFENCE
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Date: Thu, 08 Feb 2018 16:58:56 -0600
Message-ID: <20180208225856.22074.98252.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR13CA0021.namprd13.prod.outlook.com (10.169.208.31) To
 DM5PR12MB1148.namprd12.prod.outlook.com (10.168.236.143)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2d7eb71-52da-4e1c-f24d-08d56f478b60
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1148;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1148;3:SNpzmVhX6iaDYcIjprgiucZAdt7xVpReD6Q+OYF0tIoIkWnuyDMD3nc0SP/tHLGuMoZuh+gqwAt3xpzNCsZrTym8w4MSjxAo87fUHGVYtrNAxE+lvWnljXXv4FHwiAYxQIKrmRUfsRO/JkygEXpzs3eeTjQW/f7/yZZEvvofxpGwcsbx7oadaCxc9bYBGV4aRK4OIYIYyc808/WwvNeWUEPzivC1nDg+hswB7Uq1sdegtwBGI7nTPz1RlAP01n9F;25:fd2NshFR9VTc//64gmWOwI4tbxCoMhB0P/IxWCrGpNSnEBFD861Mg3YN4JxO0HCFbtry6H1LfXQTPWF7qdHYgSNLlM7lb0iv3V6dbc6uippfjaFBsjETmzy5uvE4vH1IoLa1f1GXoT+YWqcD99jMNsSWkkkoRHLYMxSnkHsRORjZ0liyghn+SgHsSw/62HPqZeno/ryhB7nE4uPFk09DpQzFRL1czf1mkOzvt9vPoispa3YoCvuq+1dE0yCDQsJpTegMR2/G+NIjnW8cWK62dK5mpnwAeVQwhe86B9KQuJHxxwGpFjU3D3jZvzp5j1WZX27+YkKwtG0HvDCpvhaFIA==;31:yPYfOQx3scbSR51KGru6027VLz/iXQIRPb1w3Cl5hmXpf4vzHiLrVuvuRVLb9CQgu7F4wKKUx7LyeEgfJffk6XyaR1rVAgGDOog5+Vctr3gf1YaJIiGQISZyJOeejsoFu+wDfItY0YrLGRJ/NuVdeAba6FNIPKSLvHMm0CkSUkcrmZ0u7hCIGAGN+Ec847xf+w3qeXgaO4escnMxPPtblhihYmXh7F674EXVIpKbbbA=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1148;20:4rWAiAQ7S6Z88XiornLLNzRntnCOGto4espGalhTxvL/BDOm/zUOznLJbQao1MibiTVZUcdEN3qxB/6To9QdvXzxGBzCn4FajvPyI6r9K9BEO55NwGid9zOIDY8obQEN2uzdDBk9xGnuLcKG4v4O5ZKdxQqPalhMrewNnBoWa6mt1BAoWyswVHY1jyDRTkOAylzEwrilp3+JKeIpo0XfVFR21Vu0g3xxeyqZ1Io0aK4FfQ0hv8SvDdpeNDo/bi1hayqH5/rZZPRWggbux8s5uG77SFDr5N4iW15HvIy7URNUaoB+BHXS72BTLezdWp3++MCn/Kj2gdJXsTeEBkkWOy9HpB/RsgCRnr5uutCVriFp9oE5PR1S2yzX40L4QYby3DSPvPVLko4OXD8PpwTbj797smMZbzCjzD5tE0B/hp1wYnbwe9e+fTiezoHvBJ4wBDLTzY59XacDoKQ6YcHdgCUDbPyxtAqmnVGPzkohv6idv1ET8jmZd8tqSpSDe99O;4:stj+MpY4RgSHOhI4rXc79MoC8xpko+r8vUygDtxb0j1hjg5zV3CUWMOxl2issNDZ1xRI+xmWC7RZVt2RFioFE60d5zCiR5xyiHJlgPU0uPD24EvIzuvH98jVbc12dWZqlCLPuHMKsXwpbWQJxCrr3XgotHMqg/zcF7Kv8op1X03A91zW7jFJejgCjNp1SEo+QvqpWgccPk8+xHPq+hsjtiD+VmWXhyvoGKG5MXfFgNhiCHgL8CiFaPTbJy1wgOmvKkceE8aFrdAJoemudnsUEh7JY/0n05AOJmB8n6Lc2kXE+E53vFOP0GzIOEUNpa9E
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148C7BCEB5F52AE234A7E72ECF30@DM5PR12MB1148.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1148;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1148;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(97736004)(53416004)(478600001)(66066001)(58126008)(68736007)(50466002)(54906003)(86362001)(25786009)(2486003)(7696005)(97746001)(103116003)(53936002)(1076002)(2906002)(6116002)(230700001)(316002)(52116002)(6666003)(26005)(7736002)(305945005)(6506007)(69596002)(76176011)(2950100002)(8676002)(3846002)(9686003)(23676004)(16526019)(8936002)(59450400001)(386003)(55016002)(106356001)(72206003)(186003)(5660300001)(81156014)(105586002)(81166006)(83506002)(47776003)(4326008)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1148;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMTQ4OzIzOm5BVzdMWGtsWnF1WXBLSjQyRGo3a1FRblZn?=
 =?utf-8?B?dWczdzV0UEVZd1AzVTJjY1psejFQUk5PbUo3WEtyTmpYN3BNYjdmU0swUXls?=
 =?utf-8?B?SXUwUUwvWnVlZVVOQ2NzOHd6UVF2ZlpWTDJZNml5b3BqdWRWU0pvSU1zbE1Z?=
 =?utf-8?B?M0NPQ1Zmb0oyZGoyMkEvbXVIWWg1eUJNN0RpRGVTRjk1dFk2UnBpNVZRR2Jx?=
 =?utf-8?B?TnVRMHRkNFA2TDNtV2VwRDlMNGpkKzNYdHNuUXRxY2lib3dHUHFoSmlMRTJC?=
 =?utf-8?B?bW9rRjA3aGJEdDhlRHpIblhiOFAyU1lPSGxUcHNuZFh0NmE5MjRlSDZQV04w?=
 =?utf-8?B?WFZOV0lGQk9QU2dnUjJWT215eUI0SlAvUUpzbEU0VUJaczlTd1EzMnJYOUtR?=
 =?utf-8?B?Zm5mSEtnWTJwam9Od3BsdG1pUTRLaWloWWkzY3Fncy9ydTBSdVhaUDE4VEhn?=
 =?utf-8?B?MUhkbUZuWm5IOVl2ZGtZM3FyQnZPM2UvZHZVMWh4M05zQzBEWHJDVzFhcmRM?=
 =?utf-8?B?TCtxT2dncGJiSFNTR3FWcDZvOWlUTnBrTysxeEc2bDI3U0VEV3Vjcm5VVyth?=
 =?utf-8?B?TDYyaHVOampQQXNXbzBYYTloM2drb3FEa21kK1NBSTJadnRpbFV3Wnl0THVr?=
 =?utf-8?B?SEJIVTg1ZlYyNDR1R3NBdHJ1dWxzVFR6eUo4UmdhcEgwZEpNbHNqUURsczlu?=
 =?utf-8?B?SFk4U3hzTm9raHczcFpHNmpnQW9wRG54bUY3cHp4blFVR1htQ3FNZjM0VGl2?=
 =?utf-8?B?WXdnalVpYUUvVm1SSlFLeXExYzhEN2IrZUNVaktONG8zbEVCeDMwRlpOcWJh?=
 =?utf-8?B?NnhxUHJjVzZxNEZPTmkyVlNNb09wMDhOQ3JkUGV5M1FYSnlCZWdwYU9Femw4?=
 =?utf-8?B?Yk5oTWVOZUdFeVFnZjN2cHZiZ3FGY3ZxUFdQR0U5Lys1REY4Y2tVVlNOdHZQ?=
 =?utf-8?B?VEtiWWJDam9UeWlzVWhTdnVzcjAxQmJhWm1YbDJaRXc3OUQ2WWh2dlRvUXpu?=
 =?utf-8?B?Mzl0SHVEcHg4dlM5QXAySkpGSVZLS3ZiQzZlSVpqdHZqREF0QzFMU1Q4UFJq?=
 =?utf-8?B?ZlJPMk9vVThYajdlWkZROU1RbE8rVnRQQUE1NUFzZjhrUUxvNEpuY1dHdHJv?=
 =?utf-8?B?Y2wzVzZEMEhPTXpFbWJHdllxM2ZlcW1iWVZ5N1N5TjVzYmdKaUc1NkRFWXhV?=
 =?utf-8?B?SWlMUnBoK3N1WExtNnlvbENDajB6QnB2S2lVd2UyRXJUM3pqc3E5Tm1ZM3g5?=
 =?utf-8?B?VmNxcnNVaTg3cEx3MFB6WGR2Vlh1b3Fhc014bXliVjRZL1JDYlZXOFVMZzJQ?=
 =?utf-8?B?NzNlb0diRU8yLzVvZG1PUDRjUThWc0lXNUZKQTBFeCszMlJDS3haS3ppUlMz?=
 =?utf-8?B?eERYR2xCb0ZEYUdOcjdjSzRqMWViQklUTVUrR0ZkdFkyTEtnazVoNUQxZEdZ?=
 =?utf-8?B?ZzdYbkZXTms2NEkxRWRISGczbVR6bG1vNjAyeEVVb1FXZDVNbzU3QzZXS3dL?=
 =?utf-8?B?M01FTVJ5dEduTllaa0Z3RFIybTJ1MFNhNWcyQnY3TzBNSDJEelcvZGRoQ2F1?=
 =?utf-8?B?WDh5TWpqTFJUWUZJa25NVk1WdmxVTHNtZEJTRHNFWWpyNWxEamR3STYxYjR2?=
 =?utf-8?B?eWd3VzZ0Ykc0VXBvNDVRQ0tOMkRmREt4RWVCRmVBUko4eUhad01oZHdEaVJt?=
 =?utf-8?B?R2JjemVIYmgwM2R6SWlFVGp2dit4ZWJ1ZUgwbzM2a2ZaNzAxNFVkeEJEa2hF?=
 =?utf-8?B?ejRUMm05NmRnZGxxRFI3dz09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1148;6:Zl9ZRfne5WHpwwXXUO/GiScOxAudqfolZdCs5qYmtlVT7SiiUVgwU9MHW8axplJ9GJvUx/eebOoy1YyF+KlzFp3Vq8IA8DgJETLfogid13+TGjtN5T/BnwfjWYTw9OIKFpfzxmytRnCrQpIgQJv/G4bXmOIBTLtTqpyjQSrGIPQNKTiM3cjWFHbmDI8EFJ2QO2XDn/uz8tZZVdzlCw5+I7Kf8PFxkasTGpDuGJ4YG0nP4kwkKyKd4RCAEUXKRvVB1coWwmn9GL4w/fzMVSMUF5bOmDSsHxILCj4g6b1cQ1+69m1/+qiTRccHvtJ6TXcEVibMne+CYCQU5qHXO/DKfva87FJpTWDiraWH6nxkWnk=;5:pximi+glMCd22Ck+gz0wn8RSOCK4hG35Fp/6h1/fZq7xm2WbcBZDu9yD/elroLoj2q3UzjCHiKzVAkHg2I6H28ZtwvVY/0p1O1SlXav5ifmV0dX1Eq0bAko3Gtm/7VZZvoV0HWXZ6RLctuPyK362CduQuY5cFgPc8eZKZn9/syE=;24:GsLakB5aaZi3IWtZgGtQccKC6kFJQ3wrXQmy+GS2su86jlcuQfpHI5HDk4LlwwIDN6PYCMCa+lDh/ivFZ9KOqREvmk/5WmRUaqlR4DlD1tI=;7:Vj/I2KbEGG0PwrsTIGbWQ5NR0ApTPt197Y6bAOxqIiHFjgnj6AvBDPI/pEo6UmVNW+0V/G6xy0HS/x83/QU0qKHAlDqzkVMRqDTZD5nWHKfUWNT132ZdRlAsqd8MJbbECCg8Z6wwjruXs2BpNkng/6qxutlFq+zJsRy/GmT4VinzxmFsMJJoo5QG1572YlgNZ/9wGsXg9o7HKgHgpj1h8geAtQz3peYlJM4ovWFkuTi4iFaBk4Q8BKNqtuR6jdwl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1148;20:wovlZxN6Wu/dhJgX27IwzBr8oVxWvBH446k88C7qWoErQKI0Iet8ZaANo/V4wD1qVeSuHpvt/Di5TvRMk0MUZqOoghNEpBaBaJ8tySm33BXPhqltLHS5txysAwqBlVZxVc56YKz0OPulerVyEmUQgUzQqlFENdVzvnl+ATZRUmSNdA33F26n6FN5NyHjBaPQ7bSQ6iQgBCEeZvJFCZJoyjr42MoQYVpe1uoNSR0OIQqTglaV0S3NFZ3uYIDszafs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 22:59:00.4853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d7eb71-52da-4e1c-f24d-08d56f478b60
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an entry in the new MSR as a feature framework to allow a guest to
recognize LFENCE as a serializing instruction on AMD processors.  The MSR
can only be set by the host, any write by the guest will be ignored.  A
read by the guest will return the value as set by the host.  In this way,
the support to expose the feature to the guest is controlled by the
hypervisor.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kvm/svm.c |   16 ++++++++++++++++
 arch/x86/kvm/x86.c |    6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 1bf20e9..f39e345 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -178,6 +178,8 @@ struct vcpu_svm {
 	uint64_t sysenter_eip;
 	uint64_t tsc_aux;
 
+	u64 msr_decfg;
+
 	u64 next_rip;
 
 	u64 host_user_msrs[NR_HOST_SAVE_USER_MSRS];
@@ -3912,6 +3914,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			msr_info->data = 0x1E;
 		}
 		break;
+	case MSR_F10H_DECFG:
+		msr_info->data = svm->msr_decfg;
+		break;
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
@@ -4047,6 +4052,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_VM_IGNNE:
 		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
 		break;
+	case MSR_F10H_DECFG:
+		/* Only the host can set this MSR, silently ignore */
+		if (!msr->host_initiated)
+			break;
+
+		/* Check the supported bits */
+		if (!kvm_valid_msr_feature(MSR_F10H_DECFG, data))
+			return 1;
+
+		svm->msr_decfg = data;
+		break;
 	case MSR_IA32_APICBASE:
 		if (kvm_vcpu_apicv_active(vcpu))
 			avic_update_vapic_bar(to_svm(vcpu), data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4251c34..21ec73b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1060,7 +1060,13 @@ struct kvm_msr_based_features {
 	u64 value;			/* MSR value */
 };
 
+static const struct x86_cpu_id msr_decfg_match[] = {
+	{ X86_VENDOR_AMD, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_LFENCE_RDTSC },
+	{}
+};
+
 static struct kvm_msr_based_features msr_based_features[] = {
+	{ MSR_F10H_DECFG, MSR_F10H_DECFG_LFENCE_SERIALIZE, msr_decfg_match },
 	{}
 };
 

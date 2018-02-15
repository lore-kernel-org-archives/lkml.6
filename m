Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164326AbeBOXMS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:12:18 -0500
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:57166
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756621AbeBOXMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:12:12 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 1/2] KVM: x86: Add a framework for supporting MSR-based
 features
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Date: Thu, 15 Feb 2018 17:12:06 -0600
Message-ID: <20180215231206.31016.78914.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20180215231156.31016.79657.stgit@tlendack-t1.amdoffice.net>
References: <20180215231156.31016.79657.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR18CA0021.namprd18.prod.outlook.com (10.175.188.31) To
 DM5PR12MB1148.namprd12.prod.outlook.com (10.168.236.143)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dab74377-c7d0-443b-6c0d-08d574c98aa2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1148;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1148;3:GK1IGCO55bOMqkVJf2LhbYZmXrFOmqu9Ex+zFXlgpLsLAq/j1wSiJxJzPZ5nAoUmTV9dfsvOCjCvfFl6RDLCh22bVLkqr7j7rlPkT9vRK68iT2a6Ncl4ca2PLZ56d5oiERpMIwVKbLU+W893aNilr4P7kNHzB4OCAZbrTT2wzddWhRN44ctLKBoLgNjAan9zM2NZUEoDX9wSUuzBRcMvRE9jbQ76tLJh0+r8z2Y73ctzr33KhQUJcvw/E6Smqpdr;25:gFk2fukibOpnYXkiF3XADGbIOsCHejQlr6J1f3SeOt9Xv3wiJwJXL6FfXxPAESvEAs3OhkC+IfRD7LePDEPtnJ3LS7EQvJMbK6liHy2lgD1OhmlnHYDF3oWUhW4qr2RIII0mPW0423w6Nt3VV+G+s7Ihd7dTELllyv1Ey4Rb9EpgbCAgKKAxjbfTlWtHGUrq1DcrkjUxRPqpwLsALD9ujixvg2GMF8/ZiJxeC4NGzfXHEM756RfmUeBp79l1NSfJAUWAcAJIqqDDVn2tonoh2UjhxwRbYC1FUr41+f2eK1nhbfXj+gOCfnWrOmSG6xJF5fQ6pQZnVLMOULveai4ksg==;31:9Mfn9RVdtPE5b5PEQAtw1RHM87CN1MBVWKIPr22dsQkyor2nwf22XtLOzfXoMCaSxfoUqjA8qxs/DrBVA5+G1Q6HVEZNn9sq1rj82C5JN7kwBGNIzMxJCs9AfpImOHUJ46Xtrq3fn2utvOTHpr5vRmq3GLTG60bpi8Vx8gLfUfpV5yeLQA+lV8GwMVtfQ/pfA7Qqxeojm0RVrLmge/RbFi/0h1gNR+L5zTc1krmSCDs=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1148;20:bsMREG1uc3EpJFVgBwu+/P+9bR3idstYDnCWACx26OxJ7qOkpGrAZz6M3qqlOfdZw1bXtsFc+53am3aMYuIuofZ/0XNajo/IcoCeelK/e+X5vWhi361RYczlIp9fDtIHLU6hkDp5qOkdL8bVV/rwK5q+b62Y8neBfHmVAs6YSLq+J7r+UxZzsi4YSmCp3KoW+t9SlZskWG8zDBJKvAnsbr/hdevO+vJAAQvOdlSEyPg64VaRaQcbUFh0ySglahawtmLjx2GplNpTxY6qXCQaCCJT/XolWMn6eSCpFNeYeo8HM3XQzvOvsaOEvkdcXtMxcbQ1ACO7Ne6lh5hNkrP50u9rvEc/0WpYhMNwjin0wFTgeU6rqhO4GTtKIGfYqbzjUILQpc1X/0GwRSk4lZWTq8Jlf2AruY2nkKSjXJRWpNsipA4WAK2HbFvR39aldwXPg9yAUT6TJ45mBDG+4ns/aDYf0rAHXDi2PNVQAxb/HFmT78ivUxt36bvI82BmI3fb;4:eD0GkiVXgyd5ucbierYk8n+GNJtfeGer/0zxh8fVzXag6NI95cm9QvsCoHbQ1WXIFV/odh+yKkGTVcEyqnvuOBjmMfQY02HNL7e7sC6qNeK/xoTB9d7KsAQVvpccoQDyz0zoZvcOsOAL68eFSsk3Bl4G99rFt+lrhpC2amZnw4B7uH5nWLsytTW+NFO3KPLY296FrvYJlzKbuT0wchPluqN2YFbd06ZZDOfxqyYiNm/aV1Zc24Ki9RI1k1bW0rb5nr70/03Av7zZWc3+wByYJMZUh86GJ0nU1wCTYIOVRkqHF1lwM8WmcNWSJzuOEJah
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148B30B0634AC1D31FE4C68ECF40@DM5PR12MB1148.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6055026)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1148;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1148;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(39380400002)(346002)(396003)(199004)(189003)(97736004)(9686003)(53936002)(106356001)(69596002)(47776003)(72206003)(86362001)(55016002)(575784001)(66066001)(105586002)(16526019)(26005)(59450400001)(2950100002)(6506007)(50466002)(386003)(5660300001)(186003)(230700001)(478600001)(58126008)(2906002)(103116003)(316002)(97746001)(83506002)(54906003)(4326008)(3846002)(25786009)(76176011)(8936002)(6116002)(6666003)(68736007)(1076002)(8676002)(81166006)(52116002)(2486003)(7696005)(23676004)(53416004)(305945005)(81156014)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1148;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMTQ4OzIzOjR5MzhqS2N2OWZSL1ZEQXkveGFHclJwRk9r?=
 =?utf-8?B?ZFZWeUkrSmJOWW9Bd3pXdnFQQjdCeFJkbGdYRGVvRmdoMkwwVmdUVVVZakov?=
 =?utf-8?B?TXdXWUkxZXRKVFpjTC8rOEYwUUJYc21DRitsaVVTeXFjbUZmcGJMR3hraXdl?=
 =?utf-8?B?Wmx0UVFKVVdDaDNCMDNSeWlyTys1VFJDNWxyTWVFVDYrWGpMaEp1WHJCdXZi?=
 =?utf-8?B?VERIM2hWYytaNW1idVh5aVNoZXlNRzRqNnJjZlNlZWZlcHAvZXNKUE9PV21a?=
 =?utf-8?B?NmN6TUFPRElnK3JpNHJoZ0twNU9nVDZNR3BqN3FINTFUa1VweU90K2c0UktS?=
 =?utf-8?B?MzdsNGRvbzN1ZEVpVis4OTBWMGlEOUVGUlhLdUZlanZGTkpBRElpMGxtVVdo?=
 =?utf-8?B?U1VqcDBhazBON0JOSmQ1UnArb1FnZllBbVZLNkptbVM1Q0x2SUk2U2ZjY0l2?=
 =?utf-8?B?SFhGZWxKdnRWT1ZvZUw0eFlVaUczY3RDNFNjT0tPaU51WGNiZGtRRWtWWkti?=
 =?utf-8?B?RmhLbi9lSkxEcmh3QUk1TzY4Nmo3a3poMGtrUXUyOG1UaWdKTGg5ckFJL0Q3?=
 =?utf-8?B?eVNuK1RWcUlmMXRuekgvMFZLVFQzdHR4QUxJdy9zczJCVm1kT1dSRGY1RVF1?=
 =?utf-8?B?OFBEakRxNk1leXJVRFJ3bU1hUFJkMzdzMHRWMWtzTmxINXJsT2FpNTBwc2Qy?=
 =?utf-8?B?aVl5WnZDQ1JNNFlKYlZTMFg0YTJFUkhqZXl1R3pTb3o1ckZzYWduemNKZWdp?=
 =?utf-8?B?anFOM1pJUFFOK0V5RDJTT3pBa3FiMis0Ly9PaElPSDB2Rm1udnpVc0k5TGxN?=
 =?utf-8?B?ZFI0VS8vT3RjZHF0Q0Z2K2hXMU5tS0hWRzYwL0YxZkVxbGpXbEpBMDVQYWZj?=
 =?utf-8?B?NTN1c1V2S3RSVXNXSnY5NHlFcnhDWnpSRStPL0NoKzdIdk5lb3lRL21raGp3?=
 =?utf-8?B?c2hTTDV6ZDdNa0JOdkxuYXZCNEwvSTJIUjhaWDRwU0lXeHFiMzlCZy9MZkVP?=
 =?utf-8?B?RWNvTXZJMXhtNEVtWVJ3ZnZYWjdtQThWbDJ2YS8zWUh3bzBrZzVTTnhZNFVJ?=
 =?utf-8?B?ZUtNMXMwK21YYWhKY3NMem9KUjV2RUxnK0Nad0FDS2pOTFpESWJObnl3NlNw?=
 =?utf-8?B?VXViQmhoQmo0aEFvZTRjdm5EZ3JNSEh1QlptWVQxY2xNVmVsVnNRNEhWNUZJ?=
 =?utf-8?B?b3hZOWFUODNFcy81bEVFK2NaaWJKVmE0YUlIWVdaWFI3RU9kTGk2aCtqREhx?=
 =?utf-8?B?RTNMbUp1MHdqNnFjSWJ4UFZoR2diYUtjYUlvaVRNNTRFSDdwNU5uY0c3NytX?=
 =?utf-8?B?THd5eCtiL0tLUm44ekxmT0c0c25IaEFNOHR0UFcvVkxDdlB3NUFOUVFBWlZq?=
 =?utf-8?B?N2NQalZoWjB2dWd5YTd4bEE1QWJMMEt4SkZCU3l6VzJHZHpGeUs0N3QvaHBF?=
 =?utf-8?B?UDVESXAyWURXU0QwL3YwTTM4akEyd3lDRFVocUgwOVZoKzZSWXNvYlA2clQw?=
 =?utf-8?B?Rm5IUjQwVWtPem5JaCtVampDWHNxcDNxNE82MWN3SnhwQnBjQjJZTWUzazRV?=
 =?utf-8?B?YzRSMVdSdndnQTljMHB6a0pzNWhCaU5oT2p6SEZ4Y1oxTmZNTkhGM2lXSWR1?=
 =?utf-8?B?NElzUTBEV1p5TWNBZ0cxclY3WWpKZzFuNlN4dVdQQlpyRzFDM3M1elFEazZr?=
 =?utf-8?B?cm1qZ0V6ZzVGbkxrdWhoYTd2YnFjQis5eTIwSkdRU1pDQUx2QXdROHpTZUV4?=
 =?utf-8?B?RlRFaU5nTG1xMzFucHhDQT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1148;6:JgV0UkJAMRC/GuM+noOn6dYojwbmj8HraWlziWPG0/2TtAH993Kv6vWxdSskJGdL5desNIPDqLatro/XdpafWLhzzrJQDnT/rcT45YD9w6/BPrsIcKHdJbjUsPow1vhZq3UkvPYPH4+Bu+Nt8apx7bxosw8MNpXFjd4GeTBI5RIhfsXiXCoa6DOnbw8FDuPhwpIYW1h9L/Y4o9PpELXA72xTQkjuMkjwwRK1CyqKTJRLNNW8FLoBLBi0wsF7OYIcsypfJ8cK84qdnhrZiDrwNNRmRsiFf6ErJ/6NAdNRDkOvzZbVq2IAtP2DxQcbHW4dqDTKdmdTEjnKRYrZvT9Yzjb4EnjNyhJxxM7jIF2F79o=;5:dyndPxaH8mgthnCi+75kx7jFtv52zUhPjhdRCfPaE9wy4eA2bwPq2mOugYoVwSEQ3ZOqP7rzFLy0QqchzuXj4/wt2FVPFA6yTyVBoMhbErqylBr9TmEHcVKt3Ftw1qI3iddnsesL4HWswiViDPEPo81aaNiFv7pxFlrPqidkIUw=;24:QxBxBAJl+ESKdpDMcwLARBPO3vYIhUdKTa/i8uu+j4nVVgEkvntVRlApwWP5vHAfnj0U0ZvJ57XkfykNVFOIY3KVKGCozTfihOVE/Zdtrmc=;7:ewA14jfNyOq7euWdeTlHR2Vrb7A0LvRugHBXanyH3ayEMvyfoTSjDOTSbdj0Rirh3O4fHPrGAFGqHW/02hbr1SeQ5xWufhmW5qz6TCtod+RRXpzz5PKUv9OxCuuCdDqHlatvi0+U7Pqik6BgLrXy4w7EIAa0p1xmKwRkkn2KH/cFYRNordb6U9xG84Dtvhb/dmGsA/0UPGYpkQQ3f/vUO0bMC80mJ5qk127gQnDUbRztk6KQ4JI/UJGRTASq64Wh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1148;20:jLE+sXVLwx5Cudkd7Q7iaMWGYULrQGXRSZqI9Zw3Ns6ZDHrHGMDH2jbjYREPDrjVPxKCU5bUhZNNmljvM+qzK9FNrLl5f74vaG2mCsFzUSiFjJWZJqKQ6j2T3Lv9HPiunF7g8XWvxtIx4ePU2bWPsyOPzcsxQ+MDd5pKuRrXq7UXM/TJm8yBjAvgHwwQELalyKf5HDxu6qM5hJANndOzROBDh3BUA05Uj+0iewbaFRYW4pyl0iDgcOrQD3BJarhD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 23:12:09.7660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab74377-c7d0-443b-6c0d-08d574c98aa2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a new KVM capability that allows bits within MSRs to be recognized
as features.  Two new ioctls are added to the VM ioctl routine to retrieve
the list of these MSRs and then retrieve their values. An x86_kvm_ops
callback is used to determine support for the listed MSR-based features.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/virtual/kvm/api.txt |   47 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h   |    2 +
 arch/x86/include/uapi/asm/kvm.h   |    1 +
 arch/x86/kvm/x86.c                |   51 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |    4 +++
 5 files changed, 105 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 792fa87..cd580e4 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3500,6 +3500,53 @@ Returns: 0 on success; -1 on error
 This ioctl can be used to unregister the guest memory region registered
 with KVM_MEMORY_ENCRYPT_REG_REGION ioctl above.
 
+4.113 KVM_GET_MSR_INDEX_LIST
+
+Capability: KVM_CAP_GET_MSR_FEATURES
+Architectures: x86
+Type: vm ioctl
+Parameters: struct kvm_msr_list (in/out)
+Returns: 0 on success; -1 on error
+Errors:
+  EFAULT:    the msr index list cannot be read from or written to
+  E2BIG:     the msr index list is to big to fit in the array specified by
+             the user.
+
+struct kvm_msr_list {
+	__u32 nmsrs; /* number of msrs in entries */
+	__u32 indices[0];
+};
+
+This ioctl returns the msrs that represent possible supported features.
+This list varies by kvm version and host processor.  The user fills in
+in the size of the indices array in nmsrs, and in return kvm adjusts nmsrs
+to reflect the actual number of msrs and fills in the indices array with
+their numbers.  To verify if an msr-based feature is available, the user
+should invoke KVM_GET_MSR for the msr in question.
+
+4.114 KVM_GET_MSR
+
+Capability: KVM_CAP_GET_MSR_FEATURES
+Architectures: x86
+Type: vm ioctl
+Parameters: struct kvm_msr_entry (in/out)
+Returns: 0 on MSR feature supported;
+         1 on MSR feature not supported;
+        -1 on error
+Errors:
+  EFAULT:    the msr entry cannot be read from or written to
+
+struct kvm_msr_entry {
+	__u32 index;
+	__u32 reserved;
+	__u64 data;
+};
+
+Using the list of msr-based features returned from KVM_GET_MSR_INDEX_LIST,
+the user can determine support for the msr-based feature using this ioctl.
+When a value of 0 is returned, the msr-based feature is supported and the
+data member of kvm_msr_entry contains the msr-based feature value.
+
 
 5. The kvm_run structure
 ------------------------
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dd6f57a..e466bce 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1095,6 +1095,8 @@ struct kvm_x86_ops {
 	int (*mem_enc_op)(struct kvm *kvm, void __user *argp);
 	int (*mem_enc_reg_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 	int (*mem_enc_unreg_region)(struct kvm *kvm, struct kvm_enc_region *argp);
+
+	int (*msr_feature)(struct kvm_msr_entry *entry);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index f3a9604..d5536f1 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -172,6 +172,7 @@ struct kvm_fpu {
 	__u32 pad2;
 };
 
+/* for KVM_GET_MSR */
 struct kvm_msr_entry {
 	__u32 index;
 	__u32 reserved;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c8a0b54..0219c5c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1049,6 +1049,15 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
 
 static unsigned num_emulated_msrs;
 
+/*
+ * List of msr numbers which are used to expose MSR-based features that
+ * can be used by a hypervisor to validate requested CPU features.
+ */
+static u32 msr_based_features[] = {
+};
+
+static unsigned int num_msr_based_features = ARRAY_SIZE(msr_based_features);
+
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	if (efer & efer_reserved_bits)
@@ -2785,6 +2794,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SET_BOOT_CPU_ID:
  	case KVM_CAP_SPLIT_IRQCHIP:
 	case KVM_CAP_IMMEDIATE_EXIT:
+	case KVM_CAP_GET_MSR_FEATURES:
 		r = 1;
 		break;
 	case KVM_CAP_ADJUST_CLOCK:
@@ -4410,6 +4420,47 @@ long kvm_arch_vm_ioctl(struct file *filp,
 			r = kvm_x86_ops->mem_enc_unreg_region(kvm, &region);
 		break;
 	}
+	case KVM_GET_MSR_INDEX_LIST: {
+		struct kvm_msr_list __user *user_msr_list = argp;
+		struct kvm_msr_list msr_list;
+		unsigned int n;
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
+		r = -EFAULT;
+		if (copy_to_user(user_msr_list->indices, &msr_based_features,
+				 num_msr_based_features * sizeof(u32)))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_GET_MSR: {
+		struct kvm_msr_entry __user *user_msr = argp;
+		struct kvm_msr_entry msr;
+
+		r = -EFAULT;
+		if (copy_from_user(&msr, user_msr, sizeof(msr)))
+			goto out;
+
+		r = 1;
+		if (!kvm_x86_ops->msr_feature || kvm_x86_ops->msr_feature(&msr))
+			goto out;
+
+		r = -EFAULT;
+		if (copy_to_user(user_msr, &msr, sizeof(msr)))
+			goto out;
+
+		r = 0;
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 0fb5ef9..48e0368 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -934,6 +934,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_AIS_MIGRATION 150
 #define KVM_CAP_PPC_GET_CPU_CHAR 151
 #define KVM_CAP_S390_BPB 152
+#define KVM_CAP_GET_MSR_FEATURES 153
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1373,6 +1374,9 @@ struct kvm_enc_region {
 #define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
 #define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
 
+/* Available with KVM_CAP_GET_MSR_FEATURES */
+#define KVM_GET_MSR		  _IOR(KVMIO, 0xbd, struct kvm_msr_entry)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */

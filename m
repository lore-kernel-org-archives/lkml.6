Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeBUTkD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:40:03 -0500
Received: from mail-dm3nam03on0072.outbound.protection.outlook.com ([104.47.41.72]:45336
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751510AbeBUTj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:39:59 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 1/2] KVM: x86: Add a framework for supporting MSR-based
 features
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Date: Wed, 21 Feb 2018 13:39:51 -0600
Message-ID: <20180221193951.12005.58349.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
References: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR15CA0033.namprd15.prod.outlook.com
 (2603:10b6:300:ad::19) To CY4PR12MB1143.namprd12.prod.outlook.com
 (2603:10b6:903:38::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69c46f13-2205-4e9e-490f-08d57962e2e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1143;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;3:gv7GwXod+R8gA1kYSEMWkOjX97No4nhfJa/Y/+HsQyiapMlvcP9JPfiOd+sABQ0Nr3FX8YLOJJv3917O6fbOccmJDxczzbk/SwkheG5Sde2A32FpYMEA1LWnMVmypfhCxrsp/ay9HfZMena/OQfzq0G5Z8EneDvtl4qF4a+6JNlVktNXqjVRt5BwSYU9LHstcLhsXTzim+I/mBvitSQo+DTAllLI17CjzKXqnW1BNCLBQnA/LbR2LCjXFQLYjocW;25:YotFhpUZ21V4fjB9HKRnQ6VXB/V12zA3FTbYojk9JLMQOLGqGZmtVpo166VRsSVEnAlmkeR1sMKAYlRpfe5F5HtqHaFpJFt5qp3G+bimLAjPqKd+FE/dkApLAXTC63WChgMnePobKAjA5Uxpm33cFVHu3UbkF69BTwSgAUVHB6z0iSWkdO+m17Ii+jLOib2mfQXoR42xwH9BQYcTwxG4sNK7t+lsrh0rlO6DZmUT2ZvPADyMdEywUrUj+G9nt8AjRkVEAkqBJJlAp+xpLHwkB1J63cibJAPik735oxZRn7yeeKfQO4gOqCDC/01hKzHp6Qd0V91S+nfu3wBGo7CtPg==;31:d49NpdhfzL57ImCdC7Y0IrJ2Dhp2Wllx30w+m3QEvb6GofrDFqjsvXGsXrzTP46CTmEXdXdZHVt82wIHip+x7AE5vIGeiLoKKHEaEwPeo4jjNlz0Ht5sLzh/1nCYvhyRzJhdOLpSpSxLdMWZjndOhZ90KQhe+5Q2NoFN2eFmND+rQZfllYlV3kRtXYyaQOkHsY4kNXWc+T7mnovTo52EsDHQFbgwWwvgOZQs1vwfzs0=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:z92TXtxfMPmTm9hC/ULoNNwXC3Mo5n9VKvGXCJ8//VYGZpQBcGaqVI0CqlvCE4ZOyE9+YPJ6i6VImjQgTzYcQZBQw+hq7wlC0YVns+q5eyUXDcPKNiF/Ob0duD/OBhyB8g4kMd1h6Yj9Jan+IJZ05V7lS3NuTHfLUSmCg/Hs9nc3UBBUUI2nYoAaUvDgBBbxsxzy5SMJ2hUJY9IYPYkPmri7kguo4cE/BdZ4TXKF2jD79dzEjNusrHKueraHTG6zsnEGk6sSwoM2AxLyLTGqX2bU/bYcK4RwuZUo01euYz9K1BNoaSX/4SJecKTzchf7JabkCPBh5q9skOqFI5OgZMxb9Mi+Vb979mcX6fnWLBGjyYlWUq9PtAgZ0aLIzJZ0v+Bt59md6qt5rORNFagc0eGU/xYHpFwvghR3Lxqx4t+P3JsLjxp/0+6AjvHPYaSc8QJ2k0ElpWbNlYBdRWZ2zl6fROgQo3Kj1zGMKIOL6DE0XPYqtWDT5PAbfg2usyAN;4:+fttMGD4O0XOSk5/NbyXmpB+2no//M9f8H0Yqvb0jwapT/84J/IP9fX5dAarScnmXO/3f69TO6MUpWO92NIlEBFKQI6glGEii16+bDu4IGazpRKmCxhNS4wBiuMdFgf16Uoe8AOFdID73tIU7XIg9+neviYMc+IktpolZXbZpeA8b5GWGE130x+RdyH6kbUQzSLc8DnSmUon6MNrGBRGBTcmBiEi/zNHg1RCVrB1wr7sXHUubfc0nbguJnQA9ezEVukJfmnpW622WV68iDXaDM0uQ10RgHM4whaEHc3ksVE2V6yJrUJL1ggwVscTBcBb
X-Microsoft-Antispam-PRVS: <CY4PR12MB11437BAB4E3BEDC0FA2C290AECCE0@CY4PR12MB1143.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001070)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6055026)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1143;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(2950100002)(7736002)(478600001)(53936002)(7696005)(72206003)(69596002)(25786009)(52116002)(305945005)(47776003)(97736004)(103116003)(50466002)(4326008)(9686003)(316002)(6506007)(76176011)(386003)(59450400001)(26005)(66066001)(2486003)(6666003)(230700001)(55016002)(23676004)(106356001)(54906003)(8936002)(68736007)(2906002)(105586002)(16526019)(186003)(5660300001)(81156014)(81166006)(86362001)(3846002)(97746001)(53416004)(575784001)(58126008)(8676002)(1076002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1143;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQzOzIzOmxUbXVYNk5yQitRb1B6dHJFRHJza0FMVWJU?=
 =?utf-8?B?VUkxb085cUpSY3ZwSXBMUTV2bXJYdktoa24rVEUzemd5Q2tTM2hCdzMvM2dw?=
 =?utf-8?B?TE5QcXRzZ20rd0dpa3JCS3F5Sk52bTMvc3BpRldmZmRveXZadTNJM3YvaWZt?=
 =?utf-8?B?YTd6ZkYrek5HcmtqWHA1T3BUTjgyamR3S1dnaEFOWlprc0VEWDV0RHZYbjhj?=
 =?utf-8?B?OWsvUW9ZTSs3c29QRXYzdzc1ckRZMFV5a2s4M0NobXg3anJRNzdFQXBHa2da?=
 =?utf-8?B?V1NtdUxOc1hNYWtxQ3JLOUllRE5lZlNFdkNueGpWOEJ0Nkk2YjRFRHkzejM4?=
 =?utf-8?B?LzZHczJuMmt4UVB1TERocEdtY3hzZFBXVkdkMmNmNlJ4a09PQ2dQODZRWDli?=
 =?utf-8?B?MW1tQkZoTDFrdE82RkZjU0J5T2ZlaEQ3amVhaXVNajZXbkRzMkNiYkVTMWhE?=
 =?utf-8?B?SUhrUGFTN0Fhc3VEK05iamcxa2xRNzhtZTRZVW5kcUxCNlVFNmgxazZOQ0FN?=
 =?utf-8?B?dEYvTzNPMnRiSUtONk1OZG1GTVU3d3NuMjBlYXJLM01IOXRuV1Uxam9FQ0x3?=
 =?utf-8?B?QWJwVHV6MThwWWEza2tpRlQ5akFobVc3bmpFUzNRa0JwRlovcU81S3hOUG9M?=
 =?utf-8?B?UFdDZkpkaWhDYndlNldaSnFXU1Y3TlJvV01ZMU81V21UcjFXdUtyclczcFVQ?=
 =?utf-8?B?bmtmNGZJSmt1NHpOL25La0FwTStRRDdZSjJrNkJzdjQ3cXNPZEdiY2c3WVU5?=
 =?utf-8?B?TzlnVVVOWmpQZ0ZhOVFiaURNeVFaWktVUzVxaUlEUjZuSlFBa2NVUEg4STFy?=
 =?utf-8?B?WjIxMFJoMUE0Z1JiNkMxd2NkV05QbkR1TWVWTjRzaGxlckZ0WXBMaHcyS1hy?=
 =?utf-8?B?OUYwYlg0cDVaMEg3OHBPbzU4aDRuZ0duNm1iQURkbkk4QXI2L2dMZ2JCSFBJ?=
 =?utf-8?B?NGJ4Y3BQeGphSEFoNkpTWVRIY1RwY0VJOWxKNzJtL2pqSVlWT0lmUEZhN1lj?=
 =?utf-8?B?ZmtsTE1xM2pzQnhZVDBISG54Y0lSdXlyTW9qbjZoN2NleEVWbENJMG5yUTBX?=
 =?utf-8?B?Um1acXR2dklRYSszWm43Tk1qT1E1a2ZOSUlCU1djUzRmMm1jbk12c2pKZFd6?=
 =?utf-8?B?bjh4em1jNnBXT3RPN2NKdUtUTmQ0YXkwVmtxQTNlV3dsYkVEV0hKQVRhWThp?=
 =?utf-8?B?ZWFpV0doNVk1aTBDQTVNYXVLNTJhTmVpTlRMa2swa0hiSXJyeFhYZWduU3pU?=
 =?utf-8?B?aWllQjdlWElmajZra3RKTkhIQjlvY29LNjdIK0RmQlV5RUVSRGU2VllMaUJJ?=
 =?utf-8?B?ZXBmS25RWlBmODFkYTdFMVZibUpoZnc0b1VwcitMb2Y1M3Axb1p1cDJsN241?=
 =?utf-8?B?bzRuY2NyR1lMcFEvVFdTMlpyVUJMQ2JNamZBZUNucjQ2YkYyRU9HMmdySFQr?=
 =?utf-8?B?V2I5eGhQQWhPbyt5WThjaHBDc1d3TmxyWlBveDNJWGxLTVcyZmlpdWZXam5S?=
 =?utf-8?B?MExQUHNtdmNJV1E3NXp5ZjkvQVNWbUZrbHNRcGZEaUhFRTFQOUhCMnpSaGJo?=
 =?utf-8?B?UGxNSnhSRTF0aS83d0dXN3lTZ1praXoySEs2RUZUd0d3TXQ3bVpEQ1BtMWcw?=
 =?utf-8?B?d0ozckx6YzFDRWM1WHVTM2VPUk9MVTJLZi93KzJiQU1wSVJkWmFiemRTcjVO?=
 =?utf-8?Q?ETyZhFtd+GggMdW3qcmJjOOg8o5WJAvzvWtplgT?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;6:y+VyiPLSjHP6o4IYxxRi1tSsJ+izzMiblR4YZuNGamVg8+Sk4+aSNmauQdkttWTGMwuOY9IIZekkIK4FUQp/wgliKfDv1Rr+vpjzH15nRx+8tWVytCkbwaaDZzwSiDfp8W1KhXUy6Y0qqMJU3D/WxL8LlaTnBEv4Z676DL+arvZpk9wkMGht8lYQk4PS13fUqe8yS5HOQDkF1IFCMGsDSBPTTTGLRFL9IMsXospXPdU3EALc2YIaNswHp65SOfKNBAdU1DSiHJXzQ8Yij6i7DxezkBpXCBKMDRo/R7eXYo18xMvknZ64GSAhvQwd6KY784Vswe0b4ONe+CRaf1xmxDYOhWGbSNhnWBSLhBztnvk=;5:ActdBC5RUVFoFw1xdP+hEgcQHAwok8VW+uuHS4UvtJTV+OISd3+bxbVsG8x8J5bobFbxcjL6WEBC+4mClMTrIyEEfvkzsYE3O2DrMJm0egYCDii2nA1fDf5L/5FpJIuslw/bNWuswOrjxosPo1IMywNb5X+eSU2WR1ySR+K448E=;24:LAyQL5OrXZy6iFBbzSAL1DHQgi8Apk5XEJAVUHgPVkAoxQYO7E3cSkiyfpw45L2yWL5Eo176VMVyqm03L+xgZIoqy9cufsikLBUb3t6prqM=;7:7WZotqjXwMSC+myxtZJwQ+qKtjw1QHhA0CS/7MTNCpZb5zNrSSyzVLZYztN/aL/SHLs4/6+lxpto8GBHYRGzGA+qIbvazYuhJUBGmx2UyIw7RUbJHW3BRdCvTWXbk1n4TQ4o2hxxtOy8es1WAKZcaO8tw5SFYWKk6Po9sPfqgM0dsl5JB+WJ9Baa0sczCuOnZiz2YPOJmDTEtAs0NPBFJfRo8MQkkziuuuOgCq100P5tfJPruA0QCi6+0WYtWeSC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:tz94oI5kgGEQnDXbyv14pZmqNGmt3iP7MMxfvwfaDHIi6fMFUj0kZsSxS7unXubiv1UNUu86zgHa02/42+RHL1fTU7fK/ZFF5PNTwxrhpCq0oU5dZZZ1hLwbeDuAh/Sk5qXYkAugID1NqP185Teekn1qchtDfvMPOpXf/0IHBEymA1CrUmrRtWYo8g/8EkzYhH1TRzvpQkMoUYgmSAV93Q+hZuX/7gMB3EzjAJlnQXY7xrjdBwDGynLbw7U+46p/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 19:39:55.4904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c46f13-2205-4e9e-490f-08d57962e2e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a new KVM capability that allows bits within MSRs to be recognized
as features.  Two new ioctls are added to the VM ioctl routine to retrieve
the list of these MSRs and then retrieve their values. An x86_kvm_ops
callback is used to determine support for the listed MSR-based features.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/virtual/kvm/api.txt |   29 +++++++++++----
 arch/x86/include/asm/kvm_host.h   |    2 +
 arch/x86/kvm/x86.c                |   71 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/kvm.h          |    1 +
 4 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 792fa87..613f346 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -127,10 +127,11 @@ flag KVM_VM_MIPS_VZ.
 
 Capability: basic
 Architectures: x86
-Type: system
+Type: system ioctl, vm ioctl
 Parameters: struct kvm_msr_list (in/out)
 Returns: 0 on success; -1 on error
 Errors:
+  EFAULT:    the msr index list cannot be read from or written to
   E2BIG:     the msr index list is to be to fit in the array specified by
              the user.
 
@@ -139,16 +140,22 @@ struct kvm_msr_list {
 	__u32 indices[0];
 };
 
+The user fills in the size of the indices array in nmsrs, and in return
+kvm adjusts nmsrs to reflect the actual number of msrs and fills in the
+indices array with their numbers.
+
+When used in a system ioctl:
 This ioctl returns the guest msrs that are supported.  The list varies
-by kvm version and host processor, but does not change otherwise.  The
-user fills in the size of the indices array in nmsrs, and in return
-kvm adjusts nmsrs to reflect the actual number of msrs and fills in
-the indices array with their numbers.
+by kvm version and host processor, but does not change otherwise.
 
 Note: if kvm indicates supports MCE (KVM_CAP_MCE), then the MCE bank MSRs are
 not returned in the MSR list, as different vcpus can have a different number
 of banks, as set via the KVM_X86_SETUP_MCE ioctl.
 
+When used in a vm ioctl:
+This ioctl returns the msrs that represent possible supported features.
+This list varies by kvm version and host processor.
+
 
 4.4 KVM_CHECK_EXTENSION
 
@@ -477,12 +484,18 @@ Support for this has been removed.  Use KVM_SET_GUEST_DEBUG instead.
 
 Capability: basic
 Architectures: x86
-Type: vcpu ioctl
+Type: vm ioctl, vcpu ioctl
 Parameters: struct kvm_msrs (in/out)
-Returns: 0 on success, -1 on error
+Returns: number of msrs successfully returned;
+        -1 on error
+
+When used in a vm ioctl:
+Reads the values of msr-based features for the VM. The list of msr-based
+features can be obtained using KVM_GET_MSR_INDEX_LIST in a vm ioctl.
 
+When used in a vcpu ioctl:
 Reads model-specific registers from the vcpu.  Supported msr indices can
-be obtained using KVM_GET_MSR_INDEX_LIST.
+be obtained using KVM_GET_MSR_INDEX_LIST in a system ioctl.
 
 struct kvm_msrs {
 	__u32 nmsrs; /* number of msrs in entries */
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c8a0b54..80ac039 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1049,6 +1049,28 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
 
 static unsigned num_emulated_msrs;
 
+/*
+ * List of msr numbers which are used to expose MSR-based features that
+ * can be used by a hypervisor to validate requested CPU features.
+ */
+static u32 msr_based_features[] = {
+};
+
+static unsigned int num_msr_based_features;
+
+static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+{
+	struct kvm_msr_entry msr;
+
+	msr.index = index;
+	if (!kvm_x86_ops->msr_feature || kvm_x86_ops->msr_feature(&msr))
+		return 1;
+
+	*data = msr.data;
+
+	return 0;
+}
+
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	if (efer & efer_reserved_bits)
@@ -2680,13 +2702,17 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
 		    int (*do_msr)(struct kvm_vcpu *vcpu,
 				  unsigned index, u64 *data))
 {
-	int i, idx;
+	int i, idx = 0;
+
+	if (vcpu)
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	for (i = 0; i < msrs->nmsrs; ++i)
 		if (do_msr(vcpu, entries[i].index, &entries[i].data))
 			break;
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	if (vcpu)
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
 	return i;
 }
@@ -2785,6 +2811,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SET_BOOT_CPU_ID:
  	case KVM_CAP_SPLIT_IRQCHIP:
 	case KVM_CAP_IMMEDIATE_EXIT:
+	case KVM_CAP_GET_MSR_FEATURES:
 		r = 1;
 		break;
 	case KVM_CAP_ADJUST_CLOCK:
@@ -4410,6 +4437,31 @@ long kvm_arch_vm_ioctl(struct file *filp,
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
+	case KVM_GET_MSRS:
+		r = msr_io(NULL, argp, do_get_msr_feature, 1);
+		break;
 	default:
 		r = -ENOTTY;
 	}
@@ -4464,6 +4516,19 @@ static void kvm_init_msr_list(void)
 		j++;
 	}
 	num_emulated_msrs = j;
+
+	for (i = j = 0; i < ARRAY_SIZE(msr_based_features); i++) {
+		struct kvm_msr_entry msr;
+
+		msr.index = msr_based_features[i];
+		if (!kvm_x86_ops->msr_feature || kvm_x86_ops->msr_feature(&msr))
+			continue;
+
+		if (j < i)
+			msr_based_features[j] = msr_based_features[i];
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
 

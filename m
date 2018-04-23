Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeDWFwf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:52:35 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41502 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750852AbeDWFwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:52:30 -0400
X-Google-Smtp-Source: AIpwx48lYAj/oDz8Et6anPNOMMFi9AW9xaVGO93V0RgBzO5/hbnq2xVBPD7yqFpYoEUgkaxKOlAksg==
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From: valdis.kletnieks@vt.edu
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: next-20180416 - warnings from 'make tools/perf'
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1524462741_2556P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Apr 2018 01:52:21 -0400
Message-ID: <61890.1524462741@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1524462741_2556P
Content-Type: text/plain; charset=us-ascii

Seeing these warnings.  'diff' tells me that the files
are in fact significantly different.

Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'
Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
Warning: Kernel ABI header at 'tools/arch/arm/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm/include/uapi/asm/kvm.h'
Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

I even tried removing the tools/include versions and then doing a git reset--hard,
and the issue persists.  Looking at kvm.h, it appears at least two commits hit
the include/uapi version and failed to be applied to the tools/include/uapi copy.

Running 'diff' on the first:

diff -u 'tools/include/uapi/linux/kvm.h' 'include/uapi/linux/kvm.h'
--- tools/include/uapi/linux/kvm.h	2018-04-23 01:40:20.259290792 -0400
+++ include/uapi/linux/kvm.h	2018-04-16 18:41:38.735881690 -0400
@@ -396,6 +396,10 @@
 		char padding[256];
 	};

+	/* 2048 is the size of the char array used to bound/pad the size
+	 * of the union that holds sync regs.
+	 */
+	#define SYNC_REGS_SIZE_BYTES 2048
 	/*
 	 * shared registers between kvm and userspace.
 	 * kvm_valid_regs specifies the register classes set by the host
@@ -407,7 +411,7 @@
 	__u64 kvm_dirty_regs;
 	union {
 		struct kvm_sync_regs regs;
-		char padding[2048];
+		char padding[SYNC_REGS_SIZE_BYTES];
 	} s;
 };

@@ -936,6 +940,7 @@
 #define KVM_CAP_PPC_GET_CPU_CHAR 151
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
+#define KVM_CAP_HYPERV_EVENTFD 154

 #ifdef KVM_CAP_IRQ_ROUTING

@@ -1375,6 +1380,10 @@
 #define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
 #define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)

+/* Available with KVM_CAP_HYPERV_EVENTFD */
+#define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
+
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1515,4 +1524,14 @@
 #define KVM_ARM_DEV_EL1_PTIMER		(1 << 1)
 #define KVM_ARM_DEV_PMU			(1 << 2)

+struct kvm_hyperv_eventfd {
+	__u32 conn_id;
+	__s32 fd;
+	__u32 flags;
+	__u32 padding[3];
+};
+
+#define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
+#define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
+
 #endif /* __LINUX_KVM_H */


--==_Exmh_1524462741_2556P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWt10lY0DS38y7CIcAQIgEAgAhfAAeklqBYUfGeIvgC5AOHOwd0EKEWJK
BNr3aunE7BSvf02VM82E/zMLq+HMLDXPclORVezupr6gBfIEnZldXECeYDrd+8Ev
wRAD1jScr40Ddj7BV/X3qhEAz5D3ZUsqL+p977CFxKqCJX8YFIqxJjIfO/Y7JQnU
ka/eOhD7jNaFa/zY0OkT3ILnYTJZluT4ntfq3Lmo0wgFG/eMd95JE1KVCXzukRdJ
ZpoxXhmMbi0ox32GWEPk0xQuspfVEboWBSAouhYzC7s4s314xCbuG+wOcLtUYlR0
JtEGXWZRajAjRKSn97EPD8sIJViKVI6FqHYgJBM3CsfGA8jL455syQ==
=+clZ
-----END PGP SIGNATURE-----

--==_Exmh_1524462741_2556P--

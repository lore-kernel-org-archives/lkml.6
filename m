Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeBEViJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:38:09 -0500
Received: from terminus.zytor.com ([65.50.211.136]:44497 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBEVhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:37:55 -0500
Date: Mon, 5 Feb 2018 13:34:39 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jmcf78tqiudgn46zqfw2tgt2@git.kernel.org>
Cc: acme@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        tmricht@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
        adrian.hunter@intel.com, namhyung@kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com, hpa@zytor.com, ravi.bangoria@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, paulus@ozlabs.org, jolsa@kernel.org
Reply-To: ravi.bangoria@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        paulus@ozlabs.org, jolsa@kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com, hpa@zytor.com, adrian.hunter@intel.com,
        namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, brueckner@linux.vnet.ibm.com,
        tmricht@linux.vnet.ibm.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Sync
 {tools/,}arch/powerpc/include/uapi/asm/kvm.h
Git-Commit-ID: 1b8f516094d3fedba4e33a59d9d52131bc8562ae
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1b8f516094d3fedba4e33a59d9d52131bc8562ae
Gitweb:     https://git.kernel.org/tip/1b8f516094d3fedba4e33a59d9d52131bc8562ae
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 2 Feb 2018 17:04:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 2 Feb 2018 17:04:53 -0300

tools headers: Sync {tools/,}arch/powerpc/include/uapi/asm/kvm.h

The changes in the 3214d01f139b ("KVM: PPC: Book3S: Provide information
about hardware/firmware CVE workarounds") commit right now will not
produce any change in the tools, but that is because we still need to
improve tools/perf/trace/beauty/kvm_ioctl.sh to build per arch string
tables, so that we avoid assigning multiple times to the same command
string entry, i.e. multiple defines, for different arches, have the same
value, causing this:

  In file included from trace/beauty/ioctl.c:82:0:
  /tmp/build/perf/trace/beauty/generated/ioctl/kvm_ioctl_array.c: In function ‘ioctl__scnprintf_kvm_cmd’:
  /tmp/build/perf/trace/beauty/generated/ioctl/kvm_ioctl_array.c:76:11: error: initialized field overwritten [-Werror=override-init]
  /tmp/build/perf/trace/beauty/generated/ioctl/kvm_ioctl_array.c:88:11: note: (near initialization for ‘kvm_ioctl_cmds[165]’)
  /tmp/build/perf/trace/beauty/generated/ioctl/kvm_ioctl_array.c:90:11: error: initialized field overwritten [-Werror=override-init]
    [0xa6] = "PPC_GET_SMMU_INFO",
             ^~~~~~~~~~~~~~~~~~~

So the onlye effect of updating the tools/ copy of ppc's kvm.h header
is to silence these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/kvm.h' differs from latest version at 'arch/powerpc/include/uapi/asm/kvm.h'

At some point we should do what we did for the errno tables and create
per-arch string translation tables for the KVM ioctl commands for the
architectures supporting KVM, such as s/390, PowerPC, x86_64 and ARM.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jmcf78tqiudgn46zqfw2tgt2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/kvm.h | 25 +++++++++++++++++++++++++
 tools/include/uapi/linux/kvm.h            |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 61d6049..637b726 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -443,6 +443,31 @@ struct kvm_ppc_rmmu_info {
 	__u32	ap_encodings[8];
 };
 
+/* For KVM_PPC_GET_CPU_CHAR */
+struct kvm_ppc_cpu_char {
+	__u64	character;		/* characteristics of the CPU */
+	__u64	behaviour;		/* recommended software behaviour */
+	__u64	character_mask;		/* valid bits in character */
+	__u64	behaviour_mask;		/* valid bits in behaviour */
+};
+
+/*
+ * Values for character and character_mask.
+ * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
+ */
+#define KVM_PPC_CPU_CHAR_SPEC_BAR_ORI31		(1ULL << 63)
+#define KVM_PPC_CPU_CHAR_BCCTRL_SERIALISED	(1ULL << 62)
+#define KVM_PPC_CPU_CHAR_L1D_FLUSH_ORI30	(1ULL << 61)
+#define KVM_PPC_CPU_CHAR_L1D_FLUSH_TRIG2	(1ULL << 60)
+#define KVM_PPC_CPU_CHAR_L1D_THREAD_PRIV	(1ULL << 59)
+#define KVM_PPC_CPU_CHAR_BR_HINT_HONOURED	(1ULL << 58)
+#define KVM_PPC_CPU_CHAR_MTTRIG_THR_RECONF	(1ULL << 57)
+#define KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS	(1ULL << 56)
+
+#define KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY	(1ULL << 63)
+#define KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR		(1ULL << 62)
+#define KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ULL << 61)
+
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
 
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 496e59a..8fb90a0 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -932,6 +932,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
 #define KVM_CAP_S390_AIS_MIGRATION 150
+#define KVM_CAP_PPC_GET_CPU_CHAR 151
+#define KVM_CAP_S390_BPB 152
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1261,6 +1263,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_CONFIGURE_V3_MMU  _IOW(KVMIO,  0xaf, struct kvm_ppc_mmuv3_cfg)
 /* Available with KVM_CAP_PPC_RADIX_MMU */
 #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
+/* Available with KVM_CAP_PPC_GET_CPU_CHAR */
+#define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeCGI06 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:26:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeCGI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:26:55 -0500
Date: Wed, 7 Mar 2018 00:26:38 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-h31oz5g0mt1dh2s2ajq6o6no@git.kernel.org>
Cc: namhyung@kernel.org, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        adrian.hunter@intel.com, hpa@zytor.com, acme@redhat.com,
        dsahern@gmail.com, jolsa@kernel.org, thomas.lendacky@amd.com,
        mingo@kernel.org, rkrcmar@redhat.com, tglx@linutronix.de
Reply-To: thomas.lendacky@amd.com, jolsa@kernel.org, dsahern@gmail.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
        acme@redhat.com, adrian.hunter@intel.com, wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Sync copy of kvm UAPI headers
Git-Commit-ID: d976a6e9d9614a951dc21aaf2fbebdeca567dcfa
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

Commit-ID:  d976a6e9d9614a951dc21aaf2fbebdeca567dcfa
Gitweb:     https://git.kernel.org/tip/d976a6e9d9614a951dc21aaf2fbebdeca567dcfa
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 5 Mar 2018 11:56:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 11:56:40 -0300

tools headers: Sync copy of kvm UAPI headers

In 801e459a6f3a ("KVM: x86: Add a framework for supporting MSR-based
features") a new ioctl was introduced, which with this sync of the kvm
UAPI headers, makes 'perf trace' know about it:

  $ cd /tmp/build/perf/trace/beauty/generated/ioctl/
  $ diff -u kvm_ioctl_array.c.old kvm_ioctl_array.c
  --- /tmp/kvm_ioctl_array.c	2018-03-05 11:55:38.409145056 -0300
  +++ /tmp/build/perf/trace/beauty/generated/ioctl/kvm_ioctl_array.c	2018-03-05 11:56:17.456153501 -0300
  @@ -6,6 +6,7 @@
 	[0x04] = "GET_VCPU_MMAP_SIZE",
 	[0x05] = "GET_SUPPORTED_CPUID",
 	[0x09] = "GET_EMULATED_CPUID",
  +	[0x0a] = "GET_MSR_FEATURE_INDEX_LIST",
 	[0x40] = "SET_MEMORY_REGION",
 	[0x41] = "CREATE_VCPU",
 	[0x42] = "GET_DIRTY_LOG",

So when using 'perf trace -e ioctl' that will appear along with the
others, like in this excerpt of a system wide session:

  14.556 ( 0.006 ms): CPU 0/KVM/16077 ioctl(fd: 19<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
  14.565 ( 0.006 ms): CPU 0/KVM/16077 ioctl(fd: 19<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
  14.573 (         ): CPU 0/KVM/16077 ioctl(fd: 19<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) ...
  34.075 ( 0.016 ms): gnome-shell/2192 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_BUSY, arg: 0x7ffe4e73e850) = 0
  40.549 ( 0.012 ms): gnome-shell/2192 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_BUSY, arg: 0x7ffe4e73ece0) = 0
  40.625 ( 0.005 ms): gnome-shell/2192 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_BUSY, arg: 0x7ffe4e73e940) = 0
  40.632 ( 0.003 ms): gnome-shell/2192 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_MADVISE, arg: 0x7ffe4e73e9b0) = 0

This also silences the perf build header copy drift verifier:

  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j4' parallel build
  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-h31oz5g0mt1dh2s2ajq6o6no@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 0fb5ef939732..7b26d4b0b052 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -761,6 +761,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_TRACE_PAUSE           __KVM_DEPRECATED_MAIN_0x07
 #define KVM_TRACE_DISABLE         __KVM_DEPRECATED_MAIN_0x08
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
+#define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
 /*
  * Extension capability list.
@@ -934,6 +935,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_AIS_MIGRATION 150
 #define KVM_CAP_PPC_GET_CPU_CHAR 151
 #define KVM_CAP_S390_BPB 152
+#define KVM_CAP_GET_MSR_FEATURES 153
 
 #ifdef KVM_CAP_IRQ_ROUTING
 

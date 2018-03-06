Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754044AbeCFRYW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754031AbeCFRYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:24:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A295221777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 5/9] tools headers: Sync copy of kvm UAPI headers
Date: Tue,  6 Mar 2018 14:23:39 -0300
Message-Id: <20180306172343.16546-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306172343.16546-1-acme@kernel.org>
References: <20180306172343.16546-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 
-- 
2.14.3

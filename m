Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeC0NSi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:18:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55206 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752897AbeC0NQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:16:53 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, cdall@kernel.org, marc.zyngier@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, ard.biesheuvel@linaro.org,
        peter.maydell@linaro.org, kristina.martsenko@arm.com,
        mark.rutland@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [kvmtool PATCH 18/17] kvmtool: Allow backends to run checks on the KVM device fd
Date: Tue, 27 Mar 2018 14:15:28 +0100
Message-Id: <1522156531-28348-19-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
References: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow architectures to perform initialisation based on the
KVM device fd ioctls, even before the VM is created.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/kvm/kvm.h | 4 ++++
 kvm.c             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index 90463b8..a036dd2 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -103,6 +103,10 @@ int kvm__get_sock_by_instance(const char *name);
 int kvm__enumerate_instances(int (*callback)(const char *name, int pid));
 void kvm__remove_socket(const char *name);
 
+#ifndef kvm__arch_init_hyp
+static inline void kvm__arch_init_hyp(struct kvm *kvm) {}
+#endif
+
 void kvm__arch_set_cmdline(char *cmdline, bool video);
 void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size);
 void kvm__arch_delete_ram(struct kvm *kvm);
diff --git a/kvm.c b/kvm.c
index f8f2fdc..b992e74 100644
--- a/kvm.c
+++ b/kvm.c
@@ -304,6 +304,8 @@ int kvm__init(struct kvm *kvm)
 		goto err_sys_fd;
 	}
 
+	kvm__arch_init_hyp(kvm);
+
 	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, KVM_VM_TYPE);
 	if (kvm->vm_fd < 0) {
 		pr_err("KVM_CREATE_VM ioctl");
-- 
1.9.1

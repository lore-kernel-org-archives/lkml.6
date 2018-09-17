Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60288ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DC3214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DC3214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeIQQKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:10:04 -0400
Received: from foss.arm.com ([217.140.101.70]:56690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbeIQQKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:10:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB9691C01;
        Mon, 17 Sep 2018 03:43:15 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 271853F5BD;
        Mon, 17 Sep 2018 03:43:13 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, will.deacon@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, dave.martin@arm.com,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com
Subject: [kvmtool PATCH v5 19/18] kvmtool: Allow backends to run checks on the KVM device fd
Date:   Mon, 17 Sep 2018 11:41:41 +0100
Message-Id: <20180917104144.19188-20-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917104144.19188-1-suzuki.poulose@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 1edacfd..dc3f0dd 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -135,6 +135,10 @@ int kvm__get_sock_by_instance(const char *name);
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
index 7de825a..0894778 100644
--- a/kvm.c
+++ b/kvm.c
@@ -373,6 +373,8 @@ int kvm__init(struct kvm *kvm)
 		goto err_sys_fd;
 	}
 
+	kvm__arch_init_hyp(kvm);
+
 	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, KVM_VM_TYPE);
 	if (kvm->vm_fd < 0) {
 		pr_err("KVM_CREATE_VM ioctl");
-- 
2.19.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938362AbeE1LbX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:31:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33938 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937985AbeE1LbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:31:18 -0400
X-Google-Smtp-Source: AB8JxZrX4Hsq8kOIYmMVq5zxo+WVt13qsOanbGLA+Lb1nWXlsB15eNZ9g1wzGdUWsNj+7zfrCuYNSQ==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: dvyukov@google.com, stable@vger.kernel.org
Subject: [PATCH] KVM: irqfd: fix race between EPOLLHUP and irq_bypass_register_consumer
Date: Mon, 28 May 2018 13:31:13 +0200
Message-Id: <20180528113113.30941-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A comment warning against this bug is there, but the code is not doing what
the comment says.  Therefore it is possible that an EPOLLHUP races against
irq_bypass_register_consumer.  The EPOLLHUP handler schedules irqfd_shutdown,
and if that runs soon enough, you get a use-after-free.

Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/eventfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 6e865e8b5b10..44dda5dad0ee 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -402,11 +402,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	if (events & EPOLLIN)
 		schedule_work(&irqfd->inject);
 
-	/*
-	 * do not drop the file until the irqfd is fully initialized, otherwise
-	 * we might race against the EPOLLHUP
-	 */
-	fdput(f);
 #ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
 	if (kvm_arch_has_irq_bypass()) {
 		irqfd->consumer.token = (void *)irqfd->eventfd;
@@ -421,6 +416,11 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	}
 #endif
 
+	/*
+	 * do not drop the file until the irqfd is fully initialized, otherwise
+	 * we might race against the EPOLLHUP
+	 */
+	fdput(f);
 	return 0;
 
 fail:
-- 
2.17.0

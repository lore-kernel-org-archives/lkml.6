Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pCIKKoNCGVtofAAAmS7hNA
	; Thu, 07 Jun 2018 14:35:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6E9D4607E7; Thu,  7 Jun 2018 14:35:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D90CF601D2;
	Thu,  7 Jun 2018 14:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D90CF601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934061AbeFGOfg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:35:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40392 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934039AbeFGOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:35:27 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbX-0005dI-CA; Thu, 07 Jun 2018 15:09:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-000378-IR; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Wanpeng Li" <wanpeng.li@hotmail.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Eric Biggers" <ebiggers3@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.371974922@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 279/410] KVM: mmu: Fix overlap between public and
 private memslots
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpeng.li@hotmail.com>

commit b28676bb8ae4569cced423dc2a88f7cb319d5379 upstream.

Reported by syzkaller:

    pte_list_remove: ffff9714eb1f8078 0->BUG
    ------------[ cut here ]------------
    kernel BUG at arch/x86/kvm/mmu.c:1157!
    invalid opcode: 0000 [#1] SMP
    RIP: 0010:pte_list_remove+0x11b/0x120 [kvm]
    Call Trace:
     drop_spte+0x83/0xb0 [kvm]
     mmu_page_zap_pte+0xcc/0xe0 [kvm]
     kvm_mmu_prepare_zap_page+0x81/0x4a0 [kvm]
     kvm_mmu_invalidate_zap_all_pages+0x159/0x220 [kvm]
     kvm_arch_flush_shadow_all+0xe/0x10 [kvm]
     kvm_mmu_notifier_release+0x6c/0xa0 [kvm]
     ? kvm_mmu_notifier_release+0x5/0xa0 [kvm]
     __mmu_notifier_release+0x79/0x110
     ? __mmu_notifier_release+0x5/0x110
     exit_mmap+0x15a/0x170
     ? do_exit+0x281/0xcb0
     mmput+0x66/0x160
     do_exit+0x2c9/0xcb0
     ? __context_tracking_exit.part.5+0x4a/0x150
     do_group_exit+0x50/0xd0
     SyS_exit_group+0x14/0x20
     do_syscall_64+0x73/0x1f0
     entry_SYSCALL64_slow_path+0x25/0x25

The reason is that when creates new memslot, there is no guarantee for new
memslot not overlap with private memslots. This can be triggered by the
following program:

   #include <fcntl.h>
   #include <pthread.h>
   #include <setjmp.h>
   #include <signal.h>
   #include <stddef.h>
   #include <stdint.h>
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>
   #include <sys/ioctl.h>
   #include <sys/stat.h>
   #include <sys/syscall.h>
   #include <sys/types.h>
   #include <unistd.h>
   #include <linux/kvm.h>

   long r[16];

   int main()
   {
	void *p = valloc(0x4000);

	r[2] = open("/dev/kvm", 0);
	r[3] = ioctl(r[2], KVM_CREATE_VM, 0x0ul);

	uint64_t addr = 0xf000;
	ioctl(r[3], KVM_SET_IDENTITY_MAP_ADDR, &addr);
	r[6] = ioctl(r[3], KVM_CREATE_VCPU, 0x0ul);
	ioctl(r[3], KVM_SET_TSS_ADDR, 0x0ul);
	ioctl(r[6], KVM_RUN, 0);
	ioctl(r[6], KVM_RUN, 0);

	struct kvm_userspace_memory_region mr = {
		.slot = 0,
		.flags = KVM_MEM_LOG_DIRTY_PAGES,
		.guest_phys_addr = 0xf000,
		.memory_size = 0x4000,
		.userspace_addr = (uintptr_t) p
	};
	ioctl(r[3], KVM_SET_USER_MEMORY_REGION, &mr);
	return 0;
   }

This patch fixes the bug by not adding a new memslot even if it
overlaps with private memslots.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 virt/kvm/kvm_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -837,8 +837,7 @@ int __kvm_set_memory_region(struct kvm *
 		/* Check for overlaps */
 		r = -EEXIST;
 		kvm_for_each_memslot(slot, kvm->memslots) {
-			if ((slot->id >= KVM_USER_MEM_SLOTS) ||
-			    (slot->id == mem->slot))
+			if (slot->id == mem->slot)
 				continue;
 			if (!((base_gfn + npages <= slot->base_gfn) ||
 			      (base_gfn >= slot->base_gfn + slot->npages)))

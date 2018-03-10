Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtoFlEbWKqwLTyssCmhirWVvepLUe6Hq1VvwlfYQl/tvRxD5+Lpr+HiaM/w+gHh6bXEb+zI
ARC-Seal: i=1; a=rsa-sha256; t=1520641286; cv=none;
        d=google.com; s=arc-20160816;
        b=qpKfbCOyLTBFORdImK4uRf0UZ++PMO5eblVedZTlWqAE1tw+NAHnaCZgHAJnqYNE5w
         ZCLeHZ/NFXYrpzX+CO7ZhWhYnV0MEWO5dNAm/6QMjyD3vL0dF1Xd1NeCXpBlQ/KL6edA
         fCPkZVGlaZiKVB7/x2BNZpknjtXUzS/Yr/JAJm5kUOAx3GI01b6Dee0uUjzVY6nUbSe2
         kSxV7Gc7zwAabjMvuJlJ2T+ec1F+WtSROtjGzIhfmsaSSqW3Uhg/pJwAQtI62kwPVn5S
         XXjQNXqqC/9qAyyYeJMwaxprBvOzbdLmwE3QzwJmIkQQLaSGRWFXnF9NGim0XOq/3ZzY
         dzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y1BaT9juZM0fr23+lwOFS/Dx8ULYnTPV2u9fLxQKqcU=;
        b=ZEwAxemFV9S/0NpsgMowwUyUiZtCDgT+J4ATNOgFtARCAH+sbTwm+TB40q/GIVeUZZ
         J8LVUE6o+W20cgtaeOz5OC3KUovaDo+TWKYorP+WDM8aUu/tKNzCix8BeuRfiOuofCAh
         usmIt9RwOy6z99qw19mLQl7mAhQPQL12nARvA3Kzs5Mw0ggxXg488BPp976dUmQ46JFV
         guYmGLHnXAXn89qxbIYsDvSFX4SSLB/x8i5UY8//rSwBk2y0mnb7KRLRqXumvOyzp8hp
         THufoHiM/es4lFaKCxdYMmMae/MM63gIlUrPwGyNDKsHBddRKyT/9pRL2ktiXsjWThNw
         LHeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Eric Biggers <ebiggers3@gmail.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>
Subject: [PATCH 4.9 21/65] KVM: mmu: Fix overlap between public and private memslots
Date: Fri,  9 Mar 2018 16:18:21 -0800
Message-Id: <20180310001826.622986326@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507846754131769?=
X-GMAIL-MSGID: =?utf-8?q?1594507957683652832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
---
 virt/kvm/kvm_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -976,8 +976,7 @@ int __kvm_set_memory_region(struct kvm *
 		/* Check for overlaps */
 		r = -EEXIST;
 		kvm_for_each_memslot(slot, __kvm_memslots(kvm, as_id)) {
-			if ((slot->id >= KVM_USER_MEM_SLOTS) ||
-			    (slot->id == id))
+			if (slot->id == id)
 				continue;
 			if (!((base_gfn + npages <= slot->base_gfn) ||
 			      (base_gfn >= slot->base_gfn + slot->npages)))

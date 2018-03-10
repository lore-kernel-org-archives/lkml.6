Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvqQRL7YGgrb9Zf+qfenRR6RS6Gx2K/tTeuJ9c84FJCLfttj3N5CzniliTfn5Bo6wfOn2Dh
ARC-Seal: i=1; a=rsa-sha256; t=1520641180; cv=none;
        d=google.com; s=arc-20160816;
        b=UEZrrXzvz2yqiDVAvrRM6wZIy+dr9vQnPHm5tMn6LkEVkj0u0fOZwTtueYQRMA+MWC
         9YkOVIHZ9gcpIFJGZgVG625216BKrHZr308S7KcKz47IG5YEX4yZl42NmbFSAIorF7dV
         ZEZiIgMsAvRvm2BAlyUpnOHkUt5Mq+kOUEfd9TTIdO/LdQUlkGa4cQ4jjoTUC8nB1LWs
         6NlejD3Ll6BeWqwVFJwpo4G4ArKb2fv5/URTuhGStK9YyynWe0hH5z3t/75XMyHE/cbs
         Yqemm9v/E+C3MQAKvjjt+yxORbmeXEo9ELYR0pIRQrSLb+QhCGnHDOoqMbGwFP241bqi
         jUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pKXlsX6K2ZkibikbzuFHjaXCPBkvq3RWVvIvLdbEg8c=;
        b=IqfMKpPQ4co0Lk9lKJpPJrcMUWlUpOA5/niKofw7BCwwsQfCWaZJZi4oGjOAduMmNu
         6Q0/aakE+ZEpPSZW6+8xhcj6yozmnFTkaiPo1i58kAmU6MPJoicQSBTFC2u1EMrzjXrA
         xS4uUiVcZQag0sV/i3IIgHhTXLG77JjFxbr9NSKiZVtIXI4mtmiX/fylIYHLbtNfDXly
         gVpnQ6vuHzWgDto+piiUNq1TheQjms6xsQp2bn6hJaNuJI2TVy0s71nCCylksHpE1L2v
         J2dyolJmMhWJ6RZ+wbbXLb82eYLZyn3t1KdRUDS3/L1k6ULH9V3eZBCEAKkdIzwQLFgh
         NpTQ==
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
Subject: [PATCH 4.4 10/36] KVM: mmu: Fix overlap between public and private memslots
Date: Fri,  9 Mar 2018 16:18:26 -0800
Message-Id: <20180310001807.773303334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507846754131769?=
X-GMAIL-MSGID: =?utf-8?q?1594507846754131769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -902,8 +902,7 @@ int __kvm_set_memory_region(struct kvm *
 		/* Check for overlaps */
 		r = -EEXIST;
 		kvm_for_each_memslot(slot, __kvm_memslots(kvm, as_id)) {
-			if ((slot->id >= KVM_USER_MEM_SLOTS) ||
-			    (slot->id == id))
+			if (slot->id == id)
 				continue;
 			if (!((base_gfn + npages <= slot->base_gfn) ||
 			      (base_gfn >= slot->base_gfn + slot->npages)))

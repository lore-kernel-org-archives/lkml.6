Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeBHVfM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:35:12 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41181 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbeBHVfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:35:10 -0500
X-Google-Smtp-Source: AH8x224ehpAYqK3hCzKkGcWXTJu9PCCX05QuRd/p2Pu9V8PmUu1A591mVgXaEmYmj1u2fE01b4TGRg==
Date: Thu, 8 Feb 2018 13:35:08 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [patch] kvm: suppress KVM_SET_GSI_ROUTING allocation failure
Message-ID: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KVM_SET_GSI_ROUTING ioctl does a vmalloc() of
sizeof(struct kvm_irq_routing_entry) multiplied by a user-supplied value.
This can be up to 4096 entries on architectures such as arm64 and s390
(and the upper bound may be increased on s390 eventually).

This can produce a vmalloc allocation failure warning:

vmalloc: allocation failure: 0 bytes, mode:0x24000c2(GFP_KERNEL|__GFP_HIGHMEM)
Call Trace:
 __dump_stack lib/dump_stack.c:15 [inline]
 dump_stack+0xf6/0x184 lib/dump_stack.c:51
 warn_alloc+0x208/0x230 mm/page_alloc.c:2930
 __vmalloc_node_range_memcg+0x510/0x670 mm/vmalloc.c:1711
 __vmalloc_node_memcg mm/vmalloc.c:1751 [inline]
 __vmalloc_node_memcg_flags mm/vmalloc.c:1788 [inline]
 vmalloc+0x69/0x70 mm/vmalloc.c:1803
 kvm_vm_ioctl+0x910/0x15e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4153
 vfs_ioctl fs/ioctl.c:44 [inline]
 do_vfs_ioctl+0x842/0xee0 fs/ioctl.c:611
 SYSC_ioctl fs/ioctl.c:626 [inline]
 SyS_ioctl+0x94/0xc0 fs/ioctl.c:617
 entry_SYSCALL_64_fastpath+0x12/0x17

If the vmalloc address space is fully depleted, the ioctl can gracefully
fail.  Add __GFP_NOWARN to the allocation to suppress the warning.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 virt/kvm/kvm_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 001085b611ad..d0352dd45b95 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3063,7 +3063,8 @@ static long kvm_vm_ioctl(struct file *filp,
 			goto out;
 		if (routing.nr) {
 			r = -ENOMEM;
-			entries = vmalloc(routing.nr * sizeof(*entries));
+			entries = __vmalloc(routing.nr * sizeof(*entries),
+					GFP_KERNEL | __GFP_NOWARN, PAGE_KERNEL);
 			if (!entries)
 				goto out;
 			r = -EFAULT;

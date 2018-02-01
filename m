Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756031AbeBABbz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:31:55 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:51157 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755903AbeBABbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:31:53 -0500
X-Google-Smtp-Source: AH8x225Wu7vLyGt4E4sanq/t9Fp2LSYsglGDpA8ePF4rW+P3Sny448JXcV/YHJ9lqztYHoMzinxCEQ==
From: Eric Biggers <ebiggers3@gmail.com>
To: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Eric Biggers <ebiggers@google.com>
Subject: [PATCH] KVM/x86: remove WARN_ON() for when vm_munmap() fails
Date: Wed, 31 Jan 2018 17:30:21 -0800
Message-Id: <20180201013021.151884-1-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <001a1141c71c13f559055d1b28eb@google.com>
References: <001a1141c71c13f559055d1b28eb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

On x86, special KVM memslots such as the TSS region have anonymous
memory mappings created on behalf of userspace, and these mappings are
removed when the VM is destroyed.

It is however possible for removing these mappings via vm_munmap() to
fail.  This can most easily happen if the thread receives SIGKILL while
it's waiting to acquire ->mmap_sem.   This triggers the 'WARN_ON(r < 0)'
in __x86_set_memory_region().  syzkaller was able to hit this, using
'exit()' to send the SIGKILL.  Note that while the vm_munmap() failure
results in the mapping not being removed immediately, it is not leaked
forever but rather will be freed when the process exits.

It's not really possible to handle this failure properly, so almost
every other caller of vm_munmap() doesn't check the return value.  It's
a limitation of having the kernel manage these mappings rather than
userspace.

So just remove the WARN_ON() so that users can't spam the kernel log
with this warning.

Fixes: f0d648bdf0a5 ("KVM: x86: map/unmap private slots in __x86_set_memory_region")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/kvm/x86.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c53298dfbf50..53b57f18baec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8272,10 +8272,8 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
 			return r;
 	}
 
-	if (!size) {
-		r = vm_munmap(old.userspace_addr, old.npages * PAGE_SIZE);
-		WARN_ON(r < 0);
-	}
+	if (!size)
+		vm_munmap(old.userspace_addr, old.npages * PAGE_SIZE);
 
 	return 0;
 }
-- 
2.16.0.rc1.238.g530d649a79-goog

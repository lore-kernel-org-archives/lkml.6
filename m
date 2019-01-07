Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6183C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9B12089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866479;
	bh=WVFlBJrIMisn3GqkCjLxkotvdvT8KqzQVw1MJaC6jZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yiqTaH2rHmktOkmh2FnmZDq5kmhW5sUuCai7JtfpZyfvqjh6xNr4k4ts5bWw9GBLl
	 sWXi9LRp9S1W3+u0YTrmQnHsup7Dq61vR6Ya2e3wvY53W4y28LEv5VVmPrKQRJBPy6
	 8ChsQQrq9IDjrsOse+cDg9drgCmVtmLlCQ3Zu/as=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfAGNH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:07:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbfAGNH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:07:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC522089F;
        Mon,  7 Jan 2019 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866475;
        bh=WVFlBJrIMisn3GqkCjLxkotvdvT8KqzQVw1MJaC6jZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0zHo4n/GGNXA5TiR/JbNgcxWCr6MV6XqWrYy6eJLDVj5sBZPru4DlN7rjuYgvyun9
         hzO0ZBFKqEaDHX9ev1/XAx6j2AUbPC1ahC9+b1MMLEygYSXCV0dzH53Hh5ZGrWBCLl
         TTjKmbuH8hUjkfI+M/bMaAHE1qgxxTeD5aRhTyu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 43/71] KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup
Date:   Mon,  7 Jan 2019 13:33:12 +0100
Message-Id: <20190107105335.199180221@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit e81434995081fd7efb755fd75576b35dbb0850b1 upstream.

____kvm_handle_fault_on_reboot() provides a generic exception fixup
handler that is used to cleanly handle faults on VMX/SVM instructions
during reboot (or at least try to).  If there isn't a reboot in
progress, ____kvm_handle_fault_on_reboot() treats any exception as
fatal to KVM and invokes kvm_spurious_fault(), which in turn generates
a BUG() to get a stack trace and die.

When it was originally added by commit 4ecac3fd6dc2 ("KVM: Handle
virtualization instruction #UD faults during reboot"), the "call" to
kvm_spurious_fault() was handcoded as PUSH+JMP, where the PUSH'd value
is the RIP of the faulting instructing.

The PUSH+JMP trickery is necessary because the exception fixup handler
code lies outside of its associated function, e.g. right after the
function.  An actual CALL from the .fixup code would show a slightly
bogus stack trace, e.g. an extra "random" function would be inserted
into the trace, as the return RIP on the stack would point to no known
function (and the unwinder will likely try to guess who owns the RIP).

Unfortunately, the JMP was replaced with a CALL when the macro was
reworked to not spin indefinitely during reboot (commit b7c4145ba2eb
"KVM: Don't spin on virt instruction faults during reboot").  This
causes the aforementioned behavior where a bogus function is inserted
into the stack trace, e.g. my builds like to blame free_kvm_area().

Revert the CALL back to a JMP.  The changelog for commit b7c4145ba2eb
("KVM: Don't spin on virt instruction faults during reboot") contains
nothing that indicates the switch to CALL was deliberate.  This is
backed up by the fact that the PUSH <insn RIP> was left intact.

Note that an alternative to the PUSH+JMP magic would be to JMP back
to the "real" code and CALL from there, but that would require adding
a JMP in the non-faulting path to avoid calling kvm_spurious_fault()
and would add no value, i.e. the stack trace would be the same.

Using CALL:

------------[ cut here ]------------
kernel BUG at /home/sean/go/src/kernel.org/linux/arch/x86/kvm/x86.c:356!
invalid opcode: 0000 [#1] SMP
CPU: 4 PID: 1057 Comm: qemu-system-x86 Not tainted 4.20.0-rc6+ #75
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
RIP: 0010:kvm_spurious_fault+0x5/0x10 [kvm]
Code: <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 55 49 89 fd 41
RSP: 0018:ffffc900004bbcc8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888273fd8000 R08: 00000000000003e8 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000784 R12: ffffc90000371fb0
R13: 0000000000000000 R14: 000000026d763cf4 R15: ffff888273fd8000
FS:  00007f3d69691700(0000) GS:ffff888277800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f89bc56fe0 CR3: 0000000271a5a001 CR4: 0000000000362ee0
Call Trace:
 free_kvm_area+0x1044/0x43ea [kvm_intel]
 ? vmx_vcpu_run+0x156/0x630 [kvm_intel]
 ? kvm_arch_vcpu_ioctl_run+0x447/0x1a40 [kvm]
 ? kvm_vcpu_ioctl+0x368/0x5c0 [kvm]
 ? kvm_vcpu_ioctl+0x368/0x5c0 [kvm]
 ? __set_task_blocked+0x38/0x90
 ? __set_current_blocked+0x50/0x60
 ? __fpu__restore_sig+0x97/0x490
 ? do_vfs_ioctl+0xa1/0x620
 ? __x64_sys_futex+0x89/0x180
 ? ksys_ioctl+0x66/0x70
 ? __x64_sys_ioctl+0x16/0x20
 ? do_syscall_64+0x4f/0x100
 ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
Modules linked in: vhost_net vhost tap kvm_intel kvm irqbypass bridge stp llc
---[ end trace 9775b14b123b1713 ]---

Using JMP:

------------[ cut here ]------------
kernel BUG at /home/sean/go/src/kernel.org/linux/arch/x86/kvm/x86.c:356!
invalid opcode: 0000 [#1] SMP
CPU: 6 PID: 1067 Comm: qemu-system-x86 Not tainted 4.20.0-rc6+ #75
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
RIP: 0010:kvm_spurious_fault+0x5/0x10 [kvm]
Code: <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 55 49 89 fd 41
RSP: 0018:ffffc90000497cd0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88827058bd40 R08: 00000000000003e8 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000784 R12: ffffc90000369fb0
R13: 0000000000000000 R14: 00000003c8fc6642 R15: ffff88827058bd40
FS:  00007f3d7219e700(0000) GS:ffff888277900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3d64001000 CR3: 0000000271c6b004 CR4: 0000000000362ee0
Call Trace:
 vmx_vcpu_run+0x156/0x630 [kvm_intel]
 ? kvm_arch_vcpu_ioctl_run+0x447/0x1a40 [kvm]
 ? kvm_vcpu_ioctl+0x368/0x5c0 [kvm]
 ? kvm_vcpu_ioctl+0x368/0x5c0 [kvm]
 ? __set_task_blocked+0x38/0x90
 ? __set_current_blocked+0x50/0x60
 ? __fpu__restore_sig+0x97/0x490
 ? do_vfs_ioctl+0xa1/0x620
 ? __x64_sys_futex+0x89/0x180
 ? ksys_ioctl+0x66/0x70
 ? __x64_sys_ioctl+0x16/0x20
 ? do_syscall_64+0x4f/0x100
 ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
Modules linked in: vhost_net vhost tap kvm_intel kvm irqbypass bridge stp llc
---[ end trace f9daedb85ab3ddba ]---

Fixes: b7c4145ba2eb ("KVM: Don't spin on virt instruction faults during reboot")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1324,7 +1324,7 @@ asmlinkage void kvm_spurious_fault(void)
 	"cmpb $0, kvm_rebooting \n\t"	      \
 	"jne 668b \n\t"      		      \
 	__ASM_SIZE(push) " $666b \n\t"	      \
-	"call kvm_spurious_fault \n\t"	      \
+	"jmp kvm_spurious_fault \n\t"	      \
 	".popsection \n\t" \
 	_ASM_EXTABLE(666b, 667b)
 



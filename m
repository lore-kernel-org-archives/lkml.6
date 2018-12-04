Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99613C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA20214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQgDhiCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA20214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeLDK54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbeLDK5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C52214C1;
        Tue,  4 Dec 2018 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921072;
        bh=aAde/MsE0Ky4NSjsnp7mr2ZLaqyWM0gYwlELHu82ljA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQgDhiCbUh3lcB9vO7IBG926vyyM96kC0tgkkmbGqUQj1YUNnE/W3h3VxgFDz4nz3
         jnC6QDEBAnUR2gnV9XzyJU4rsajXPBiokCICJzwwgwt2/rLzzz9KUVx6ZscHd+t/Ns
         ugmC+ljrYRGhwjO4bC3ZYc6JoDt5fO+YB8R8KLpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Wu <ww9210@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 4.19 068/139] KVM: X86: Fix scan ioapic use-before-initialization
Date:   Tue,  4 Dec 2018 11:49:09 +0100
Message-Id: <20181204103652.848324523@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpengli@tencent.com>

commit e97f852fd4561e77721bb9a4e0ea9d98305b1e93 upstream.

Reported by syzkaller:

 BUG: unable to handle kernel NULL pointer dereference at 00000000000001c8
 PGD 80000003ec4da067 P4D 80000003ec4da067 PUD 3f7bfa067 PMD 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 7 PID: 5059 Comm: debug Tainted: G           OE     4.19.0-rc5 #16
 RIP: 0010:__lock_acquire+0x1a6/0x1990
 Call Trace:
  lock_acquire+0xdb/0x210
  _raw_spin_lock+0x38/0x70
  kvm_ioapic_scan_entry+0x3e/0x110 [kvm]
  vcpu_enter_guest+0x167e/0x1910 [kvm]
  kvm_arch_vcpu_ioctl_run+0x35c/0x610 [kvm]
  kvm_vcpu_ioctl+0x3e9/0x6d0 [kvm]
  do_vfs_ioctl+0xa5/0x690
  ksys_ioctl+0x6d/0x80
  __x64_sys_ioctl+0x1a/0x20
  do_syscall_64+0x83/0x6e0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The reason is that the testcase writes hyperv synic HV_X64_MSR_SINT6 msr
and triggers scan ioapic logic to load synic vectors into EOI exit bitmap.
However, irqchip is not initialized by this simple testcase, ioapic/apic
objects should not be accessed.
This can be triggered by the following program:

    #define _GNU_SOURCE

    #include <endian.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/syscall.h>
    #include <sys/types.h>
    #include <unistd.h>

    uint64_t r[3] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff};

    int main(void)
    {
    	syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
    	long res = 0;
    	memcpy((void*)0x20000040, "/dev/kvm", 9);
    	res = syscall(__NR_openat, 0xffffffffffffff9c, 0x20000040, 0, 0);
    	if (res != -1)
    		r[0] = res;
    	res = syscall(__NR_ioctl, r[0], 0xae01, 0);
    	if (res != -1)
    		r[1] = res;
    	res = syscall(__NR_ioctl, r[1], 0xae41, 0);
    	if (res != -1)
    		r[2] = res;
    	memcpy(
    			(void*)0x20000080,
    			"\x01\x00\x00\x00\x00\x5b\x61\xbb\x96\x00\x00\x40\x00\x00\x00\x00\x01\x00"
    			"\x08\x00\x00\x00\x00\x00\x0b\x77\xd1\x78\x4d\xd8\x3a\xed\xb1\x5c\x2e\x43"
    			"\xaa\x43\x39\xd6\xff\xf5\xf0\xa8\x98\xf2\x3e\x37\x29\x89\xde\x88\xc6\x33"
    			"\xfc\x2a\xdb\xb7\xe1\x4c\xac\x28\x61\x7b\x9c\xa9\xbc\x0d\xa0\x63\xfe\xfe"
    			"\xe8\x75\xde\xdd\x19\x38\xdc\x34\xf5\xec\x05\xfd\xeb\x5d\xed\x2e\xaf\x22"
    			"\xfa\xab\xb7\xe4\x42\x67\xd0\xaf\x06\x1c\x6a\x35\x67\x10\x55\xcb",
    			106);
    	syscall(__NR_ioctl, r[2], 0x4008ae89, 0x20000080);
    	syscall(__NR_ioctl, r[2], 0xae80, 0);
    	return 0;
    }

This patch fixes it by bailing out scan ioapic if ioapic is not initialized in
kernel.

Reported-by: Wei Wu <ww9210@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wei Wu <ww9210@gmail.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7314,7 +7314,8 @@ static void vcpu_scan_ioapic(struct kvm_
 	else {
 		if (vcpu->arch.apicv_active)
 			kvm_x86_ops->sync_pir_to_irr(vcpu);
-		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
+		if (ioapic_in_kernel(vcpu->kvm))
+			kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 	}
 
 	if (is_guest_mode(vcpu))



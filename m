Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966824AbeEYPhn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:37:43 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966694AbeEYPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:37:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>, Wanpeng Li <wanpengli@tencent.com>,
        David Hildenbrand <david@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: VMX: fix building without CONFIG_HYPERV
Date: Fri, 25 May 2018 17:36:17 +0200
Message-Id: <20180525153640.3228067-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:zholDbXs/a/BZQD+yjoFV+Yq0HZjfvu2+yYd+GeN88IjZ454G0e
 g4FvFAcR3ZGMc4PPnmiDykEgNzpsC69/cu9d+PqRx4/hF2QAUR6sB4PYwzC1gMWJRXrkLbI
 RaHV9Gpl6clngOPanNpP+O+n1LjtHu/nKpZd5CnfRt+qUnRDNGJ6G4rBkpZEga79iRELycI
 pgLtr1MOCsuJD1xfBlgcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b2RsvZqalDY=:uwNuPhxW5KYzUVZ85VgpJt
 srMsl/5mLEjhVPx9ibAEPROivwhTYHnoCYWXa2+qj6GWE0AcxlVC7M/otFk9VKWjTrLdhsQcO
 rpoWkxRqbH/ClxVRYbF+Co8QNdCe4zRB3rGUZAE8ds5+YVVTVsEXKVfZPPDReU2ve7hW2QgeK
 /OeRG0mjX6LgeI2+STr9l3S0mulJI8LxFnVG6WhiA4d+dMZeaRHzNuj8eh2qLi7IJPX/+q6QZ
 QEzBZh5oXOl+9PWB+vak+MKJMTnvRvIx+NqrhmmpDYBglbLV5j1KFyMqrO6iQ9QNgesWqWmzF
 dPES87wbkO8Qb7K8aoSgj/0zU0mOI3XPPsXPLII830iWl9AmRILO3zISbyuAo8ApdIEj2jnLC
 7CoEh62fqehZdER02QZ77a8PXISHyRjQfOsiP9hWABoEHMxOc5abrwTKZsuk8ap1zNGxuqWeR
 +XfnT5TjSpj3ztdzenmC3hJBEhu7wIzkwTFHTlH5Rvd5vP4mQ0J9wpFSxFf7PJVuzCGWEVlSS
 gkC5wxgbcC+s32kWqldWOpgisjkAYWLL+dOd0tEH6aq1sLPXeWJsrQZ3/Xhbfx04kt+azr5Lq
 vcaIR+WFzQgQIkpQbhTgnqEZejgKhb5zeF9i3d1UTaOKoMQEkL8N8T2XZKrsCOQxNno1w+hMJ
 UY7h85YPSfBi8Fdxo9J3Tjf+Ed5Vizf67rSD83j5/VkPm0EpHq/wzcXZTNrXBHZad2rc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global ms_hyperv variable is part of the hyperv support, so
we get a link error from accessing it in kernels that have this
turned off:

arch/x86/kvm/vmx.o: In function `alloc_loaded_vmcs':
vmx.c:(.text+0x1654a): undefined reference to `ms_hyperv'
vmx.c:(.text+0x1657a): undefined reference to `ms_hyperv'

This changes the condition to first check the compile-time
configuration symbol to avoid the link error.

Fixes: ceef7d10dfb6 ("KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kvm/vmx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ea098131dcce..e6d6ccab43c3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4232,7 +4232,8 @@ static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 			goto out_vmcs;
 		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
 
-		if (static_branch_unlikely(&enable_evmcs) &&
+		if (IS_ENABLED(CONFIG_HYPERV) &&
+		    static_branch_unlikely(&enable_evmcs) &&
 		    (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
 			struct hv_enlightened_vmcs *evmcs =
 				(struct hv_enlightened_vmcs *)loaded_vmcs->vmcs;
-- 
2.9.0

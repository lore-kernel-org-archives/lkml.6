Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967892AbeCBMBs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:01:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45840 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936336AbeCBMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:01:45 -0500
Date: Fri, 2 Mar 2018 12:01:31 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] x86/MSR: Move native_* variants to msr.h
Message-ID: <20180302120131.5lehicnrwp3zy5p2@starbug-vm.ie.oracle.com>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
References: <20180301151336.12948-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20180301151336.12948-1-bp@alien8.de>
User-Agent: NeoMutt/20180223
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 04:13:36PM +0100, Borislav Petkov wrote:
>From: Borislav Petkov <bp@suse.de>
>
>... where they belong.
>
>No functionality change.
>
>Signed-off-by: Borislav Petkov <bp@suse.de>
>Cc: kvm@vger.kernel.org

Seems like the right place to put them.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> arch/x86/include/asm/microcode.h | 14 --------------
> arch/x86/include/asm/msr.h       | 14 ++++++++++++++
> arch/x86/kvm/svm.c               |  1 -
> arch/x86/kvm/vmx.c               |  1 -
> 4 files changed, 14 insertions(+), 16 deletions(-)
>
>diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
>index 7fb1047d61c7..871714e2e4c6 100644
>--- a/arch/x86/include/asm/microcode.h
>+++ b/arch/x86/include/asm/microcode.h
>@@ -6,20 +6,6 @@
> #include <linux/earlycpio.h>
> #include <linux/initrd.h>
>
>-#define native_rdmsr(msr, val1, val2)			\
>-do {							\
>-	u64 __val = __rdmsr((msr));			\
>-	(void)((val1) = (u32)__val);			\
>-	(void)((val2) = (u32)(__val >> 32));		\
>-} while (0)
>-
>-#define native_wrmsr(msr, low, high)			\
>-	__wrmsr(msr, low, high)
>-
>-#define native_wrmsrl(msr, val)				\
>-	__wrmsr((msr), (u32)((u64)(val)),		\
>-		       (u32)((u64)(val) >> 32))
>-
> struct ucode_patch {
> 	struct list_head plist;
> 	void *data;		/* Intel uses only this one */
>diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
>index 30df295f6d94..77254c9c8f61 100644
>--- a/arch/x86/include/asm/msr.h
>+++ b/arch/x86/include/asm/msr.h
>@@ -108,6 +108,20 @@ static inline void notrace __wrmsr(unsigned int msr, u32 low, u32 high)
> 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
> }
>
>+#define native_rdmsr(msr, val1, val2)			\
>+do {							\
>+	u64 __val = __rdmsr((msr));			\
>+	(void)((val1) = (u32)__val);			\
>+	(void)((val2) = (u32)(__val >> 32));		\
>+} while (0)
>+
>+#define native_wrmsr(msr, low, high)			\
>+	__wrmsr(msr, low, high)
>+
>+#define native_wrmsrl(msr, val)				\
>+	__wrmsr((msr), (u32)((u64)(val)),		\
>+		       (u32)((u64)(val) >> 32))
>+
> static inline unsigned long long native_read_msr(unsigned int msr)
> {
> 	unsigned long long val;
>diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>index cbd7ab74952e..c6dde6f1d848 100644
>--- a/arch/x86/kvm/svm.c
>+++ b/arch/x86/kvm/svm.c
>@@ -49,7 +49,6 @@
> #include <asm/debugreg.h>
> #include <asm/kvm_para.h>
> #include <asm/irq_remapping.h>
>-#include <asm/microcode.h>
> #include <asm/nospec-branch.h>
>
> #include <asm/virtext.h>
>diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>index cab6ea1f8be5..5f708478b66e 100644
>--- a/arch/x86/kvm/vmx.c
>+++ b/arch/x86/kvm/vmx.c
>@@ -51,7 +51,6 @@
> #include <asm/apic.h>
> #include <asm/irq_remapping.h>
> #include <asm/mmu_context.h>
>-#include <asm/microcode.h>
> #include <asm/nospec-branch.h>
>
> #include "trace.h"
>-- 
>2.13.0
>

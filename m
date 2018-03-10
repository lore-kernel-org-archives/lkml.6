Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu0mX9Ug02FHI7fN2GzceEn9mr9hSrzx53OyTvocFOW+BjJNBFizyceSt9+LCCXiePtj8SG
ARC-Seal: i=1; a=rsa-sha256; t=1520641284; cv=none;
        d=google.com; s=arc-20160816;
        b=bsP2sS3JYOK3R+2/qg7kACTNog1rEuXMF5T3P5fVd1vSbQK7Ite9+FGek10ZAPCbHO
         FzeC36f2agAVDqIXfI9thcLENIbidnW4GJlvaPZijkbD3n7yC8XCad2bjq+OOKVgG/Ln
         S2JU3qDSbw9UCDZ2fQpIOFSWeubApJXMibiDB4vTOTao0SW0dF6OaqYWUfpPTz5/mlsx
         E1FfKUeeFkC4sDOOkEcMBvliG4GFhAaG8EYS15nwyd/bjDbjHyztkGY6Rr6xTaOxjVUo
         ge90VuIJWHKeKawArsuJ1E1EoRPLUUvG0oKD0rNUNRkKTAWWvDKR9VckWM9QQ9yWpnyW
         0PZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oqTS2s6PCDk8FpeqKIm7WjVx5ndpnupPjxqY8nRo7Fk=;
        b=qYjHn4BPqTUoXq5lGN00ocLM8QuommK7tXXS1w/n1Yt2szcPaiR6pmdPLYvybIOYpX
         5fcF7lriwkUGul3CLv1Z+lkRcye+Tdu0YjwZp5yjuVYavE30p+6X9snZ+/Q5l2I9xY8S
         2RyVRX02yDdKK8ZmpEBXdRRGIOxiKzjgtjnu3T+MtEhMNBNEbIa8JwkMgAigyUzyqjnI
         8uTioBAK/tUyVHUCvfxxuVxZ3lVuqf63+L/a12p3OKdWqPuWcc57JveRbS1oLQbWkvZW
         yhUVxu8hyOweCZtheQ8dcobDU0E3sFao+A6lh02rH/5u336QCgV9qHh5qiCyyEdNZtgX
         kOvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 4.9 20/65] ARM: kvm: fix building with gcc-8
Date: Fri,  9 Mar 2018 16:18:20 -0800
Message-Id: <20180310001826.586782429@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507955197198315?=
X-GMAIL-MSGID: =?utf-8?q?1594507955197198315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 67870eb1204223598ea6d8a4467b482e9f5875b5 upstream.

In banked-sr.c, we use a top-level '__asm__(".arch_extension virt")'
statement to allow compilation of a multi-CPU kernel for ARMv6
and older ARMv7-A that don't normally support access to the banked
registers.

This is considered to be a programming error by the gcc developers
and will no longer work in gcc-8, where we now get a build error:

/tmp/cc4Qy7GR.s:34: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_usr'
/tmp/cc4Qy7GR.s:41: Error: Banked registers are not available with this architecture. -- `mrs r3,ELR_hyp'
/tmp/cc4Qy7GR.s:55: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_svc'
/tmp/cc4Qy7GR.s:62: Error: Banked registers are not available with this architecture. -- `mrs r3,LR_svc'
/tmp/cc4Qy7GR.s:69: Error: Banked registers are not available with this architecture. -- `mrs r3,SPSR_svc'
/tmp/cc4Qy7GR.s:76: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_abt'

Passign the '-march-armv7ve' flag to gcc works, and is ok here, because
we know the functions won't ever be called on pre-ARMv7VE machines.
Unfortunately, older compiler versions (4.8 and earlier) do not understand
that flag, so we still need to keep the asm around.

Backporting to stable kernels (4.6+) is needed to allow those to be built
with future compilers as well.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84129
Fixes: 33280b4cd1dc ("ARM: KVM: Add banked registers save/restore")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kvm/hyp/Makefile    |    5 +++++
 arch/arm/kvm/hyp/banked-sr.c |    4 ++++
 2 files changed, 9 insertions(+)

--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -6,6 +6,8 @@ ccflags-y += -fno-stack-protector -DDISA
 
 KVM=../../../../virt/kvm
 
+CFLAGS_ARMV7VE		   :=$(call cc-option, -march=armv7ve)
+
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
@@ -14,7 +16,10 @@ obj-$(CONFIG_KVM_ARM_HOST) += tlb.o
 obj-$(CONFIG_KVM_ARM_HOST) += cp15-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += vfp.o
 obj-$(CONFIG_KVM_ARM_HOST) += banked-sr.o
+CFLAGS_banked-sr.o	   += $(CFLAGS_ARMV7VE)
+
 obj-$(CONFIG_KVM_ARM_HOST) += entry.o
 obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
 obj-$(CONFIG_KVM_ARM_HOST) += switch.o
+CFLAGS_switch.o		   += $(CFLAGS_ARMV7VE)
 obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
--- a/arch/arm/kvm/hyp/banked-sr.c
+++ b/arch/arm/kvm/hyp/banked-sr.c
@@ -20,6 +20,10 @@
 
 #include <asm/kvm_hyp.h>
 
+/*
+ * gcc before 4.9 doesn't understand -march=armv7ve, so we have to
+ * trick the assembler.
+ */
 __asm__(".arch_extension     virt");
 
 void __hyp_text __banked_save_state(struct kvm_cpu_context *ctxt)

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3904521-1518516681-2-1287866435747739853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518516680; b=SDwdl2oX3VeDH4+Q4629LCT6jxvYpguZeDW0u+ZxX0IjQ0P
    X/0id4KzLz1uiArKX3rYq5aDQA2VQiVB8+je7IpjqZzU0KI4mDzQkMYKMqPlKU5p
    e9DqDhXQ7GFZBLW9XlD+sua5Btn8kMddzUSEM30fSajb1rhtFsAwmlNfKeJy0IBr
    Pvr792C3HG5dulBAsaKzx0PbH/gJI5JSpa9/MF4SYKgePTvJ9l4kohhDTemXpJUj
    b09osAeqAyexfGFbqF/U3zVXCH04lr8ZLNxd0WYH544ztu/Vzt6era2Y1cubj1yo
    WRBLZnVoekihaLeVnhVBVUF3XM3Bv+W5ldBHaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518516680;
    bh=8YSme3e5GreUZD2LEC14sjAKNsucBcS12JOW6sCjUZs=; b=ZbrE3mDowCdA
    U/i+2/Lb51SmiLEdBenjwSzGJrkDuxtZl+q/jzpXbY7J0fncEFbXmHK1ckHh+Cc5
    rUVFwIML6eeqjlBy0RroLXtamEP+7VNAskLdQ7d2C+l7O6OCDpqFnPq/uCrIU8mB
    FSuzKp+anRoLu2oSloG+AfO2rN3llLfBntzedIhuW5L1Ztf2NUq7yu3j9gri6z42
    IGyx05s7g//kIcLZB6Kgq3HMVGIo9rJVNkKybrIeUnR1OOO51OLtINQmr+t8K3XK
    uonSvYMynRPOJUVrqXtV2p7KZ7MnKu4dqUOw4CZz7EK2+AJ2foR6yZJRDfGEteOP
    AuPLS+bsIA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934047AbeBMKLQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 05:11:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933865AbeBMKLN (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Feb 2018 05:11:13 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com, Baoquan He <bhe@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 2/5] x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
Date: Tue, 13 Feb 2018 18:10:48 +0800
Message-Id: <20180213101051.13630-3-bhe@redhat.com>
In-Reply-To: <20180213101051.13630-1-bhe@redhat.com>
References: <20180213101051.13630-1-bhe@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a regression fix.

Before, to fix erratum AVR31, commit 522e66464467 ("x86/apic: Disable
I/O APIC before shutdown of the local APIC") moved lapic_shutdown()
calling after disable_IO_APIC() in reboot and kexec/kdump code path.
This introdued a regression. The root cause is that disable_IO_APIC()
not only clears IO_APIC, also restore boot irq mode by setting
LAPIC/APIC/IMCR, calling lapic_shutdown() after disable_IO_APIC() will
disable LAPIC and ruin the possible virtual wire mode setting which
the code has been trying to do all along.

The consequence is, in KVM guest kernel always prints warning as below
during kexec/kdump kernel boots up. That happened in setup_local_APIC()
since 'do { xxx } while (queued && max_loops > 0)' loop does not function
well any more if pending irq exists in APIC IRR after LAPIC is disabled.

[    0.001000] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1467 setup_local_APIC+0x228/0x330
[    0.001000] Modules linked in:
[    0.001000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc5+ #3
[    0.001000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
[    0.001000] RIP: 0010:setup_local_APIC+0x228/0x330
[    0.001000] RSP: 0000:ffffffffb6e03eb8 EFLAGS: 00010286
[    0.001000] RAX: 0000009edb4c4d84 RBX: 0000000000000000 RCX: 00000000b099d800
[    0.001000] RDX: 0000009e00000000 RSI: 0000000000000000 RDI: 0000000000000810
[    0.001000] RBP: 0000000000000000 R08: ffffffffffffffff R09: 0000000000000001
[    0.001000] R10: ffff98ce6a801c00 R11: 0761076d072f0776 R12: 0000000000000001
[    0.001000] R13: 00000000000000f0 R14: 0000000000004000 R15: ffffffffffffc6ff
[    0.001000] FS:  0000000000000000(0000) GS:ffff98ce6bc00000(0000) knlGS:0000000000000000
[    0.001000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.001000] CR2: 00000000ffffffff CR3: 0000000022209000 CR4: 00000000000406b0
[    0.001000] Call Trace:
[    0.001000]  apic_bsp_setup+0x56/0x74
[    0.001000]  x86_late_time_init+0x11/0x16
[    0.001000]  start_kernel+0x3c9/0x486
[    0.001000]  secondary_startup_64+0xa5/0xb0
[    0.001000] Code: 00 85 c9 74 2d 0f 31 c1 e1 0a 48 c1 e2 20 41 89 cf 4c 03 7c 24 08 48 09 d0 49 29 c7 4c 89 3c 24 48 83 3c 24 00 0f 8f 8f fe ff
ff <0f> ff e9 10 ff ff ff 48 83 2c 24 01 eb e7 48 83 c4 18 5b 5d 41
[    0.001000] ---[ end trace b88e71b9a6ebebdd ]---
[    0.001000] masked ExtINT on CPU#0

To fix this, just break down disable_IO_APIC(), then call
clear_IO_APIC() to stop IO_APIC where disable_IO_APIC() was called,
and call restore_boot_irq_mode() to restore boot irq mode before
reboot or kexec/kdump jump.

As for KEXEC_JUMP, it's a little different then reboot and kexec/kdump.
It doesn't call lapic_shutdown() before jump, so is not impacted by
commit 522e66464467. Here in order to keep it the same as the old code,
replace the old disable_IO_APIC() with clear_IO_APIC() and
restore_boot_irq_mode().

Signed-off-by: Baoquan He <bhe@redhat.com>
Fixes: commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown of the local APIC") 
Cc: stable@vger.kernel.org
---
v4->v3:
  Eric pointed out the change related to KEXEC_JUMP is not right.
  Correct it.

  Add Fixes tag and Cc to stable.

 arch/x86/include/asm/io_apic.h     | 1 +
 arch/x86/kernel/apic/io_apic.c     | 2 +-
 arch/x86/kernel/crash.c            | 3 ++-
 arch/x86/kernel/machine_kexec_32.c | 3 ++-
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 arch/x86/kernel/reboot.c           | 3 ++-
 6 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 558d1a6a13ad..0fa95bfacb39 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -193,6 +193,7 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
 extern void setup_IO_APIC(void);
 extern void enable_IO_APIC(void);
 extern void disable_IO_APIC(void);
+extern void clear_IO_APIC(void);
 extern void restore_boot_irq_mode(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
 extern void print_IO_APICs(void);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7b73b6b9b4b6..2d7cd2db77f5 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -587,7 +587,7 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 		       mpc_ioapic_id(apic), pin);
 }
 
-static void clear_IO_APIC (void)
+void clear_IO_APIC (void)
 {
 	int apic, pin;
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 10e74d4778a1..1f6680427ff0 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -199,9 +199,10 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_X86_IO_APIC
 	/* Prevent crash_kexec() from deadlocking on ioapic_lock. */
 	ioapic_zap_locks();
-	disable_IO_APIC();
+	clear_IO_APIC();
 #endif
 	lapic_shutdown();
+	restore_boot_irq_mode();
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index edfede768688..4cd79d88a4ac 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -199,7 +199,8 @@ void machine_kexec(struct kimage *image)
 		 * one form or other. kexec jump path also need
 		 * one.
 		 */
-		disable_IO_APIC();
+		clear_IO_APIC();
+		restore_boot_irq_mode();
 #endif
 	}
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1f790cf9d38f..2ab14b9c1a89 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -297,7 +297,8 @@ void machine_kexec(struct kimage *image)
 		 * one form or other. kexec jump path also need
 		 * one.
 		 */
-		disable_IO_APIC();
+		clear_IO_APIC();
+		restore_boot_irq_mode();
 #endif
 	}
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 2126b9d27c34..725624b6c0c0 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -666,7 +666,7 @@ void native_machine_shutdown(void)
 	 * Even without the erratum, it still makes sense to quiet IO APIC
 	 * before disabling Local APIC.
 	 */
-	disable_IO_APIC();
+	clear_IO_APIC();
 #endif
 
 #ifdef CONFIG_SMP
@@ -680,6 +680,7 @@ void native_machine_shutdown(void)
 #endif
 
 	lapic_shutdown();
+	restore_boot_irq_mode();
 
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
-- 
2.13.6

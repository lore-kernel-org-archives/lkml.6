Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1904769-1518587298-2-457866875247156780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518587297; b=a2TOHKBx5Ai6OUOMZ7Zc75mgr3l83yvN65ZOkHwOYjziV+g
    DJTUF35b4bR54m26GaYx68BKdX3Hnwe5fkRsH/zA0Ujg0uHVTPgz8vKTXeDspTi2
    Dw8Qe0yP8jaOCjgelQT/UoPUI9kizXprfv+WtPDh72aXizkVMowONKhFOkH535U7
    XAAj3B/X46K6+TskVkVxi1+sXMjaSXEV6w5mkPqMgFzVQNfhM3GRkxJKFXaf0vrA
    GoMK2v5KAb8E2+OgnfENghy6f5l/LehWfYAePcZJvQGlR/vNY3GtJutFqG9/1bI1
    dkiPgK48trBJULOrOFrNaQnWnhKdUOGpPEAZ59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518587297;
    bh=vqQTTGO13y7Qmy6RZc4yd/7kYQNqs2Ddux8+FuWLlcQ=; b=S1KL6kEfp5nb
    1NK/z6kn52lI7UdBSdYvlN9EG3N4lOaO8AwQG0xMd8jW67SoUvPVobRAyDTiuZV8
    N6PX+gtJPBAqgXll2vsx550GXzuD2lrDoydiEoRMaRilr0Kd4js4P9kRtI7Adpwe
    Yv8G17RJuL8QY1+otTYE/XzQ8xzn7uNNnnTk8fSTux4XoP5uxWfRH+FiTz5h1pAg
    jOjBz+em6pRJp2gFemhUTWz61S0uaonPT15U2WNOUvZ5XcqWGfS/iEuyQWnz4v4f
    Xkk6VYKbv4E49dVa3runGxuXpvKc9AOBmReA327t3JCQL5rn+QvD2KwdICqR0Ce1
    s2D45C0XSQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeBNFr1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 00:47:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754300AbeBNFr0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Feb 2018 00:47:26 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com, Baoquan He <bhe@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 3/6] x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
Date: Wed, 14 Feb 2018 13:46:53 +0800
Message-Id: <20180214054656.3780-4-bhe@redhat.com>
In-Reply-To: <20180214054656.3780-1-bhe@redhat.com>
References: <20180214054656.3780-1-bhe@redhat.com>
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

To fix this, just call clear_IO_APIC() to stop IO_APIC where
disable_IO_APIC() was called, and call restore_boot_irq_mode() to
restore boot irq mode before reboot or kexec/kdump jump.

Signed-off-by: Baoquan He <bhe@redhat.com>
Fixes: commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown of the local APIC")
Cc: stable@vger.kernel.org
---
v4->v5:
  Take the change related to KEXEC_JUMP out to new patch 0002.

v4->v3:
  Eric pointed out the change related to KEXEC_JUMP is not right.
  Correct it.

  Add Fixes tag and Cc to stable.

 arch/x86/kernel/crash.c  | 3 ++-
 arch/x86/kernel/reboot.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414919-2-4041723293364086656
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414918; b=FsLGHCTRIedpXqQHdaE6RdMnbPB+Qk5qs/IQqkC3q8DUh2L
    f/GSR+CSQrNp70+tcTTQY6NAk8Fr1eGuZW90cVMY3KdTzzA8aPoRxaubx65m7Rgq
    /Z0/3K+jBASczGyLEDIJVYGeafcjx5QGUQAz99NBDZ+2cJPNLkINu0MF0njpuk0q
    Y/E9hsyz+XJUG70vzt+hasFKPx1lChZyRkyQQCMcvmkKgiCL1xtLINrOsBFhbL/X
    Sj+qbpRp71xLVl5yZIr2JC2jtYMhaH49JpNN11ySmG72UaqSynGRSpLj1UApD5U+
    fLCmDnDNPy835xEitqOh0tp59W/8XS76D/uV6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414918; bh=rulrJfhth68c+Gja/rZGjzjEV7
    PhRO0lNp9YoijfQJU=; b=pLKtC3lzu55K4mUcjRPfd+59aC2eXi2ZVd4bT/xKY2
    Ac2c8payHsyrgpBjJ3Ucauogycnv1fmPLrGBIZLPwVHYleOw+TgmOvdHFGcQa/qu
    yPo6iM4Z2U08y4j2BIRyfHAs6W7Dz2BzhbyVWgcRTu1VIU11qx9We8WtJ0DnP6Rk
    hrXVEJv25ky3MD5ZUVU2aES+aefiztmZtebY771Ae4h8zObsBFmLY7s5vagGR2Nd
    /2fufkGfT1rhh8AYbHgiEfsvqSyoMadzoRNo6LlB7sbTfmYsdVKnzYGhWkHNixbU
    ngfutM2Fp5qeFsPpO68zeyZyvVMha+7VEn/P/yMst2gg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934449AbeBWSsp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:48:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933827AbeBWSsm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 141/145] x86/microcode/AMD: Change load_microcode_amd()s param to bool to fix preemptibility bug
Date: Fri, 23 Feb 2018 19:27:27 +0100
Message-Id: <20180223170742.924579868@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit dac6ca243c4c49a9ca7507d3d66140ebfac8b04b upstream.

With CONFIG_DEBUG_PREEMPT enabled, I get:

  BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
  caller is debug_smp_processor_id
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc2+ #2
  Call Trace:
   dump_stack
   check_preemption_disabled
   debug_smp_processor_id
   save_microcode_in_initrd_amd
   ? microcode_init
   save_microcode_in_initrd
   ...

because, well, it says it above, we're using smp_processor_id() in
preemptible code.

But passing the CPU number is not really needed. It is only used to
determine whether we're on the BSP, and, if so, to save the microcode
patch for early loading.

 [ We don't absolutely need to do it on the BSP but we do that
   customarily there. ]

Instead, convert that function parameter to a boolean which denotes
whether the patch should be saved or not, thereby avoiding the use of
smp_processor_id() in preemptible code.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170528200414.31305-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[arnd: rebased to 4.9, after running into warning:
 arch/x86/kernel/cpu/microcode/amd.c:881:30: self-comparison always evaluates to true]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/microcode_amd.h |    1 -
 arch/x86/kernel/cpu/microcode/amd.c  |   17 +++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -59,7 +59,6 @@ static inline u16 find_equiv_id(struct e
 
 extern int __apply_microcode_amd(struct microcode_amd *mc_amd);
 extern int apply_microcode_amd(int cpu);
-extern enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t size);
 
 #define PATCH_MAX_SIZE PAGE_SIZE
 
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -135,6 +135,9 @@ static size_t compute_container_size(u8
 	return size;
 }
 
+static enum ucode_state
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size);
+
 /*
  * Early load occurs before we can vmalloc(). So we look for the microcode
  * patch container file in initrd, traverse equivalent cpu table, look for a
@@ -451,7 +454,7 @@ int __init save_microcode_in_initrd_amd(
 	eax   = cpuid_eax(0x00000001);
 	eax   = ((eax >> 8) & 0xf) + ((eax >> 20) & 0xff);
 
-	ret = load_microcode_amd(smp_processor_id(), eax, container, container_size);
+	ret = load_microcode_amd(true, eax, container, container_size);
 	if (ret != UCODE_OK)
 		retval = -EINVAL;
 
@@ -864,7 +867,8 @@ static enum ucode_state __load_microcode
 	return UCODE_OK;
 }
 
-enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t size)
+static enum ucode_state
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 {
 	enum ucode_state ret;
 
@@ -878,8 +882,8 @@ enum ucode_state load_microcode_amd(int
 
 #ifdef CONFIG_X86_32
 	/* save BSP's matching patch for early load */
-	if (cpu_data(cpu).cpu_index == boot_cpu_data.cpu_index) {
-		struct ucode_patch *p = find_patch(cpu);
+	if (save) {
+		struct ucode_patch *p = find_patch(0);
 		if (p) {
 			memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
 			memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data),
@@ -911,11 +915,12 @@ static enum ucode_state request_microcod
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	bool bsp = c->cpu_index == boot_cpu_data.cpu_index;
 	enum ucode_state ret = UCODE_NFOUND;
 	const struct firmware *fw;
 
 	/* reload ucode container only on the boot cpu */
-	if (!refresh_fw || c->cpu_index != boot_cpu_data.cpu_index)
+	if (!refresh_fw || !bsp)
 		return UCODE_OK;
 
 	if (c->x86 >= 0x15)
@@ -932,7 +937,7 @@ static enum ucode_state request_microcod
 		goto fw_release;
 	}
 
-	ret = load_microcode_amd(cpu, c->x86, fw->data, fw->size);
+	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
 
  fw_release:
 	release_firmware(fw);

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415773-5-236091170349909235
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415773; b=sn0bzhVlyETcwlwqadgXQ8SJui0eqaDxO0R0Kg+M3p0SHZa
    Eb06VG7cHrxFvyXWgeqkGxGRm4fAsvbUW055ocZTNMkokmm1ovF46RKNNqkiT0F6
    whBlJj54afBDgaqn6a+3bkvU9SU3Fw82JRHk1PG4fGU5VgP7V+Fa2LMz1/3qVIgu
    3owS46AfQkZ0eFdoQDnnOZdvxT3uNdFedtU8Q7uGrKmBoBFsfXCGACK3EJJxe7Pb
    a7Y8OFbfJBTTdR7bt9/q1Kdghr8ppgtKHJNPblkW57xZn8PCkIwZxJikjO9DGbnm
    SAfNNlvIizEalfzSCspaS/XkWI0dVgQKSWDlpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415773; bh=mLLsLwpSlzn2jQq4PPrnyW6m+Q
    o2nfMIEp5Hxv6XO00=; b=iS/AVASBF+L5iJQKoq54RG1bzRDS2RNo75XuXkJFFW
    7UQLbnzy2iSX7xvXfuJ1Ts4Q+mpqCLCrPz7vKQeOj2Q07OpC+qc/6aN+jJq8y8yN
    FPJ9Zk0vbj+at5b0Pp1IPmREvYpK1BOG6YsiyBBSZzC82YNG/dRvZL93Dqvvob1R
    nGqCA5Yai6ZIkfOckEIQ8HciB9qLsJ9o0wjjQwJ6FMdfBNtA5ovzUZE+QTk1r9mH
    COWq1P5D0tA8ojTQMP0uwizifi5aqVk6RhhaxX6ZJIz7tgfshRNwe1yuYmj/QqtI
    4CL4eqcZaZAys6iIcVI+KzEt2fVq5RWJmMdE+JMYktMg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933673AbeBWSo5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:44:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933660AbeBWSoz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 043/145] ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context
Date: Fri, 23 Feb 2018 19:25:49 +0100
Message-Id: <20180223170730.472205159@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>


[ Upstream commit d09220a887f70368afa79e850c95e74890c0a32d ]

With the CMA changes from Joonsoo Kim <iamjoonsoo.kim@lge.com>, it
was noticed that n900 stopped booting. After investigating it turned
out that n900 save_secure_ram_context does some whacky virtual to
physical address translation for the SRAM data address.

As we now only have minimal parts of omap3 idle code copied to SRAM,
running save_secure_ram_context() in SRAM is not needed. It only gets
called on PM init. And it seems there's no need to ever call this from
SRAM idle code.

So let's just keep save_secure_ram_context() in DDR, and pass it the
physical address of the parameters. We can do everything else in
omap-secure.c like we already do for other secure code.

And since we don't have any documentation, I still have no clue what
the values for 0, 1 and 1 for the parameters might be. If somebody has
figured it out, please do send a patch to add some comments.

Debugged-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/omap-secure.c |   19 +++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.h |    4 ++++
 arch/arm/mach-omap2/pm.h          |    4 ----
 arch/arm/mach-omap2/pm34xx.c      |   13 ++++---------
 arch/arm/mach-omap2/sleep34xx.S   |   26 ++++----------------------
 5 files changed, 31 insertions(+), 35 deletions(-)

--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -73,6 +73,25 @@ phys_addr_t omap_secure_ram_mempool_base
 	return omap_secure_memblock_base;
 }
 
+u32 omap3_save_secure_ram(void __iomem *addr, int size)
+{
+	u32 ret;
+	u32 param[5];
+
+	if (size != OMAP3_SAVE_SECURE_RAM_SZ)
+		return OMAP3_SAVE_SECURE_RAM_SZ;
+
+	param[0] = 4;		/* Number of arguments */
+	param[1] = __pa(addr);	/* Physical address for saving */
+	param[2] = 0;
+	param[3] = 1;
+	param[4] = 1;
+
+	ret = save_secure_ram_context(__pa(param));
+
+	return ret;
+}
+
 /**
  * rx51_secure_dispatcher: Routine to dispatch secure PPA API calls
  * @idx: The PPA API index
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -31,6 +31,8 @@
 /* Maximum Secure memory storage size */
 #define OMAP_SECURE_RAM_STORAGE	(88 * SZ_1K)
 
+#define OMAP3_SAVE_SECURE_RAM_SZ	0x803F
+
 /* Secure low power HAL API index */
 #define OMAP4_HAL_SAVESECURERAM_INDEX	0x1a
 #define OMAP4_HAL_SAVEHW_INDEX		0x1b
@@ -65,6 +67,8 @@ extern u32 omap_smc2(u32 id, u32 falg, u
 extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
 extern int omap_secure_ram_reserve_memblock(void);
+extern u32 save_secure_ram_context(u32 args_pa);
+extern u32 omap3_save_secure_ram(void __iomem *save_regs, int size);
 
 extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
 				  u32 arg1, u32 arg2, u32 arg3, u32 arg4);
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -81,10 +81,6 @@ extern unsigned int omap3_do_wfi_sz;
 /* ... and its pointer from SRAM after copy */
 extern void (*omap3_do_wfi_sram)(void);
 
-/* save_secure_ram_context function pointer and size, for copy to SRAM */
-extern int save_secure_ram_context(u32 *addr);
-extern unsigned int save_secure_ram_context_sz;
-
 extern void omap3_save_scratchpad_contents(void);
 
 #define PM_RTA_ERRATUM_i608		(1 << 0)
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -48,6 +48,7 @@
 #include "prm3xxx.h"
 #include "pm.h"
 #include "sdrc.h"
+#include "omap-secure.h"
 #include "sram.h"
 #include "control.h"
 #include "vc.h"
@@ -66,7 +67,6 @@ struct power_state {
 
 static LIST_HEAD(pwrst_list);
 
-static int (*_omap_save_secure_sram)(u32 *addr);
 void (*omap3_do_wfi_sram)(void);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
@@ -121,8 +121,8 @@ static void omap3_save_secure_ram_contex
 		 * will hang the system.
 		 */
 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
-		ret = _omap_save_secure_sram((u32 *)(unsigned long)
-				__pa(omap3_secure_ram_storage));
+		ret = omap3_save_secure_ram(omap3_secure_ram_storage,
+					    OMAP3_SAVE_SECURE_RAM_SZ);
 		pwrdm_set_next_pwrst(mpu_pwrdm, mpu_next_state);
 		/* Following is for error tracking, it should not happen */
 		if (ret) {
@@ -434,15 +434,10 @@ static int __init pwrdms_setup(struct po
  *
  * The minimum set of functions is pushed to SRAM for execution:
  * - omap3_do_wfi for erratum i581 WA,
- * - save_secure_ram_context for security extensions.
  */
 void omap_push_sram_idle(void)
 {
 	omap3_do_wfi_sram = omap_sram_push(omap3_do_wfi, omap3_do_wfi_sz);
-
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
-		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
-				save_secure_ram_context_sz);
 }
 
 static void __init pm_errata_configure(void)
@@ -554,7 +549,7 @@ int __init omap3_pm_init(void)
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
-			kmalloc(0x803F, GFP_KERNEL);
+			kmalloc(OMAP3_SAVE_SECURE_RAM_SZ, GFP_KERNEL);
 		if (!omap3_secure_ram_storage)
 			pr_err("Memory allocation failed when allocating for secure sram context\n");
 
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -93,20 +93,13 @@ ENTRY(enable_omap3630_toggle_l2_on_resto
 ENDPROC(enable_omap3630_toggle_l2_on_restore)
 
 /*
- * Function to call rom code to save secure ram context. This gets
- * relocated to SRAM, so it can be all in .data section. Otherwise
- * we need to initialize api_params separately.
+ * Function to call rom code to save secure ram context.
+ *
+ * r0 = physical address of the parameters
  */
-	.data
-	.align	3
 ENTRY(save_secure_ram_context)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
-	adr	r3, api_params		@ r3 points to parameters
-	str	r0, [r3,#0x4]		@ r0 has sdram address
-	ldr	r12, high_mask
-	and	r3, r3, r12
-	ldr	r12, sram_phy_addr_mask
-	orr	r3, r3, r12
+	mov	r3, r0			@ physical address of parameters
 	mov	r0, #25			@ set service ID for PPA
 	mov	r12, r0			@ copy secure service ID in r12
 	mov	r1, #0			@ set task id for ROM code in r1
@@ -120,18 +113,7 @@ ENTRY(save_secure_ram_context)
 	nop
 	nop
 	ldmfd	sp!, {r4 - r11, pc}
-	.align
-sram_phy_addr_mask:
-	.word	SRAM_BASE_P
-high_mask:
-	.word	0xffff
-api_params:
-	.word	0x4, 0x0, 0x0, 0x1, 0x1
 ENDPROC(save_secure_ram_context)
-ENTRY(save_secure_ram_context_sz)
-	.word	. - save_secure_ram_context
-
-	.text
 
 /*
  * ======================

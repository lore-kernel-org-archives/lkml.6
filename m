Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53605C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A0720895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A0720895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJMRdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:33:11 -0400
Received: from mout.web.de ([212.227.15.4]:53223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeJMRdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:33:10 -0400
Received: from [192.168.1.10] ([95.157.57.47]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpwIR-1fhjN403tv-00fju8; Sat, 13
 Oct 2018 11:55:01 +0200
Received: from [192.168.1.10] ([95.157.57.47]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpwIR-1fhjN403tv-00fju8; Sat, 13
 Oct 2018 11:55:01 +0200
Subject: [PATCH] x86/entry/32: Fix setup of CS high bits
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
 <1531906876-13451-11-git-send-email-joro@8bytes.org>
 <97421241-2bc4-c3f1-4128-95b3e8a230d1@siemens.com>
Message-ID: <35a24feb-5970-aa03-acbf-53428a159ace@web.de>
Date:   Sat, 13 Oct 2018 11:54:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <97421241-2bc4-c3f1-4128-95b3e8a230d1@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:46apdO8moDu5QHFVU11jJ6e9YB2KSg5ysNjNpLtGN795QjOXZR+
 BIJk5T9jQJK4E0w+8eXXP756wE8D0QyA87XH9ATa/StWQNDY/HCgkgsXViYHeklhTYH0mma
 ecBvkN0Vz9kKDZlBF5xn+HmBUWEek8g0qkfJzZgF3rvspDDzmGTVWISAalMWxPiMPvtGiOQ
 oAArQ3WVB05Bl1MY8x1fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F7fHc4ajTRs=:fdkSt1FJ3KxC+FF24byc/T
 VLCoq3efYFGOX0C+HOgF9kKwLdZUGbjFMeLJiWbuL2IG0oC3YIkgXu273BLHPQQA6Q4u/tiHT
 lbHi05yWcqYpjTbqaeIQ/eMITxvHPOyAkC3qBYOXAejrfBuJ5B5ahC9fKS8jLJ+InoZbNWqqq
 jkv1yBm3GzMLPqfdNXX1RHko3cZM2Uo9VMwssBUkeyPG2X+ajprEkRgQDBFDUJZY/Upch4cW8
 bBspY7h5XtfJGW04s1UymYFCfxPLn34d+Y6eCmZNFXt73qVkrdmrZ3jc5A9aBe3XmrshqBRUT
 9yZpf1mwybspxULU6ZBQgThIb86hE+D7sw9qnKFl3ZEvjHaqXezR8GrYHjMiUa/8rFKkvhTU0
 Zt5PIOK2/4/TtL49xPK+osMYU0Qh8shJaufp59x238e2iCc20JpkPTLyKai+PbzvXwNXN6H/d
 daqY162idpwfO5WFK67w2RIP/t5Gg9KUYLNHaaTLIHwWkP/LX9YnVdrIqEZPPsUIzWpeLLGwh
 JYhoiLmOet5mbW36575bQVMQ6ltb1P6N56sFqoZBJ8oVzppTlZFzz1b8RBa5XYNKcAL275GhG
 4U6S0B6MgJhkR9snyMxq6H0AaWTO0mSRCLzvMtXmhhflW9L756PaDUsbg7f4rDclyIN4Jg2Zr
 afl5LUTwUiJpHQC7Wc/IDj+vmrihkkuZNU9wTuuONhCtwObczOA4AuQkLzZNTb+jBOEP24lPd
 R3RE7rYFaNsiECmY2CfJs73Yg1FnGl76pMN79WAF2cfJBzAoZU8RLfoYEwxsPyW07XEAlPzKe
 zQaleoHaFxzepdXqXihiUm1XSnrYY0WxYgKdRk9DJLW17+cArY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Even if we are not on an entry stack, we have to initialize the CS high
bits because we are unconditionally evaluating them
PARANOID_EXIT_TO_KERNEL_MODE. Failing to do so broke the boot on Galileo
Gen2 and IOT2000 boards.

Fixes: b92a165df17e ("x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/entry/entry_32.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2767c625a52c..95c94d48ecd2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -389,6 +389,12 @@
 	 * that register for the time this macro runs
 	 */
 
+	/*
+	 * Clear unused upper bits of the dword containing the word-sized CS
+	 * slot in pt_regs in case hardware didn't clear it for us.
+	 */
+	andl	$(0x0000ffff), PT_CS(%esp)
+
 	/* Are we on the entry stack? Bail out if not! */
 	movl	PER_CPU_VAR(cpu_entry_area), %ecx
 	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
@@ -407,12 +413,6 @@
 	/* Load top of task-stack into %edi */
 	movl	TSS_entry2task_stack(%edi), %edi
 
-	/*
-	 * Clear unused upper bits of the dword containing the word-sized CS
-	 * slot in pt_regs in case hardware didn't clear it for us.
-	 */
-	andl	$(0x0000ffff), PT_CS(%esp)
-
 	/* Special case - entry from kernel mode via entry stack */
 #ifdef CONFIG_VM86
 	movl	PT_EFLAGS(%esp), %ecx		# mix EFLAGS and CS
-- 
2.16.4

Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8068ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDC520645
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDC520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbeISPIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:08:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63681 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbeISPIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:08:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42FZPB4R5Tz9ttG0;
        Wed, 19 Sep 2018 11:31:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eHTt2WDtmo6z; Wed, 19 Sep 2018 11:31:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42FZPB3vYwz9ttC2;
        Wed, 19 Sep 2018 11:31:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C4BE48B830;
        Wed, 19 Sep 2018 11:31:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hiqHfysY15Ju; Wed, 19 Sep 2018 11:31:26 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7341E8B831;
        Wed, 19 Sep 2018 11:31:26 +0200 (CEST)
To:     linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: How to define some additional KBUILD_CFLAGS after building
 include/generated/asm-offsets.h ?
Message-ID: <e1b65467-7497-5db4-aa93-1ad00d12af3f@c-s.fr>
Date:   Tue, 18 Sep 2018 23:41:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to implement TLS based stack protector in the Linux Kernel.
For that I need to give to GCC the offset at which it will find the 
canary (register r2 is pointing to the current task struct).

I have been able to do it with the below patch, but it only works when 
include/generated/asm-offsets.h already exists from the start of the build.

Is there a way to evaluate CANARY_OFFSET and add the stack-protector 
flags to KBUILD_FLAGS only after include/generated/asm-offsets.h is built ?

Or another way of add -mstack-protector-guard-offset=offsetof(struct 
task_struct, stack_canary) ?

diff --git a/arch/powerpc/kernel/asm-offsets.c 
b/arch/powerpc/kernel/asm-offsets.c
index 89cf15566c4e..b25483946921 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -89,6 +89,9 @@ int main(void)
         DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
         OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
  #endif /* CONFIG_PPC64 */
+#ifdef CONFIG_STACKPROTECTOR
+       DEFINE(TSK_STACK_CANARY, offsetof(struct task_struct, 
stack_canary));
+#endif

  #ifdef CONFIG_LIVEPATCH
         OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e58c3f467db5..051b907b5c02 100644
[root@pc16082vm linux-powerpc]# git diff
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 748e34e81a03..7b5a23a8afe8 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -113,7 +113,8 @@ KBUILD_ARFLAGS      += --target=elf$(BITS)-$(GNUTARGET)
  endif

  ifdef CONFIG_STACKPROTECTOR
-KBUILD_CFLAGS  += -mstack-protector-guard=global
+CANARY_OFFSET := $(shell awk '{if ($$2 == "TSK_STACK_CANARY") print 
$$3;}' include/generated/asm-offsets.h)
+KBUILD_CFLAGS  += -mstack-protector-guard=tls 
-mstack-protector-guard-reg=r2 
-mstack-protector-guard-offset=$(CANARY_OFFSET)
  endif

  LDFLAGS_vmlinux-y := -Bstatic


Thanks
Christophe

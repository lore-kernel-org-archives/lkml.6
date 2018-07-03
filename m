Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C467CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E51724C47
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpEPpUf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E51724C47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeGCHuX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933028AbeGCHuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:50:18 -0400
Received: from linux-5o07 (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652AE24C34;
        Tue,  3 Jul 2018 07:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530604218;
        bh=swiM/o44vsTJYW5czzI3ZUMuI/bRgrPkEIJeXrGmjTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpEPpUf7fVIe2jXXFvl8KDEMGqZcVI8CZoYcT8A84GdnuDVZ4My16G7Nyh68Wprpc
         gF/SR/Kw352sY6BJACzmqPLL7ZTIb/lLttwUDYcYX6Hx4kHw2RrWFFbVVQ6l8oSxzm
         IF9lEtXjWvSMSsOcICPgdPFzalU25zRj8HdQWXDU=
Date:   Tue, 3 Jul 2018 09:50:13 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/8] jump_table: move entries into ro_after_init region
Message-ID: <20180703075013.ntyu7zlw5rijfeyn@linux-5o07>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
 <20180702181145.4799-9-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180702181145.4799-9-ard.biesheuvel@linaro.org>
X-OS:   Linux linux-5o07 4.18.0-rc1-lp150.11-default+ x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Ard Biesheuvel [02/07/18 20:11 +0200]:
>The __jump_table sections emitted into the core kernel and into
>each module consist of statically initialized references into
>other parts of the code, and with the exception of entries that
>point into init code, which are defused at post-init time, these
>data structures are never modified.
>
>So let's move them into the ro_after_init section, to prevent them
>from being corrupted inadvertently by buggy code, or deliberately
>by an attacker.
>
>Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

For module parts:

Acked-by: Jessica Yu <jeyu@kernel.org>

>---
> arch/arm/kernel/vmlinux-xip.lds.S |  1 +
> arch/s390/kernel/vmlinux.lds.S    |  1 +
> include/asm-generic/vmlinux.lds.h | 11 +++++++----
> kernel/module.c                   |  9 +++++++++
> 4 files changed, 18 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
>index 3593d5c1acd2..763c41068ecc 100644
>--- a/arch/arm/kernel/vmlinux-xip.lds.S
>+++ b/arch/arm/kernel/vmlinux-xip.lds.S
>@@ -118,6 +118,7 @@ SECTIONS
> 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> 	.data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
> 		*(.data..ro_after_init)
>+		JUMP_TABLE_DATA
> 	}
> 	_edata = .;
>
>diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
>index f0414f52817b..a7cf61e46f88 100644
>--- a/arch/s390/kernel/vmlinux.lds.S
>+++ b/arch/s390/kernel/vmlinux.lds.S
>@@ -67,6 +67,7 @@ SECTIONS
> 	__start_ro_after_init = .;
> 	.data..ro_after_init : {
> 		 *(.data..ro_after_init)
>+		JUMP_TABLE_DATA
> 	}
> 	EXCEPTION_TABLE(16)
> 	. = ALIGN(PAGE_SIZE);
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index e373e2e10f6a..ed6befa4c47b 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -256,10 +256,6 @@
> 	STRUCT_ALIGN();							\
> 	*(__tracepoints)						\
> 	/* implement dynamic printk debug */				\
>-	. = ALIGN(8);                                                   \
>-	__start___jump_table = .;					\
>-	KEEP(*(__jump_table))                                           \
>-	__stop___jump_table = .;					\
> 	. = ALIGN(8);							\
> 	__start___verbose = .;						\
> 	KEEP(*(__verbose))                                              \
>@@ -303,6 +299,12 @@
> 	. = __start_init_task + THREAD_SIZE;				\
> 	__end_init_task = .;
>
>+#define JUMP_TABLE_DATA							\
>+	. = ALIGN(8);							\
>+	__start___jump_table = .;					\
>+	KEEP(*(__jump_table))						\
>+	__stop___jump_table = .;
>+
> /*
>  * Allow architectures to handle ro_after_init data on their
>  * own by defining an empty RO_AFTER_INIT_DATA.
>@@ -311,6 +313,7 @@
> #define RO_AFTER_INIT_DATA						\
> 	__start_ro_after_init = .;					\
> 	*(.data..ro_after_init)						\
>+	JUMP_TABLE_DATA							\
> 	__end_ro_after_init = .;
> #endif
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 7cb82e0fcac0..0d4e320e41cd 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3349,6 +3349,15 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
> 	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> 	 */
> 	ndx = find_sec(info, ".data..ro_after_init");
>+	if (ndx)
>+		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
>+	/*
>+	 * Mark the __jump_table section as ro_after_init as well: these data
>+	 * structures are never modified, with the exception of entries that
>+	 * refer to code in the __init section, which are annotated as such
>+	 * at module load time.
>+	 */
>+	ndx = find_sec(info, "__jump_table");
> 	if (ndx)
> 		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
>
>-- 
>2.17.1
>

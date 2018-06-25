Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA53DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EF42570C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEefgy8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EF42570C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755078AbeFYJxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754650AbeFYJxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:53:01 -0400
Received: from linux-5o07 (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 235322570B;
        Mon, 25 Jun 2018 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529920380;
        bh=ZuySTQAWHuQCqjxpuJh+37pcrUTd7axEvmTAIVhs7FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEefgy8hPXNzP6iBDUPmmH406bbgsRF1jw81IqNnPfB5eHy15olIW9OqYVmkiwhRv
         4QMBiehkLFqT40r3a4q03jQ6sZFjzsA0JmGC5f34nMrP+g5Mzw3TjDf5xwdvpraZfJ
         GO6+qeljZeyE5GEdmHUZ8JfXNfCdezWpUX7TZoBk=
Date:   Mon, 25 Jun 2018 11:52:58 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: replace VMLINUX_SYMBOL_STR() with __stringify()
 or string literal
Message-ID: <20180625095258.umu7nfazw2g3tiwp@linux-5o07>
References: <1529768264-10199-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1529768264-10199-1-git-send-email-yamada.masahiro@socionext.com>
X-OS:   Linux linux-5o07 4.18.0-rc1-lp150.11-default+ x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [24/06/18 00:37 +0900]:
>With the special case handling for Blackfin and Metag was removed by
>commit 94e58e0ac312 ("export.h: remove code for prefixing symbols with
>underscore"), VMLINUX_SYMBOL_STR() is now equivalent to __stringify().
>
>Replace the remaining usages to prepare for the entire removal of
>VMLINUX_SYMBOL_STR().
>
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thanks.

Jessica

>---
>
> include/linux/module.h | 4 ++--
> kernel/module.c        | 6 ++----
> 2 files changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index d44df9b..f807f15 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -266,7 +266,7 @@ extern int modules_disabled; /* for sysctl */
> /* Get/put a kernel symbol (calls must be symmetric) */
> void *__symbol_get(const char *symbol);
> void *__symbol_get_gpl(const char *symbol);
>-#define symbol_get(x) ((typeof(&x))(__symbol_get(VMLINUX_SYMBOL_STR(x))))
>+#define symbol_get(x) ((typeof(&x))(__symbol_get(__stringify(x))))
>
> /* modules using other modules: kdb wants to see this. */
> struct module_use {
>@@ -575,7 +575,7 @@ extern void __noreturn __module_put_and_exit(struct module *mod,
> #ifdef CONFIG_MODULE_UNLOAD
> int module_refcount(struct module *mod);
> void __symbol_put(const char *symbol);
>-#define symbol_put(x) __symbol_put(VMLINUX_SYMBOL_STR(x))
>+#define symbol_put(x) __symbol_put(__stringify(x))
> void symbol_put_addr(void *addr);
>
> /* Sometimes we know we already have a refcount, and it's easier not
>diff --git a/kernel/module.c b/kernel/module.c
>index f475f30..624d2c0 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1339,14 +1339,12 @@ static inline int check_modstruct_version(const struct load_info *info,
> 	 * locking is necessary -- use preempt_disable() to placate lockdep.
> 	 */
> 	preempt_disable();
>-	if (!find_symbol(VMLINUX_SYMBOL_STR(module_layout), NULL,
>-			 &crc, true, false)) {
>+	if (!find_symbol("module_layout", NULL, &crc, true, false)) {
> 		preempt_enable();
> 		BUG();
> 	}
> 	preempt_enable();
>-	return check_version(info, VMLINUX_SYMBOL_STR(module_layout),
>-			     mod, crc);
>+	return check_version(info, "module_layout", mod, crc);
> }
>
> /* First part is kernel version, which we ignore if module has crcs. */
>-- 
>2.7.4
>

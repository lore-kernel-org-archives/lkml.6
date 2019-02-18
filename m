Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69961C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B08F2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550483002;
	bh=5KQyjcgHMMJvQhYRe9+MzGsF49jugRElnB4gy2U8kfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=llnAxviF8tlTkRmwA0i4e8jrPc3//N8Tz6YMVCZtsA6eo4ushmail4pnq4gKHADeV
	 2ET2sp2WmZ2MVkJTeevVHPUd35VkDlIi4qiyLQIBpSBzF8s26L/5Gi/jrV46eoQEH8
	 lgh6utHyqGtKJClb3AA1fuZwh4GvUfu3ZGLdO/OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfBRJnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfBRJnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:43:20 -0500
Received: from linux-8ccs (ip5f5adbd6.dynamic.kabel-deutschland.de [95.90.219.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2E22177E;
        Mon, 18 Feb 2019 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550482999;
        bh=5KQyjcgHMMJvQhYRe9+MzGsF49jugRElnB4gy2U8kfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzJVQkO8Hk69UziSZkHvvTTvc6v5DwuFfktadgZz9jl5Ear/TdWqJOvPf6T0YDUPQ
         /r9hdNPNrc27dT17sgF8XUBBiURP5TiNZd9kdNrzfQpcS7YWYr8WR/gsiMuX8eU+LR
         L6TOUUbRjfx0csEV8OR7Xa0ZSN1AelLVUcSFJV+E=
Date:   Mon, 18 Feb 2019 10:43:14 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH v3] x86/ima: require signed kernel modules
Message-ID: <20190218094313.GA9296@linux-8ccs>
References: <1550249418-7986-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1550249418-7986-1-git-send-email-zohar@linux.ibm.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Mimi Zohar [15/02/19 11:50 -0500]:
>Have the IMA architecture specific policy require signed kernel modules
>on systems with secure boot mode enabled; and coordinate the different
>signature verification methods, so only one signature is required.
>
>Requiring appended kernel module signatures may be configured, enabled
>on the boot command line, or with this patch enabled in secure boot
>mode.  This patch defines set_module_sig_enforced().
>
>To coordinate between appended kernel module signatures and IMA
>signatures, only define an IMA MODULE_CHECK policy rule if
>CONFIG_MODULE_SIG is not enabled.  A custom IMA policy may still define
>and require an IMA signature.
>
>Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks!

>---
> arch/x86/kernel/ima_arch.c | 9 ++++++++-
> include/linux/module.h     | 5 +++++
> kernel/module.c            | 5 +++++
> 3 files changed, 18 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
>index e47cd9390ab4..3fb9847f1cad 100644
>--- a/arch/x86/kernel/ima_arch.c
>+++ b/arch/x86/kernel/ima_arch.c
>@@ -64,12 +64,19 @@ static const char * const sb_arch_rules[] = {
> 	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> #endif /* CONFIG_KEXEC_VERIFY_SIG */
> 	"measure func=KEXEC_KERNEL_CHECK",
>+#if !IS_ENABLED(CONFIG_MODULE_SIG)
>+	"appraise func=MODULE_CHECK appraise_type=imasig",
>+#endif
>+	"measure func=MODULE_CHECK",
> 	NULL
> };
>
> const char * const *arch_get_ima_policy(void)
> {
>-	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
>+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
>+		if (IS_ENABLED(CONFIG_MODULE_SIG))
>+			set_module_sig_enforced();
> 		return sb_arch_rules;
>+	}
> 	return NULL;
> }
>diff --git a/include/linux/module.h b/include/linux/module.h
>index 8fa38d3e7538..5aaa9359adc8 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -660,6 +660,7 @@ static inline bool is_livepatch_module(struct module *mod)
> #endif /* CONFIG_LIVEPATCH */
>
> bool is_module_sig_enforced(void);
>+void set_module_sig_enforced(void);
>
> #else /* !CONFIG_MODULES... */
>
>@@ -780,6 +781,10 @@ static inline bool is_module_sig_enforced(void)
> 	return false;
> }
>
>+static inline void set_module_sig_enforced(void)
>+{
>+}
>+
> /* Dereference module function descriptor */
> static inline
> void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>diff --git a/kernel/module.c b/kernel/module.c
>index 2ad1b5239910..73cada04bd24 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -286,6 +286,11 @@ bool is_module_sig_enforced(void)
> }
> EXPORT_SYMBOL(is_module_sig_enforced);
>
>+void set_module_sig_enforced(void)
>+{
>+	sig_enforce = true;
>+}
>+
> /* Block module loading/unloading? */
> int modules_disabled = 0;
> core_param(nomodule, modules_disabled, bint, 0);
>-- 
>2.7.5
>

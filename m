Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CCEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0778521B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900587;
	bh=2OsP9BlHcHdO+RqWmL8Fxm4La3wb1bYhLefiHJGPUfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oiE+02KqE7RAkrDCsFyK3LG3MS9+pQdsUo2Nbc0wo/uHpxSknZZMyrQgCNDC0J+cm
	 SoljsJc0LM0rYKKiCmB936LVjPpCpheqhbhXKk3YboxiFCrDtMYAMendHThYY+hsqT
	 NmMXWHo2PNmIS7v2ZyGt0DzHKEuc1UxhmJ2g1I2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfBKP4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730516AbfBKP4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:56:15 -0500
Received: from linux-8ccs (ip5f5ade6b.dynamic.kabel-deutschland.de [95.90.222.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48ACB21B18;
        Mon, 11 Feb 2019 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549900574;
        bh=2OsP9BlHcHdO+RqWmL8Fxm4La3wb1bYhLefiHJGPUfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2avaZrqVWp6jhRyWQ9X2Kg4h3D3V007qa4GO/Hmnzd8wUTPmrO5Wwja2jabmNBDWg
         RLg1P8UynkRfq8frz5tZFswt5FUSWjr/2Jx9qageaeCAtRc9k/L4vHJNKOE+YRH4Ip
         p10XFiy90e/qg0UQDLsdzGMiNBsMQzmWg+H672bY=
Date:   Mon, 11 Feb 2019 16:56:09 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/ima: require signed kernel modules
Message-ID: <20190211155609.GC20732@linux-8ccs>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
 <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Mimi Zohar [31/01/19 14:18 -0500]:
>Require signed kernel modules on systems with secure boot mode enabled.
>
>To coordinate between appended kernel module signatures and IMA
>signatures, only define an IMA MODULE_CHECK policy rule if
>CONFIG_MODULE_SIG is not enabled.
>
>This patch defines a function named set_module_sig_required() and renames
>is_module_sig_enforced() to is_module_sig_enforced_or_required().  The
>call to set_module_sig_required() is dependent on CONFIG_IMA_ARCH_POLICY
>being enabled.
>
>Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>---
> arch/x86/kernel/ima_arch.c        |  9 ++++++++-
> include/linux/module.h            |  7 ++++++-
> kernel/module.c                   | 15 +++++++++++----
> security/integrity/ima/ima_main.c |  2 +-
> 4 files changed, 26 insertions(+), 7 deletions(-)
>
>diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
>index e47cd9390ab4..96a023238a83 100644
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
>+			set_module_sig_required();
> 		return sb_arch_rules;
>+	}
> 	return NULL;
> }
>diff --git a/include/linux/module.h b/include/linux/module.h
>index 8fa38d3e7538..af51c8ec755f 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -659,7 +659,8 @@ static inline bool is_livepatch_module(struct module *mod)
> }
> #endif /* CONFIG_LIVEPATCH */
>
>-bool is_module_sig_enforced(void);
>+bool is_module_sig_enforced_or_required(void);
>+void set_module_sig_required(void);
>
> #else /* !CONFIG_MODULES... */
>
>@@ -780,6 +781,10 @@ static inline bool is_module_sig_enforced(void)
> 	return false;
> }
>
>+static inline void set_module_sig_required(void)
>+{
>+}
>+
> /* Dereference module function descriptor */
> static inline
> void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>diff --git a/kernel/module.c b/kernel/module.c
>index 2ad1b5239910..70a9709d19eb 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -275,16 +275,23 @@ static void module_assert_mutex_or_preempt(void)
>
> static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
> module_param(sig_enforce, bool_enable_only, 0644);
>+static bool sig_required;
>
> /*
>  * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
>  * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
>  */
>-bool is_module_sig_enforced(void)
>+bool is_module_sig_enforced_or_required(void)
> {
>-	return sig_enforce;
>+	return sig_enforce || sig_required;
> }

Hi Mimi,

Just wondering, is there any particular reason why a distinction is
made between sig_enforce and sig_required? Doesn't sig_enforce imply
that signed modules are required? In other words, why introduce
another variable instead of just using sig_enforce? It may be
confusing in the case of a user looking at /sys/module/module/parameters/sig_enforce
and it having a value of 0 yet module signatures are being required by ima.

Thanks,

Jessica

>-EXPORT_SYMBOL(is_module_sig_enforced);
>+EXPORT_SYMBOL(is_module_sig_enforced_or_required);
>+
>+void set_module_sig_required(void)
>+{
>+	sig_required = true;
>+}
>+EXPORT_SYMBOL(set_module_sig_required);
>
> /* Block module loading/unloading? */
> int modules_disabled = 0;
>@@ -2789,7 +2796,7 @@ static int module_sig_check(struct load_info *info, int flags)
> 	}
>
> 	/* Not having a signature is only an error if we're strict. */
>-	if (err == -ENOKEY && !is_module_sig_enforced())
>+	if (err == -ENOKEY && !is_module_sig_enforced_or_required())
> 		err = 0;
>
> 	return err;
>diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>index 357edd140c09..bbaf87f688be 100644
>--- a/security/integrity/ima/ima_main.c
>+++ b/security/integrity/ima/ima_main.c
>@@ -563,7 +563,7 @@ int ima_load_data(enum kernel_load_data_id id)
> 		}
> 		break;
> 	case LOADING_MODULE:
>-		sig_enforce = is_module_sig_enforced();
>+		sig_enforce = is_module_sig_enforced_or_required();
>
> 		if (ima_enforce && (!sig_enforce
> 				    && (ima_appraise & IMA_APPRAISE_MODULES))) {
>-- 
>2.7.5
>

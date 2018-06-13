Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C7B7DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F45208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqgq36ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F45208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935594AbeFMNPY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935359AbeFMNPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:15:23 -0400
Received: from linux-5o07 (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5A2208B0;
        Wed, 13 Jun 2018 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528895722;
        bh=MKX6b51uBh9EUI5d9hrVwkEbaQAVPAx0YkjS4gSHcro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqgq36ap9mF1Nzab6QCfb5Wu8PBy51wnJSZZ4d+DVyPiq7UXvluZgQJ/EWqw+5DGE
         LMA3/6O83UszhBIIvpi3j7NM5ABbk4EHjXrHU3kAWYMw9ehbllowVKk3YFw9SvNQ9T
         WQAHz8iueb8ng/XjmsCrulNzxQzxBLXu4RHYfHiI=
Date:   Wed, 13 Jun 2018 15:15:20 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     "Brett T. Warden" <brett.t.warden@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Implement sig_unenforce parameter
Message-ID: <20180613131520.uwtwi67meobos3ws@linux-5o07>
References: <201806062114.40uzFbuB%fengguang.wu@intel.com>
 <20180606194414.14500-1-brett.t.warden@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180606194414.14500-1-brett.t.warden@intel.com>
X-OS:   Linux linux-5o07 4.12.14-lp150.11-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Brett T. Warden [06/06/18 12:44 -0700]:
>When CONFIG_MODULE_SIG_FORCE is enabled, also provide a boot-time-only
>parameter, module.sig_unenforce, to disable signature enforcement. This
>allows distributions to ship with signature verification enforcement
>enabled by default, but for users to elect to disable it without
>recompiling, to support building and loading out-of-tree modules.
>
>Signed-off-by: Brett T. Warden <brett.t.warden@intel.com>
>---
>
>Added CONFIG_X86 guards around use of boot_params since this structure
>is arch-specific.
>
> .../admin-guide/kernel-parameters.txt         |  4 +++
> kernel/module.c                               | 31 +++++++++++++++++--
> 2 files changed, 33 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>index 1beb30d8d7fc..87909e021558 100644
>--- a/Documentation/admin-guide/kernel-parameters.txt
>+++ b/Documentation/admin-guide/kernel-parameters.txt
>@@ -2380,6 +2380,10 @@
> 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
> 			is always true, so this option does nothing.
>
>+	module.sig_unenforce
>+			[KNL] This parameter allows modules without signatures
>+			to be loaded, overriding CONFIG_MODULE_SIG_FORCE.
>+
> 	module_blacklist=  [KNL] Do not load a comma-separated list of
> 			modules.  Useful for debugging problem modules.
>
>diff --git a/kernel/module.c b/kernel/module.c
>index c9bea7f2b43e..27f23d85e1ba 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -64,6 +64,7 @@
> #include <linux/bsearch.h>
> #include <linux/dynamic_debug.h>
> #include <linux/audit.h>
>+#include <linux/efi.h>
> #include <uapi/linux/module.h>
> #include "module-internal.h"
>
>@@ -274,9 +275,13 @@ static void module_assert_mutex_or_preempt(void)
> }
>
> static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
>-#ifndef CONFIG_MODULE_SIG_FORCE
>+#ifdef CONFIG_MODULE_SIG_FORCE
>+/* Allow disabling module signature requirement by adding boot param */
>+static bool sig_unenforce;
>+module_param(sig_unenforce, bool_enable_only, 0444);
>+#else /* !CONFIG_MODULE_SIG_FORCE */
> module_param(sig_enforce, bool_enable_only, 0644);
>-#endif /* !CONFIG_MODULE_SIG_FORCE */
>+#endif /* CONFIG_MODULE_SIG_FORCE */
>
> /*
>  * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
>@@ -415,6 +420,10 @@ extern const s32 __start___kcrctab_unused[];
> extern const s32 __start___kcrctab_unused_gpl[];
> #endif
>
>+#ifdef CONFIG_X86
>+extern struct boot_params boot_params;
>+#endif
>+
> #ifndef CONFIG_MODVERSIONS
> #define symversion(base, idx) NULL
> #else
>@@ -4243,6 +4252,24 @@ static const struct file_operations proc_modules_operations = {
> static int __init proc_modules_init(void)
> {
> 	proc_create("modules", 0, NULL, &proc_modules_operations);
>+
>+#ifdef CONFIG_MODULE_SIG_FORCE
>+#ifdef CONFIG_X86
>+	switch (boot_params.secure_boot) {
>+	case efi_secureboot_mode_unset:
>+	case efi_secureboot_mode_unknown:
>+	case efi_secureboot_mode_disabled:
>+		/*
>+		 * sig_unenforce is only applied if SecureBoot is not
>+		 * enabled.
>+		 */
>+		sig_enforce = !sig_unenforce;
>+	}
>+#else
>+	sig_enforce = !sig_unenforce;
>+#endif
>+#endif

I don't want to rope in Secure Boot specifics and arch-specific code
(other than what's in arch/) into the module loader. I also don't want
to change the current semantics of CONFIG_MODULE_SIG_FORCE, for any
existing users who just want to set a build-time policy and already
assume that unsigned modules can't be loaded, period. Lastly, having
both sig_enforce and sig_unenforce parameters is really confusing.
Might as well just make it one parameter - sig_enforce - and make that
toggleable under a certain configuration.

It sounds like you want to ship with signature enforcement enabled by
default, but stil want to make this toggleable for users. So maybe
something in between CONFIG_MODULE_SIG and CONFIG_MODULE_SIG_FORCE.
Half baked suggestion: Would a new config option that enforces module
signatures by default but makes sig_enforce toggleable for users suit
your use case? This would be less strict than CONFIG_MODULE_SIG_FORCE.

Thanks,

Jessica
